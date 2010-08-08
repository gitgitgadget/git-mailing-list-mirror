From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 3/4] t/Makefile: Can't include GIT-BUILD-OPTIONS, it's a .sh
Date: Sun,  8 Aug 2010 14:49:26 +0000
Message-ID: <1281278967-31376-4-git-send-email-avarab@gmail.com>
References: <1281278967-31376-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 16:50:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oi7Ca-00055O-6y
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 16:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251Ab0HHOty convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Aug 2010 10:49:54 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48195 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183Ab0HHOtp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 10:49:45 -0400
Received: by mail-wy0-f174.google.com with SMTP id 39so9175367wyb.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 07:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=mvPBfaCYquxKswoLsNqMFL8y8/BeOCYM8+3zOetznqU=;
        b=gM6N99BLgeVHOgonu1vNUXpSfv4deFiR3rOi8oj8TZET7byDCZVey+Yj+Kmc0mPTVq
         uKFD9Bzr7yjVhjMYPlz9nPbVxpdRzevt5E7D7i0gim62YykVSFy4nukhXGxU6JkNpCph
         W5kww6HKTslxrsZRM6es0KPYPG0+dou+3qSEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XC7nnsfKa2hJ6TX9aCDOcgDKr++De5EZrjho5BS3CXXvcFl3VaAyBz2Xa5KXgwfDWN
         vv/SmMFKfHmR9bIqHGdcjxLbF008KZgrc6JCFt0Yu36jZq5lSlu1yCFuf7SOMBfQf+BG
         kIb/15A5Jg4M9Vz8Cy7mhosDqHmtpbNLLorig=
Received: by 10.216.203.71 with SMTP id e49mr12830783weo.60.1281278984876;
        Sun, 08 Aug 2010 07:49:44 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k83sm2005995weq.38.2010.08.08.07.49.43
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 07:49:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1281278967-31376-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152915>

Change the smoke testing portion of t/Makefile not to include
GIT-BUILD-OPTIONS. It's a shellscript, not a Makefile snippet, so it
had the nasty side-effect of sneaking e.g. SHELL_PATH =3D '/bin/sh'
(with quotes) everywhere.

Just add our own PERL_PATH variable as a workaround. The t/Makefile
already has e.g. an equivalent SHELL_PATH and TAR option which
duplicate the definitions in GIT-BUILD-OPTIONS.

Reported-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index d8bf05f..00f6482 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -8,6 +8,7 @@
=20
 #GIT_TEST_OPTS=3D--verbose --debug
 SHELL_PATH ?=3D $(SHELL)
+PERL_PATH ?=3D /usr/bin/perl
 TAR ?=3D $(TAR)
 RM ?=3D rm -f
=20
@@ -50,7 +51,6 @@ valgrind:
 	GIT_TEST_OPTS=3D--valgrind $(MAKE)
=20
 # Smoke testing targets
--include ../GIT-BUILD-OPTIONS
 -include ../GIT-VERSION-FILE
 uname_S :=3D $(shell sh -c 'uname -s 2>/dev/null || echo unknown')
 uname_M :=3D $(shell sh -c 'uname -m 2>/dev/null || echo unknown')
--=20
1.7.1
