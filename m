From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v5 8/8] MSVC: Enable OpenSSL, and translate -lcrypto
Date: Wed, 21 Oct 2009 19:04:51 +0200
Message-ID: <1256144691-2908-9-git-send-email-kusmabite@gmail.com>
References: <1256144691-2908-1-git-send-email-kusmabite@gmail.com>
 <1256144691-2908-2-git-send-email-kusmabite@gmail.com>
 <1256144691-2908-3-git-send-email-kusmabite@gmail.com>
 <1256144691-2908-4-git-send-email-kusmabite@gmail.com>
 <1256144691-2908-5-git-send-email-kusmabite@gmail.com>
 <1256144691-2908-6-git-send-email-kusmabite@gmail.com>
 <1256144691-2908-7-git-send-email-kusmabite@gmail.com>
 <1256144691-2908-8-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Marius Storm-Olsen <mstormo@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 19:06:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0edJ-0007uR-Mi
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 19:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754472AbZJURFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 13:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754467AbZJURFl
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 13:05:41 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:63374 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402AbZJURFk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 13:05:40 -0400
Received: by mail-ew0-f207.google.com with SMTP id 3so6261965ewy.17
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fvh8tjumvNr/Hh/bwBptXAaMM6qOjX9HGTJsXvRBps8=;
        b=ZIfjDNDaRmHThsbNiJRHbMxIZtBe7FiVCARWj2bBYgHllXuKUvr+YjNaLx2mmSImFL
         px6pmbdBZMudFqooa0jRGAZwCbodTaSTobzqtMO5Svne0bjCEy+RQDQQ3GiNvs/j5Fj0
         yAbaI+FysJGX/iRj5e/9Xeu+7D/tMcyBI6uHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eCforeTFNVWrlt0uA8UPPOuBba10a4A+Kqa16iM00CNDzspxJdwhU3ouuWGBkq72Cl
         9ClLL8y5bX6Gq6cFMuADyzRxTkNYjODFatfPlNHhsVkYAHuBm3iz7YBpW0u116IGCOgT
         UX5IxJbcvGvefSeG+/9vk4DhQKECLsTSMCN0U=
Received: by 10.210.7.24 with SMTP id 24mr1332193ebg.48.1256144744466;
        Wed, 21 Oct 2009 10:05:44 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 23sm900295eya.12.2009.10.21.10.05.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Oct 2009 10:05:43 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1256144691-2908-8-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130935>

From: Marius Storm-Olsen <mstormo@gmail.com>

We don't use crypto, but rather require libeay32 and
ssleay32. handle it in both the Makefile msvc linker
script, and the buildsystem generator.

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile                        |    2 +-
 compat/vcbuild/scripts/clink.pl |    3 +++
 contrib/buildsystems/engine.pl  |    3 +++
 3 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 986483b..1e1a2f2 100644
--- a/Makefile
+++ b/Makefile
@@ -900,7 +900,7 @@ ifdef MSVC
 	GIT_VERSION := $(GIT_VERSION).MSVC
 	pathsep = ;
 	NO_PREAD = YesPlease
-	NO_OPENSSL = YesPlease
+	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NO_IPV6 = YesPlease
diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
index f9528c0..8a2112f 100644
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
1.6.4.msysgit.0
