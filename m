From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 14/19] mingw: fix t9700's assumption about directory
 separators
Date: Sun, 24 Jan 2016 16:45:14 +0100 (CET)
Message-ID: <0435c425fb956743e077adeb2fc85cd7316d982c.1453650173.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:45:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMqy-0001OC-3S
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:45:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936AbcAXPpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:45:20 -0500
Received: from mout.gmx.net ([212.227.15.19]:54417 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753717AbcAXPpR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:45:17 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MgbTj-1aj0k12qRD-00O2lT; Sun, 24 Jan 2016 16:45:14
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453650173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:/ym+DXRBPBHuurqW+Yny04ztx9d5j99bQTnw/rfPjXDK0CZRwT3
 WiBO6rl3PMKFcW6VSQED3P95vWuOCCzGBNC3EavhhJVG5/sru33aPTKhw9dTMCGiNWIs28i
 xZv8UqKeXDWvMzJwiGMd8lOLfIE9EbbVMnaN3pXZOSARxUrhjD6IJB5BLep7OxooM9jGncb
 OgGWypAksLBwwkhvPGiuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fVLWkcCBREo=:HLNak4jH7T35kniAbTbILL
 eRLC1QCtbBMg8c8ULFgH2FmFcMWKVUtGhnM1XEv82nDoLNdzL4p4MS8dk66w6h988Mx9vUmYe
 yo1PxIv6DY+JFjqbc5pfAacdLtjcM7lzvICqxn6bm78w+/9Br7SoDE5Bdz7SurHs6AF6/IN0q
 dTohzC9CqU8A7AkpOiqyChKzfXALy3v8cszEPe/u5Sc5OjkS0MorTWSYUb/qv5YgLdtDgcXzt
 yRF8mm9l1XoDvG70Lz6bxk1LRvYdgOShKz5sgSA8MpD9Rl+qg6vmqXpHiDHDFjlRZnDMZjh1J
 rWUK/yj2+ryZ3realHSGAKIr2P/a3g5tm1bOnhYz6QP0pbB0xoX5GBWB84zCRwJ7vu2eDRPd4
 kPT5KvIv5vjqsPIm4DKgUhfJw1T10Cyb6oAPjl5hC2X+qDCNe2znnJ4Dmc9pvlDsvVJSbuLim
 k3/SUQap8zWB+AV9d5/0Tz2N5W2LY6LcyRTI07k/xOJB9WA8i7tR8fUDA1VJscrIzEPBudryo
 ee3E1d9veHbRXxBLUcPRSivyKXZbgAlb9H+Lqb0EvrvlIa0/meNAubCHAAwA7zC3Ryw/nMJgs
 kr2QfMw7mbemONDnk18chh4cvu0NzpdLwHBWnpKL5Zf4a3ownLEIf9nbqr6Ftcr0ltqiQvuMC
 dZ9HOj23YTdZs8L3UoUJV0FxoltNQxzyiC4cpU7K99s7fEDdLPzRv1I17I0+0yVwCDjVEitHf
 f7X6KrA+OF8rB6Gkk/OFMXSr3Egb1251VHl9mzkoEOzqNuc1iqVuEkJNKemAQJnwj7GS90t0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284678>

This test assumed that there is only one directory separator (the
forward slash), not two equivalent directory separators.
However, on Windows, the back slash and the forward slash *are*
equivalent.

Let's paper over this issue by converting the backward slashes to
forward ones in the test that fails with MSYS2 otherwise.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9700/test.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 1140767..7e8c40b 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -33,7 +33,7 @@ is($r->config_int("test.int"), 2048, "config_int: integer");
 is($r->config_int("test.nonexistent"), undef, "config_int: nonexistent");
 ok($r->config_bool("test.booltrue"), "config_bool: true");
 ok(!$r->config_bool("test.boolfalse"), "config_bool: false");
-is($r->config_path("test.path"), $r->config("test.pathexpanded"),
+is($r->config_path("test.path") =~ s/\\/\//gr, $r->config("test.pathexpanded"),
    "config_path: ~/foo expansion");
 is_deeply([$r->config_path("test.pathmulti")], ["foo", "bar"],
    "config_path: multiple values");
-- 
2.7.0.windows.1.7.g55a05c8
