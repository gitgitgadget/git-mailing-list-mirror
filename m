Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721FAC352A4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 07:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A58920838
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 07:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ISKIDr86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgBJHPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 02:15:47 -0500
Received: from mout.web.de ([212.227.15.3]:49779 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgBJHPr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 02:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581318939;
        bh=fgojvUymxcvWwWjSbbitmgCwBIqJbU8Pe4bPy8HnfRk=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=ISKIDr867oDV4ohe/W2Wqx7pkrAdtgJL3KxmMRwXn2UwPWo5PKdSqIIQssZou0wmb
         lg5yrbmgWUxtZ7+PBdamxIuJG+eapi0vUGkkuDOZWpCbGkTevT8lM55l1mgo7FnX++
         eahiVOd5K9CKT3jUTZ7QYlC1mroGCZVloBsvi6C4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LsNpI-1jTtsx0Yky-011ygN; Mon, 10
 Feb 2020 08:15:39 +0100
Subject: [PATCH 2/1] mailinfo: don't insert header prefix for
 handle_content_type()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <019be197-e0aa-1234-e16f-6561d8340023@web.de>
 <b31c46a8-380b-3528-27a5-a2dddacaf837@web.de>
Message-ID: <35ef5149-2da9-a147-fb5b-8f175ff617e7@web.de>
Date:   Mon, 10 Feb 2020 08:15:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b31c46a8-380b-3528-27a5-a2dddacaf837@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LKZoJ4SVMdGSITcYK8Jx/4o7T/V1MOxe8uL6c+/1Qfg+vNma9VY
 F5LYxoau4GlZmssXUIz5r62DdDAalcRaKUEOdGK/1jZUn/KFoDu+Rkvih5kMEL39RHO9JZ0
 PtyKe9XQbpPkv5M4XBOVDRvF/qyQP4vytGlNhAKJuEGzGM4Zq9UhW1jE+Gza9LP7sI2N2lw
 DAuO/9XrTsTucqPlbLIHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fyxfy2BFXd4=:6lwAfRPY5LzkBkL3gDFXAE
 i16Mb79xoXAAiut+hMK5hM6f+euPS4MRtGSr3G6VktpbP9d8tE2leFYxfcCmt2cd9z/smvbIZ
 OtYR1bqCEaFc/eKmYKzFFa8pMTD7IyxgDyHmmiNh/FbWkWDnZNMIGw9vRUG4o/U6ILLPQr/P4
 /opz+pn5oKqw6pHQPoCEXdK1CnJ6tMQkz84f5Af8ph8tp3wwNGqmYe/s4UPHnV9OvPh3g//DD
 MBg8Ma1pjeHOfpevMeL+AqddXoT8JdLGkg+/CwKZkOlc7txG9nyL/vaYTgyGSQCmJUBDEHPOq
 iL4JYJpMu8GkNF5nhQCxNRvIMkIX21Snssyvyi52lSgqdeTI/mtrpWfd6mMpXDFWUOdhIUl+u
 zWJUCInuaJ+MvbUvGxfamC/wwPTXJ7SVzm1o7CqE1kx0VsSX6b9fDYlq+zoxeZDwvCMKMT0B3
 jjHBWAb362VNqjsFQFY+Zkcq8BZwtxZZuP2deD0I9tBgi1edfikvjv7j89U7aMmpeo2jZ6Vlx
 Ri91RTuWck0qcS9n0e76MaHYi64E2oDXjHppDd9pzs2HZqzRKbvbtdMWnpwNKm4z2s7NqQqCx
 KjttxjohTsfiVubg3Bi/FdcmHuspbodagFbn5G7oQVtrCNIz9PbrlKubMzur20L4jZSCmlETJ
 uWdK5gEpyZgqeejHbVyQsYOLUbI+Z4mFvPhUvrMuVY0a0UXBoqeGWo+tMeUssTDsDC0/3MRaf
 GRwwpl249DfQAZLs/9j9yM0PJfUKOQsOUVE+Mg5mTiopu/eYs91jxB15L/C3slW+TXroEdmbh
 l8XvcpZeQuTeN7zzfd5ROFq36PLw53iko6tyStke85jhSTaOzOtpEhAMqyPF4+ViIkpAt8ZCI
 JISCle2q0hIOBapCrCjMW4m/1gyLxucNO5ADDZDDbI3/6mZzblOVHJT2JV/WrMdhr0JkrfnBm
 safqFFbtKCs6uqPOm24f8nssWhcuU6wl0I71o2TQM/knYx3BHBe/a/iPf3Zrq+6NeGlGRZDD1
 tmaDXVoiHMORQoZw6h6gpN2UqnXMt+FGFMTgHer4cAQwh6N3LysMnz948zsN+UngF3kC80Nto
 H4pb4U6e3rosEwNgcUzPxAlHdlLZH6uYP6pPKrazmhHdEqAzWFKuVm2wNEiwbRXUZgRQkp5rr
 K093arlG8ujgyqNuJjqDcsb50jEU1Wm7f8zPjkNz/OySgTG93L6hJgfATfAEeulpX8GZe+L2N
 sgy2jeIU0K6pyYWDm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

handle_content_type() only cares about the value after "Content-Type: ";
there is no need to insert that string for it.

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 mailinfo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mailinfo.c b/mailinfo.c
index 543962d40c..402ef04dd1 100644
=2D-- a/mailinfo.c
+++ b/mailinfo.c
@@ -570,7 +570,6 @@ static int check_header(struct mailinfo *mi,
 		len =3D strlen("Content-Type: ");
 		strbuf_add(&sb, line->buf + len, line->len - len);
 		decode_header(mi, &sb);
-		strbuf_insertstr(&sb, 0, "Content-Type: ");
 		handle_content_type(mi, &sb);
 		ret =3D 1;
 		goto check_header_out;
=2D-
2.25.0
