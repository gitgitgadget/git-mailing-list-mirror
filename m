Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A490C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 20:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0643E20774
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 20:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJpmunkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438404AbgDOUcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2636968AbgDOUca (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 16:32:30 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099C2C061A41
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 13:32:30 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id r7so104874edo.11
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 13:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GzmpfVcWwFgm71xNfp3t2ZsVFTZARKOsv58I8Lux5JQ=;
        b=GJpmunkd61SZU0hn8mQJuVLY6HnQUoRoNqVQRh6X1Js/fiiMYjpGmKg4bx+E7wSjl7
         nPC9S3s3bwvFHuC4xNIIb84CdnXzh1dYftQRIuYl8/27VSEse6DSImeM5anXx3cpAYNF
         n/6GVRhTTWkgyqGTnML1meMTKTOA/pAAjg4LpIR5iXonuJU8YLo4zdVw0U0RwVDlUE0V
         IMCyymxAiI6nOJUsAWzNoH+dJo8uYMZvmJGpUlAoeR98cX8mWKwfED0iEb3w/8ENRFvW
         A3oiitXGA1PtcLdf0FR5tIV9iA2bVC2W+tC/e0QrzxtOaS+5GLNZGuk0LzqmKgFEeGcC
         eVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GzmpfVcWwFgm71xNfp3t2ZsVFTZARKOsv58I8Lux5JQ=;
        b=DLpr9P2DKsq8B0Uxk7JlMvF0D+c/wM2VKk2ubwBlbElDgkxt7UpqoHwyHwNTpxxLoT
         qCrkciPv+USg1VhdrZkJwD+O/VyDawt9POGegsEXJxGqW+cE61+Yz3FVg5HTU9BASn36
         eXW654CdhgJJ3LbwF0yCrmX17leKU1hHP35JrsqDqlrhGIXO1x4clJ8w8JqkO5FjF7yh
         LR4/BMdtSVhjzs+X3Ovg0mIeEUWQ+rXHzGpplzY5n/+eqX3FJzWUYNEIIjuf3/Up0TgW
         ztTbukSmXqs4woMfc1HpalAjbI/IWoQ+JjjhSfRv3PJgLH1LtFjMoK/ioOLrj/cTPdzk
         WnQw==
X-Gm-Message-State: AGi0PubYHpqXeyhUc+0cgnikQ0IlpFYoUXTBDKrL7IxdjkbmGiinBNPu
        hyS5zGxwa3T/jQGhzqpHn1s/+DJl
X-Google-Smtp-Source: APiQypLDDFMVvacuKoPrJejSV5f/0jz1cK1Hh121QcxJIh0IIsyX/DyFDQN8Nq1Qa+lC6PKgXhsFpQ==
X-Received: by 2002:a50:e809:: with SMTP id e9mr19430078edn.182.1586982748331;
        Wed, 15 Apr 2020 13:32:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16sm2233946edv.71.2020.04.15.13.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 13:32:27 -0700 (PDT)
Message-Id: <72fddcff55425cffb598790fce3d5e7c47325234.1586982745.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.760.v2.git.git.1586982745.gitgitgadget@gmail.com>
References: <pull.760.git.git.1586960921.gitgitgadget@gmail.com>
        <pull.760.v2.git.git.1586982745.gitgitgadget@gmail.com>
From:   "Vasil Dimov via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Apr 2020 20:32:25 +0000
Subject: [PATCH v2 2/2] range-diff: avoid negative string precision
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

If the supplied integer for "precision" is negative in
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
