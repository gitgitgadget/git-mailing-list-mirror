From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 13/19] mingw: fix t9700's assumption about directory
 separators
Date: Tue, 26 Jan 2016 15:35:18 +0100 (CET)
Message-ID: <d15d51987ac6a8aca30caa6440eb3e9d6aa25524.1453818790.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:35:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4iS-0004mL-13
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966147AbcAZOf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:35:28 -0500
Received: from mout.gmx.net ([212.227.17.21]:49910 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966201AbcAZOfV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:35:21 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M6wWn-1a9RmF3psD-00wmYQ; Tue, 26 Jan 2016 15:35:18
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453818789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:gPopr1M/RU5dSmf9TIQm76TR/ulaNXNr8q8xbZvf2dBbj2BvNGn
 XIKyxcjL9AScHDMAitZ3CawjJzcD9o5VhghEDRlW2fhmeqANxfeb1HXpvbXr3h7AHZIcrwp
 FQL6FHYIvP9fqCnED0y/4JuCsUp2ifeiCG1940d8M2bjiMXY4EL3h3btFTv6/U8GDhdGZbu
 wOR45IcN6CAhqHMM6RywQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2ldrUXmStVA=:T7TgrGvWz+oRtnTXvWWs0K
 u5fLNOAfNgbki/Vis8kcyhaYjHTPwvfalzHvmnpKqyIWtGBT8yYQxCphs4DvDtQyaApzCyEwF
 UUbIomXNU/MVNChVgd3GbPdF1PsP9WiAUSXGxC42kHKQjphfMVEsKBYEY7nnZJn4RhDEL4Isg
 8qMsWX/7Tskvr6VQPfc6O5T+hGJxvub2ajhwH5EliAGSlKIFB0rHGlBu1n1pYlLyEfvCZhyyX
 48B8sl3OHA5gXA9tGvMYDL/o7ojaMKbeYKfkKRfnpUSVZ0pGEI94MoFmP3iFLsJQL/iQUUZ6C
 Y/AOQscuwcscqeFyUDrfKKa46MktCz2hxCfoXtcbBTYI86+OrPpCOm+ar/Oe3hx3jlUCDIRvx
 acIMhvCLkCJftRjbHjK4NtaxsSqIMPCBeEkFR+svu5rRE+UzH5fp/s1PC0PYu7tWoukAw/KhH
 CZ4FhIXtvFb2lSfAHDsd9SHMf57HO1HFboHiOPUxvq8BVu6NZ/eksdZCWG+z0ofSlMK3UkC7P
 4RVhYX1UddQPlSYO2PdOG2DB/B2GnmG1ZgNaemL3hbYlxJ6U0o5I9Zuxp5T3fAgO+ZOrWlKyx
 1GfnCj5Iy09OsB1MHY4DkFQCzzTXzknV4JTwyeRG7SQ+I6aQEcHohBnDrhcYtsnI9imtuO0Bf
 I90cut0bW9oe8OWMsW4p+X5+ptM58w4MDx/ze7/RO0S3NS8pJWK+pq2zsWbK+NTNekcrg2FqU
 43mOYxr6sc1I7nc+Cpy/7+UVpYPGQPCb3t3Wc75nBO+qhJN6oPo38ytFkZ7RXzbjCElm1bog 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284823>

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
