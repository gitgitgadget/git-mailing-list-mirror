From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] git.el: Only show completions from refs/heads, refs/remotes and refs/tags
Date: Tue, 24 Feb 2009 16:40:54 +0100
Message-ID: <871vtnvo55.fsf@krank.kagedal.org>
References: <1235464350-23383-1-git-send-email-davidk@lysator.liu.se>
	<87fxi4ut2p.fsf@krank.kagedal.org> <87ocwrx527.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 16:42:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbzQQ-00066g-Ea
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 16:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975AbZBXPk6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 10:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755789AbZBXPk6
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 10:40:58 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:43024 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755414AbZBXPk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 10:40:57 -0500
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 155654001C;
	Tue, 24 Feb 2009 16:40:48 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id 0AFAA40007; Tue, 24 Feb 2009 16:40:48 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id C13DB4001C;
	Tue, 24 Feb 2009 16:40:47 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 9BF84DC49C; Tue, 24 Feb 2009 16:40:54 +0100 (CET)
In-Reply-To: <87ocwrx527.fsf@wine.dyndns.org> (Alexandre Julliard's message of "Tue\, 24 Feb 2009 15\:50\:08 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111301>

Alexandre Julliard <julliard@winehq.org> writes:

> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>
>> Sorry, I didn't check this properly. I thought I was fixing inside t=
he
>> git-checkout function, but this is git-read-commit-name which is use=
d
>> in more than one place.
>>
>> But for git-checkout, I would like to see a much shorter list of nam=
ed
>> commits, namely those that can be called "branches". I'll come up wi=
th
>> a better patch.
>
> I think it's reasonable to do this for the other uses of
> git-read-commit-name too, so your original patch looks OK.

Actually, I'd like to go one step further. I'm only interested in
branches, and only in branches I can commit to. So only asking for
refs/heads seems the best solution.

And the default parameter to git-read-commit-name is never used, so I
removed it.

And completing-read works fine with an alist, so the mapcar isn't
nedded any more.

Here is an updated patch:

=46rom: David K=C3=A5gedal <davidk@lysator.liu.se>
Subject: [PATCH] git.el: Only show completions from refs/heads

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
 contrib/emacs/git.el |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index feb229c..d4f8710 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1385,11 +1385,9 @@ With a prefix arg, diff the marked files instead=
=2E"
         (push (match-string 1) files)))
     files))
=20
-(defun git-read-commit-name (prompt &optional default)
+(defun git-read-commit-name (prompt)
   "Ask for a commit name, with completion for local branch, remote bra=
nch and tag."
-  (completing-read prompt
-                   (list* "HEAD" "ORIG_HEAD" "FETCH_HEAD" (mapcar #'ca=
r (git-for-each-ref)))
-		   nil nil nil nil default))
+  (completing-read prompt (git-for-each-ref "refs/heads")))
=20
 (defun git-checkout (branch &optional merge)
   "Checkout a branch, tag, or any commit.
--=20
1.6.2.rc1.21.gda6d



--=20
David K=C3=A5gedal
