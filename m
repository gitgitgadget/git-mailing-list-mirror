Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FB9C2D0A3
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 12:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D9822228
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 12:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="dWXvjrYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgKLMXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 07:23:18 -0500
Received: from mout.web.de ([212.227.17.12]:58663 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgKLMXS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 07:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1605183791;
        bh=QjXuIZEQDYFyZHMsYSPplq964eMRCVRUwmEheCLYOjc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=dWXvjrYS7hcPnN2Ifb4AGP91UjefcpFKwNwsvY5NDk6+Lz9SPrDbym5NGI+t41p1h
         htclGlSVFp9Ce1ODomEF2RD85i1fFkz15yB7KGVvxrYVMmmmpQ0RyNyzEYZzbvqiuB
         ZKs0evjmtFDCrVj7DGu5cqp7IKDfaBaeQe1DdCJQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lkh7Q-1k31zv1HLo-00aXIh; Thu, 12
 Nov 2020 13:23:11 +0100
Subject: [PATCH 3/3] pack-write: use hashwrite_be64()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <16932ced-8bcd-89bd-b927-cae1bce0365a@web.de>
Message-ID: <716c9fd8-273e-6bf6-ab67-1f589d2c9687@web.de>
Date:   Thu, 12 Nov 2020 13:23:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <16932ced-8bcd-89bd-b927-cae1bce0365a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S/h1yCvS0Z80mMlC9TlJAm8rbtlIzj393CynmGhX4VI/pXAAkk8
 OJsJOmPzdK45qMSN/wKwNOqKiO8cqc8rNnUwZMk2kMGqWhlzwq8ZGpJ9EMg86j29wlaI5tx
 uw2/bhJLFH7UjHI+yKrNBn4rP6qezDvd2NdntzCUFUuCePrJoWg0RiPC8xONN0myXwnSfLv
 UOr8vfHPpvNKTvRBczfwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:21piSzHdJwI=:hqKjM1Jdm0uRapiGFML2jg
 6PVdoju9xYHL6u1X/1g8yISw8jrqx1ceXbK836pF69Nf3bVbmZtHTTlVt1/7bcvbKBUm/uoW7
 vJGR/HvdnO+X5SkwW1/LSuqd9CoBLBYpNuhg15nFfynT7EotHHOTl1YS7wzAnM3Z+oYASc+IH
 e+Mwz8aDyS8QlvIZs4xliipxpw1EJ5AeYDbs5XnFejWiIrzOQUpKoE/7nmMtg7fGrLNhNg3ft
 84r7wghoRROLUzExWI1Ge9XrPeR7PJiJSm/dt37Ru1iDJ4Wz+n0mI8pUcAvUvYQY0KVGEVPwa
 336/DXuHqHb22tyzO0L/9c/16ttjdpUVpiIECqkcJSgg+t19eKO7e9o+RJA+RWwgwuRnoDAqW
 Q3dbrWwg45sTI8VLZz7E/L6zkwyTqYWvyENC1ZrsuPwggEN1vMVjK2xYgyRohDPeSEfZ17glF
 Z/Qw2/BJfAPd9u+IKJnM5cOx5NpiCd23PJcpH12j7YprBkvn0a2wXDz002qKIAAaFwoSGBBZM
 cKx0mCToKrfPr2Vj/sVvoGbFubw5zypumk6bTbrgQwsLXXPVA6ZiaOmA6ILhSkDya8ArzX7e7
 wP1iI+OhbnxIqNn8DOMLQ05ARXAoxxrV+8z6ywziCZewg7zoO8wKVycWrr9nMmA4HVtQ/g7y5
 U5ekTM6gebbShTO16Jj4f6g/aOWJco9491fIzgVrKu9RGx+UO6zkynzMiWy+lX0B6tvygs31p
 1EWU3L2bk0LnYP+NzyztzrTVPljP86M9lWKjToZwoMOQSpHifitC/9gs7cpdFvrCKg88beahr
 waThPEMFlXvFTtm7BkzNUwKu6QS59SR6l5CheR4kS58ZOvPqekfGyPTmL0FBcIsAs7mS4H+bf
 5V6QAQAKQ14gYhDUDmLA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call hashwrite_be64() to write a 64-bit value instead of open-coding it
using htonl() and hashwrite().  This shortens the code, gets rid of a
buffer and several magic numbers, and makes the intent clearer.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 pack-write.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index 23e19cc1ec..3513665e1e 100644
=2D-- a/pack-write.c
+++ b/pack-write.c
@@ -151,13 +151,10 @@ const char *write_idx_file(const char *index_name, s=
truct pack_idx_entry **objec
 		while (nr_large_offset) {
 			struct pack_idx_entry *obj =3D *list++;
 			uint64_t offset =3D obj->offset;
-			uint32_t split[2];

 			if (!need_large_offset(offset, opts))
 				continue;
-			split[0] =3D htonl(offset >> 32);
-			split[1] =3D htonl(offset & 0xffffffff);
-			hashwrite(f, split, 8);
+			hashwrite_be64(f, offset);
 			nr_large_offset--;
 		}
 	}
=2D-
2.29.2
