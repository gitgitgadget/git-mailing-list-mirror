Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730E71F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 19:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfJDTZ7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 15:25:59 -0400
Received: from mout.web.de ([212.227.17.11]:37275 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfJDTZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 15:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570217153;
        bh=XXsuqevWWgcHjU+8TloI8VI//XN8r3/myRV9tMbIDjQ=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=II6DWPtWMaUmfRFD71dWRZRMMZPkcE2DpPmVJsmtBEU6jtGGaIm7kqu/8vSN6+wWW
         PFbGfbCoqXCJ+6nWUotANRCryepp01trP0ncIc89QhPB/ciWSmqKAy4WDsfzynMQwf
         tWjLCxVhTDbXpCAlq6OSKcRTDRozwgvKGiZFNjF0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LsQPU-1i9pKj0bYO-0120Fs; Fri, 04
 Oct 2019 21:25:53 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] convert: fix handling of dashless UTF prefix in
 validate_encoding()
Message-ID: <c886671c-7753-6ac8-fefc-277e76019cd4@web.de>
Date:   Fri, 4 Oct 2019 21:25:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DmQ+rJB5DOyov3BebScsWm6S9mhA407dtFqoJFhJ5OtKeuej/t5
 w0DiZ/Btvos/IAVyE32mFil8SluItoLd1ju0XshjUazGd9MoQkA+1p5qlB81ZtIOYkZhHnb
 BB+Lin2ZpW19jAEDCAxJx8DP/nZID+rywoX0hxJ+sT5SMfl4oNrhBrGPo32VTxbb/VI/15j
 VrphuGmdXWd3k4Wkw9iKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OpI7kWbpaaM=:ICHY+nA4uxlXscxWlpoBMZ
 hWlCJuVLGiEwIeuh8li1jluA8jbV8KJK7/6jUUj7h8rJdVCaowRzqctUbXmhjMJsQBTvT9Qm9
 BNKusQsbXmJ422vq+OPkw5mGd0cT/URcSKWZnmiwaAjKV9I9OU00MHjkIoRLwIfx/dSF1RAaZ
 oqhPJ1VfXA6JTod03zxCqlQwTOf91PvcKWOYSwYpcetmuUq+zo1iEg1OYZTbJnUaGGB9p1tLn
 jvGvToIllPDeyS8R/qEcGjsriz0qvxw2c2C82g1kYQ1hb7RmezPQSeeedmB5yR4/6G4vRfH2Z
 6/ZHvkMeF4IF49ua/A5HMnZU/b9cNJJQz3bbbSE4kxr/MEdei/w/bpZuh45thmJL/F0q0m/z4
 qYFSGwyUDtdllwOaJYbbTUjmd8s3H66s6zmtRG6FuWErGwvYEHmI05oucTmgA8FTV9DFhTftO
 3XVptbM/N9Y3CJ0cgr7P8A0+m6ZjNJVAg95VIQqYnPd57tkhVknSpFgt0T88nJl9k1oiwjxXf
 uvUBaDi1ajbfcA4Ceo3cXtsE2NUriNQVjp10D/3NjAEt9LeM7D0liEnh17yAggkcDIgm/W+Bb
 iXzo3cMD+xUjstNVLfKR3qynDH7Hr+yJzY0i51pSLt2sYL0mwNt3rScFLBPUjKva0ONtN2Ex9
 d19XAL4REp3Bh28EDn5qDa6k2CJgGs0bWBzGuW4pwxhdRI8XvAtfdrgXTgD8z68crWQqsnOPU
 igqxenv4cIHZS04OKYoAdeIX4jf3OFBHeWJQNpQpBkPCOTt9pJJtr4eVYtXk+9bQk9zC2MAis
 +G0EHXKzbslPe4oXG4e7OpbXx9g7MD0W/ytAFyYUVbsMUjPgaR4GK17v7DXJRmk9EjbU3n+Hl
 xkz5LyUXKXL105a6BiPDcpV3PR+r8VRf6YpFohIessb5BlVPt8JgpKJhfZUG0yvuNJWoDtkcI
 JGxvDCHYhaYKcnjzjrN1kWWaIcbC5yDZfgOjFBK/RNdYtQK/nHDH08nPlxlhOgJ9eDLFj4VEa
 ecsuFsFtDGNO5Q9h1Iirnvy7Bnb/m2KzKR1U/CPGMf2aYhA7G71A29Fp3TJ0TEp40N6N/guqN
 hQsAqOQWha/UdcnLhNBgfz58RdbLq/vYzOYqeGKKvzCTcfRhwgo+3+qm9HqEXLMZFd5xxYota
 Oz8AJYZQzHImNg+6SZpcMsGqsvvyqycQryaDryzjHGbeW0CVgCb+6oDPU4aamAFrOpDlOoKhz
 +GwZomS0kXuDTGgW7/TiaMI/boWlccp5gLeGUQg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Strip "UTF" and an optional dash from the start of 'upper' without
passing a NULL pointer to skip_prefix() in the second call, as it cannot
handle that.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 convert.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/convert.c b/convert.c
index deb6f71b2d..25ac525d5f 100644
=2D-- a/convert.c
+++ b/convert.c
@@ -290,8 +290,8 @@ static int validate_encoding(const char *path, const c=
har *enc,
 			const char *stripped =3D NULL;
 			char *upper =3D xstrdup_toupper(enc);
 			upper[strlen(upper)-2] =3D '\0';
-			if (!skip_prefix(upper, "UTF-", &stripped))
-				skip_prefix(stripped, "UTF", &stripped);
+			if (skip_prefix(upper, "UTF", &stripped))
+				skip_prefix(stripped, "-", &stripped);
 			advise(advise_msg, path, stripped);
 			free(upper);
 			if (die_on_error)
@@ -310,8 +310,8 @@ static int validate_encoding(const char *path, const c=
har *enc,
 				"working-tree-encoding.");
 			const char *stripped =3D NULL;
 			char *upper =3D xstrdup_toupper(enc);
-			if (!skip_prefix(upper, "UTF-", &stripped))
-				skip_prefix(stripped, "UTF", &stripped);
+			if (skip_prefix(upper, "UTF", &stripped))
+				skip_prefix(stripped, "-", &stripped);
 			advise(advise_msg, path, stripped, stripped);
 			free(upper);
 			if (die_on_error)
=2D-
2.23.0
