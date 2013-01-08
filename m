From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/10] reroll of ap/log-mailmap
Date: Mon,  7 Jan 2013 16:10:11 -0800
Message-ID: <1357603821-8647-1-git-send-email-gitster@pobox.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 01:10:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsMmI-00061G-9Q
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 01:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756161Ab3AHAKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 19:10:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50183 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754756Ab3AHAKY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 19:10:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9892B79B;
	Mon,  7 Jan 2013 19:10:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=+xLg9FfMVSoS6aqOmA/+H62NhYQ
	=; b=w+ynAy/AHCe29gcVbE2uXZ5y9m1/isKB/Rl/IHASBYEuJwtWvAqb8WMeq1S
	zHzDRYcokCHeXxmQUuqBWHPcMH0YrxADFBKpuoViCC6NKhr69NnWYRJy/EFrsIGn
	1ON3F0WX+hiR0x82GaiWLZnit96YJl71O/iXC+SVXHc4MUL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=qnQbOcHBnPcyZsnsUWi1z
	LXAjFoOHdkZvbMPrqL0W9Gu/16LNiecF9ZCmpVjePV+xQy4+xb/kX6vqEuEKSE7C
	OAt3FaFZsmdQNCuJeytGr4kEznERFFK924WZrfOv78kc71Gmin2M9BwHShobfb+1
	a6eUUVPm229uXICjzgzXFs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB32AB79A;
	Mon,  7 Jan 2013 19:10:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 427F3B799; Mon,  7 Jan 2013
 19:10:23 -0500 (EST)
X-Mailer: git-send-email 1.8.1.304.gf036638
X-Pobox-Relay-ID: CBD3DD14-5927-11E2-9711-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212922>

This is a reroll of the previous series Antoine posted on Saturday.

A new patch "string-list: allow case-insensitive string list"
teaches the string-list API that some string lists can be sorted
case insensitively (actually, you can feed any custom two string
comparison functions).

The string_list_lookup_extended() function introduced by the
previous series has been discarded.  Instead, the third patch
"mailmap: remove email copy and length limitation" introduces a
helper function that takes a <char *, size_t> key that is not NUL
terminated to look for a matching item in a string list, and uses
that to update map_user() function, together with the fourth
patch "mailmap: simplify map_user() interface".

All other patches are unmodified from Antoine's series (modulo
wording tweaks here and there).

Antoine Pelisse (9):
  Use split_ident_line to parse author and committer
  mailmap: remove email copy and length limitation
  mailmap: simplify map_user() interface
  mailmap: add mailmap structure to rev_info and pp
  pretty: use mailmap to display username and email
  log: add --use-mailmap option
  test: add test for --use-mailmap option
  log: grep author/committer using mailmap
  log: add log.mailmap configuration option

Junio C Hamano (1):
  string-list: allow case-insensitive string list

 Documentation/config.txt  |   4 +
 Documentation/git-log.txt |   5 ++
 builtin/blame.c           | 183 ++++++++++++++++++++++------------------------
 builtin/log.c             |  16 +++-
 builtin/shortlog.c        |  54 ++++----------
 commit.h                  |   1 +
 log-tree.c                |   1 +
 mailmap.c                 |  94 +++++++++++++++---------
 mailmap.h                 |   4 +-
 pretty.c                  | 114 ++++++++++++++++-------------
 revision.c                |  54 ++++++++++++++
 revision.h                |   1 +
 string-list.c             |  17 ++++-
 string-list.h             |   4 +
 t/t4203-mailmap.sh        |  56 ++++++++++++++
 15 files changed, 379 insertions(+), 229 deletions(-)

-- 
1.8.1.304.gf036638
