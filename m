Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C782DC433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiI3SId (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiI3SIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:08:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F6C1E3F40
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h7so7977538wru.10
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TgT2iuxAv+3m0iS4FOz21fuf57LYQ3dj/jiFS/+Df18=;
        b=O8zR3NUfJ/cExANvw8tIdSMp1CzRp0T9A+53CeOIRgTfpsKXmSKE0iSzlkz2xIIgQf
         1qjtWvJMkQgekvdrn9WzJCFQ84Wdk7EOkwk2rPRgBZXTd7cj17cBpeBodYXvsTY7wk8g
         1mlZALTZI9XQ+wiibDSp2Ej5wpUaAtzyxUL+kf8jl9RlDx6NfYhXHcDmc4Vf3fv2FUt2
         xILgYWtXTihpeG2K68+QS3nckgChILxBxWebZCoJPnqzgfLFhRJ4MT5ov0UwGNFmQpm0
         +MlKlcmHYmnBdVf6Zv353O0fN/5xTmqWNNkTVhR+MolG8AatnPI3XNZW1ki8gB/vYz/4
         zPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TgT2iuxAv+3m0iS4FOz21fuf57LYQ3dj/jiFS/+Df18=;
        b=ZzZ4FYbzm1PtXAuqcH9Fq57WKPzOdJ9qyKmUJL5k7l6yF/j+HzfBohEpS4lwK+4D90
         M7gA0i55zAmRv/H3mR9UNQms/4FVZa2e4BYiE4vNqyDngs/rZVNyW62qOVZ0rjYBnWY9
         7dvEikyPQeyOTGsaSUVL23IlfS8gY2dmrEgEzLiQqfCqsV1zldMeHDrz9E1VjOOCnw4l
         yBwhibXx8cyUMKyUzR4lzyL0Z0LMlvSDaRdDczQhgVVl4+flkKFlPSlYXUl7teFc0MgL
         RY/l+p4UHtiAmoAiO8J3GD1iEw1wkozVvaEIUYVj293V0v5ZXep5dluTUgvv22aR4QU/
         iUxA==
X-Gm-Message-State: ACrzQf37cpPheWJjGZhnAyxsUCddWzccyfoCysKCEPNx98P0XvC41zs8
        MDoizgYxp+30gMVadmNVBvsR91lsuEjd1g==
X-Google-Smtp-Source: AMsMyM7Td2mJPSV6WPVib38F1cayPJnaRwtr9Hn095cCmrAerUoe5skyB9XQIYLMQah2ZZQyBoB3zg==
X-Received: by 2002:a05:6000:904:b0:21a:3dca:4297 with SMTP id bz4-20020a056000090400b0021a3dca4297mr6556695wrb.487.1664561300860;
        Fri, 30 Sep 2022 11:08:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:08:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/36] blame: use a more detailed usage_msg_optf() error on bad -L
Date:   Fri, 30 Sep 2022 20:07:27 +0200
Message-Id: <patch-v3-04.36-a8312c50f01-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the error message emitted when there's a bad -L argument, and
do so using the parse-options.c flavor of "usage()", instead of using
the non-parse-options.c usage() function. This was the last user of
usage() in this file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/blame.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index a9fe8cf7a68..8ec59fa2096 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1108,12 +1108,13 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	anchor = 1;
 	range_set_init(&ranges, range_list.nr);
 	for (range_i = 0; range_i < range_list.nr; ++range_i) {
+		const char *arg = range_list.items[range_i].string;
 		long bottom, top;
-		if (parse_range_arg(range_list.items[range_i].string,
-				    nth_line_cb, &sb, lno, anchor,
+		if (parse_range_arg(arg, nth_line_cb, &sb, lno, anchor,
 				    &bottom, &top, sb.path,
 				    the_repository->index))
-			usage(blame_usage);
+			usage_msg_optf(_("failed to parse -L argument '%s'"),
+				       blame_opt_usage, options, arg);
 		if ((!lno && (top || bottom)) || lno < bottom)
 			die(Q_("file %s has only %lu line",
 			       "file %s has only %lu lines",
-- 
2.38.0.rc2.935.g6b421ae1592

