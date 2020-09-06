Return-Path: <SRS0=Ralj=CP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5804C43461
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 08:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83AD6207BB
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 08:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="sNmrEY7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgIFI7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 04:59:21 -0400
Received: from mout.web.de ([212.227.15.4]:57257 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgIFI7R (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 04:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1599382746;
        bh=bVyyUW9EudqClzMvV5x0GP9IWefCf7Ds3XVV7u0uYdc=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=sNmrEY7VixU68Qk/60CtpAgeIr98igyxzUDWPneHC68t+SrASReixg+mpaXVGZePo
         LovezZM374k8xK8Qfaz3zLWGNDEF0AX0kV67LhwcWTDlClVPE1Qh9Ay/RpSmUAtqa7
         DwMUHNcqusNjMssG0jsnreeGKDwYSUpphj45XHsQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.149.245]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKek3-1kEZOn2hct-0020Z5; Sun, 06
 Sep 2020 10:59:06 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] pack-bitmap-write: use hashwrite_be32() in write_hash_cache()
Message-ID: <1143b9e0-3adf-095f-78cf-2f8d8c2bd368@web.de>
Date:   Sun, 6 Sep 2020 10:59:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yd7gA4HgCEsXxXnVUfE6T3MMiz43ph4GeaTzjuwwUsRZuivqI5S
 u2qCUO5TGUxkPHfUssIxEx0QKcfQLQgvbtsYplETHyHFMJZ3hkTvwH0BeIF4kPCinUuBj5P
 tTt8pcTqLFvZugpTf/Cin+3Owpj+VK4FmOpTuYpM4+Wtch7UZOPQS9rfjcNG8l6j4YqavED
 ODBVfAPmMu4VR/8jPkdSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0uGVCUyZHGk=:XWJ9T/zvfzK89yq4EFDOu6
 s/2rEVS2U9yEw4M1+5AdXAvJp3a4pI/g5FIj3bdRlTE0/Ew0Rcq0YtKAOUCJPc3OCwQJo3Iry
 j9Fh1HIyowfRUvv4m7BX4ub+sh2k+Tb/rq5YhFgqx6ecb2zboLGt0EDMZz0PF4+CduH5ixxDX
 PjSHaU02l+bXtuG2oAWUvT6Of2o9uTRSQI9wtiJdXKzvSik9WZKh2iwVLv47ROXx+Mz8EqUhC
 VGPJmdcQkzk05WKXfEmt5Y8dvbc5Sip+NgW1wgYK4Hxl1R3dOOUDG/d1l9gloR/vr+75Uyjmq
 J2T9Sjv3Ca+yT7/pZX0tdM3bGng9K3qYvs2fk7H5C0+fDb2bAdSr154iR3nTUkeoFrORdWgA3
 ph9qG7EMlkFs5knWn8+zrdElU5+NhYCA1/ouf0Ah2eE2Lxr6CwVpOdoSd/SEuJJxg6xh6fUkz
 84hqwuoNpBRUmpcZE/is6nLJ4zvXkPfP2KxzVnzf+SpsZYVerP2aGICLId0EVgx4zg2If1Z2F
 OgBFjkQhs20hQFfYrdaLRmwjEo/+IzdFbkaeHx9GkRdNis1sxgDikBobKQDBbTGCXeFwUQ/VQ
 ld9urgFa50iKIK2ZyI4a9HAufLhHdA65IlYKN3wzFOYt+4ZHCnmb4ooLeYqj/VxewnC5At5vF
 +I7ca0atO24KwdubvDgUWCSRHqDM/J4TcjC9t//7Z8flhssWCPNvI1SHjUEDdOGz71cGw2n+Q
 wPmHcxUH9QimyiXLa7UoAL4d2JkhWB8FxcQ4T1S78y0wVE3feAO3HT46YHo4biVhyofAoTNhF
 dF7jnNHBcekQZVzh7i+HFozePOhiO8KtZ/3qW/R9QMAoRbOW7cTkX+Z4piitWpVEPvsufKw8k
 5I1lnVuluXx2zDq5ozb/khe2OWBalQ7YDRDkPTeVTGo0HV4Tt/LIaoddCbqVWlQTdybr097pL
 pHTlVaQjb2MtScvYai/OCLmDEHax91CjOw4jcLbY3HfciRdhcHu2jUucnidZk+OIdTENF7SSx
 BtBgmR3xYww54VklGFJu8Z30uzw2cEKKxdVXS/btKD/NCXP32GlH5lGp93GXlN8OqDgfXx1RS
 z1Njpk85YL1qmQJwGIltSGpJY0usuTghOEzvwKcRx3l5LzRFQB7LIg0gMbYyh78ikTkStYpii
 jCPApgxx3inklvAH6YDo73LeXWWj4ZIMlZCN5nmG8UrounCNE7qSNpKD/4ASZLU2/uAdKmYsz
 yi7QN8T+z576bLfJa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call hashwrite_be32() instead of open-coding it.  This is shorter and
easier to read.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 pack-bitmap-write.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index a7a4964b50..5e998bdaa7 100644
=2D-- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -503,8 +503,7 @@ static void write_hash_cache(struct hashfile *f,

 	for (i =3D 0; i < index_nr; ++i) {
 		struct object_entry *entry =3D (struct object_entry *)index[i];
-		uint32_t hash_value =3D htonl(entry->hash);
-		hashwrite(f, &hash_value, sizeof(hash_value));
+		hashwrite_be32(f, entry->hash);
 	}
 }

=2D-
2.28.0
