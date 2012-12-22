From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/7] format-patch --reroll-count
Date: Sat, 22 Dec 2012 00:33:25 -0800
Message-ID: <1356165212-5611-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 09:34:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmKWo-0007hl-Es
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 09:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091Ab2LVIdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 03:33:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64805 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906Ab2LVIdf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 03:33:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F7328279
	for <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=G4XZbJgsmRkI2I0zNhm2R+h+7PA
	=; b=PwjlPgee0BZ7akDMrt+S8FxtSa00bGCliLmp6OzTZ9JV3CvmvbOpSwuZVSa
	b9E+sSPbMPL3MfOKF2OanJIqJM+zls/nNumQJ4yNCFYvxaEH0LFezdpAm/r++jRB
	M4As71DAkDz1Pet0Jqbh2OhzMFGH8yZAHw/97Zs61Ulx1L0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=XtC66YiYvxq7dSBW4t1+hiRJmePlQ
	3KG+EfIM+48WTNRkmgXxiWwQTAAUL+Bk5A5atvABBHw4HiPOwSthmd4k7OwrFn6O
	Frd4nFtKIN42TyM106KYmOPKpHgGQPAkZwN1JL525N2hLibUCbYY/v62Tma7inJ1
	y/n3K7IGur7E4c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 326288278
	for <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 924248277 for
 <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:33 -0500 (EST)
X-Mailer: git-send-email 1.8.1.rc2.227.g7335c9f
X-Pobox-Relay-ID: 45A45920-4C12-11E2-B6F9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212036>

The --reroll-count=$N option, when given a positive integer:

 - Adds " v$N" to the subject prefix specified.  As the default
   subject prefix string is "PATCH", --reroll-count=2 makes it
   "PATCH v2".

 - Prefixes "v$N-" to the names used for output files.  The cover
   letter, whose name is usually 0000-cover-letter.patch, becomes
   v2-0000-cover-letter.patch when given --reroll-count=2.

This allows users to use the same --output-directory for multiple
iterations of the same series, without letting the output for a
newer round overwrite output files from the earlier rounds.  The
user can incorporate materials from earlier rounds to update the
newly minted iteration, and use "send-email v2-*.patch" to send out
the patches belonging to the second iteration easily.

The early patches of this series are all preparatory clean-ups. I
think reopen_stdout() also can be cleaned up, but I'll leave it to
a future reroll.

Junio C Hamano (7):
  builtin/log.c: drop unused "numbered" parameter from
    make_cover_letter()
  builtin/log.c: drop redundant "numbered_files" parameter from
    make_cover_letter()
  builtin/log.c: stop using global patch_suffix
  get_patch_filename(): simplify function signature
  get_patch_filename(): drop "just-numbers" hack
  get_patch_filename(): split into two functions
  format-patch: add --reroll-count=$N option

 builtin/log.c | 33 ++++++++++++++++++++++++---------
 log-tree.c    | 52 +++++++++++++++++++++++++++++++---------------------
 log-tree.h    |  4 ++--
 revision.h    |  1 +
 4 files changed, 58 insertions(+), 32 deletions(-)

-- 
1.8.0.6.gd28b5d4.dirty
