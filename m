From: Junio C Hamano <gitster@pobox.com>
Subject: [PREVIEW v3 0/9] Preview of "Peace with CRLF" rerolled
Date: Wed, 13 Jan 2016 19:03:00 -0800
Message-ID: <1452740590-16827-1-git-send-email-gitster@pobox.com>
References: <1450303398-25900-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 04:03:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJYBz-0007SB-5r
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 04:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbcANDDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 22:03:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55246 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751182AbcANDDN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 22:03:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6CCF93C41E;
	Wed, 13 Jan 2016 22:03:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Vov+
	Ix6mZeaEjHOWAmlY/rn7rLg=; b=l7S2Bwv3KUCjY3iNM3XQfgq0TYdM89RyFgPF
	eQAtvFXcUIxZnEWiV1lxEjfNW/tM9oLlq6MbIXP/a07xjJxJKcQhUfNQo796S5GO
	0Uu8bNTviX7xeyzERwKclyAZYaKlrU1ZdnBYZ27OZTtO1FDdJffoRxVgxXy1v7gE
	ZYxpfh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Yqai/wbe0/RBPV2IpL1UtyxMqq2pLxrVLoxLcolRGJYQAOX2bc0/ecea0kLCyxVt
	qQHRB3pD38KjjDr6oCIyvcCDRrxK5YXASVwZCeiH8KjB4TsXTQgr9KJBXbuGm07W
	+CLsXN2rLvfxD3sFctJ6sXwGTXli9uouWrJ5rHMF8Pw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6570F3C41D;
	Wed, 13 Jan 2016 22:03:12 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E1E9B3C41C;
	Wed, 13 Jan 2016 22:03:11 -0500 (EST)
X-Mailer: git-send-email 2.7.0-242-gdd583c7
In-Reply-To: <1450303398-25900-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 58D669C8-BA6B-11E5-B169-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284001>

Continued from

 http://thread.gmane.org/gmane.comp.version-control.git/282614

Here is only the preparatory part that

 - introduces strbuf_getline_lf() and strbuf_getine_nul() and
   converts existing callers to strbut_getline() to use them;

 - retires strbuf_getline() that takes an arbitrary line terminator
   and demotes it to strbuf_getdelim() that is merely an
   implementation detail inside strbuf.c; and

 - gives the short-and-sweet name strbuf_getline() to the most
   "text friendly" strbuf_getline_crlf().

I am sending this out as preview now before implementing the main
part of the series that audits callers of strbuf_getline_lf() and
selectively turns them into strbuf_getline().  The work I did for v2
that corresponds to that main part will have to be redone because of
the changes to function names made by these preparatory steps, and
it would be rather boring mechanical and time-consuming work that is
prone to stupid mistakes, which I do not want to start late in the
day.

Junio C Hamano (9):
  strbuf: miniscule style fix
  strbuf: make strbuf_getline_crlf() global
  strbuf: introduce strbuf_getline_{lf,nul}()
  mktree: there are only two line terminators
  check-attr: there are only two line terminators
  check-ignore: there are only two line terminators
  update-index: there are only two line terminators
  checkout-index: there are only two line terminators
  strbuf: give strbuf_getline() to the "most text friendly" variant

 bisect.c                   |  8 ++++----
 builtin/am.c               | 37 +++++++++++--------------------------
 builtin/cat-file.c         |  2 +-
 builtin/check-attr.c       |  7 ++++---
 builtin/check-ignore.c     |  7 ++++---
 builtin/check-mailmap.c    |  2 +-
 builtin/checkout-index.c   | 10 +++++++---
 builtin/clean.c            |  6 +++---
 builtin/clone.c            |  2 +-
 builtin/column.c           |  2 +-
 builtin/commit.c           |  2 +-
 builtin/fetch-pack.c       |  2 +-
 builtin/grep.c             |  2 +-
 builtin/hash-object.c      |  2 +-
 builtin/mailinfo.c         |  8 ++++----
 builtin/mktree.c           | 14 ++++++++------
 builtin/notes.c            |  2 +-
 builtin/pull.c             |  2 +-
 builtin/repack.c           |  2 +-
 builtin/rev-parse.c        |  4 ++--
 builtin/send-pack.c        |  2 +-
 builtin/update-index.c     | 27 ++++++++++++++++-----------
 compat/terminal.c          |  2 +-
 credential-cache--daemon.c |  4 ++--
 credential-store.c         |  2 +-
 credential.c               |  2 +-
 daemon.c                   |  2 +-
 fast-import.c              |  4 ++--
 ident.c                    |  2 +-
 remote-curl.c              |  6 +++---
 remote-testsvn.c           |  4 ++--
 remote.c                   |  4 ++--
 sequencer.c                |  2 +-
 sha1_file.c                |  2 +-
 shell.c                    |  2 +-
 strbuf.c                   | 28 +++++++++++++++++++++++++---
 strbuf.h                   | 27 ++++++++++++++++++++++-----
 test-sha1-array.c          |  2 +-
 transport-helper.c         |  5 +++--
 walker.c                   |  2 +-
 wt-status.c                |  4 ++--
 41 files changed, 148 insertions(+), 110 deletions(-)

-- 
2.7.0-242-gdd583c7
