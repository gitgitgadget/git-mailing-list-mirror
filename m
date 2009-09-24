Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 4887 invoked by uid 107); 24 Sep 2009 14:49:08 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Thu, 24 Sep 2009 10:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412AbZIXOmR (ORCPT <rfc822;peff@peff.net>);
	Thu, 24 Sep 2009 10:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbZIXOmQ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 10:42:16 -0400
Received: from lo.gmane.org ([80.91.229.12]:33963 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753406AbZIXOmP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 10:42:15 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MqpWT-0003f7-86
	for git@vger.kernel.org; Thu, 24 Sep 2009 16:42:17 +0200
Received: from 91-64-214-160-dynip.superkabel.de ([91.64.214.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Sep 2009 16:42:17 +0200
Received: from sschuberth by 91-64-214-160-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Sep 2009 16:42:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	Sebastian Schuberth <sschuberth@gmail.com>
Subject:  [PATCH 1/2] Make generated MSVC solution file open from Windows Explorer
Date:	Thu, 24 Sep 2009 16:40:52 +0200
Message-ID:  <4ABB84F4.7080403@gmail.com>
Mime-Version:  1.0
Content-Type:  text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding:  7bit
X-Complaints-To: usenet@ger.gmane.org
Cc:	mstormo@gmail.com
X-Gmane-NNTP-Posting-Host: 91-64-214-160-dynip.superkabel.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

 From c6d29a2d243647bb2877eb2114938ae20c8e56e5 Mon Sep 17 00:00:00 2001
From: Sebastian Schuberth <sschuberth@gmail.com>
Date: Thu, 24 Sep 2009 15:52:25 +0200
Subject: [PATCH 1/2] Make generated MSVC solution file open from Windows Explorer

In order to be able to open the generated solution file by double-clicking it
in Windows Explorer, all project files need to use DOS line-endings and a
comment about the Visual Studio version needs to be added to the header of the
solution file. This also fixes the icon that is displayed for the solution file
in Windows Explorer.
Note that opening the solution file from a running instance of Visual Studio
already worked before.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
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
1.6.4.msysgit.0

