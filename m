From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: What's cooking extra
Date: Sat, 22 May 2010 23:24:46 +0200
Message-ID: <4BF84B9E.7060009@lsrfire.ath.cx>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Phil Lawrence <prlawrence@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 22 23:25:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFwCE-0008WV-0V
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 23:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758403Ab0EVVZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 17:25:08 -0400
Received: from india601.server4you.de ([85.25.151.105]:51372 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758082Ab0EVVZH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 17:25:07 -0400
Received: from [10.0.1.100] (p57B7F4C3.dip.t-dialin.net [87.183.244.195])
	by india601.server4you.de (Postfix) with ESMTPSA id 5B91F2F8069;
	Sat, 22 May 2010 23:25:03 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147541>

Am 19.05.2010 16:33, schrieb Junio C Hamano:
> I am aware of the following topics, that are probably all worthy of
> inclusion at some point, but am unclear in what status their discussions
> are.  I'd appreciate it if people can help me come up with a list of
> topics that are fully discussed, and if patch submitters of these topics
> can re-send the final "to apply" copy.

>  * (Rene) grep on binary files

There was one helpful comment from Dmitry, which I addressed in a follow-up
patch.  No reply from Phil, the one who started the topic, though.

I'll send an updated round as replies to this message:

[PATCH 1/8] grep: add test script for binary file handling

	Adds a simple test script documenting what git grep can do with
	binary files.  New: tests for -L and -q.

[PATCH 2/8] grep: grep: refactor handling of binary mode options

	Cleanup patch; unchanged.

[PATCH 3/8] grep: --count over binary
[PATCH 4/8] grep: --name-only over binary

	Correctness patches for handling of the options --count and
	--name-only in connection with binary files.  The first one was
	reimplemented and the second one is new.

[PATCH 5/8] grep: use memmem() for fixed string search
[PATCH 6/8] grep: continue case insensitive fixed string search after NUL chars

	These two patches make git grep -F work on binary files.  They
	have been rebased against the preceding changed patches but are
	unchanged otherwise.

[PATCH 7/8] grep: use REG_STARTEND for all matching if available

	This make git grep work on binary files if the platform's
	regexec() supports the flag REG_STARTEND.  Our own version in
	compat/ doesn't, unfortunately.  In the first round it consisted
	of two patches, which have been squashed and rebased.

[PATCH 8/8] grep: support NUL chars in search strings for -F

	New patch, adds support for NUL in patterns, but only for git
	grep -F (not -Fi).  It's main value is the addition of tests to
	show the current limitations regarding searching for NULs.


 builtin/grep.c         |    8 +++-
 grep.c                 |   98 +++++++++++++++++++++++++++------------------
 grep.h                 |    2 +
 t/t7008-grep-binary.sh |  102 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 169 insertions(+), 41 deletions(-)
