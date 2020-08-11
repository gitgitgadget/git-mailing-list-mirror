Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7CAC433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 17:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DC0B206DC
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 17:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Q3IEqTXW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgHKRPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:15:17 -0400
Received: from mout.web.de ([212.227.17.11]:34575 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729092AbgHKRPP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 13:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597166104;
        bh=WXbLLS8NGHR+Jt9An3gGwv+CTOAcVvj16HxOYKKgKb4=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=Q3IEqTXW7KeCCQSQ7fOuMtklIVO5drwqWOCbGlsjd5u42BmfR8odztpvdS0USbwFp
         6OGd21/9znxM/muxODmZtvTnTHXTz03as70LmNyhjImW+5uVywMAWO5NnVuwups4iw
         4yaorlwg3nvgW3pNGTmVTpLMrZIw/Z+XU3RqtnOk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mcni1-1kNLra3XSD-00HzjE; Tue, 11
 Aug 2020 19:15:03 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] upload-pack: remove superfluous sigchain_pop() call
Message-ID: <29ac165c-8458-9bb1-7e59-e7c2c68a9f2a@web.de>
Date:   Tue, 11 Aug 2020 19:15:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RgXWB9IJjiAv3QSUF5cM6I4eR4Nb5hCbqiBn25fG8mQdlyi3l0+
 J1CtNOTcHwllnmNmB9YByx51jK809prQyPTYs/SowZZ384fnhRfEms8NpVGAe9HL/mZTArW
 CV+neoPdFuC+Gf7A4/X8QFhRp75OExy5uorbXRUEF/euNt7u0v3nsVnaK8pufNeRnKQ5xyr
 78WoMzcQbgIn/c+LS/MAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:njR13aYFjS8=:CYM02UPcKLFv5pIhxsL5XT
 erwoRdSCpm4QLoVKYaVxGflmUNwMWd0ZMVzXXAzjD6yNl4kks3BePIZ3vNhjiQQjm/3Wlok+n
 +mt/9mPIiJ/MVfipGotrFsZrfhd+B8SKy6ZhMCuu87hpZm6svxMBKnqcxipgzvXgOiCJGTFcE
 ZgZkZFddPlj41a1eS3O3uWPR5hZigsPXIL5HTPAKVZS9KJLgMJh/hlNBo58VI+PKt/uLxJhEr
 jMde6SMa0UTSwtnr16motSHee5Z3S4W6/JgnYWJ1JdSUfGPTPQ+JiaDJMZHoSinGgsvlBsBtE
 RAjc8IQD0Npfq0t33rCp3FA1EVP78euafUFfkXJGtvObtDTiuV3cTbibGorXhYwrFiEXLwD+B
 SWZ0VoBUYcuou7mc8u8Ef3hz2gTykpPoJoR8PxdqQpPc5Zp8orJ+pGfyjJ9GVSli89eUn7Zb8
 uaZ39/iOooZ/yi0fVwuhGIa56FugtltE4+eYMNF8D9jHlGc9fNY5BD1EOjRR9RAprToqpPgDg
 daA615goS61r3JWSke/3WlVp1JLbnisAgj301KxTN09sbofBfyR/HJguwtWp42eWeZ6kNVw9x
 aZFbLx9YzHu6uvXCE7RKcAMbLKUdc+mkvUo/ffUpRpNJ/xI4ain4gLM/Eb2zJQ+GjJQsr/zw2
 Z4QP3HeaXLjxqJ8eCp+XsSSvEQfAfmWDlNgYNMbvcgGWkbVHThsXX88FvkCd9agyEYlYfVezU
 RP46RQHGOUlodc5ZMovPzQ9ul3erviNIsSBZneGluWFIBG4E9GF26BUCQ/GGCSwZwN1WeQkhK
 q2eJ1EM9VFO0VoFcp2B00lFUrMsTlgptTowHDS2NbY1ZmzcbYUZUTybszX0yYJYARrrr/Bp49
 767T173jGhfXDb7DbZnMTV4E+OFAYkBW54T9i6Q2zAfxFRPh/JKsS4GDXDdabggInjr15TVXd
 lMc0ljQoq/Mi83KUdb/ypGuW5tSBZVckqIQrmd0Zo+1YBFupjD3KEu0vB+yxOSHbwRvoJ0hwl
 pegNVn7LRuYVi61Oqc4na4mr6oGvR8DphPhKRWsxPLT8CC7FEmDAxgTD6hYWf6k9R/eDWz5Rb
 /gBUN3UlsHpJEscPRLSt83/3BR5IuGDHotL5VwmdELYb6vhSACis3nf4/SgspzzpzUEMmI9im
 48uaMTcBkxcGoE29URSF6mxfVw8hH5FM6X09UWvuwG8FwVELxHSWmFFczAw4VbDx2GXYtRqqf
 PjuBm+lPiTRw48Gf8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2997178ee6 (upload-pack: split check_unreachable() in two, prep for
get_reachable_list(), 2016-06-12) moved most code of has_unreachable()
into the new function do_reachable_revlist().  The latter takes care to
ignore SIGPIPE during its operations, and restores the original signal
handler before returning.

However, a sigchain_pop(SIGPIPE) call remained in the error handling
code of has_unreachable(), which does nothing because the stack is
empty after do_reachable_revlist() cleaned up after itself.  Remove it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 upload-pack.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/upload-pack.c b/upload-pack.c
index d087113d23e..1b068da0d26 100644
=2D-- a/upload-pack.c
+++ b/upload-pack.c
@@ -731,7 +731,6 @@ static int has_unreachable(struct object_array *src, e=
num allow_uor allow_uor)
 	return 0;

 error:
-	sigchain_pop(SIGPIPE);
 	if (cmd.out >=3D 0)
 		close(cmd.out);
 	return 1;
=2D-
2.28.0
