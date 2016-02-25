From: larsxschneider@gmail.com
Subject: [PATCH v2] add DEVELOPER makefile knob to check for acknowledged warnings
Date: Thu, 25 Feb 2016 09:42:22 +0100
Message-ID: <1456389742-48052-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 09:42:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYrVH-0005XR-Kz
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 09:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759697AbcBYIm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 03:42:28 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34582 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758880AbcBYIm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 03:42:26 -0500
Received: by mail-wm0-f45.google.com with SMTP id b205so21653356wmb.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 00:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LSa6ZbBjF57ZSXMgIFta8vcqiji2VGMkR5nrLRaLpGc=;
        b=JiGHmRlAWaB8UrHgoB5YnP3u0L8PXyOyUEaf9NihyAikcWOEa12+PSie2kcVlJYNH2
         6XDwh/PZp0TThSr+icHb9kSOEQ8o2mKoPdZuRGkiN48qq/sR0lWy00QaQ4Xg9JcqDBso
         CjygY1ChRfWJiWZ98IDWY/7pPuaKdzvVnbWPaHPAssAClDZNn6DpkBxcVazZ4zJ0nK42
         ssFkE9YRU23kpXng2Ge96pPzLBbni4/b/6Zx/ryHaM4VYdqfZDCKuEum5hPXTosGOvje
         /B/jJyq70PS8GZ0YnsdTObMUqAOBRPzlbohH9JMMvd9Cdw+ZjBmjQYC9LhUjJGQn1nj0
         oirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LSa6ZbBjF57ZSXMgIFta8vcqiji2VGMkR5nrLRaLpGc=;
        b=brRfOBrMzxVJZrRb7kscKFA+cW4kE/M+2/oW83CRjVqQosNrdsBtB4jkhgFAoXurMB
         kpIcxg1qfK8K53PGZlM4ywm8f7DkaEB/djhHIYPAqHwiT3bT8+B/K7SclOjNFQIZ+WT5
         ek6W6xvmYI4yzlG6Go3FCXpI9Ut4JMDXr8mEwWCzXQmtgvtWAFzAKNmxZ+HSrs0hLPvj
         EW+5xZCVfpVLSpmw820kMZRJ9IOoMYA2RiYd8RP7I2melqk8Ycg7S5STu5FpAm6cvcDc
         dBihvyhmlhYllw6udKCyBCr7N/FmuOOT04/SO2irfEd0UuqObCzITvz2yvu2F32SnVT8
         M0hA==
X-Gm-Message-State: AG10YOSOl2PL/me6HrVTB5WfoMN7aj/30w0CQU1Sn9df2nxC5i2vdua5OyzAXcfCb4FCkA==
X-Received: by 10.28.211.1 with SMTP id k1mr2250828wmg.93.1456389745467;
        Thu, 25 Feb 2016 00:42:25 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB4D3D.dip0.t-ipconnect.de. [93.219.77.61])
        by smtp.gmail.com with ESMTPSA id y3sm2079173wmy.17.2016.02.25.00.42.24
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 00:42:24 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287345>

From: Lars Schneider <larsxschneider@gmail.com>

We assume Git developers have a reasonably modern compiler and recommend
them to enable the DEVELOPER makefile knob to ensure their patches are
clear of all compiler warnings the Git core project cares about.

Enable the DEVELOPER makefile knob in the Travis-CI build.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

This patch is the successor of "[PATCH v1] travis-ci: override CFLAGS properly,
add -Wdeclaration-after-statement" [1] which enables compiler warnings for the
Travis-CI build.

Peff suggested to codify the knowledge about the compiler warnings the Git
project cares about [2] which I have done here.

The only problem is the "-Wold-style-declaration" compiler warning as this is
only supported by GCC and not Clang. Should we ignore that warning or would you
prefer to detect the GCC compiler and add the warning? The Linux kernel project
does a similar thing [3].


Thanks,
Lars


[1] http://thread.gmane.org/gmane.comp.version-control.git/285752
[2] http://article.gmane.org/gmane.comp.version-control.git/285761
[3] https://github.com/torvalds/linux/blob/6dc390ad61ac8dfca5fa9b0823981fb6f7ec17a0/Makefile#L303-L306


 .travis.yml                    |  2 +-
 Documentation/CodingGuidelines |  4 ++++
 Makefile                       | 12 ++++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index c3bf9c6..168ae21 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -15,12 +15,12 @@ addons:

 env:
   global:
+    - DEVELOPER=1
     - P4_VERSION="15.2"
     - GIT_LFS_VERSION="1.1.0"
     - DEFAULT_TEST_TARGET=prove
     - GIT_PROVE_OPTS="--timer --jobs 3"
     - GIT_TEST_OPTS="--verbose --tee"
-    - CFLAGS="-g -O2 -Wall -Werror"
     - GIT_TEST_CLONE_2GB=YesPlease
     # t9810 occasionally fails on Travis CI OS X
     # t9816 occasionally fails with "TAP out of sequence errors" on Travis CI OS X
diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index c6e536f..1c676c2 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -171,6 +171,10 @@ For C programs:

  - We try to keep to at most 80 characters per line.

+ - As a Git developer we assume you have a reasonably modern compiler
+   and we recommend you to enable the DEVELOPER makefile knob to
+   ensure your patch is clear of all compiler warnings we care about.
+
  - We try to support a wide range of C compilers to compile Git with,
    including old ones. That means that you should not use C99
    initializers, even if a lot of compilers grok it.
diff --git a/Makefile b/Makefile
index fd19b54..9d4614d 100644
--- a/Makefile
+++ b/Makefile
@@ -380,6 +380,18 @@ ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 STRIP ?= strip

+ifdef DEVELOPER
+	CFLAGS +=	-Werror \
+				-Wdeclaration-after-statement \
+				-Wno-format-zero-length \
+				-Wold-style-definition \
+				-Woverflow \
+				-Wpointer-arith \
+				-Wstrict-prototypes \
+				-Wunused \
+				-Wvla
+endif
+
 # Create as necessary, replace existing, make ranlib unneeded.
 ARFLAGS = rcs

--
2.5.1
