Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A915C4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 12:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2611161165
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 12:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhHUMxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Aug 2021 08:53:24 -0400
Received: from mout.web.de ([212.227.15.4]:57751 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhHUMxX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Aug 2021 08:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1629550360;
        bh=YrPsVq8IE+Lxkg+PtLncyXKMG9uKVXKyatvnwrZPRtg=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=Pu+P4ypGt4NQY48/NgtAySF5AlTTBLkxSsB8ghPYqRDFNhJv53893f6BtdsdFNjgf
         vyHRtBe5i59wAAG5ISh6mxyjV8gLM4w7w+qa9h8VY9mdKdUNcV1ym+p13FKwW/TGAd
         SKzXrRxNUWzwjwwGie3oD2WZDhxYLCdVpCUYGiN0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb001 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MDgPG-1mGpKY305W-00H43u; Sat, 21 Aug 2021 14:52:40 +0200
X-Mozilla-News-Host: news://public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] compat: let git_mmap use malloc(3) directly
Message-ID: <9c2fe5de-be23-3e66-6edf-3c2edfb804f3@web.de>
Date:   Sat, 21 Aug 2021 14:52:40 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jVA0om7UFB07gLRwo+6nepwbsQKBwyGmeTXOKMfBFrwEDAM6L0M
 KZ1GZFs84XKcdpdx9s2DJGo9kbcnI+CWhZEYTGFUqmhLkq9xmiyK9Ek9Vu8PbbVDsbO8jFo
 Vo8MJmjZpXk9lu5Kxe9d5F9TO9poCS5VQe0l1TQNteBR5pP/Qj7gW2qpZBWWcTrNmhBzd2y
 kEFblT9yBDBt+/ADsFmtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ElyS6/oavkI=:fQ+uXO6vmV3Nsn1jdoSWYb
 uXHFMkVlmFU+4ePDdwlnm54IbiovM7Zn6J08higwcCmeZ9z6Mzhhz5hhfhHgvWJAdl990cDTM
 SI8eUNT1wvDAQ1KT0YMDZcMaj9slaBwoNVtCwrUjHaOMrFFu3deiV1vIz4OiFKKQ+04JQ/dmR
 modi9Mfox3ROLJ+7s5+wthQQJR+GnYjE/bb38Dm8o9MZm7aml8asbJV/OF22mU4V7lA4JwnaF
 +KXdB+BXp9r2whnsYvro/uW314yYNy3czkbge9RGOzxB0pEUzcwBWnOa1PaKU5MjkvfEkBXaU
 vJ/rGUXx3vIMF/GaU7KL5qIgJ/4fnszP9E1vrVLFsNKmmZtAurjwJUyWHz9S9ceuYbOcX/DQd
 UQQ1Y1sHse2QJilaFiR8xCNUni0jgBpJWVCSJrW2I1tEMTaUKuaDs3FjN0C3y80BOxmjBX0kF
 yeC6d40nVqbaDFFhhMqzpmLUWuwPUtdClXq2ofw2CaZqHXDimyH7r3adaDtrAJwKpe3QnzVTJ
 Rhfd6RFeyeLwH8NEKslkmWYIkGqimXsgwIFXSedckH3NVnYOGXQgIX3Jc0XFP4sWoMVrPfyFM
 OAq9AqV4/ROJEbhwQk+M4kBsls3ZjwQ91GKt5e7PYGa1sZEoMit+Ev1Pt8Ddxh4N+X0WhrrcP
 YuyyV2x25xO96TAoxBaxSYJcXmEC9ZcPWXRPe+8A5UWh+PfLLqssQEYNUbvz/Wxc6f0JsCaUd
 M8NISaJkdRJy7xCUNQaNPoZBz2Zi+f6PaYuou/88NYRTtSTfz7KsgmZtkvCAFxDE9345i0vlY
 l3YVVcsYmKC/eKu6ppP5/dlkL0Z8WkqM9/fskiBfCDPME08Ic1/5LmZUfPlazPQ9SbbNAtHZR
 JijzGPz/Gc/JzG310dKo5vsVZPr4G3LPImZLu/H6ZB9/1xIpBRMDYmF+PwJkVL/3ioMO6N2qG
 hiRRW+8Vg5/kA9ocbITxDRVhxIAK9HtvWSI+vknnBaE03ORK2rra18YFOI5O1lMiaSjnuJ13m
 5iVyD7fAgyAVzIBFADRJNYPL6lGjHRCTQH0hund4VR+AoL1cDvme4w+IKc2aVcnJi5iBa5lZv
 jBhc9p02gkgl9XF00yU/1rEnWSif1bX2llN
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

xmalloc() dies on error, allows zero-sized allocations and enforces
GIT_ALLOC_LIMIT for testing.  Our mmap replacement doesn't need any of
that.  Let's cut out the wrapper, reject zero-sized requests as required
by POSIX and use malloc(3) directly.  Allocation errors were needlessly
handled by git_mmap() before; this code becomes reachable now.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 compat/mmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/compat/mmap.c b/compat/mmap.c
index 14d31010df..8d6c02d4bc 100644
=2D-- a/compat/mmap.c
+++ b/compat/mmap.c
@@ -7,7 +7,12 @@ void *git_mmap(void *start, size_t length, int prot, int =
flags, int fd, off_t of
 	if (start !=3D NULL || flags !=3D MAP_PRIVATE || prot !=3D PROT_READ)
 		die("Invalid usage of mmap when built with NO_MMAP");

-	start =3D xmalloc(length);
+	if (length =3D=3D 0) {
+		errno =3D EINVAL;
+		return MAP_FAILED;
+	}
+
+	start =3D malloc(length);
 	if (start =3D=3D NULL) {
 		errno =3D ENOMEM;
 		return MAP_FAILED;
=2D-
2.33.0
