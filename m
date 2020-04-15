Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D23C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 14:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7654B2078A
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 14:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCfIRwf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394005AbgDOO25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394000AbgDOO2r (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 10:28:47 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D64C061A0F
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 07:28:47 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c7so5120864edl.2
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 07:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+Kc98uF130oKq2yiQtCOSYib7t9FxhgRY+ruPo5hUgI=;
        b=VCfIRwf7OCP0OZ3dx+DFmAd3Je0pOsVDobcSrbwE5B8ZvCQMAWirMEZ1Ub3Vy0BmkT
         S6FNJM9/ZUwZSiPsKvnGZE9pfyi4q/M7ke5R6GZKIIys6h1vpofI3bgqGuQgb8Ulgsh3
         245d3Jndm5nNdJJrKKbgm51o01D5OnlSlEHctHu4LMruzijIPu7ESPyUnl/RkLqNYu4x
         O61voiRFO1di+fviN4ir2fcA7MB7hBAfiPzbYdZL49mco0/+mNlsp7zTQTqAT1IpWbGJ
         eYD2vN6ON/uZMBUqvuw64duIQFvh5eB7VZcZCZoirUrMuRfHanSODhhp2vauIar6dG3K
         nNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+Kc98uF130oKq2yiQtCOSYib7t9FxhgRY+ruPo5hUgI=;
        b=l5IKaB5b6v2/8HAA7J1dVambhte1zlAfThLcafSk8OP9gOortUxyhTYXSD63sVTJXy
         v6gbmvNKjKeDiBJZDRovbLf5vONJ7qGQP2hBxybuYJJkHEPRanTWoGXHQcikCXb0Tsv4
         noALVRrdbnoMNgmD88MAre6l20znu8F6j0wYfHQRyL8uXkxu2jQq9Yc6ZtXYZlPYhOZh
         YfSR7ccY4aEy/YAz/fMMaRZMPH2yQLepNuLh8GsRGvvFhxSr6vSl4L06vHjdM1i7h47y
         OO+rl/FuFoEkEaMbA3IH4ZIXPjys5zj7qhOwWf1EoLCLbHwjKSZS69px6i4/IkilkhZO
         sLww==
X-Gm-Message-State: AGi0PubjvAHEpoe+pBXBAyZ7wGZDeA5tA6gk+Y9/1/CZyN0GGM5JQxNv
        aNWHLAkHBNPPEaa+lqlGrHlN7vU9
X-Google-Smtp-Source: APiQypJVxJsWoND8DPBgrCzT/qeAyiytWhIKs3YChS/dJ63x1ECbXpMvmxpeQO4ueAMOgRKcaHqONg==
X-Received: by 2002:a05:6402:28b:: with SMTP id l11mr19287944edv.156.1586960925613;
        Wed, 15 Apr 2020 07:28:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16sm2152192edv.71.2020.04.15.07.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 07:28:44 -0700 (PDT)
Message-Id: <b3384880c7201d65adb7341ce23386d578e69193.1586960921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.760.git.git.1586960921.gitgitgadget@gmail.com>
References: <pull.760.git.git.1586960921.gitgitgadget@gmail.com>
From:   "Vasil Dimov via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Apr 2020 14:28:41 +0000
Subject: [PATCH 2/2] range-diff: avoid negative string precision
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Vasil Dimov <vd@freebsd.org>, Vasil Dimov <vd@FreeBSD.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Vasil Dimov <vd@FreeBSD.org>

If the supplied integer for "precisoin" is negative in
`"%.*s", len, line` then it is ignored. So the current code is
equivalent to just `"%s", line` because it is executed only if
`len` is negative.

Fix this by saving the value of `len` before overwriting it with the
return value of `parse_git_diff_header()`.

Signed-off-by: Vasil Dimov <vd@FreeBSD.org>
---
 range-diff.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/range-diff.c b/range-diff.c
index 5cc920be391..40af0862818 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -123,16 +123,19 @@ static int read_patches(const char *range, struct string_list *list,
 			struct patch patch = { 0 };
 			struct strbuf root = STRBUF_INIT;
 			int linenr = 0;
+			int orig_len;
 
 			in_header = 0;
 			strbuf_addch(&buf, '\n');
 			if (!util->diff_offset)
 				util->diff_offset = buf.len;
 			line[len - 1] = '\n';
+			orig_len = len;
 			len = parse_git_diff_header(&root, &linenr, 0, line,
 						    len, size, &patch);
 			if (len < 0)
-				die(_("could not parse git header '%.*s'"), (int)len, line);
+				die(_("could not parse git header '%.*s'"),
+				    orig_len, line);
 			strbuf_addstr(&buf, " ## ");
 			if (patch.is_new > 0)
 				strbuf_addf(&buf, "%s (new)", patch.new_name);
-- 
gitgitgadget
