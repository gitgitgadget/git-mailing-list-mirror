From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] test: fix t7001 cp to use POSIX options
Date: Fri, 11 Apr 2014 06:44:07 -0700
Message-ID: <4def160d638b09b02e04f45688c41a8@74d39fa044aa309eaea14b9f57fe79c>
References: <1c3e86191de8c91545ac3ddc18fd31e@74d39fa044aa309eaea14b9f57fe79c> <20140411114338.GD28858@sigill.intra.peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 11 15:44:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYbkt-0001Qs-43
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 15:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411AbaDKNoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 09:44:24 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:41999 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754211AbaDKNoX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 09:44:23 -0400
Received: by mail-pd0-f182.google.com with SMTP id y10so5280692pdj.41
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 06:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m2yeam8H6Gy74IkEBsL/p1h3ULHT2sBg+Lva9nXzJrI=;
        b=LwuxK4h4fmS2lBlbK5JRT0YsTawOaFU0/uEvkMuBabA8S+4BR9/8pOl/CGNbaju7T4
         KNrlyQ80L2tGmya/YJqjKa6U/vofcT1f9dJMSPWIUdDlevAURmND273kLCDTA7SzSXCp
         5gaA18ZaCJuWJSzdZxTzbV5GISivUaUsgEq9FFgZOCCvsEmut0Ly0AeJxJpdDJfSMduR
         JUGkeH2FNwtemulQq7BvNBOABqnp2h8/pNOznjucnBGxzFWPe9uAwyWAdIYcmt0IBOr4
         xO+dqT7zCB8VqMcWDIqetCOGfrvRiT2Y1QjCdaqBnl7XaHNPA3d+Pp0Iz0HUtlURXgt0
         Vz6Q==
X-Received: by 10.66.252.135 with SMTP id zs7mr27411977pac.13.1397223863005;
        Fri, 11 Apr 2014 06:44:23 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ov4sm11269154pbc.46.2014.04.11.06.44.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 06:44:22 -0700 (PDT)
In-Reply-To: <20140411114338.GD28858@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246091>

On Apr 11, 2014, at 04:43, Jeff King wrote:
> On Fri, Apr 11, 2014 at 01:24:02AM -0700, Kyle J. McKay wrote:
>
>> Since 11502468 and 04c1ee57 (both first appearing in v1.8.5), the
>> t7001-mv test has used "cp -a" to perform a copy in several of the
>> tests.
>>
>> However, the "-a" option is not required for a POSIX cp utility and
>> some platforms' cp utilities do not support it.
>>
>> The POSIX equivalent of -a is -R -P -p.
>>
>> Change "cp -a" to "cp -R -P -p" so that the t7001-mv test works
>> on systems with a cp utility that only implements the POSIX
>> required set of options and not the "-a" option.
>
> I wonder if the "-R" is the part that we actually care about here.
> Including the others does not hurt in that case, but using only "-R"
> would perhaps make it more obvious to a later reader of the code  
> exactly
> what we are trying to do.

I was wondering the same thing myself, but Jens is on the Cc: list and  
added both of those, so I'm hoping he'll pipe in here about that.  I  
did notice that the other test scripts seem to only use -R, so that  
would definitely be a more consistent change to match the rest of the  
tests.

In any case v2 of the patch with just -R is attached below.  It seems
to pass the tests so it's probably fine.

--Kyle

---- 8< ----

Subject: [PATCH v2] test: fix t7001 cp to use POSIX options

Since 11502468 and 04c1ee57 (both first appearing in v1.8.5), the
t7001-mv test has used "cp -a" to perform a copy in several of the
tests.

However, the "-a" option is not required for a POSIX cp utility and
some platforms' cp utilities do not support it.

The POSIX equivalent of -a is -R -P -p, but the only option we
actually care about for the test is -R.

Change "cp -a" to "cp -R" so that the t7001-mv test works
on systems with a cp utility that only implements the POSIX
required set of options and not the "-a" option.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>

---
 t/t7001-mv.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 215d43d6..675ca5bd 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -308,7 +308,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and no .gitm
 	(
 		cd sub &&
 		rm -f .git &&
-		cp -a ../.git/modules/sub .git &&
+		cp -R ../.git/modules/sub .git &&
 		GIT_WORK_TREE=. git config --unset core.worktree
 	) &&
 	mkdir mod &&
@@ -331,7 +331,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and .gitmodu
 	(
 		cd sub &&
 		rm -f .git &&
-		cp -a ../.git/modules/sub .git &&
+		cp -R ../.git/modules/sub .git &&
 		GIT_WORK_TREE=. git config --unset core.worktree
 	) &&
 	mkdir mod &&
-- 
tg: (0bc85abb..) t/t7001-posix-cp (depends on: maint)
