From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 1/2] Make generated MSVC solution file open from Windows Explorer
Date: Mon, 28 Sep 2009 13:34:20 +0200
Message-ID: <bffcec831c47d8f82e41ee629bd381dbcc7221d0.1254137149.git.mstormo@gmail.com>
References: <cover.1254137149.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org, spearce@spearce.org, sschuberth@gmail.com
X-From: git-owner@vger.kernel.org Mon Sep 28 13:35:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsEVH-0001sp-9B
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 13:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbZI1Len (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 07:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752781AbZI1Len
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 07:34:43 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:48859 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbZI1Lel (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 07:34:41 -0400
Received: by ewy7 with SMTP id 7so4324429ewy.17
        for <git@vger.kernel.org>; Mon, 28 Sep 2009 04:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=L32rRNcb+b0t2cb6Pt/rkZwRujGqhmZqKA5KwJm9b30=;
        b=q+aR/F9wZqK+35duzMDZRcLVPxmmDF35VXzJzLNf3RqTctiGW2IOM5AKYIn4PWJ2gt
         j3siUT35JpWv+nnOcKvLZrdr89hZqrvTuCwnD5zzubx7lUw7VECVRv3V4kCEBIWwtZ9i
         /Dl9JcERuMDainuEYM+VkcxtXMFl7NkHA0iC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nbbrecBL1UoC24SLDgors0S2krjhePUwbG/p2+sa6vDH0DRUeXcEOLQGL6fO23Z7/r
         iu72QfpIdmMKFMqUYnlmH3ZhX7AF3lG9XeMdmhTwEm3NGlAew9/r1kelWwZdOllMWQyP
         KX447gkwlZ65iF8Jad/dS5dWdJeRYrAqB/Hrc=
Received: by 10.211.158.8 with SMTP id k8mr3613979ebo.38.1254137684125;
        Mon, 28 Sep 2009 04:34:44 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 5sm755655eyh.35.2009.09.28.04.34.43
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 28 Sep 2009 04:34:43 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc2.177.ga9dd6
In-Reply-To: <cover.1254137149.git.mstormo@gmail.com>
In-Reply-To: <cover.1254137149.git.mstormo@gmail.com>
References: <4ABB84F4.7080403@gmail.com> <cover.1254137149.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129253>

From: Sebastian Schuberth <sschuberth@gmail.com>

In order to be able to open the generated solution file by double-
clicking it in Windows Explorer, all project files need to use DOS
line-endings and a comment about the Visual Studio version needs to
be added to the header of the solution file. This also fixes the icon
that is displayed for the solution file in Windows Explorer.
Note that opening the solution file from a running instance of Visual
Studio already worked before.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
Acked-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 contrib/buildsystems/Generators/Vcproj.pm |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/contrib/buildsystems/Generators/Vcproj.pm b/contrib/buildsystems/Generators/Vcproj.pm
index 00ec0c1..50daa03 100644
--- a/contrib/buildsystems/Generators/Vcproj.pm
+++ b/contrib/buildsystems/Generators/Vcproj.pm
@@ -131,6 +131,7 @@ sub createLibProject {
     $includes =~ s/-I//g;
     mkdir "$target" || die "Could not create the directory $target for lib project!\n";
     open F, ">$target/$target.vcproj" || die "Could not open $target/$target.pro for writing!\n";
+    binmode F, ":crlf";
     print F << "EOM";
 <?xml version="1.0" encoding = "Windows-1252"?>
 <VisualStudioProject
@@ -353,6 +354,7 @@ sub createAppProject {
     $includes =~ s/-I//g;
     mkdir "$target" || die "Could not create the directory $target for lib project!\n";
     open F, ">$target/$target.vcproj" || die "Could not open $target/$target.pro for writing!\n";
+    binmode F, ":crlf";
     print F << "EOM";
 <?xml version="1.0" encoding = "Windows-1252"?>
 <VisualStudioProject
@@ -537,7 +539,7 @@ sub createGlueProject {
     print "Generate solutions file\n";
     $rel_dir = "..\\$rel_dir";
     $rel_dir =~ s/\//\\/g;
-    my $SLN_HEAD = "Microsoft Visual Studio Solution File, Format Version 10.00\n";
+    my $SLN_HEAD = "Microsoft Visual Studio Solution File, Format Version 10.00\n# Visual Studio 2008\n";
     my $SLN_PRE  = "Project(\"{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}\") = ";
     my $SLN_POST = "\nEndProject\n";
 
@@ -560,6 +562,7 @@ sub createGlueProject {
     @apps = @tmp;
 
     open F, ">git.sln" || die "Could not open git.sln for writing!\n";
+    binmode F, ":crlf";
     print F "$SLN_HEAD";
     foreach (@libs) {
         my $libname = $_;
-- 
1.6.5.rc2.177.ga9dd6
