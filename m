Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603C5C4332B
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B8EB64E31
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhCONH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 09:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhCONHm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 09:07:42 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA0FC06175F
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 06:07:41 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso20213120wmi.3
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 06:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cNdErgbTIi22zeV1bjROMXkc7EFOZR6J2VD/EkVEmkM=;
        b=ULtLdMyWUDktJP5wWa68t7GjJlz/UQzpS9xJjjSm7412o/TqwZdIialbSGVufTqqJ+
         oADEr2Yzf3yJo3AAFC2Y56FpX9XPI//81spG+YVa6tYC4CR5n/8bwUpVje8QI16fPQCg
         y7ZdwgXhAJbVeNqwVik45zYahvYw4vRrQc+JQunc9NUmzaBlVWtrzaxHQLtn5+Scl4bE
         9W8mAf8Rt1eoQTC555WyaZSkmrxbf0eJ52ZM251EirL9KS92sUbvkwRot23Kb6LmFY/1
         8PN2IsvFVAUT19kaoNFt87VXSP1n85tlprdQSmJNhU0RDGOchoFrwU2/rltZW+CUw8PY
         CN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cNdErgbTIi22zeV1bjROMXkc7EFOZR6J2VD/EkVEmkM=;
        b=VQU4/ncevCdzaKhGiGokBaJdC7zKxjE7YRLMyYUvmrajozVErjK98rPXIKDoLAtY29
         gEib/ZqvvH+8bHpiMb1LoPu/B71pM6qgXy640SEkZn8zjYV6T9BwO+QVkd8MKM1wdL5Z
         lXXdTWZO8uCwtbYuHjGBi1TeMQ8APDMMTnPWK7GqGbWYn35eDDyqmQ2tAdvSgx/q1dis
         vwfxQZZzA8ilbi0H6AZP1FeMl1kBwZeeyZodv1pPtnU7q3jFdAncgzX+e6W0ksllsj8t
         NYxL2BulYezgR3a4ZCv/sHBoTFGMBFxlLj+6U7kgc748N6/lxaXsWZTgKhUsQnnDSy32
         IC7Q==
X-Gm-Message-State: AOAM5329QRT1yU/BRG8OM5BcGWWPj5/CUtGs19tnJidumeLN3W2Jyg2t
        oR5P5QL+oToLX1zZhgfmQ66Ptda6IFI=
X-Google-Smtp-Source: ABdhPJwv31T8s0/Ro7PNfAbL4No5AjRPvBUqtHdP08WgVC7ycSb1UunZNZw4cTZvxK5iAiOqZ+O5HA==
X-Received: by 2002:a05:600c:2106:: with SMTP id u6mr26215210wml.55.1615813660484;
        Mon, 15 Mar 2021 06:07:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c128sm35322375wme.3.2021.03.15.06.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 06:07:40 -0700 (PDT)
Message-Id: <68e0bd9e2d6f0a89d60db730eb77507d6a17a5ae.1615813658.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.v8.git.1615813658.gitgitgadget@gmail.com>
References: <pull.901.v7.git.1615799304883.gitgitgadget@gmail.com>
        <pull.901.v8.git.1615813658.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Mar 2021 13:07:37 +0000
Subject: [PATCH v8 2/2] interpret_trailers: for three options parse add
 warning
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

When using `interpret-trailers`, if user accidentally fill in the
wrong option values (e.g. `--if-exists=addd` or `--where=begin` or
`--if-missing=do-nothing`), git will exit quietly, and the user may
not even know what happened.

So lets provides warnings when git parsing this three options:
"unknown value '%s' for key ('where'|'--if-exist'|'--if-missing')".
This will remind the user :"Oh, it was because of my spelling error."
(or using a synonym for error).

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/interpret-trailers.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 84748eafc01b..6d8e86a44d43 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -24,19 +24,38 @@ static enum trailer_if_missing if_missing;
 static int option_parse_where(const struct option *opt,
 			      const char *arg, int unset)
 {
-	return trailer_set_where(&where, arg);
+	int ret;
+
+	ret = trailer_set_where(&where, arg);
+	if (ret)
+		warning(_("unknown value '%s' for key 'where'"),
+			arg);
+	return ret;
+
 }
 
 static int option_parse_if_exists(const struct option *opt,
 				  const char *arg, int unset)
 {
-	return trailer_set_if_exists(&if_exists, arg);
+	int ret;
+
+	ret = trailer_set_if_exists(&if_exists, arg);
+	if (ret)
+		warning(_("unknown value '%s' for key 'if_exists'"),
+			arg);
+	return ret;
 }
 
 static int option_parse_if_missing(const struct option *opt,
 				   const char *arg, int unset)
 {
-	return trailer_set_if_missing(&if_missing, arg);
+	int ret;
+
+	ret = trailer_set_if_missing(&if_missing, arg);
+	if (ret)
+		warning(_("unknown value '%s' for key 'if_missing'"),
+			arg);
+	return ret;
 }
 
 static void new_trailers_clear(struct list_head *trailers)
-- 
gitgitgadget
