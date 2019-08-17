Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50C4D1F461
	for <e@80x24.org>; Sat, 17 Aug 2019 16:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfHQQYQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 12:24:16 -0400
Received: from mout.web.de ([212.227.15.14]:53257 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbfHQQYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 12:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566059053;
        bh=6EA/LZJS6omXR7+upmppamUGTLDaHLjbc/vwR3z2mic=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=rBnfhO5hBWk4FAqms8A1DtAhrYh0MczowkuOdLYyWOhWA756Vw1wLtYtdw4iJd6/d
         0fdr5NgcWl4QDnNJTKKC4/CfF4c9qFH/1Q/Unh897ZTeNkBjKOfuIXb1JKwIwn1WWI
         4Scix1dBaQu0hK2fjkUSPdsW5DpIe1zPf82CFNPc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lb289-1ifBvo2Vsf-00kdAy; Sat, 17
 Aug 2019 18:24:13 +0200
Subject: [PATCH 3/4] archive-tar: use size_t in strbuf_append_ext_header()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <c77a0081-93ab-7b97-e322-9616f6e7f86c@web.de>
Message-ID: <1933ad5e-612f-b5ce-065b-f435338c3c9c@web.de>
Date:   Sat, 17 Aug 2019 18:24:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c77a0081-93ab-7b97-e322-9616f6e7f86c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Il3LCK8RX4jNjDrcKWOqOjzDVeSiSgV5jkbIm+ajX6wRnCncMeN
 oxuW3BjqeS4nQM/Tvy/ZlaP3qR55/+mwlqquPI7ttd62VzH7txImihWw4yLkfPZYhT1EUJL
 qcOTTHUUiWWfwD7p7pMaH5Z5gCVszjgSW8sxSUYnUAEKw8Cs1zdcC5o1IjQukgISJK4X7z0
 BciaaKfmZRlMTBOGQjlDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qD4jKnagt4o=:FAK19FPM6PF1lVJ9eD7a8S
 0Qcrt7uCWlKt1CfpaMLf+Do09z55f1T7vBmYbrY138rma4gU3ieEH3ARBVe2dRe/78eT3dL0d
 F0o+meRVbAc/3ghOFNg3JpreZl8YEwV+BMM3fMr4uB7oY3H1on5kK0/BgUNd8OKuC+HxvyeKi
 UWVirA58gWFfHLc8AkfN8cyF0EiJY2H5sxkBG3RugLSP4R5W3rCcDB66R4bwpkYm5QK57YLyG
 1ReewSLLdkFP6Q9HQ/1s2kLsWyVdZT0S3yWb6J4Ox3176igv77ugzFIdqNnKGh5FnPwgn55gT
 c8Le/H18F/bYgHSFhDVslf0DWUPNT7t3rnpwfk0gZ8oP7U1DxuOwhXI/ZP298J5ZtBsuczwFH
 kiR151EGmLi0ebztGZc+vYVgfIaZDogv3QtcNQRsSqJiUXmjt1qGumZDyycmes9hkOHzf0RBN
 h2CieZv1LuPRzVjSwgyf0Sy+7s25ln5LqJ4os/LdNAAcvZARB73InrB4eg8bPsUR25II6yBKr
 Pa3IDW6o1gV3cpFeCcFi5tovPwwd9ixFxXjF+bVyn+MYWTk2YFvMPfX7qL43uEPpMLkMNaTlw
 KMn4kVLeDkXReSkGnteH8kBhn9DATyZ/Y8qFZ76mEL8bUn2Z0CnaOZB3WHbxYJf12MBWgU/dS
 El90nK5JXAj3IK/zBUcJKc+lTNrsurBZe+rkg50zSRw3FnUttOIvMzVotXSeo+2i4dAt0OxHD
 FdAIgXypH7LYGy5yHAT7/Rr46lxbUt1kCS7Wg+DwWDgccnedOmM4CtLCFpfNKyGB/Teh3fWa1
 nmTp+bevKodb0jKUmYQfSH/9Blz8Fd5+tKtT+GKo1Bz4YYGADlNJdS5f3CcFETAEww4Us5FK0
 +2DUeGOmyLcT02VbhftzY7D8009hN1oPoE7KMg/e3bphliSVcwnoH6H2rfvpFSEm/EJ2Og8Xu
 uPs5l+oopQ0tk16lV0OYD/X0j786cKTZBdQrtFXQS7qL3Y89wSMOzDCla7DTq7mdIfWgA5ALa
 KQ7apLiZEufC6WpGoYEB8fnZgBIZZdyKPXd+q1SSTv2P6ny5B7G2q1CFoacYAwVRsOwGWcoh4
 tvtpaQktBv+6v4SnVVUeGAwAaqD4fvagOcPHiD6+YP8cSneJglSsPRlo0gUxI88Q7OJW3FeXb
 bM3ao=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of its callers already passes in a size_t value.  Use it
consistently in this function.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 archive-tar.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 4395a29ffb..9d09edd547 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -142,10 +142,10 @@ static int stream_blocked(const struct object_id *oi=
d)
  * string and appends it to a struct strbuf.
  */
 static void strbuf_append_ext_header(struct strbuf *sb, const char *keywo=
rd,
-				     const char *value, unsigned int valuelen)
+				     const char *value, size_t valuelen)
 {
 	size_t orig_len =3D sb->len;
-	int len, tmp;
+	size_t len, tmp;

 	/* "%u %s=3D%s\n" */
 	len =3D 1 + 1 + strlen(keyword) + 1 + valuelen + 1;
@@ -153,14 +153,14 @@ static void strbuf_append_ext_header(struct strbuf *=
sb, const char *keyword,
 		len++;

 	strbuf_grow(sb, len);
-	strbuf_addf(sb, "%u %s=3D", len, keyword);
+	strbuf_addf(sb, "%"PRIuMAX" %s=3D", (uintmax_t)len, keyword);
 	strbuf_add(sb, value, valuelen);
 	strbuf_addch(sb, '\n');

 	if (len !=3D sb->len - orig_len)
-		warning("pax extended header length miscalculated as %d"
+		warning("pax extended header length miscalculated as %"PRIuMAX
 			", should be %"PRIuMAX,
-			len, (uintmax_t)(sb->len - orig_len));
+			(uintmax_t)len, (uintmax_t)(sb->len - orig_len));
 }

 /*
=2D-
2.23.0
