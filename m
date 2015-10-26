From: Pietro Battiston <me@pietrobattiston.it>
Subject: Filters and diff vs. status
Date: Mon, 26 Oct 2015 15:54:44 +0100
Message-ID: <1445871284.2698.43.camel@pietrobattiston.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 26 16:01:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqjGa-0006I4-F1
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 16:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbbJZPAv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Oct 2015 11:00:51 -0400
Received: from pietrobattiston.it ([92.243.7.39]:54273 "EHLO
	jauntuale.pietrobattiston.it" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754156AbbJZPAt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2015 11:00:49 -0400
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2015 11:00:49 EDT
Received: from debiousci (nat-sc.sssup.it [193.205.81.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by jauntuale.pietrobattiston.it (Postfix) with ESMTPSA id 1F7274E7A
	for <git@vger.kernel.org>; Mon, 26 Oct 2015 15:54:45 +0100 (CET)
X-Mailer: Evolution 3.18.1-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280197>

Dear mailing list,

I am using, on specific files, a filter which I created.=C2=B9 Often, f=
iles
being tracked are modified in a way not meant to be reflected in the
git history to result in changes to be committed. And sometimes, the
following happens:

pietro@debiousci:~/path/to/repo$ git status a_file.ipynb
On branch master
Your branch is up-to-date with 'origin/master'.
Changes not staged for commit:
=C2=A0 (use "git add <file>..." to update what will be committed)
=C2=A0 (use "git checkout -- <file>..." to discard changes in working
directory)

	modified:=C2=A0=C2=A0=C2=A0a_file.ipynb

no changes added to commit (use "git add" and/or "git commit -a")
pietro@debiousci:~/path/to/repo$ git diff a_file.ipynb
pietro@debiousci:~/path/to/repo$


(notice that no diff shown). Then I wonder what is happening (checking
out the file doesn't help, resetting --hard neither), and I try to
commit the (apparently unchanged) file . And I get the following:


pietro@debiousci:~/path_to_repo$ git commit a_file.ipynb -m '?!'
[master
c76125a] ?!
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)
pietro@debiousci:~/path/to/repo$ git show HEAD
commit c76125a537f88db4ff5d13c97b92e1f01c13bb47
Author: Pietro Battiston <me@pietrobattiston.it>
Date:=C2=A0=C2=A0=C2=A0Mon Oct 26 13:37:24 2015 +0100

=C2=A0=C2=A0=C2=A0=C2=A0?!

diff --git a/a_file.ipynb b/a_file.ipynb
index dfdbd79..61663fb 100644
--- a/notebook/a_file.ipynb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
+++ b/notebook/a_file.ipynb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
@@ -349,4 +349,4 @@
=C2=A0=C2=A0=C2=A0=C2=A0"metadata": {}
=C2=A0=C2=A0=C2=A0}
=C2=A0 ]
-}
\ No newline at end of file
+}


Now, I don't particularly care about a newline being present or not at
the end of the file, but the fact that the working tree looks dirty
(forbidding me from doing merges) - and that I don't understand why,
and how to fix this without adding bogus commits, annoys me.
I found an analogous behaviour reported some years ago,=C2=B2 and the
conclusion was "I think that there is a bug. I have observed this as
well with my own clean filter sometimes, but not always. I haven't
found a recipe that reliably exhibits the problem." Apart from that, I
have found no clue of why "git diff" and "git status" do not agree.

Does anybody have any pointer to solve this? I could try to play with
my filter imposing that it adds/doesn't add a newline at the end of its
output, but I am really missing the logic of what is going on on the
git side.

Thanks in advance,

Pietro



=C2=B9 I don't want to waste anybody's time (I guess the answer to my
problem is pretty general), but for more details see
=C2=A0https://github.com/toobaz/ipynb_output_filter=C2=A0, presenting b=
oth the
script and the configuration I use.

=C2=B2=C2=A0
http://thread.gmane.org/gmane.comp.version-control.git/125378/focus=3D1=
25
684
