Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9154BC07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 17:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7757961CC8
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 17:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhGGRpn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 13:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhGGRpl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 13:45:41 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6964FC061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 10:43:01 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id r29so4246314oiw.13
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 10:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=RNplSe3nCbqFC5L2M2cOO4E5xAsrG6zBKqZpqoI+7b4=;
        b=u++e/6iGQ5N6hMcKbXAGiIHL4mQRG6iap1yS/yZvA8waCjUEQEDnLsOapLfLYURBlX
         92oqNVnBEv8YLGoN2aYmiVY5w8wnhrb1CVfxutyyJtFxmUTrDSFtoYXlAh3Ug8ZLqBMZ
         h8fl73IejIHB4iF6aEVToYIoyFIEFQDxlq4phu/tV1b2xabXt1Igb3Vfju2bD2tBpo+A
         7G/FpVEV2L+iyWUvIuF6zHv9R1DitkTk7A+/3Cmpu9xf5s8G3Ufs67uE/psQ8wPxctUU
         ca/aWEqAiTvyt3QjRlMCcTu3rI9YeASdiw7I3R2J13LDIvxNpRK0k2X9MPXTFEhNquGx
         XD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=RNplSe3nCbqFC5L2M2cOO4E5xAsrG6zBKqZpqoI+7b4=;
        b=qjscp6bFG1aXZzlLQJvjrWiSt4vOGlEqzS5FbopIYWy9K4eE3yhsvhdNGOx+MW77NS
         6F3e2//1Iolx6GzjG2X6mXNLsaQnla3+2dy9lN+Jvgf2H2ZTUqme8zPWO8HGd8KY5hoA
         9f0+xhbc/TYzaID5J5Fpq3NdYBCH5C6i8F9NFbCBhlF3UV0qJCxiv16S6OsJljjIt4G0
         ZI8/ljbzJnQNVbLiJ/MUvgsRWOJJiYFCIlA2RMO4lQXdRZmnjJ6VtF5XoAFAmT/i/cyH
         0n2XiBBo0ii6gVM7RKc3YXNI0zhDcnrbRaqFNpS9qwiXPGx15396fQWRUbgajJ7AbxDm
         sk+w==
X-Gm-Message-State: AOAM532DjKmqxS8Qnv90i00Fhrjhv9rWGEwlTgPsCjqjz+rREkjlC6xA
        KvBUi7JO6c9gT5N40BQyejo=
X-Google-Smtp-Source: ABdhPJx5NPrOghRqvF3AmQ/G3OPdSTzp+nuoI+8CJJXFAsCg9VkNgwtR2F59P99xI2k1g5t4qfRlwg==
X-Received: by 2002:aca:1b18:: with SMTP id b24mr153832oib.65.1625679780765;
        Wed, 07 Jul 2021 10:43:00 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id h96sm124708oth.25.2021.07.07.10.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 10:43:00 -0700 (PDT)
Date:   Wed, 07 Jul 2021 12:42:58 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Hu Jialun <hujialun@comp.nus.edu.sg>, git@vger.kernel.org
Cc:     gitster@pobox.com, Hu Jialun <hujialun@comp.nus.edu.sg>
Message-ID: <60e5e7a2d2ddf_30143720855@natae.notmuch>
In-Reply-To: <20210707162308.2438170-3-hujialun@comp.nus.edu.sg>
References: <20210706022438.580374-1-hujialun@comp.nus.edu.sg>
 <20210707162308.2438170-1-hujialun@comp.nus.edu.sg>
 <20210707162308.2438170-3-hujialun@comp.nus.edu.sg>
Subject: RE: [PATCH v2 2/2] commit: remove irrelavent prompt on
 `--allow-empty-message`
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hu Jialun wrote:

> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -918,7 +918,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		if (cleanup_mode == COMMIT_MSG_CLEANUP_ALL) {
>  			status_printf_ln(s, GIT_COLOR_NORMAL, msg_enter_prompt);
>  			status_printf_ln(s, GIT_COLOR_NORMAL, ignore_char_prompt, comment_line_char);
> -			status_printf_ln(s, GIT_COLOR_NORMAL, empty_msg_abort_prompt);
> +			if (!allow_empty_message) {
> +				status_printf_ln(s, GIT_COLOR_NORMAL, empty_msg_abort_prompt);
> +			}

In git the style is to avoid braces if the content of the condition is a
single line.

-- 
Felipe Contreras
