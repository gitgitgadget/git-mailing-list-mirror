Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB54C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 17:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiLARxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 12:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiLARxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 12:53:16 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711F59B7AC
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 09:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669916981; bh=ir30PDMxxOc/iLwRUs1v3CmmcsShjkkGbD1kPAleGpo=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=SbedIbJyRimoeT0Dj9JMXDGdp78mzN8y37Dhnb9cZPjg9IDzWGX1zQMNLIjQkhESW
         /IdT9NYM44d1i7legWRddX8UKdLWJSjgZwr6ZvuwXqL4CcnijH3m97KLAQSA5U9rw0
         4wDr37qcKjHk55mzM5+F/C/340tvqAmLUoFfYbJkJDxxZbKVZ7k8+mrIdo0FGUIBw6
         peJuXAspeGtMN81nPafoeIxnwSi1FCuIv737fsxepbpqOQemleSBlKbEOqztJJV4fF
         KAeyn5g2No+gjc9rzeuTJUFz7cQGG7KZLxqXmYvbgs7u4ep5ZcOeEnxfssxHht9pb7
         WehXRtS3w9XMA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.34] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2BM4-1orD1H2zfS-013a2I; Thu, 01
 Dec 2022 18:49:41 +0100
Message-ID: <b4361c3e-852b-e30c-f240-86c34bc9c474@web.de>
Date:   Thu, 1 Dec 2022 18:49:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] list-objects-filter: plug pattern_list leak
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IVlW2ZAzubeSqQWixuP/+Ar2Gdfc7ByYKHQFozm4t4LlYxeYSD1
 6c3HEptey0JRHNNnkNkvdgHexFe3QkEwgiA7d6RU4/2LbJvYzB9EGx7OPwLolM8TmBRcguB
 idnykhdXhr70yJ4n6DTuRpJVrkBAr0p7rQK7k0jGQdrTY5HRohQ2GHL5xX6CHAfD+dYa8k8
 4LOOhuuuGfXWqRZKlhnFg==
UI-OutboundReport: notjunk:1;M01:P0:ZiEMoSO4Z5U=;6M2Flix78yoKrXlEduErXGEyZ77
 W3YXXcFs1Cr+A6s4zD3mGXzLMzfXGtEPsMO4MV5QXoa0xqygFsvp961/Flo6LRhIK17CuTrhM
 EjxDNwbhGfhCJfI+eXXA5eiF6zBbiwU6G74LYRo4QJTAKVLroCaxtEsO3ezXRFHiIVdQFM8sd
 CBquQu3Z3KilW3dr5K4ZmknTalRJ7pT6stInR2TllRpZwAA9/Z0/f0ZYsBmITkQdppkLr8iFc
 ZAZlIttl++qQUUXBcw/SiJRjQvvtw/soIam879rr6VTKwwoDzOdI/rvQfr4HPKWJ63xCqgeJN
 dMvA/mWV1PV33AnXs8VnCCPb1wlWcSaEwh2dhiVeA/xUQ+XVjW5KjZ8IUCI15d5+fKl7d3IkS
 cclNKFRQVZK6WADXeJNzxHQQsqod6H2KGVT7O9lWHHsX1YilJL4/pcUM5zMRsseP+YVOZ64v3
 iTDOI7pdcaDzIhZpOS061VoMLbVdQrzw88/16b859K/eVpCx6EWJS+m+4cNML7ztigI4z8eUo
 4zrZXmYGGyPIfUQ03i8UcXKMhng1WH/xCo1HMiD0jHqdfrfwu590FWh+yauR7smqrZWsCEADr
 kH0ECP5Wv8IRwYOdXBwhOrde8ZjOrn3tdR3YgPhQ60KpuiYoyzr2ApNS6Sn0P3FYxi8cOCm01
 P6A+fWOeMjWfxVlyLWkUakaJL234JuINVyJWdyARpFfdWhxFRIAlzhKUqxOVEcNAJBfQIYDYW
 vJhveGYwqUFCZ4TUk1nvAGSv7vUOtA2US9Law3LGT7Uqg8lXfgY1gx/oDTSJZiYFgZS+xEg17
 RTT9LxmMX6gglMoHPdT8THpGhgw1C85sl+Ry4r2BgyiN81pNN18AxkVynyZqBHETPwv0Z+kmh
 umfnsowpmoXmDu+U/dHbn/2wKoaIFsz2mHTsgw2+Z7zXVM4aywLQkKNEFVnfk4wYptuHxALuO
 Op8jwtMUU0ijIwKBowe1W/oD5q4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

filter_sparse_oid__init() uses add_patterns_from_blob_to_list() to
populate the struct pattern_list member of struct filter_sparse_data.
Release it in the complementing filter_sparse_free().

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 list-objects-filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index b9543545ca..dfc3f49f4f 100644
=2D-- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -514,6 +514,7 @@ static enum list_objects_filter_result filter_sparse(
 static void filter_sparse_free(void *filter_data)
 {
 	struct filter_sparse_data *d =3D filter_data;
+	clear_pattern_list(&d->pl);
 	free(d->array_frame);
 	free(d);
 }
=2D-
2.30.2
