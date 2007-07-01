From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: [PATCH] Document git-stash
Date: Sun, 01 Jul 2007 14:26:08 +0900
Message-ID: <200707010533.l615XiH6006728@mi1.bluebottle.com>
References: <Pine.LNX.4.64.0706301853400.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 01 07:33:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4s4C-0000Y8-4E
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 07:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbXGAFdq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 01:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbXGAFdq
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 01:33:46 -0400
Received: from mi1.bluebottle.com ([206.188.25.14]:35178 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbXGAFdp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 01:33:45 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l615XiH6006728
	for <git@vger.kernel.org>; Sat, 30 Jun 2007 22:33:44 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=T1y1Th4flQEK8bbP0quwmH7ZAiv0fA3f74kwYW41blEK3BBOIpyARH5UDpW2BLQsm
	x4pYm7unydnMqbNh/wjK/aO6dCuiLlGIAPczePEMIPz9883u0M8+cwt7YL/EY0m
Received: from nanako3.mail.bluebottle.com (riy01che04.ae.net.sa [212.162.130.92])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l615Xash003431
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 30 Jun 2007 22:33:41 -0700
cc: Junio C Hamano <gitster@pobox.com>
In-Reply-To: <Pine.LNX.4.64.0706301853400.4438@racer.site>
X-Trusted-Delivery: <cfb64577876a5ebac796001d2a0e08e5>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51276>

This describes the git-stash command.

I borrowed a few paragraphs from Johannes's version, and added a few
examples.

Signed-off-by: Nanako Shiraishi <nanako3@bluebottle.com>
---
 Documentation/cmd-list.perl |    1 +
 Documentation/git-stash.txt |  162 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 163 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-stash.txt

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index fcea1d7..8ee8122 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -178,6 +178,7 @@ git-show-ref                            plumbinginterrogators
 git-sh-setup                            purehelpers
 git-ssh-fetch                           synchingrepositories
 git-ssh-upload                          synchingrepositories
+git-stash                               mainporcelain
 git-status                              mainporcelain
 git-stripspace                          purehelpers
 git-submodule                           mainporcelain
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
new file mode 100644
index 0000000..17ebc83
--- /dev/null
+++ b/Documentation/git-stash.txt
@@ -0,0 +1,162 @@
+git-stash(1)
+============
+
+NAME
+----
+git-stash - Stash the changes in a dirty working directory away
+
+SYNOPSIS
+--------
+[verse]
+'git-stash'
+'git-stash' [list | show [<stash>] | apply [<stash>] | clear]
+
+DESCRIPTION
+-----------
+
+Use 'git-stash' when you want to record the current state of the
+working directory and the index, but want to go back to a clean
+working directory.  The command saves your local modifications away
+and reverts the working directory to match the `HEAD` commit.
+
+The modifications stashed away by this command can be listed with
+`git-stash list`, inspected with `git-stash show`, and restored
+(potentially on top of a different commit) with `git-stash apply`
+commands.  The default operation when called without options is to
+save the changes away.
+
+The latest stash you created is stored in `$GIT_DIR/refs/stash`; older
+stashes are found in the reflog of this refererence and can be named using
+the usual reflog syntax (e.g. `stash@{1}` is the stash one previously made,
+`stash@{2}` is the one before it, `stash@{2.hours.ago}` is also possible).
+
+OPTIONS
+-------
+
+(no subcommand)::
+
+	Save your local modifications to a new 'stash', and run `git-reset
+	--hard` to revert them.
+
+list::
+
+	List the stashes that you currently have.  Each 'stash' is listed
+	with its name (e.g. `stash@{0}` is the latest stash, `stash@{1} is
+	the one before), the name of the branch that was current when the
+	stash was made, and a short description of the commit the stash was
+	based on.
++
+----------------------------------------------------------------
+stash@{0}: submit: 6ebd0e2... Add git-stash
+stash@{1}: master: 9cc0589... Merge branch 'master' of gfi
+----------------------------------------------------------------
+
+show [<stash>]::
+
+	Show the changes recorded in the stash.  When no `<stash>` is given,
+	shows the latest one.  By default, the command shows diffstat, but
+	you can add `-p` option (i.e. `git stash show -p stash@{2}`) to view
+	it in patch form.
+
+apply [<stash>]::
+
+	Restores the changes recorded in the stash on top of the current
+	working tree state.  When no `<stash>` is given, applies the latest
+	one.  The working directory must match the index.  When the changes
+	conflict, you need to resolve them by hand and mark the result with
+	`git add` as usual.  When the changes are cleanly merged, your
+	earlier local changes stored in the stash becomes the differences
+	between the index and the working tree (i.e. `git diff`), except
+	that newly created files are registered in the index (i.e. `git diff
+	--cached` is necessary to review the newly added files).
+
+clear::
+	Removes all the stashed states.
+
+
+DISCUSSION
+----------
+
+A stash is represented as a commit whose tree records the state of the
+working directory, and its first parent is the commit at `HEAD` when
+the stash was created.  The tree of the second parent records the
+state of the index when the stash is made, and it is made a child of
+the `HEAD` commit.  The ancestry graph looks like this:
+
+            .----W
+           /    /
+     ...--H----I
+
+where `H` is the `HEAD` commit, `I` is a commit that records the state
+of the index, and `W` is a commit that records the state of the working
+tree.
+
+
+EXAMPLES
+--------
+
+Pulling into a dirty tree::
+
+When you are in the middle of something, you learn that there are
+changes that possibly are relevant to what you are doing in the
+upstream.  When your local changes do not conflict with the changes in
+the upstream, a simple `git pull` will let you move forward.
++
+However, there are cases in which your local changes do conflict with
+the upstream changes, and `git pull` refuses to overwrite your
+changes.  In such a case, you can first stash your changes away,
+perform a pull, and then unstash, like this:
++
+----------------------------------------------------------------
+$ git pull
+...
+file foobar not up to date, cannot merge.
+$ git stash
+$ git pull
+$ git stash apply
+----------------------------------------------------------------
+
+Interrupted workflow::
+
+When you are in the middle of something, your boss comes in and
+demands you to fix something immediately.  Traditionally, you would
+make a commit to a temporary branch to store your changes away, and
+come back to make the emergency fix, like this:
++
+----------------------------------------------------------------
+... hack hack hack ...
+$ git checkout -b my_wip
+$ git commit -a -m "WIP"
+$ git checkout master
+$ edit emergency fix
+$ git commit -a -m "Fix in a hurry"
+$ git checkout my_wip
+$ git reset --soft HEAD^
+... continue hacking ...
+----------------------------------------------------------------
++
+You can use `git-stash` to simplify the above, like this:
++
+----------------------------------------------------------------
+... hack hack hack ...
+$ git stash
+$ edit emergency fix
+$ git commit -a -m "Fix in a hurry"
+$ git stash apply
+... continue hacking ...
+----------------------------------------------------------------
+
+SEE ALSO
+--------
+gitlink:git-checkout[1],
+gitlink:git-commit[1],
+gitlink:git-reflog[1],
+gitlink:git-reset[1]
+
+AUTHOR
+------
+Written by Nanako Shiraishi <nanako3@bluebottle.com>
+
+GIT
+---
+Part of the gitlink:git[7] suite
-- 
1.5.2.2

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Get a free email account with anti spam protection.
http://www.bluebottle.com
