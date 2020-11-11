Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16981C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0CBA206FB
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBeX4WOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgKKM2k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 07:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgKKM2d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 07:28:33 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D516C0617A6
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:28:33 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id d12so2306233wrr.13
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9tX+jisZnF8QKIRir0GzdfsvhwQEBVAh2/i2Bt96TTA=;
        b=UBeX4WOdEt8+UG7iY33GzAK6JEwdBaMZl/1jCJeof2K2NtJj94JP4uEzJrFFK9ERQv
         dJ8Tsz4CsezE9ssOb3goaKxRiClqPqzZtycBUz7wRwrp+rfPxmJZhKP+4uuAVZeRX/MN
         djZKDqrzz4Pa44tHqcSu2PIAruvX5hRfhJHehzUzKwokmEg+9WxUFijRtmNJgwPb5n5g
         UtFeYSlMsbGjMP1QfeMk3qEf+EW9iPN9gm+MEMEcVn1vXbdzIvVMafsHl7qP1BvQwpR3
         etMqkq7iwUUOq+vVcxn9IQOX0NCyYb0w/1TzbjsAQh1WM6Oabrol7amMqUoxFfh6aMe2
         KoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9tX+jisZnF8QKIRir0GzdfsvhwQEBVAh2/i2Bt96TTA=;
        b=WiNm4HAZW0Ld2S8f/NXdOW238iEmVlJBSnmabObXP4fws3fqs/JVPddtltjW255tEZ
         SJ6IQy9WXmADcJ4g+HDmkMLMlkwkl1HKEuOWrIZHC08Rr5+QSTOP9FXXWjgcIQW3TDSM
         s34E1qGcDVXC1Rc8KJWRW0FSDmG12XKXFGuvS0hBxtoIV9CYBZ83r18TCLPyigOX/QVp
         uUr11h9ORg+33QAmhHl/+Y6PAu6El5ccGGth0+77rOt0tdWJ8fs9GKHbtggcESAK9wcP
         1+hs05uBrSCMUg/uFQTlkbZ1eC6iG0esbAQWr1YG2SzFSti4H5p2PZvdZUUY+sl2luIN
         nVRw==
X-Gm-Message-State: AOAM531xAwhq5eCKMQ7EKG8qxaLGM6Gr6oeWGUAdP9yUyZw05Pzb3xTO
        VvLb7OHKMrSRdksrWIjwRIGP6VX7asc=
X-Google-Smtp-Source: ABdhPJzx8OmL2M2QdWlirlWub1VBjlICfC+9On3SLk7v8VM2N0/xhyiN45csKS+jGb52nPB/30L8zQ==
X-Received: by 2002:adf:e789:: with SMTP id n9mr20176237wrm.211.1605097711923;
        Wed, 11 Nov 2020 04:28:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8sm2214470wmc.11.2020.11.11.04.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 04:28:31 -0800 (PST)
Message-Id: <91ded2fbbe7197d8ad46005ff3eadeb2a5a69e18.1605097704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
        <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 12:28:21 +0000
Subject: [PATCH v2 08/11] add -i (built-in): use the same indentation as the
 Perl version
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When copying the spaces used to indent non-flat lists in `git add -i`,
one space was appended by mistake. This makes the output of the built-in
version of `git add -i` inconsistent with the Perl version. Let's adjust
the built-in version to produce the same output as the Perl version.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 9126684348..c298a8b80f 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -1137,7 +1137,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	print_file_item_data.color = data.color;
 	print_file_item_data.reset = data.reset;
 
-	strbuf_addstr(&header, "      ");
+	strbuf_addstr(&header, "     ");
 	strbuf_addf(&header, print_file_item_data.modified_fmt,
 		    _("staged"), _("unstaged"), _("path"));
 	opts.list_opts.header = header.buf;
-- 
gitgitgadget

