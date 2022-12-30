Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40EDC4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 21:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiL3V4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 16:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiL3V4v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 16:56:51 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234141CFE1
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 13:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672437404; bh=LjngQSBkJCIJH4ACcFJIV5Q5pJVps0Baa0cunVQxd4c=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=WWwyYMwYp92yRJz1KWN4n9BAb2nwgZQfL5NGT8twsBlYBWMTjjH+YBKkE6YUCiac+
         ass34LHWi4R+XYNGi4TXkclOU0VF2ku8odcn4zR0SPBfOxyV8rYe7rBoP7JJi7NvNI
         0auvMNfCmu4Jxg3RaM0FaNNJBBUtOexwGdE6s35IS3Tzd9CF09UEqzJe5/tuv1Met3
         woaKvK6PGTlvKfGqscQeOqMOaJ2pJxDlFjE6BLYdSigvYkUV2sZVA7raUqxBZL+9uA
         OeB1yvUUfm9qPE2dd+QW2y3TO/BPiBqwA7VJeBCLVyBVuhXDNbuNSrDg1mRG2RPHDN
         d0Uc0idbT/iBg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0Icn-1owIWJ3eUB-00wtjj; Fri, 30
 Dec 2022 22:56:44 +0100
Message-ID: <f3b9e9be-06ef-3773-a496-da5e479f9d49@web.de>
Date:   Fri, 30 Dec 2022 22:56:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: [PATCH 1/3] do full type check in COPY_ARRAY and MOVE_ARRAY
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
In-Reply-To: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tBPXt9OMWJcIBfd6m5fwwp6znEYSO/SjP9B9VzUMSeyUHb27YYE
 2OEaHvCxofx1Kxexs2qfrhx8vOED6//InXL1S7PVM3hZUKjWryzx2m09xS46P8H/sQDWVa2
 mCGYy3b1DQJivTHBUgpLnst3Vxc5bySKMr8hSU39UPrieTGvs9+P9QLXVXylHW2VsyFV5hv
 C/yC1TJLTRH8h9cyJQs3g==
UI-OutboundReport: notjunk:1;M01:P0:nytalSmekHs=;R9fPlccbjZOsvaGssgG4jo05Xca
 g/4OkzLnB46z62fbVGYCvpTf3tHIMCTZmdBB/Q8jt5nOR5IXs8EwLDQJJAdQybhe+I/nuNMev
 lX0Oe+wMW4sXn2Ej3T15Iv4KRTff7rMspWuw4Qmb2p5cQN7reUHsQwXmrAaZFymZ+0GrzAQSf
 TJf0y/4XRHB21jEaO18NZ4AXUshTdNsMg6EU8905NebrPsbS8umzLn8rdOhZGZav9URwQCUjU
 51Cnsg4FV6kalliDIRkunOohYKpV8hr5pU7xQ390soMTLa1naPv630IgPEUvLKrzblpkJLPom
 YjM2g7M4p3kd+4i36CHBjUtMaZBkSzVwApAcz60QkYuNIcEu9ykeaUqQ4jCLXAIaMn+wz2H/Y
 yD78ls1c6JV7A5xVT8akv1tnNBRP1eKC4xXJMOoLMFgaiVfovr86lzOLGCdfBsBakSDB4PN12
 /X0PmYqtVewCZlRzUezcVqwObIJtEw3t2x5Y+UuTATpALyHH5A5wDcsOelFi262LNjRNxjzR/
 QMwLG6G+A3WJZtHv4siosfRdztFvAXZjl1Su0AJGAw2gu1oWN0q6rKqEbOhAKVUdjRQvohF5G
 QdhpA5+L658WU/FNyZNFJRUx+tZHKZy9LUhijSVSV+0dfvqghbGewTxQOAsZf2wbiuVPDPeCl
 pSX7VLArXegg2cPVVHJXjQZ/p3OkEUcwBJ3vTkwDl9C2z2vYSRsShcd6gx9sNYZR1UAfChong
 8kkBztLRxXF7Rey3CIcuxRSIfI8SiR4CDopg3jUvX/Yzma6moJ47u0NkX9lZZjyrpspVuoRaz
 4yJM4wxazVoCWXhaIyJ9DP9KglIOY3svibO4sJthfItsr26K8nw2LQ0tWjcSgjBery4QYyK60
 8OFXBi4YKvdAB/5tuCPLMqWBvqLh2NFto+wF4Mt3HYF/8wS5p8SynLEbQsCj+lfTfp+LbRxlO
 xmSFLg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the element size comparison between source and destination with
a full type check using an assignment.  It is not actually evaluated and
even optimized out, but compilers check the types before getting to that
point, and report mismatches.

The stricter check improves safety, as it catches attempts to copy
between different types that happen to have the same size.  The size
check is still needed to avoid allowing copies from a array with a
smaller element type to a bigger one, e.g. from a char array to an int
array, which would be allowed by the assignment check alone.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 git-compat-util.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 76e4b11131..8d04832988 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1094,6 +1094,7 @@ int xstrncmpz(const char *s, const char *t, size_t l=
en);
 #define REALLOC_ARRAY(x, alloc) (x) =3D xrealloc((x), st_mult(sizeof(*(x)=
), (alloc)))

 #define COPY_ARRAY(dst, src, n) copy_array((dst), (src), (n), sizeof(*(ds=
t)) + \
+	(0 ? (*(dst) =3D *(src), 0) : 0) + \
 	BUILD_ASSERT_OR_ZERO(sizeof(*(dst)) =3D=3D sizeof(*(src))))
 static inline void copy_array(void *dst, const void *src, size_t n, size_=
t size)
 {
@@ -1102,6 +1103,7 @@ static inline void copy_array(void *dst, const void =
*src, size_t n, size_t size)
 }

 #define MOVE_ARRAY(dst, src, n) move_array((dst), (src), (n), sizeof(*(ds=
t)) + \
+	(0 ? (*(dst) =3D *(src), 0) : 0) + \
 	BUILD_ASSERT_OR_ZERO(sizeof(*(dst)) =3D=3D sizeof(*(src))))
 static inline void move_array(void *dst, const void *src, size_t n, size_=
t size)
 {
=2D-
2.39.0
