From: Sergey Shelukhin <sergey@hortonworks.com>
Subject: strange problems applying --no-prefix patch with -p0 and added files
Date: Wed, 24 Oct 2012 13:54:30 -0700
Message-ID: <CAHXxaiCELHomSPQoZWw+SdV61Y0gVb9MEdRv-gCOfkJG50xCeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 24 22:54:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TR7yP-00022l-4A
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 22:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746Ab2JXUyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 16:54:32 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33423 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205Ab2JXUyb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 16:54:31 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1352871lbo.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 13:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :x-gm-message-state;
        bh=S7WF5rCC1adDbHdEztwwcrs+Y3hwm+xnDlsR8bIt4q4=;
        b=mP2n6tXLN9t7Nb7XeiHiVeP/VQrXmwCHWAYYF7iVB4vGBi5+h1sA6dqiSgrPk/gYZI
         woS7gIxmNOirKwro7VBv2q6Qvx+n3nXDdUA1d5eei1NrZorf8bIqVFLFE+ZS730Pr+eG
         ICGmx5BEmGsa5O/9dHWu2PbnbksX3Yne8I4zMiha6+nRVXbnBVv390QOKn/OghqXxJM/
         M8hw/6D5D2/iO4V2b7He+xr9FhQYSlna26c4GDx1CJ2IIfXD6HrQbUhzBevXcpjIKt1l
         7CKtAqjg5XMAX/anM2O5G+89nPMpLY+sRMVkD0G+9W0XbQnydLuSLCZO/tf7dgMT+LLY
         I3Rg==
Received: by 10.152.110.74 with SMTP id hy10mr15747633lab.54.1351112070237;
 Wed, 24 Oct 2012 13:54:30 -0700 (PDT)
Received: by 10.114.14.134 with HTTP; Wed, 24 Oct 2012 13:54:30 -0700 (PDT)
X-Gm-Message-State: ALoCoQnBB5wRGo4NXTfEQ2WjOE3P6a+lsxdZ50NlHF1XmPismIT+NYWZ6IDvy95FOAf6cP35CmMm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208323>

Hello.
I am trying to apply a patch made via {git diff somehash^ somehash >
....} before (same version of Git, same machine). I have no-prefix
enabled by default.
If I try to apply the patch with -p0, it fails.
If I go to a directory where all the changed files are ("src/" below)
to "simulate" the prefix for -p1, it silently does nothing.
Only if I make it a -p1 patch, it actually tries to do apply (and
applies the new files that cause problems in -p0 alright too, if used
with --reject).

I am relatively new to git, so while researching I realized I might be
using wrong ways to do things (e.g. not using cherry-pick), but this
seems like a bug regardless.

Here's the log of my interactions with git:

reznor-mbp:git-hbase-089 sergey$ git version
git version 1.7.10.2 (Apple Git-33)
reznor-mbp:git-hbase-089 sergey$ git status
# On branch 0.94
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#    HBASE-6371.patch
nothing added to commit but untracked files present (use "git add" to track)
reznor-mbp:git-hbase-089 sergey$ git apply -p0 HBASE-6371.patch
fatal: git apply: bad git-diff - inconsistent new filename on line 128
reznor-mbp:git-hbase-089 sergey$ sed -n 125,129p HBASE-6371.patch
diff --git src/main/java/org/apache/
hadoop/hbase/regionserver/CompactSelection.java
src/main/java/org/apache/hadoop/hbase/regionserver/CompactSelection.java
new file mode 100644
index 0000000..a9ee0d4
--- /dev/null
+++ src/main/java/org/apache/hadoop/hbase/regionserver/CompactSelection.java
reznor-mbp:git-hbase-089 sergey$ cd src
reznor-mbp:src sergey$ git apply -p1 -v --whitespace=nowarn ../HBASE-6371.patch
[ there's nothing here, e.g. no output ]
reznor-mbp:src sergey$ git status
# On branch 0.94
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#    ../HBASE-6371.patch
nothing added to commit but untracked files present (use "git add" to track)
reznor-mbp:src sergey$ cd ..
reznor-mbp:git-hbase-089 sergey$ sed -E "s/(--git|---) src/\1 a\/src/"
HBASE-6371.patch | sed -E "s/ src\// b\/src\//" >
HBASE-6371-prefix.patch
reznor-mbp:git-hbase-089 sergey$ git apply HBASE-6371-prefix.patch
HBASE-6371-prefix.patch:169: trailing whitespace.
 ...
error: patch failed:
src/main/java/org/apache/hadoop/hbase/HBaseConfiguration.java:64
error: src/main/java/org/apache/hadoop/hbase/HBaseConfiguration.java:
patch does not apply
....
