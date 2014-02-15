From: =?ISO-8859-1?Q?Gr=E9gory_Pakosz?= <gregory.pakosz@gmail.com>
Subject: git diff, external diff tool, and submodules
Date: Sat, 15 Feb 2014 13:19:45 +0100
Message-ID: <CAC_01E0Pu+_UeSniFVhaqfu90d=iaFDqLrKZ1zjM6GMA4BvcGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 15 13:20:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEeEB-00041r-Rw
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 13:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbaBOMUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Feb 2014 07:20:09 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:52209 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbaBOMUI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Feb 2014 07:20:08 -0500
Received: by mail-lb0-f171.google.com with SMTP id c11so10291570lbj.30
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 04:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=5XYiFasgw8JtTDJX3JZg8TG4a1YYnBCzlTFXRsNLo1U=;
        b=LIU82G+ZSQOCUrJ3B4mgJ/4RlT9BVWXMWBmgOukZWfnET7FCbW+sAoIr6BKslexMB8
         lbE2Ba7kiDWIi5bDObLmYbJaCJLD4Cf9lDixg1YwxQltJjtUHSKsvxR0Nkqz5Iuxt/wT
         1hBPsjq4L9BEgZxetlYQFsReeXDVt9h4PgneOt+LBXy/b8IFBARRDl7uVXcNBJ8Nx8RI
         g9v9NKpEfPpNqR9QumiYTBuCp3el8qXNuO2Vrt4bytAMGgoMarifZEyKS4Z38qp5W+Ee
         IOlhCJr3XYCANO8PhxxC14TjI32p64BqcWOhFbC6m0Mhw2v4oyrgthzuPEDGQOvM2EOv
         ESrg==
X-Received: by 10.152.36.8 with SMTP id m8mr9562262laj.24.1392466805753; Sat,
 15 Feb 2014 04:20:05 -0800 (PST)
Received: by 10.152.207.163 with HTTP; Sat, 15 Feb 2014 04:19:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242188>

Hello,

When a submodule has new commits, I noticed the following:

$ git diff
diff --git a/submodule b/submodule
index 4c75be6..b272d40 160000
--- a/submodule
+++ b/submodule
@@ -1 +1 @@
-Subproject commit 4c75be6435cd515887d35c300ed8b487f8143d8e
+Subproject commit b272d4077fda29028c0bd02efba2837e12a8319c

As you can see, the diff shows the submodule has new commits.

However when using an external diff tool, it seems to me that git diff
fails to handle the submodule case:

$ GIT_EXTERNAL_DIFF=echo git diff
submodule /var/folders/1h/q9nt7m6d2fs61_v177kq1_h00000gn/T//cz1ati_submodule
4c75be6435cd515887d35c300ed8b487f8143d8e 160000 submodule
0000000000000000000000000000000000000000 160000

$LOCAL is set to a temp file that contains:
Subproject commit 4c75be6435cd515887d35c300ed8b487f8143d8e

And I expected $REMOTE to be set to another temp file that contains:
Subproject commit b272d4077fda29028c0bd02efba2837e12a8319c

Instead, $REMOTE is set to the actual submodule path and then visual
diff tools rightfully complains $REMOTE doesn't point to a valid file.

I think git diff should handle the submodule case and create 2
temporary files containing "Subproject commit sha1" for external diff
tools to compare.

What do you think?
Gregory

PS: git difftool has a special "directory mode" triggered with "-d"
that does what git diff does when GIT_EXTERNAL_DIFF is not set. It
creates temp files with "Subproject commit sha1" lines for diff tools
to compare.
