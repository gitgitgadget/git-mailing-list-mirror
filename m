Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D7211F453
	for <e@80x24.org>; Sun,  4 Nov 2018 09:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbeKDTBr (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 14:01:47 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:52676 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729041AbeKDTBq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 14:01:46 -0500
Received: from localhost.localdomain (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 1622C335C58;
        Sun,  4 Nov 2018 09:47:23 +0000 (UTC)
From:   =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
Subject: [PATCH 2/2] t/t7510-signed-commit.sh: add signing subkey to Eris Discordia key
Date:   Sun,  4 Nov 2018 10:47:10 +0100
Message-Id: <20181104094710.27859-2-mgorny@gentoo.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104094710.27859-1-mgorny@gentoo.org>
References: <20181104094710.27859-1-mgorny@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a dedicated signing subkey to the key identified as 'Eris
Discordia', and update tests appropriately.  GnuPG will now sign commits
using the dedicated signing subkey, changing the value of %GK and %GF,
and effectively creating a test case for %GF!=%GP.

Signed-off-by: Michał Górny <mgorny@gentoo.org>
---
 t/lib-gpg/keyring.gpg    | 62 ++++++++++++++++++++++++++++++++++++----
 t/t7510-signed-commit.sh |  6 ++--
 2 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/t/lib-gpg/keyring.gpg b/t/lib-gpg/keyring.gpg
index d4754a1f1..918dfce33 100644
--- a/t/lib-gpg/keyring.gpg
+++ b/t/lib-gpg/keyring.gpg
@@ -30,7 +30,6 @@ Cezx4Q2khACcCs+/LtE8Lb9hC+2cvr3uH5p82AI=
 =aEiU
 -----END PGP PRIVATE KEY BLOCK-----
 -----BEGIN PGP PRIVATE KEY BLOCK-----
-Version: GnuPG v1
 
 lQOYBFFMlkcBCADJi/xnAF8yI34PHilSCbM7VtOFO17oFMkpu4cgN2QpPuM5MVjy
 cvrzKSguZFvPCDLzeAFJW1uPxL4SHaHSkisCrFhijH7OJWcOPNPSFCwu+inAoAsv
@@ -83,11 +82,43 @@ fn1sY/IG5atoKK+ypmV/TlBlMZqFQzuPIJQT8VLbmxtLlDhJG04LbI6c8axIZxOO
 ZKLy5nTTSy16ztqEeS7eifHLPZg1UFFyEEIQ1XW0CNDAeuWKh90ERjyl4Cg7PnWS
 Z9Ei+zj6JD5Pcdi3BJhQo9WOLOVEJ0NHmewTYqk9QVXH/0v1Hdl4LMJtgcbdbDWk
 4UTkXbg9pn3umCgkNJ3Vs8fWnIWO9Izdr2/wrFY2JvUT7Yvl+wsNIWatvOEzGy7n
-BOW78WUxzhu0YJTLKy+iKCjg5HS5dx6OC+e4aEEgfhNPCMkbvDsJjtQ=
-=hieJ
+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
+el64
+=Iv7W
 -----END PGP PRIVATE KEY BLOCK-----
 -----BEGIN PGP PUBLIC KEY BLOCK-----
-Version: GnuPG v1
 
 mQGiBEZnyykRBACzCPjIpTYNL7Y2tQqlEGTTDlvZcWNLjF5f7ZzuyOqNOidLUgFD
 36qch1LZLSZkShdR3Gae+bsolyjxrlFuFP0eXRPMtqK20aLw7WZvPFpEV1ThMne+
@@ -137,6 +168,25 @@ bGPyBuWraCivsqZlf05QZTGahUM7jyCUE/FS25sbS5Q4SRtOC2yOnPGsSGcTjmSi
 8uZ000stes7ahHku3onxyz2YNVBRchBCENV1tAjQwHrliofdBEY8peAoOz51kmfR
 Ivs4+iQ+T3HYtwSYUKPVjizlRCdDR5nsE2KpPUFVx/9L9R3ZeCzCbYHG3Ww1pOFE
 5F24PaZ97pgoJDSd1bPH1pyFjvSM3a9v8KxWNib1E+2L5fsLDSFmrbzhMxsu5wTl
-u/FlMc4btGCUyysvoigo4OR0uXcejgvnuGhBIH4TTwjJG7w7CY7U
-=iYv/
+u/FlMc4btGCUyysvoigo4OR0uXcejgvnuGhBIH4TTwjJG7w7CY7UuQENBFveu9wB
+CACo7Hk9LE0I8jd/Xzp9H88VqfPURDFFCoC4oG9NTCrrjSN3HnQWbM94aRTilXIo
+ua5XcPLn98ktzpIbdg3xz0g+DaxsyxhM0k6UNdEvDdqtA1GMMi1OgtFPB5zGZv5/
+pQhgW1KMb567qIQLygI6Rzt65ifA+A3vYZVoP38HQMUENEr3tJDfFcJNqdRrjjlk
+CldUlPXPpAYqLu3XsEJm4pT0Wpypj+WUlOHpoaUzjJSRVxfpJmEjg0JNXDL1ljm9
+7bZZdpZV9Brpe0o3/oWqvxXEckZO08OTB8GY6+Wlogp8tP9Pm8r3xekgSH88hKpc
+llEUNoB2VKkoht0DzGYmK9OHABEBAAGJAmwEGAEIACAWIQTUviIxGtMTHl7aKaRh
+CS6FtyJxiQUCW9673AIbAgFACRBhCS6FtyJxicB0IAQZAQgAHRYhBPg2Slngf/6f
+TWMAWmWg7qAuMMrXBQJb3rvcAAoJEGWg7qAuMMrXA/YH/1ooLR5e5RcpfEWhP7qk
+ThRHpWcjNNL9YeeX3fyBkRvPBLTdC6+BWqgaj5DGY1PyzfVDAWk3fu+PLx5R2sHm
+apY1ybvfQjvSHe2OMO1sxdwt2MkLBmfdhBsbYbDytPq4R1dDG2iDbqSNaDvYAExY
+JUsate6PNxSWrRkY2lwmWrvI6+e/wctTBrY5PiKtTZMxpK1++/C3UUBiyg8NkGu5
+bHR2PHd5VDwB/Jm2/exC5iHPbTxtmjOwEyS+5wZhbkx6OoZhHCMN9hIvSitc8TNG
+cpRGJIwYxwJZJVpim/TImsjAubh1uyMoY5fjW4GyBK9iU2plv/bS+lKyCMYgxHam
+hzXwmgf/Q/ld9VKXKIXPWs8AeABfHYkMLeZ34laZ1Xhf1vPnktQctlukK8CzbYTU
+Wm2BZ7kn/VEhwGOmrQ1nvnoCHTCyL+HHtIt8pKHM0rtKDKFAjMXZfZEK7DR2Qqll
+/zogwy0m9Obvz/94XvdNMurUgdeTGyDwOouQcP+vd5x4LqsUtQEmwQfy4iLt7wl3
+RRLPUTLyCfqpD98UAPeqCJkIikd1Ojhr+fd3jjSoo1CDTah0auvlMSMifjggIvi9
+kE4nQISS0QqehGQ/ertNnLYWKvCgPI9fq8fQXG3mnFVR3qXhtSbIMbF1/AUye2bk
+uVVZ3WTo2oPFEVv/ZyTH9NcP4XpeuA==
+=KRyT
 -----END PGP PUBLIC KEY BLOCK-----
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index e8377286d..86d3f93fa 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -197,9 +197,9 @@ test_expect_success GPG 'show bad signature with custom format' '
 test_expect_success GPG 'show untrusted signature with custom format' '
 	cat >expect <<-\EOF &&
 	U
-	61092E85B7227189
+	65A0EEA02E30CAD7
 	Eris Discordia <discord@example.net>
-	D4BE22311AD3131E5EDA29A461092E85B7227189
+	F8364A59E07FFE9F4D63005A65A0EEA02E30CAD7
 	D4BE22311AD3131E5EDA29A461092E85B7227189
 	EOF
 	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
@@ -209,7 +209,7 @@ test_expect_success GPG 'show untrusted signature with custom format' '
 test_expect_success GPG 'show unknown signature with custom format' '
 	cat >expect <<-\EOF &&
 	E
-	61092E85B7227189
+	65A0EEA02E30CAD7
 
 
 
-- 
2.19.1

