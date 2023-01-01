Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5869C4167B
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 21:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjAAVOU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Jan 2023 16:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjAAVOT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2023 16:14:19 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326152634
        for <git@vger.kernel.org>; Sun,  1 Jan 2023 13:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672607653; bh=qiOZT+WSqzZ7si82W9asIYJoe6TGqxJKoq5H37aH7tU=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=poQcMLZjmDfYQyE2Lu7BLAf/bH7+lLbIbrykqk/7p6emDudAaJeW4KmuAF2EyeOUW
         P/xDZ+oNaBjaVMGfFE868Fwa+ySxT5YDHX+OWoL25pswC4/4mMMmaTCecj8tm3FDWG
         ZL9z0bUQM80WT73amObOQj8VQsVWhN0xPqh5MzYQgFYiUa00NnN65/rGtq8VFhXJsd
         BVmqrUON6iv0dSLzwdROTINdRU1QtrS4AoBoUKq1Gtr9WaltVaF/otKxtTs93o74Ae
         NYfsLgMKuayWnO7UZeX7LaHOYCzZt0p8k4OeNTBeVYdxmv+2lC1+AAJ5Ucd+JFN+Aq
         64fGWFAZ8ZI/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFrxr-1p2PoQ0VW3-00H5oz; Sun, 01
 Jan 2023 22:14:13 +0100
Message-ID: <04e99a14-a25b-7e47-8bf3-49442c877c89@web.de>
Date:   Sun, 1 Jan 2023 22:14:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: [PATCH v2 3/4] add DUP_ARRAY
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
 <9bc1bd74-f72c-1b43-df7c-950815babb03@web.de>
In-Reply-To: <9bc1bd74-f72c-1b43-df7c-950815babb03@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J10RJa5z1g/eWqhdBrCZwWNicp3sgIfOng7dPrb6vsfRERIAVbK
 IE+ADLY28cCd41bFNB46Y5nhS+pyFMdKNJB3liLaOC3jmmsxe0S9J1/4MDcauSTZXllYNPp
 ktoYq/VUHdSSC/UsFTaXCynHRMccoMrIfZ79fjSUayPVnhAfHyGkXpi74q/uIuCClHyKZjb
 uzEtTSCotG1P0t5DtwlBg==
UI-OutboundReport: notjunk:1;M01:P0:pNkh/tq8asE=;To/UJ4k0/FkyP+ka0PeaYDZE3Tr
 1qhFrTOQRVTYjR2uEDxgPdpeR/nSTrRS8QFfmZkEbl3R0rgmtVZvpaoDsu6dJuCGxcBQNb/5c
 SWDWtC7Mcg56BwibigQ8yLYY1q2UZDuyPJQvtL4byfZ3qGj9OMaoCGQukovsNf/Wgh4bRxFNg
 93rNnpSuvksNQMaKn/EEMnnkpEAV46MfFXL5OhizMZWBDnyAFRvIlOFbTp7FhPnuqpbAdAClW
 tUk42Tj1UC2FbNHF7LlXpOCK1guz9iec/l+V+Q8/Xdp3EelmhkzYqiF8jALgPg8vsVsHcQUuV
 AEU+wrIT9KvhgiyMDYAzyE8wXWm4SDSDhr4txOYkVnyXcGacndjQuVBsA6MB4wwM58YmvZzdj
 oD+8yCZh1MQacujIMD64ab1XStXox6icnl5L6rrkdcrgdr1Px5WB5EDhz1xmbDKDobe/MNBgJ
 sYwBlxA3w4nHix26+qDIlsMAYFCxNLL72kjjYBv8N0KyxnmcMItLbk9S3no2FSeYLr0Ivrcfo
 F91L9+4UJyB00a+LW0pIZtgY+UUZGot+S8G+iaoB2yP7gGqaONg7V0fuyRe0ohhMmaN0okEa6
 WYx2fNNDJsbfLLv2FqDeDhqdgKIUx4wtJaqtJZkjca953cbEIu65u7TE5N19g9LZLu9e5kZrb
 FWF3c93+ELXucCXzCKLzfUmCVVvc/yeysnFEVZEoO3we5O8O0wkmERYIXJu/FW6U9QSIhndMZ
 HwP1oXroY2licefHSC8yMxfj3q0HHJoNmx+ZASyuYCxVOrYL+1+hpnGj0d6ELj1QW+GdHbpfL
 fmp+QbMjgPM3lT9z8D0XfRjK35ZA+zjdDWhNXJCc0yZHGpEmnqxo5NwmjhJAU3RD/EjMUUr0t
 s/OfZFAvLkGUsumls6x5s7lcQ8NeuN5RmkGqGQebqk3sgnvGJFHk4xIWgjWyI+LWxJKFXSVRE
 vLxvriIQ/uhpSvEu4DMeJsTQOSE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a macro for allocating and populating a shallow copy of an array.
It is intended to replace a sequence like this:

   ALLOC_ARRAY(dst, n);
   COPY_ARRAY(dst, src, n);

With the less repetitve:

   DUP_ARRAY(dst, src, n);

It checks whether the types of source and destination are compatible to
ensure the copy can be used safely.

An easier alternative would be to only consider the source and return
a void pointer, that could be used like this:

   dst =3D ARRAY_DUP(src, n);

That would be more versatile, as it could be used in declarations as
well.  Making it type-safe would require the use of typeof_unqual from
C23, though.

So use the safe and compatible variant for now.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Why typeof_unqual and not just typeof?  To remove const when duplicating
a const array.

 git-compat-util.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index e81bb14fc9..44abb240ae 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1115,6 +1115,11 @@ static inline void move_array(void *dst, const void=
 *src, size_t n, size_t size)
 		memmove(dst, src, st_mult(size, n));
 }

+#define DUP_ARRAY(dst, src, n) do { \
+	size_t dup_array_n_ =3D (n); \
+	COPY_ARRAY(ALLOC_ARRAY((dst), dup_array_n_), (src), dup_array_n_); \
+} while (0)
+
 /*
  * These functions help you allocate structs with flex arrays, and copy
  * the data directly into the array. For example, if you had:
=2D-
2.39.0
