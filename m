Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8725C35250
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 10:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D49B20726
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 10:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="bI+5JAmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgBIKXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 05:23:37 -0500
Received: from mout.web.de ([212.227.15.4]:53707 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgBIKXh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 05:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581243813;
        bh=YNEPhLeddTylx+gTM2tOTzzrSBTPrldC7vsxEY2ZedY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bI+5JAmS7AJRDzC+ow80f2tOvk4i8E+HONguvidxGhatA+Y3dpO86tjsqHSp03Sq4
         62N/FqfNtfcWymy6uwA3RxcjoIKjp7EBE4WO2ERW+Z0XhvzjrLrcegr7CA7dg/n1mp
         P/MiGtQxL2bMeo51Ir5R1ffG8c7SkjY+oaNF/ilg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKJEM-1iz5Jz3Kz8-001jTR; Sun, 09
 Feb 2020 11:23:33 +0100
Subject: Re: [PATCH] strbuf: add and use strbuf_insertstr()
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <019be197-e0aa-1234-e16f-6561d8340023@web.de>
 <CAPig+cRmzHEQPhTzHrqqS9So63pJqQVGa1kGoWARmGU_0tn0_A@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5566a63d-f713-7580-6fc1-83286bc8955d@web.de>
Date:   Sun, 9 Feb 2020 11:23:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRmzHEQPhTzHrqqS9So63pJqQVGa1kGoWARmGU_0tn0_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GENULQwmM7D6oHL4ZQDuzPupbq1H482Ffu8lGy5lM61zdTieN6q
 QKYlQDVk7LPoH8w2MbTVwTU94J7SXkaaZY7m/ze3Ff9ck5/Ge8bgMPO3z6S5THK4qQreyRI
 Wo3rYYfWy49C5RZ2MEaHI1PvOWlm3DIo+DXRP7TDUGwm9En4rYZDFo9pG+wTk9LJIlROF2g
 4YMUp3RdpvB+WsLk6/dyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sWUauCVMQWw=:noSXS8g61SbYK9/WRGtK+o
 /BcSjNcqksz38YYAzZPFZSlYtiPoLxyydITZwAUd+Au+b6/05e6zoK4NRWe1WGe5ZZYECPAEg
 RhxPN7BdQ33w0Vw05gGg89EJLHNmMQCjM8WaU4B+hoV1JnE54uTtV71mvq4vWFTNjLdeGOv97
 q56CNAAi7YBbdPo1Y13A9WLcjjXmroKfh9ivQkxE3NfMHkyIUEDQI9Tm1TiAOXw44QoSINrL1
 /YEZKmXudxyXTy1YT3GYhjnnbaO/eQJB9Lf16iCVhGuEpZMr3mpKUpwB7/MuSHPtjT1u6bSeE
 0Tvb3VlJJ98xgKpmg/j+Ans9vzN6HPO7vMjvC/V3u4UDjFk7iFomNwWEbuYzwaXUL2lcQaVu2
 KtutosKk5pLHo9C7YG465t+skAxqKziJn9u+zfWw7IeC1e2vNFRdvBmqCmErwXtJ4q2GUovrn
 byxf4zsnkQGuQQDheRs+AoHCxjuaNfsd28sm/Id5RtoqSgudEuRPieyXTc7JLjKSn6LDvGr0R
 GD6KqJOLE9hRob3R4E3VpGk//lT4Fw9ojGY2RjMkMQjJiNmRdRpMiG5d0DxAvjUZflNmHrQrC
 9h9fnWGFfrOCLFPWLtpEixSh2Sxd7tFyTcUk3rJcB62YtdY3iYuG2PgoT/Mjcx4eExpaQj/mh
 vlUE0AtFT88+H/rRptye0DBGOyKhB2FFlKEbb8T2Ue2WxJ7nM6qE/PlyJccMnGHwhky2RzkwO
 TDNMZ5Fnmljjzsq5mB3hy9aX5DNDr5aqCBFcGL9yoomC55J9VAC/xiwauMk7KoJFNH0o/pssP
 ErHYBs75wQblJIL7xCSigtrwPCBEbK8qr5DTbZZOw+NExZqHLrdTlfITLjyjH4X7n1QN4b/oU
 7h4Wc4O/T9RyMkljw+B6gHxKJCPXCflv40jasaNr7pgfHtHbP/UfWOXjE4if6+VlFU01inmeh
 jgSonevEe4oA2v2sXUSGV892r6zrYiYFoGSVAb63+QYWftVjerZqSmtJ0OHMYZTdZP9mHP+pk
 Qxezg0oXr7MWwqSbJBTHykIOFN9vzp13YzYtCW6LWqYnItZyM/xQ/SE+/Q8jPEg2QtzSPmJIn
 rqSFnyR5fHLiubsahE3avUiDfpZR/aEX4uJ1rJDEhUNiUHtWI43xKLMd5lZeHuL+2SOxAYZ6i
 N+vlMw/PQklm+tdW7WyQEFs8YramNElZ9xQKsuwpybGCRIypT2r6mJnE7KYrStNva04x8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.02.20 um 01:53 schrieb Eric Sunshine:
> On Sat, Feb 8, 2020 at 2:57 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>> Add a function for inserting a C string into a strbuf.  Use it
>> throughout the source to get rid of magic string length constants and
>> explicit strlen() calls.
>>
>> Like strbuf_addstr(), implement it as an inline function to avoid the
>> implicit strlen() calls to cause runtime overhead.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>> diff --git a/notes-utils.c b/notes-utils.c
>> @@ -52,7 +52,7 @@ void commit_notes(struct repository *r, struct notes_=
tree *t, const char *msg)
>> -       strbuf_insert(&buf, 0, "notes: ", 7); /* commit message starts =
at index 7 */
>> +       strbuf_insertstr(&buf, 0, "notes: "); /* commit message starts =
at index 7 */
>
> Is there a reason to retain the comment which talks about magic number 7=
?

I didn't understand its usefulness, so I didn't dare touch it.  Looking
deeper, I think it already became obsolete with 13f8b72d8c (Convert
commit_tree() to take strbuf as message, 2011-12-15), which included:

diff --git a/builtin/notes.c b/builtin/notes.c
index f8e437db01..5e32548cdd 100644
=2D-- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -301,12 +301,12 @@ void commit_notes(struct notes_tree *t, const char *=
msg)
 		return; /* don't have to commit an unchanged tree */

 	/* Prepare commit message and reflog message */
-	strbuf_addstr(&buf, "notes: "); /* commit message starts at index 7 */
 	strbuf_addstr(&buf, msg);
 	if (buf.buf[buf.len - 1] !=3D '\n')
 		strbuf_addch(&buf, '\n'); /* Make sure msg ends with newline */

-	create_notes_commit(t, NULL, buf.buf + 7, commit_sha1);
+	create_notes_commit(t, NULL, &buf, commit_sha1);
+	strbuf_insert(&buf, 0, "notes: ", 7); /* commit message starts at index =
7 */
 	update_ref(buf.buf, t->ref, commit_sha1, NULL, 0, DIE_ON_ERR);

 	strbuf_release(&buf);

Ren=C3=A9
