From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH 8/8] MSVC: Enable OpenSSL, and translate -lcrypto
Date: Fri,  9 Oct 2009 17:04:42 +0200
Message-ID: <1255100682-13952-8-git-send-email-kusmabite@gmail.com>
References: <1255100682-13952-1-git-send-email-kusmabite@gmail.com>
 <1255100682-13952-2-git-send-email-kusmabite@gmail.com>
 <1255100682-13952-3-git-send-email-kusmabite@gmail.com>
 <1255100682-13952-4-git-send-email-kusmabite@gmail.com>
 <1255100682-13952-5-git-send-email-kusmabite@gmail.com>
 <1255100682-13952-6-git-send-email-kusmabite@gmail.com>
 <1255100682-13952-7-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com, Marius Storm-Olsen <mstormo@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 17:11:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwH8C-0007fT-Da
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 17:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761071AbZJIPGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 11:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761066AbZJIPGo
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 11:06:44 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:65273 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760855AbZJIPGn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 11:06:43 -0400
Received: by ewy4 with SMTP id 4so698009ewy.37
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 08:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WzSkNrLYPSgVWkbgbrse6zF9teeFQzSIKfTjYCfcnus=;
        b=m2GC2DvwWarros/oUiylQg3KUoU/6QahIj8iL774g2TXjREAJ7JyC1Gh6Mb+vP/iFL
         Zr/HKLL822KK+ewLdHbEgafbSEefhXb5PfulOKaJW5kKB/PdNU1I3ase8ModMtD74/qV
         AvhOHjC+v67QSjZ3JVlvAdNQG1APOXrZIbcrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RQbgfKZCsF8NYs+ZUb7oqiCX9EusAr3zWEhtN0J8ED/kDVMseVwCsZ2zFmwmUpRiQH
         sqf1uvduDrKHUDTGMmNT85P19WitRdj0zdk2NNKiU9/rd7yngH4dOPqrbT8YalECbGnr
         0lBhvYrst5qHH1+XmrjjqJPTdFGsji5nXpUWo=
Received: by 10.211.147.10 with SMTP id z10mr370884ebn.28.1255100766320;
        Fri, 09 Oct 2009 08:06:06 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 10sm1138768eyd.14.2009.10.09.08.06.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 08:06:05 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1255100682-13952-7-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129811>

From: Marius Storm-Olsen <mstormo@gmail.com>

We don't use crypto, but rather require libeay32 and
ssleay32. handle it in both the Makefile msvc linker
script, and the buildsystem generator.

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile                        |    1 -
 compat/vcbuild/scripts/clink.pl |    3 +++
 contrib/buildsystems/engine.pl  |    3 +++
 3 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 8818f0f..c4b91d8 100644
--- a/Makefile
+++ b/Makefile
@@ -881,7 +881,6 @@ ifdef MSVC
 	GIT_VERSION := $(GIT_VERSION).MSVC
 	pathsep = ;
 	NO_PREAD = YesPlease
-	NO_OPENSSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NO_IPV6 = YesPlease
diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
index 0ffd59f..fce1e24 100644
--- a/compat/vcbuild/scripts/clink.pl
+++ b/compat/vcbuild/scripts/clink.pl
@@ -29,6 +29,9 @@ while (@ARGV) {
 		push(@args, "zlib.lib");
 	} elsif ("$arg" eq "-liconv") {
 		push(@args, "iconv.lib");
+	} elsif ("$arg" eq "-lcrypto") {
+		push(@args, "libeay32.lib");
+		push(@args, "ssleay32.lib");
 	} elsif ("$arg" =~ /^-L/ && "$arg" ne "-LTCG") {
 		$arg =~ s/^-L/-LIBPATH:/;
 		push(@args, $arg);
diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 20bd061..d506717 100644
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -315,6 +315,9 @@ sub handleLinkLine
             $appout = shift @parts;
         } elsif ("$part" eq "-lz") {
             push(@libs, "zlib.lib");
+	} elsif ("$part" eq "-lcrypto") {
+            push(@libs, "libeay32.lib");
+            push(@libs, "ssleay32.lib");
         } elsif ($part =~ /^-/) {
             push(@lflags, $part);
         } elsif ($part =~ /\.(a|lib)$/) {
-- 
1.6.5.rc1.60.g41795
