From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] contrib/hooks: avoid requiring root access in usage
 instructions
Date: Fri, 19 Oct 2012 17:31:04 -0700
Message-ID: <20121020003104.GA26596@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Olivier Berger <olivier.berger@it-sudparis.eu>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"Kevin P. Fleming" <kpfleming@digium.com>,
	Chris Hiestand <chiestand@salk.edu>,
	Miklos Vajna <vmiklos@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 20 02:33:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPN0Y-0003fl-Q1
	for gcvg-git-2@plane.gmane.org; Sat, 20 Oct 2012 02:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498Ab2JTAbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 20:31:22 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50146 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754827Ab2JTAbW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 20:31:22 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so721324pad.19
        for <git@vger.kernel.org>; Fri, 19 Oct 2012 17:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=cPNIvmaSnll3ayTaTkKZGYpuREKm9Fmn+eKZe3iUQQw=;
        b=killpq4GSVZdZJRHAgtppdrR83sFHrMVbyjI64tdFV/nfiKqt+cARF92ayvYRw1lzS
         KXkhk2SVgdeeF2SICtwTbqnMYHVYFqqnXrfVcjQxtA834jazxXYrod2e4VaNBwTapIpy
         4LIQtOzZtHA11nIDnXhIA8QQWxQf3qnLItLJ7ijxwg6Nx2rwgkNyzJl+20ARDy3PHeYA
         TcfTlxEIctDHyhjCpyiZWGJA6j3l5SwDUF5TEnPI2cdYRBINE7ZQ3CIVsOvHHis4mUMo
         y5x+trg96f0KPRRtca0mQviollbd379uwqF4EUxbVvLZ5vRBqRzSrWLHZxtJSLM2vhTN
         Dhhg==
Received: by 10.66.83.129 with SMTP id q1mr8609996pay.4.1350693081614;
        Fri, 19 Oct 2012 17:31:21 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id qb2sm1971160pbb.15.2012.10.19.17.31.12
        (version=SSLv3 cipher=OTHER);
        Fri, 19 Oct 2012 17:31:15 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208077>

Comments in hooks/post-receive-email suggest:

 For example, on debian the hook is stored in
 /usr/share/git-core/contrib/hooks/post-receive-email:

  chmod a+x post-receive-email
  cd /path/to/your/repository.git
  ln -sf /usr/share/git-core/contrib/hooks/post-receive-email hooks/post-receive

Doing that means changing permissions on a file provided by a package,
which is problematic in a number of ways: the permissions would be
likely to change back in later upgrades, and changing them requires
root access.  Copying the script into each repo that uses it is not
much better, since each copy would be maintained separately and not
benefit from bugfixes in the master copy.

Better to ship the hook with executable permission and remove the
chmod line so enabling the hook becomes a one-step process: just
symlink it into place.

Likewise for the pre-auto-gc-battery hook.

Reported-by: Olivier Berger <olivier.berger@it-sudparis.eu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
From <http://bugs.debian.org/687391>.

Thoughts?
Jonathan

 contrib/hooks/post-receive-email  | 1 -
 contrib/hooks/pre-auto-gc-battery | 1 -
 2 files changed, 2 deletions(-)
 mode change 100644 => 100755 contrib/hooks/pre-auto-gc-battery

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 8ca6607a..359f1ad2 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -13,7 +13,6 @@
 # For example, on debian the hook is stored in
 # /usr/share/git-core/contrib/hooks/post-receive-email:
 #
-#  chmod a+x post-receive-email
 #  cd /path/to/your/repository.git
 #  ln -sf /usr/share/git-core/contrib/hooks/post-receive-email hooks/post-receive
 #
diff --git a/contrib/hooks/pre-auto-gc-battery b/contrib/hooks/pre-auto-gc-battery
old mode 100644
new mode 100755
index 1f914c94..9d0c2d19
--- a/contrib/hooks/pre-auto-gc-battery
+++ b/contrib/hooks/pre-auto-gc-battery
@@ -13,7 +13,6 @@
 # For example, if the hook is stored in
 # /usr/share/git-core/contrib/hooks/pre-auto-gc-battery:
 #
-# chmod a+x pre-auto-gc-battery
 # cd /path/to/your/repository.git
 # ln -sf /usr/share/git-core/contrib/hooks/pre-auto-gc-battery \
 #	hooks/pre-auto-gc
-- 
1.8.0.rc2
