Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3727C388F7
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 12:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 362CF22228
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 12:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="KBKGlHAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgKLMUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 07:20:31 -0500
Received: from mout.web.de ([212.227.17.12]:59669 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbgKLMUb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 07:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1605183623;
        bh=f/l10ATK9WfQYBxooZriEcXjINxRzQtQS/Q/nvm69KA=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=KBKGlHATW30BHfupLpd+cUFyVR9yo6NIUg7kdgZ7JV0auTscr8G72gKDx+yLWIn4u
         kXipC2oe9mmDNrRN+Ev9yYM5i1CydgWYbinX0rgMRp1aQYssknQdqXdLkdFR/EUwRQ
         nKJYNlWV80fMAKTTv3BemvT+5ZZzjcIrT7E4rOiU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LyUgM-1kGpgv1IRi-015pIt; Thu, 12
 Nov 2020 13:20:23 +0100
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/3] csum-file: add hashwrite_be64()
Message-ID: <16932ced-8bcd-89bd-b927-cae1bce0365a@web.de>
Date:   Thu, 12 Nov 2020 13:20:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qi+CSVVPmGMLnWckUJuSgSy+51RUwp/7VIitNHIv6JoNvVddk9d
 E7HgcQQiIX82C1igDEcyRC2I1YoMWodHHOT2oQwwBSuaAMAEHE2a5pK/n5Cc/LGzZdwX+Hg
 bMrlfOEdZzaXDhQ0x3yqhWOPJK95956XFVaEOaqY8qO2xB8D+v01gRwC+sKHUM3Vy57KT+M
 vqElTc9CxQVrPJSe4i3iA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cYs86Se9f4A=:DVLpc+ny5fIjaZxFFH03O9
 VF3Uedx0aajuxHcSZ4uQcSFWJjZjNkYyhxpCKDd9TTGCuiFCzvsB4rgLD1Lm5VRWIUPHztxkC
 tSwaZ/CbVMLwVnnshF3IkPWQCj3CjodaWvKqsr+87sV5IxQpdeXxSfYxmij8YtwOM5G1GtCLi
 oSCaj9QQGfZB8Ucxc5GmH3h8U41spD9HLCD5K2NN98spOJnht6eP8vb71ktfNpeWcCgk6cxuF
 IBl3FfteJdQjtSKYts1qEC4FWT08LQObID8KUQqxVzwX1uLi1ENrLwGm0dtSXq0m08iKsMpCr
 xCYuZpvRCDQWNj0OwzFu04DNux9wAbZEjLs4jJl1fCYyLTWVUFdF8E0pw6VQQpdlRzZhn1UaR
 VVFG2uquVzA/lHr9EhmvLJ/X/kB6CWHwRPWdgGRHdhhkSiiUJf4GqQ+rHSEe+fTTxy3s7htav
 JGokcDAJs3+ZIeSHodYa+NGswCvoKs0bVNSYrEpp6EbyJ7Gl39OrR6KcmYuK7a73b9EGaRzHG
 Ju89EaX16rDLqHrZAaKS/PA4RWS2ax1o+RiKe6C2xKpSUQswIkmkSEbU6rINF7ph8W64GDRCt
 F0NwRgNDXdohPpWN34erfaLDh8Bc5khFFshy9NBl5WAlhtfKK9h8iESClIlS3+8Xro8iHcZWY
 tVtbLJdOMk1rGfv2obfHZB0A2cYyEWRFd8TEArLuKhohZAkBqb/jITL95M0IY2t7aQvBJDYJY
 2h8zhVNf/gkFvTz5wcyKi7FwKXG+DFRzTLVANoUbrPFPPS2r1UYHTpog1YMES84/4t93QNXh1
 HC6waAGgp6fTDhASMKsHhmoBRLLlRzWy7Lzz9amPCdZFJIieAdpwCDQYDuuJzwn6ztzqGQ6ld
 5N5a3r9NpFqpzw2MwCpQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a helper function for hashing and writing 64-bit integers in network
byte order.  It returns the number of written bytes.  This simplifies
callers that keep track of the file offset, even though this number is a
constant.

Suggested-by: Derrick Stolee <dstolee@microsoft.com>
Original-patch-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 csum-file.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/csum-file.h b/csum-file.h
index f9cbd317fb..e54d53d1d0 100644
=2D-- a/csum-file.h
+++ b/csum-file.h
@@ -62,4 +62,11 @@ static inline void hashwrite_be32(struct hashfile *f, u=
int32_t data)
 	hashwrite(f, &data, sizeof(data));
 }

+static inline size_t hashwrite_be64(struct hashfile *f, uint64_t data)
+{
+	data =3D htonll(data);
+	hashwrite(f, &data, sizeof(data));
+	return sizeof(data);
+}
+
 #endif
=2D-
2.29.2
