From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH v3] git-stash.txt: Add example "Using stash selectively"
Date: Fri, 07 May 2010 11:50:59 +0300
Organization: Private
Message-ID: <87iq70w0wc.fsf_-_@jondo.cante.net>
References: <1273045035-7292-1-git-send-email-jari.aalto@cante.net>
	<7v39y6jfmv.fsf@alter.siamese.dyndns.org>
	<87pr194e3v.fsf_-_@jondo.cante.net> <4BE28624.70302@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 07 10:51:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAJH8-0007KJ-Qs
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 10:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551Ab0EGIvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 04:51:07 -0400
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:56879 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527Ab0EGIvG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 04:51:06 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 800DF8BF6A;
	Fri,  7 May 2010 11:51:04 +0300 (EEST)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A00EBB7D4FA; Fri, 07 May 2010 11:51:04 +0300
Received: from jondo.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 0BF26402E;
	Fri,  7 May 2010 11:50:59 +0300 (EEST)
References: <4BE28624.70302@viscovery.net>
In-Reply-to: <4BE28624.70302@viscovery.net>
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146531>

Add a new example to demonstrate the use of --keep-index.
Idea by Johan Sageryd <j416@1616.se> and
Johannes Sixt <j.sixt@viscovery.net>.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-stash.txt |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)


    Johannes Sixt <j.sixt@viscovery.net> writes:

    > Am 5/6/2010 10:40, schrieb Jari Aalto:
    >
    >> +$ git reset                     # make the index clean
    >> +$ git add -p A C                # add necessary bits to the index
    >> +$ git stash save --keep-index   # the remainder goes to the stash
    >
    > Isn't "the remainder goes to the stash" wrong? I thought that both
    > worktree changes and index go to stash; only that changes recorded in the
    > index are not undone in the index and worktree.
    >
    >> +... test, debug, perfect ...
    >> +$ git commit
    >> +$ git stash pop                 # get the remainder back
    >
    > And here both changes are unstashed, but since the changes that previously
    > were only in the index are already commited, it looks as if no index
    > changes were unstashed.
    >
    > The distinction is important because if you 'stash --keep-index', but then
    > change your mind and 'reset --hard', you actually do *not* lose data
    > because the index changes are still in the stash.
    >
    > Or spelled in a different way: you cannot undo the index changes and keep
    > only the worktree changes by 'stash --keep-index', 'reset --hard', 'stash
    > pop'.

    Reworked based on comments. Let me know if more is needed.

    Jari


diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 473889a..bde5120 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -243,6 +243,28 @@ grep commit | cut -d\  -f3 |
 xargs git log --merges --no-walk --grep=WIP
 ----------------------------------------------------------------
 
+Using stash selectively::
+
+The `--keep-index` option can be useful in a situation where you want
+store some, but not all, files temporarily in the stash. But keep in
+mind that it still records the whole tree (unless --patch is
+specified). If you `stash --keep-index', but then change your mind and
+`reset --hard', you actually do *not* lose data because the index
+changes are still in the stash.
++
+So if you don't plan to reset the following workflow may be handy.
+Suppose you have changes to files A, B, C; you continue to edit A and
+B, but want to stash C:
++
+----------------------------------------------------------------
+$ git reset                     # make the index clean
+$ git add -p A C                # add necessary bits to the index
+$ git stash save --keep-index   # current index is left untouched
+... test, debug, perfect ...
+$ git commit
+$ git stash pop                 # get the remainder back
+... and continue to work ...
+----------------------------------------------------------------
 
 SEE ALSO
 --------
-- 
1.7.0
