Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E33461F404
	for <e@80x24.org>; Mon, 30 Apr 2018 06:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751631AbeD3GfZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 02:35:25 -0400
Received: from mout.web.de ([212.227.15.4]:37473 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751581AbeD3GfY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 02:35:24 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LfAro-1ebRWj3DEu-00on4R; Mon, 30
 Apr 2018 08:35:21 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, newren@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 1/1] test: Correct detection of UTF8_NFD_TO_NFC for APFS
Date:   Mon, 30 Apr 2018 08:35:19 +0200
Message-Id: <20180430063519.27122-1-tboegi@web.de>
X-Mailer: git-send-email 2.16.0.rc0.8.g5497051b43
In-Reply-To: <CABPp-BHitvta8we8di-tFiNdVV7vXnMNAhiAs2=CrQc-gGuSJw@mail.gmail.com>
References: <CABPp-BHitvta8we8di-tFiNdVV7vXnMNAhiAs2=CrQc-gGuSJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:d+Ya+SK6hb10lMNWxKgZO8aKfBZ2yuvY407uZ5gOVak0td//3UC
 pPIxa+ADNg8RP2TkTFOWY7FTizECqZ7vY5IUmhfSM8UqW/vC402esgm4MmALJkdztgFs4BS
 uGgoWrfkoVV+Jig4cwufyG+bvPsiOR5s6A0kV11AI77+rizhhst1Jeshg+wkYHcCCr5qbKo
 S+Z/aiZJJwSFA7FwnBTFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A30qS7M5ZYg=:CZsi5XFYT1BgnFR7ramGOZ
 aSobfGThTVxgr0enQFQs1AsuId7VDfB40QTmMa3zP30gyi93XDD1A5YYc1KGtEEUNK6Xa0eIy
 v+4dFjOaVB4pyKkb5e+Xr2HnYtvtV3roTh1uXql7ySI08JNGQLvQZrrPrBKxZdBx7ZdUxrRF8
 e41VxNsmbqizRKNDijM/AwEFr6XpQBuoTMPHJn2nRRbLoqIqKqTsWDvUBuJoVyU/P08Y+G63U
 ji8Oi+3JRhuaVFV96SWAaOnyJfD+EFLdyhzReeRwyZrx2k/msc5yGl3RMSzp2HJ/VVAjmnbLj
 nismhU0O3Lk0K7PN2BiMs5h0Tbr0+4NuXwlEmtMo+HzYpG4KZmNhMRvjz8Vdra2C2mXMeCeg0
 f03We4m1mqAkR7JVrH9J6kP1kVpYPPWN9PSi+WT+YF0yShwOjk7ZKZJwyjnFwamd1x8UdUMNt
 QVa5r3niIayIpKursSDBBLtkVFipAMSZV9+As9W6oFoZNXFiFTaqGOxcDs492Qs8s9WwJIe0d
 99Mp90oUxNgX1CNwvUxWAGW/238BsQ3Wv1kLSkZ40K3HIJJBFsrCivwM9zpPbHLSVYBOD1mah
 isPQ+40gWeESKft2oJSqq75ZjfusuDICXq2kKsL1GusQQsqdaOexmJVzK1UaarePRQWV55SRA
 vDOYzNWkSTS+aCZKcXl/aOXSYI5vwpQn3nKBUyo4w3WD49pDBrFNIB1DgzyBdjw71Dvfkf8PM
 2E8YViqTjk3hQHQYNDpB2XTPEp07OGIewu2yPr1sB43US0czYGDKqNrxFbCsr9v6JLyvIFEGq
 fJaK3Xb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

On HFS (which is the default Mac filesystem prior to High Sierra),
unicode names are "decomposed" before recording.
On APFS, which appears to be the new default filesystem in Mac OS High
Sierra, filenames are recorded as specified by the user.

APFS continues to allow the user to access it via any name
that normalizes to the same thing.

This difference causes t0050-filesystem.sh to fail two tests.

Improve the test for a NFD/NFC in test-lib.sh:
Test if the same file can be reached in pre- and decomposed unicode.

Reported-By: Elijah Newren <newren@gmail.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 t/test-lib.sh | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index ea2bbaaa7a..e206250d1b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1106,12 +1106,7 @@ test_lazy_prereq UTF8_NFD_TO_NFC '
 	auml=$(printf "\303\244")
 	aumlcdiar=$(printf "\141\314\210")
 	>"$auml" &&
-	case "$(echo *)" in
-	"$aumlcdiar")
-		true ;;
-	*)
-		false ;;
-	esac
+	test -r "$aumlcdiar"
 '
 
 test_lazy_prereq AUTOIDENT '
-- 
2.16.0.rc0.8.g5497051b43

