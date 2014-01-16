From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v4 6/6] Documentation: Describe 'submodule update' modes in detail
Date: Wed, 15 Jan 2014 20:10:27 -0800
Message-ID: <4a8dca477ed5b190767d6a4619c593a83f86f082.1389837412.git.wking@tremily.us>
References: <20140114224246.GA13271@book.hvoigt.net>
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 16 05:11:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3eIy-0001c1-QH
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 05:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbaAPELi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 23:11:38 -0500
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:49559
	"EHLO qmta09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751051AbaAPELc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jan 2014 23:11:32 -0500
Received: from omta06.westchester.pa.mail.comcast.net ([76.96.62.51])
	by qmta09.westchester.pa.mail.comcast.net with comcast
	id EUBG1n00116LCl059UBXLZ; Thu, 16 Jan 2014 04:11:31 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta06.westchester.pa.mail.comcast.net with comcast
	id EUBW1n00J152l3L3SUBWQz; Thu, 16 Jan 2014 04:11:31 +0000
Received: from mjolnir.tremily.us (unknown [192.168.0.141])
	by odin.tremily.us (Postfix) with ESMTPS id E0D49EFE492;
	Wed, 15 Jan 2014 20:11:29 -0800 (PST)
Received: (nullmailer pid 18581 invoked by uid 1000);
	Thu, 16 Jan 2014 04:11:04 -0000
X-Mailer: git-send-email 1.8.5.2.8.g0f6c0d1
In-Reply-To: <20140114224246.GA13271@book.hvoigt.net>
In-Reply-To: <cover.1389837412.git.wking@tremily.us>
References: <cover.1389837412.git.wking@tremily.us>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389845491;
	bh=fTbaxtLCl0voP1ti89BnWtgVfMSlzafuuEGC596mYKo=;
	h=Received:Received:Received:Received:From:To:Subject:Date:
	 Message-Id;
	b=dKPYZ9rB1tyN3Bvb/qNdrCZRMXloSYnnSxKIkG5NU2bjvLLuUWMDpl+o0vZpQwqSK
	 fU1L2ZsYDxMOWUgji+kGYIU4QMWZPBCNm9X64hzFViqZ7q4WQyBeQMtzmeISgY7Vf4
	 GCMefgANoOiyVjWbPqZfaExtXgBbtQRpzEiHyzFfhOSSEwz9ip3DsPZQAdvXFyegyy
	 gtxbZ1qEFn5oDbAxS3Qf6fEvEUQWzZziwC3NlD5uJbJFqcAInQJqmbn9vD57UDEDvf
	 NAh9paWlcYYAJsixwLRN9p5b/HLrXXTTAQsdQuhXWT5pErU2hfKuOkDrRinqgrXoh4
	 7mIVESPhX27uA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240503>

The old documentation did not distinguish between cloning and
non-cloning updates and lacked clarity on which operations would lead
to detached HEADs, and which would not.  The new documentation
addresses these issues while updating the docs to reflect the changes
introduced by this branch's explicit local branch creation in
module_clone.

I also add '--checkout' to the usage summary and group the update-mode
options into a single set.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/git-submodule.txt | 36 +++++++++++++++++++++++++++---------
 Documentation/gitmodules.txt    |  4 ++++
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index bfef8a0..02500b4 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -15,8 +15,8 @@ SYNOPSIS
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
-	      [-f|--force] [--rebase] [--reference <repository>] [--depth <depth>]
-	      [--merge] [--recursive] [--] [<path>...]
+	      [-f|--force] [--rebase|--merge|--checkout] [--reference <repository>]
+	      [--depth <depth>] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
@@ -155,13 +155,31 @@ it contains local modifications.
 
 update::
 	Update the registered submodules, i.e. clone missing submodules and
-	checkout the commit specified in the index of the containing repository.
-	This will make the submodules HEAD be detached unless `--rebase` or
-	`--merge` is specified or the key `submodule.$name.update` is set to
-	`rebase`, `merge` or `none`. `none` can be overridden by specifying
-	`--checkout`. Setting the key `submodule.$name.update` to `!command`
-	will cause `command` to be run. `command` can be any arbitrary shell
-	command that takes a single argument, namely the sha1 to update to.
+	checkout the commit specified in the index of the containing
+	repository.  The update mode defaults to 'checkout', but be
+	configured with the 'submodule.<name>.update' setting or the
+	'--rebase', '--merge', or 'checkout' options.
++
+For updates that clone missing submodules, checkout-mode updates will
+create submodules with detached HEADs; all other modes will create
+submodules with a local branch named after 'submodule.<path>.branch'.
++
+For updates that do not clone missing submodules, the submodule's HEAD
+is only touched when the remote reference does not match the
+submodule's HEAD (for none-mode updates, the submodule is never
+touched).  The remote reference is usually the gitlinked commit from
+the superproject's tree, but with '--remote' it is the upstream
+subproject's 'submodule.<name>.branch'.  This remote reference is
+integrated with the submodule's HEAD using the specified update mode.
+For checkout-mode updates, that will result in a detached HEAD.  For
+rebase- and merge-mode updates, the commit referenced by the
+submodule's HEAD may change, but the symbolic reference will remain
+unchanged (i.e. checked-out branches will still be checked-out
+branches, and detached HEADs will still be detached HEADs).  If none
+of the builtin modes fit your needs, set 'submodule.<name>.update' to
+'!command' to configure a custom integration command.  'command' can
+be any arbitrary shell command that takes a single argument, namely
+the sha1 to update to.
 +
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index f7be93f..36e5447 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -53,6 +53,10 @@ submodule.<name>.branch::
 	A remote branch name for tracking updates in the upstream submodule.
 	If the option is not specified, it defaults to 'master'.  See the
 	`--remote` documentation in linkgit:git-submodule[1] for details.
++
+This branch name is also used for the local branch created by
+non-checkout cloning updates.  See the 'update' documentation in
+linkgit:git-submodule[1] for details.
 
 submodule.<name>.fetchRecurseSubmodules::
 	This option can be used to control recursive fetching of this
-- 
1.8.5.2.8.g0f6c0d1
