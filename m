Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D09C4167B
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 21:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjAAVJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Jan 2023 16:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjAAVJB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2023 16:09:01 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D9D18E
        for <git@vger.kernel.org>; Sun,  1 Jan 2023 13:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672607334; bh=+XDYoBNly11/mzLi5c4ogTejJL7sEwPIOEpkFGAYtGI=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=exzutYmmiHREbodr1mWPjKaSqj7NoKTbTcbORhLm9rtaDz1K/JLdgz1bJF9xBi8qi
         F94YLnFE8O2qhFtkMSIZuauBmyb0pQkSLwC5E4DSI27oF4Jelc3BEKHvGgfOq00tYA
         FMXD13AnnMG71ucywFumUz8eaDUk8LSg7AfqsLAdUBFmkAn2JGNtR1Qksxj6ulBpFh
         8hODnoOzyu+tE+YNN8TyPzsBa31h/UO1D82adnun9xdRO+TMNxANrt/e4ayuWp/Ywy
         5Lr5IX5sdzpNkG9xWMIGRTCI/TSTb6LAluYafVlVeuozp72oH4FHQXQ7zcmILapquG
         tzJWcspSwUBjw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqqPN-1oPEI83uvR-00mZgV; Sun, 01
 Jan 2023 22:08:53 +0100
Message-ID: <66ec2a0e-e4f8-1d27-76d3-3451ac2335d2@web.de>
Date:   Sun, 1 Jan 2023 22:08:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: [PATCH v2 1/4] factor out BARF_UNLESS_COPYABLE
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
 <9bc1bd74-f72c-1b43-df7c-950815babb03@web.de>
In-Reply-To: <9bc1bd74-f72c-1b43-df7c-950815babb03@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1tB2cfCtN7LM3LF0Zdh2XGCXwM6M5OPwFn/Smpd4Dyj70YpJukw
 AF+RfXewWQneGOVEq2vak51DVvsmeIYnSMC7929XUNSb5y0FCpMpiccpOsA2id05aPgt1jz
 Di8KPLqvqPMBQO3iYRnktDKld9t76O2/E/ymn+4he8D0neicDVgHLU5TUK256WQwJ84hXfN
 +yVgwrjYOC1CYv+xfzUOw==
UI-OutboundReport: notjunk:1;M01:P0:9GjJTe5Yv8A=;77GtSkzM1bVe2aLJ5OSefIPsEis
 7A4Yo0kH3egZhAve2QLOkOd5fgL8WeiQJcUlxOeoagVMDvaHYKw06+jTlI/S+THQ/L9TkVe6w
 ykvICAaU1DCuW/bFSJ+fThRc5avT9y5khBMjmed7kpud3r+jutB+u6d3TyPYPs7tfVXt2ukMY
 HNMv6GIYpCFGQOQEctbgXoC67hPM4KU2/tjJgAhByYMOMXdK1BXdIre8Kxji1X0W9DBhNohR1
 n+8CWMNXMTvR1OqBk3le83P9EZitBRojxXEXYSl1vA0OqrhGZPg3oVAKzIJZQAsIX2o3GLCHZ
 54lU2vDNnPq//gFTrJrWAujy75jo7fAbn07LfF2f9cb9rVLrJppWMMwO8L5yhlaSLwdFCvFDA
 g4Se1lzzAo6mC7ht2wv/hNx2djJXk5zWDm5t6fx+RKQ+f/N4I85RaS5V6MbTxuEIVRGUO0aWm
 Jva1/Ezr8lWViySeQzD6F/Pm5wiIBi09e84idFNymFcWyA767g2/4fADfWjckcOiCH78sECK7
 f9NCNAa8wNib+4n8/6cXb7mwmRBvX02GzDE43NNToUAEO74svciAFi+59IMWK0JmM24rbWoSG
 WXEyRGIsThtIdt2MomXsSaw7Lw41uJhTjdvsb/JZBycmoXpKFhVl4D0wR7vUo0JAwDPtLAHiw
 woVR7YtyC0/iy0hd9iGTd1ijT8qOlgQvf+3JAreTW1GeyvUo7iduFSjyWsqa7oGkRia2jJn9j
 ekuZPt2syERpXFe7bDGpbG+LN/8m7VUJjs8Bbn6HImQ5p2TQxAnETHbYlO9fBYE5HwPXJyIfZ
 8cUiJsyIsz37ynZ++CwTRpCZ/4jfUmECPmWG3Xzu3xQx6xb3rhBKQkr4WZidlta8gkJ26z0UX
 80w5iu9xrDNF9OhOCjrRa2Mx9LqQhT718SQQ5VGXeoSSCOdedZSmNpMiRN/KKQCyWgSW8BGUg
 3yi2ADK/AYofbZvylpXCxngd8N0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the common basic element type check of COPY_ARRAY and MOVE_ARRAY to
a new macro.  This reduces code duplication and simplifies adding more
elaborate checks.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 git-compat-util.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 76e4b11131..940d03150c 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1093,8 +1093,11 @@ int xstrncmpz(const char *s, const char *t, size_t =
len);
 #define CALLOC_ARRAY(x, alloc) (x) =3D xcalloc((alloc), sizeof(*(x)))
 #define REALLOC_ARRAY(x, alloc) (x) =3D xrealloc((x), st_mult(sizeof(*(x)=
), (alloc)))

+#define BARF_UNLESS_COPYABLE(dst, src) \
+	BUILD_ASSERT_OR_ZERO(sizeof(*(dst)) =3D=3D sizeof(*(src)))
+
 #define COPY_ARRAY(dst, src, n) copy_array((dst), (src), (n), sizeof(*(ds=
t)) + \
-	BUILD_ASSERT_OR_ZERO(sizeof(*(dst)) =3D=3D sizeof(*(src))))
+	BARF_UNLESS_COPYABLE((dst), (src)))
 static inline void copy_array(void *dst, const void *src, size_t n, size_=
t size)
 {
 	if (n)
@@ -1102,7 +1105,7 @@ static inline void copy_array(void *dst, const void =
*src, size_t n, size_t size)
 }

 #define MOVE_ARRAY(dst, src, n) move_array((dst), (src), (n), sizeof(*(ds=
t)) + \
-	BUILD_ASSERT_OR_ZERO(sizeof(*(dst)) =3D=3D sizeof(*(src))))
+	BARF_UNLESS_COPYABLE((dst), (src)))
 static inline void move_array(void *dst, const void *src, size_t n, size_=
t size)
 {
 	if (n)
=2D-
2.39.0
