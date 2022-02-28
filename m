Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD19C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 07:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbiB1HkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 02:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiB1HkK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 02:40:10 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4C660AA1
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 23:39:32 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v4so10370151pjh.2
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 23:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HyL7F8+ys4ftvJENfXbN0Anz5s5JB7tVQddph3tRRUw=;
        b=qnKG0LwWTedpWhep2+qJJSPsGKyXjtnVExE1nV5qouoQI7xh43ILiemr95Zri21+q1
         J6hp8op9GAGcbiav6owQ6x57XnW5tGpAKrevnieMGBNinmEeTdbrMk9cxMKLFzIBwyH5
         k0Hzp4cQt7cfhC3xAaIFLMl7EqUhjCXFZUZVQsVKdKbNsoKc3/JMZldeFrmOmM6GL2rH
         tQTCoKEp889zYVg7alMczs9XqL2zMmrGxR+yNK7y9q3b2i4vEbo/XHa58By7Km6soewD
         3IRpVE6jAJxc2rCl5a+M5XW1hw9L+xLY53D6uafsg4wsNKUZArnvJxHfxKZMm+y6RVe7
         BLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HyL7F8+ys4ftvJENfXbN0Anz5s5JB7tVQddph3tRRUw=;
        b=SPcKY29RA41qYQXbA+Gbu27JeeGC10ly14OR+HfLYkAHoHZyw6Wf2fc7GwdTzBlZuU
         2mkp4cAIEcfl35TSE2OgUfBFmGdp+x8ja2i+Rkmq+WJbSLLVwt/RjvDpo+UrdBhEsTBH
         VBGaGB2s1ZM+QBcWJTUCmgI6UxGcxoUL4KtrZKLLTwfYmggcm47ece4TBu8noMj2ZA80
         nh31uy7C+JemsvpngMumxnPmOFpC0LM6lQI988eBT6qvIqieDwfoRjNTqrqbwg2IfRAI
         CJy/LQa30LQwJ2Oe6ArqBmaGl/TXKL8T60E0vkrmZi5h5gd6nRKmCR4xxsbMssJ/mIRW
         5oTQ==
X-Gm-Message-State: AOAM53243kQENC8gbjIh9mW2K8HeU0AHNj1YCBnA/A+kiM3nUOBBQh78
        ZnBOcArrbcgjcwpejh5kuQI=
X-Google-Smtp-Source: ABdhPJwvU/Zh4jaka2h769u05qsYIqaIEP+UFhswmX5BblAnAWVMElf9AZNX52PTAroOsOyaZRpLlQ==
X-Received: by 2002:a17:90a:160f:b0:1b8:ab45:d287 with SMTP id n15-20020a17090a160f00b001b8ab45d287mr15203672pja.91.1646033971823;
        Sun, 27 Feb 2022 23:39:31 -0800 (PST)
Received: from localhost.localdomain ([202.142.80.243])
        by smtp.gmail.com with ESMTPSA id l7-20020a056a00140700b004e1c206b99bsm11951628pfu.48.2022.02.27.23.39.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Feb 2022 23:39:31 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] parse-options.c: add style checks for usage-strings
Date:   Mon, 28 Feb 2022 13:09:08 +0530
Message-Id: <20220228073908.20553-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqqtuck3yv2.fsf@gitster.g>
References: <xmqqtuck3yv2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> wrote:

> Nah, I can just discard the second commit and keep the first one.

Okay, that's great. But one thing I want to ask - How the discussion
for `adding check for usage strings` will be held i.e. Whether the
idea is discarded for now.

If it is not discarded, then how to proceed? Johannes prefers the first
version and Ævar prefers the `add check to parse-options.c` version.

Thanks :)
