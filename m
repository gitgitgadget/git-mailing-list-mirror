Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87C201F461
	for <e@80x24.org>; Sun, 25 Aug 2019 12:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfHYMxf (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 08:53:35 -0400
Received: from mout.web.de ([212.227.15.14]:34373 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbfHYMxf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 08:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566737607;
        bh=Z59f1oBnHfIHCxW+yTY+ewYoBlZhyghQ4pnZ3R91iDM=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=I4MggAgbOpGlGTHuleVw6ivbUBTNfo/VAPabfGwjxXVb3OLcAn2ZMuQT+2KFiMJ42
         yppM7LDZkogLhDfkCCEIBQPFaRz/GGb1WpCeSp77nF9U1/ZwCvMazjUO5Z/LXIfgxq
         yjWoNx22I+BqNXHvGfyXfTM8GFNcS3NDPYokmxgw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MQ63n-1i611Y26fT-005FT9; Sun, 25
 Aug 2019 14:53:27 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] log-tree: always use return value of strbuf_detach()
Message-ID: <dc471768-7f42-3e51-6397-1c40466d3726@web.de>
Date:   Sun, 25 Aug 2019 14:53:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G/MtekvBWIqvlHTj7wVJXIf6Hg0ZFzn3Vw4euiUouSeqJtLaUzH
 +B5SMolzRFjpva8uhvuHLkhqvkl8J9yz3NLrETtbIznoWVUF3Tg/g+0Zj2riPny1w5s5FWJ
 YUcfctMSn0z41ZbM367eVlTnUzIvYU8pU7gwyukuRpXfvMkoygKMqrNsYBBPRj+lT8h9K7f
 CYFid1LO6pUdk0MZXGroA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f3ysJkI4YbQ=:kc5EqfaZK51D4gVakMttMg
 dJg8Gnh2OKwgpKqV4BUd6jYU8GOuf04hJLVcJWELBduozj0IJdlk4KyehipOhO7RuBAyoLGjZ
 0K/W+Ui+HF63qq4oLrONKpTxJwR21uQ9YStkGuLxFn7y56iJJ1izhn80bLbGg/ioOBE+pfuVo
 iMbjW9P4MsrIIzz4lrfFAFkOFPOikOpSa6H5eCRuMSFNkoR91pFKqjZmPRHWM8FCF8keec33Q
 LnKvhC3DOxu5WNZVxOaQqZWQj95+VCWKBSLM1OTlg2xiFf7+WqvYYQ84GdUDUrPT7fcuRqQp2
 2TDMorT2dHKi9IIsgVj1pCx/pJ4vWpC+RjodEL0o2lIPm/vcC6phAmaey3N6gmKRs2ZxufGkP
 jNWWn18haF8oV/xjLkkjkA+lNRqLouqJU6OZywwir0E1rckJlEdCETPcRdcfuDa2r/XrQ6cVg
 szEgOUObutD2syNO58ltpV1CSUmwn7fMOxw0OwC/F+Z/+m973lUsLlSbbsLWYRbWCpTP6exJb
 FK/sDx4R078rwTw4gRKNqDlbs3WMLYTHe8G9iuuelJSd0ZqnSQGkx9TTqrwsLf399N0RStHqP
 IDobEM1U3UnujdCfFcbNK0CnH7in7ychXjceoeWtc/7j4v47d35ACHvxOGatRLx3OIgRYLtTt
 kB6J3gzgWA+epLVZU6lHaDsDYo723mOWhZJ0wf7z4bbug+358OllZb1I6h9SaokEOCnwq73Us
 yHGDvsCkriz/9422YTgp/ExyzqMQ5YhTdt+ofUcDJ3dO3mASjsVjh3iLFPGBmzi4aIU7KTlzF
 PN671zXPAuZChcgVlmhlRhogvO2osydfFsgCLzb6uEsWDHoXdhRSbq5oODbu7jdqzqJpJt43l
 ZCDkeKCFdaYG2zcA1HE38iS1fdoGD9Gx8TcTqDkb9Ybb9TL9UVX4ETgQKwir4HFwjXT6njNOD
 +8yd+ZhdjAmVemKi7YDVpB0qk9xaBSORyXXFGosJTh+sZS4jXLIM+fVWgTDLWKL6uSehPksw0
 vNHrstNzeRFVM9umiAu2uSInnWNaO+TB5CO0YWsHAKMR30HjP2D6vT3ZFsVB3gTXzHF2tOXH1
 lBH6RB1zvTr64zVlPLBDIEtvubVtMNfgSic3c4Z5isvGENTHfKvybIN+s322pka+0j+zfH07n
 Msssw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

strbuf_detach() has been returning a pointer to a buffer even for empty
strbufs since 08ad56f3f0 ("strbuf: always return a non-NULL value from
strbuf_detach", 2012-10-18).  Use that feature in show_log() instead of
having it handle empty strbufs specially.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
The patched code was added one day earlier, by ddf333f66c ("pretty:
prepare notes message at a centralized place", 2012-10-17).

 log-tree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 1e56df62a7..109c212224 100644
=2D-- a/log-tree.c
+++ b/log-tree.c
@@ -677,9 +677,7 @@ void show_log(struct rev_info *opt)
 		raw =3D (opt->commit_format =3D=3D CMIT_FMT_USERFORMAT);
 		format_display_notes(&commit->object.oid, &notebuf,
 				     get_log_output_encoding(), raw);
-		ctx.notes_message =3D notebuf.len
-			? strbuf_detach(&notebuf, NULL)
-			: xcalloc(1, 1);
+		ctx.notes_message =3D strbuf_detach(&notebuf, NULL);
 	}

 	/*
=2D-
2.23.0
