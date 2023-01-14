Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641C5C46467
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 15:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjANPDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 10:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjANPDY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 10:03:24 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FF27A93
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 07:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1673708597; bh=kFAOBlnkLt3zGHxjxGgFvYpVcdI+SR079HDuStQA0no=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=XtXrqYRRrl1JJGxxybdtYTwpTO4MJ4a6BvCmUjbdO/XapfZ6Dhkh5oXGsQTkInNJb
         3raTYKFsQF8O/yuCWGX9CVZ/gPfAtmn0QBUg/ToxjVMHPOdZMt0WU+Yg9ysPa4SJum
         Lprdz/H7rx1Iag3J5OgpCrCKt6fGn3kDSLt2Hw2p5rRd5EbYxJlpohUL1/HR7GBWOe
         PM3bg/svY3e4t0eftvkZPlgBYnOULQi8xH+UPu+GyeFvRV+1wwE09WFQlZhjRfzSag
         rIwtrkZESkEWj7qFFDFHNirnY/Nh7EDnLSt132QCKnYwq6ePWcfdZ3c+AzmP+pAj66
         RNJvanpe2JL+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.69]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mf3qK-1onS7L3Cxu-00gm9D; Sat, 14
 Jan 2023 16:03:17 +0100
Message-ID: <55ae7333-3a13-0575-93ed-f858a1c2877e@web.de>
Date:   Sat, 14 Jan 2023 16:03:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: [BONUS][PATCH] ls-tree: remove dead store and strbuf for
 quote_c_style()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <59f0a3f8-2dae-db47-5075-0cf50aada335@web.de>
In-Reply-To: <59f0a3f8-2dae-db47-5075-0cf50aada335@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2N0Zvmytuj5QWKA+1RiI54mPQNhb7whgYe1uu4YKyq3sXEjtqPj
 mYC/N8TgYkwVRgO8qX+44R/zUcw2+MRVOCgkj7j7TvLMB1t0KA25FX+0EnaIwO2m8AC1OR+
 Pe/seS3E4B3H2mdlaua9tEBJlOsx8qUKNRu4hOLF/X/6pTG/vpbPSQdk3ZgqLnIRwN0uWIP
 cTnGH+Hp7zxkqX6/a9ZEQ==
UI-OutboundReport: notjunk:1;M01:P0:yqQ8rXiG+34=;gQQ5LJhoReL5xhSqVQqL6ifC15p
 MC18zWYhl6ihDgCcCikd4KFgu8sdxIrMS0HdCll/AA8V22lIbef7R1PmDr1j+3aRkuUgX4btN
 CAaTWBs1zqjn/H/7aXeXC3OGrTGOVpGzv4Q6a99U3KfPk0sbizGKH07okPVp9/ZzRyWGmLT8V
 kiJTKEl5xScZnT3fHMAZUWCE+3Rz74uCDTN64EE6k7r6jqUh7yqQyVRSATWJ4U/ENYlO5xCoG
 66ngWRKX49gQ2+FisLtn0M1fIa/Is9D5XiTEVGY9Qzeh9JI32mxedBSDHM4rOpzprlhWF2g22
 3p+yGsRHAc1V3eVWvHqCwqlT0e+8yGi/GGAxNjj5D9RjQKUF/r6/jcuFCLlIXoiC9vIWJGkCH
 LymWP7/WnQ+Ri+TCJ3NfKmEgX3grxs+zXFxW8LShRSkToZy7RKbpSjLiY4F5VjeTD+9tELtlX
 IoNVCbB01NCnx8MfzuP/r42rwoB8SI4+4TgYnZREQkWN9yY8vKT++C/qa88VGftN9Lcv6RebN
 iR90RqJPAxtPKmucpYyZqhKFDuOhYZGEruGjMsinXy+SAkydf21lKtaI6jmqQMqYQsNDZAorg
 1d1Q8jSuK0QJeNhk1jTHi2WsobumN1xOdH0gFMF+7Q6t653Wu6+LXV1vv9G4UmAMLfrXUP2o6
 pHCIyvQYPpaeNCou5ms/u9qSMQkfdScQKp291CDk68hwVjc84R4SY+yxEzrWbgRBys3mEXm9f
 lAykSYMhVmveMS405XCZwylsIBky/pQTI/JIyrzvwdcwbEWaJ5OPIBFAtfNQtwacYJ0rBZcvc
 ort5tOKhBxr0bUD4xkd1q14g3qSyxPo5HMhslahc+Rxte5Segc5u4l+hMRZsM+1QccWPhp5yx
 qHhlMxvL1eEpTSxP72GzAw8QVvh2SdiHYdSDc7L6pcHXxCykGfow/c+gxvbB6VW9hnOBafW0Z
 jRlUDQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop initializing "name" because it is set again before use.

Let quote_c_style() write directly to "sb" instead of taking a detour
through "quoted".  This avoids an allocation and a string copy.  The
result is the same because the function only appends.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/ls-tree.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 120fff9fa0..9b804cd13b 100644
=2D-- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -94,18 +94,15 @@ static size_t expand_show_tree(struct strbuf *sb, cons=
t char *start,
 	} else if (skip_prefix(start, "(objectname)", &p)) {
 		strbuf_add_unique_abbrev(sb, data->oid, abbrev);
 	} else if (skip_prefix(start, "(path)", &p)) {
-		const char *name =3D data->base->buf;
+		const char *name;
 		const char *prefix =3D chomp_prefix ? ls_tree_prefix : NULL;
-		struct strbuf quoted =3D STRBUF_INIT;
 		struct strbuf sbuf =3D STRBUF_INIT;
 		size_t baselen =3D data->base->len;
 		strbuf_addstr(data->base, data->pathname);
 		name =3D relative_path(data->base->buf, prefix, &sbuf);
-		quote_c_style(name, &quoted, NULL, 0);
+		quote_c_style(name, sb, NULL, 0);
 		strbuf_setlen(data->base, baselen);
-		strbuf_addbuf(sb, &quoted);
 		strbuf_release(&sbuf);
-		strbuf_release(&quoted);
 	} else {
 		errlen =3D (unsigned long)len;
 		die(_("bad ls-tree format: %%%.*s"), errlen, start);
=2D-
2.39.0
