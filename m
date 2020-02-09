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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62339C35254
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 15:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1612080C
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 15:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="lKJpOlH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBIP6A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 10:58:00 -0500
Received: from mout.web.de ([212.227.15.4]:55959 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbgBIP6A (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 10:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581263876;
        bh=BolcHo35TYV5SMVP1jTEWFEUeDIGcjL4m7k76Zzue6I=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=lKJpOlH07mZP/uFiOxY6XZmQJxKtmOlAupxpu/UeUv7BVCW/Gos/Am75EevvpXrAG
         XsG0udCnupyoDeIMwnvtXH0sVuZOKhbjUIOuxjJF1B/KjnWan27c3chQjsq5tMmZSG
         Xyns1SpMQIa5YveqLpC6ocrzhETx3QDue4oALoS0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MAMY6-1jCKVC2FKc-00Betc; Sun, 09
 Feb 2020 16:57:56 +0100
Subject: [PATCH 3/4] parse-options: const parse_options_concat() parameters
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?Q?y?= 
        <pclouds@gmail.com>
References: <11b82734-f61c-5e73-2d0c-22208c06d495@web.de>
Message-ID: <2f8eeca8-bada-d67d-9c96-bf10f97a794e@web.de>
Date:   Sun, 9 Feb 2020 16:57:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <11b82734-f61c-5e73-2d0c-22208c06d495@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yz0K4RzpE25HFYDL7lxun6YYNz/JMkmDNqbhjMKDCLEuz2uGvXF
 x7Ywqt1H7cCGfbC4LU7GcWBbkJM/HGScNPuJBBibhmtwAjgkTHAA3oPE+oGn8WhShHuoZUo
 fXVsk7RwZzzcgWD6DP7PKvFwK93pxDxVzEQk1bbQUnFvshU7VprUCdjGZn99YRRbAMhCxGj
 MzGuTJBZC9Fv6fL65ejIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KOEOBRnvOKU=:8pZhW9mUTipamBDd3mFwil
 LdL6ZyECxd+f5CHkaMMN9GlDvaf2O5M9lo3Eg343Zy7itwKCLFNidGeLa4jbc3BqJunkPYRyc
 Gc+Kty8V0HdekqxOQHIFGwDD+I6xk8s2iOxA8ktL+zoBA7QmQLBWghUHPgDG1WOsK1uw9Hycp
 //clLxTpczXvjuKpshaFFGFQ9UMzYWz1zAtOf6k3750b4Tl15FF80mJ6I/p+8tovfShls21pL
 oE956m6za0pHrIQxDalVTPRBRjAWmRDRLPkhE1Cm8ZX4+zsVAskgg/yP+HgmxBlFIWLoBjvII
 ZH1yVi4dJ+ZPsPcb79OY10KtG90RAEaWnPJ+IZjW7x0O2es3RXwvScNeIodfAj1CHILZ+ISXm
 Qmk3WEwaF0YWNt/TFpW+uuCNDehfbYJuA94p6XMdULxYw6meMxYofwGfSgfXZMe0D34YC5MYp
 /d3cjrBXUMe5ES7/7oBZCL060q+YL/3gbsOXxUV6mhaXiNjFUk8r3PbY0KDPh1jKod75q98ye
 aRjjHUApIoyoErDK7L3fco+/BP/5CHH0tLj2U7w486dj5d0gyB7xMFTEDcjxwcFAUFks92Q9u
 H9L+AqQqzZw5Uvt87HxjUSdeD23hGu8epBzKw8NM6N821S7f6CC6wehWEtcnI4ayn58+75Bea
 JcLck7CtjxTk6Su4dS2cBBqC2/Ra9cel+amAaraPW+qwgSDJqnQ1258OrdpnYaq5WpPmjDIbd
 qrBj0jtL4trtXYkTYEUAqZerlBLscI/H7tj4wT8OpgSainOLiqRaKVB3fzl+K86IJvzvB9yzm
 +wSpBE29FKUYABrP8qFKuorrIoBJt5PHD7uK1KbXEAfWnM6PY9c7uRp7Bl7ByepGQZyFaHmR6
 4UwULPJbYJJ2zK8PPTGdJe0cm/qYgijqCW1q8cWhKqvJ/KLgelp37oW9eEuM+5fUMo6d9Hx6n
 kL+VaYbg0moJ60Gd0C6We9sbwnCytpq4Xd3xRS4FIy0w6grYEVOPspND1ehscl5Wkm4YTnNdG
 l/VWmRrU8rs8YnsUfaXh41m3HnTkeelNjl07r8zAxmiEhN0HX9OPX1dL6iKTPdouEHEXyNtU9
 Hz/4Xq26+D8OiurEOVvz7876TWvG6x6wipMfkQy85PpaaH3GdpW1jAvjSk/c4H4jISU542Xx1
 vWlPHYUip7HhlPH3l6coToojtCqXQOvx7ckOcllEFQQ8k1rgxLN97/AGDXZmsHTPvqtJE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document the fact that the function doesn't modify the two option arrays
passed to it by adding the keyword const to each parameter.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options-cb.c | 3 ++-
 parse-options.h    | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index db6f666ef7..7d56681130 100644
=2D-- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -181,7 +181,8 @@ struct option *parse_options_dup(const struct option *=
o)
 	return opts;
 }

-struct option *parse_options_concat(struct option *a, struct option *b)
+struct option *parse_options_concat(const struct option *a,
+				    const struct option *b)
 {
 	struct option *ret;
 	size_t a_len =3D parse_options_count(a);
diff --git a/parse-options.h b/parse-options.h
index fdc0c1cb97..1d60205881 100644
=2D-- a/parse-options.h
+++ b/parse-options.h
@@ -281,7 +281,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 int parse_options_end(struct parse_opt_ctx_t *ctx);

 struct option *parse_options_dup(const struct option *a);
-struct option *parse_options_concat(struct option *a, struct option *b);
+struct option *parse_options_concat(const struct option *a, const struct =
option *b);

 /*----- some often used options -----*/
 int parse_opt_abbrev_cb(const struct option *, const char *, int);
=2D-
2.25.0
