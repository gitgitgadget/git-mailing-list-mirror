From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git add -p =?utf-8?Q?=E2=80=9CYour?= edited hunk does not
 apply. Edit =?utf-8?Q?again=E2=80=9D?=
Date: Tue, 14 Apr 2015 11:43:05 +0200
Message-ID: <vpq7ftfkpue.fsf@anie.imag.fr>
References: <loom.20150414T035141-286@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Tanky Woo <wtq1990@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 11:43:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhxNG-0004Fm-1E
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 11:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbbDNJnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 05:43:14 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35060 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329AbbDNJnM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 05:43:12 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t3E9h41K020563
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 14 Apr 2015 11:43:05 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3E9h62Z006745;
	Tue, 14 Apr 2015 11:43:06 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 14 Apr 2015 11:43:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3E9h41K020563
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1429609388.85266@6P3BzNWN8gKh49ds5x1ZYQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267127>

Tanky Woo <wtq1990@gmail.com> writes:

> -       coverage erase
> +
> +covhtml:
> +       make clean
> +       nosetests
> +       coverage html
> +       cd ${HTMLCOV} && python -m SimpleHTTPServer
> So I use e to manually edit the hunk, I delete all the + lines, it seems:

I can reproduce on git.git's master. Actually, you don't even have to
edit the patch, just save and exit, and you get the same error message.
So it's clearly a bug.

I can get the same kind of bug with "stash -p", without even using the
'e' command, by doing "split" and then answer n, y. On a simpler example
with two hunks:

$ git stash -p
diff --git a/bar.txt b/bar.txt
index 35fbd83..1d3fda3 100644
--- a/bar.txt
+++ b/bar.txt
@@ -1,4 +1,6 @@
 aaa
+added line 1
 bbb
+added line 2
 ccc
 ddd
Stash this hunk [y,n,q,a,d,/,s,e,?]? s
Split into 2 hunks.
@@ -1,2 +1,3 @@
 aaa
+added line 1
 bbb
Stash this hunk [y,n,q,a,d,/,j,J,g,e,?]? n
@@ -2,3 +3,4 @@
 bbb
+added line 2
 ccc
 ddd
Stash this hunk [y,n,q,a,d,/,K,g,e,?]? y

Saved working directory and index state WIP on master: 1cad001 abcd
error: patch failed: bar.txt:1
error: bar.txt: patch does not apply
Cannot remove worktree changes

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
