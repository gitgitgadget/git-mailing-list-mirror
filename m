Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2E7C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 12:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D1B613D3
	for <git@archiver.kernel.org>; Wed, 12 May 2021 12:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhELMVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 08:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhELMVK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 08:21:10 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68696C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 05:20:02 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id h7so12437339plt.1
        for <git@vger.kernel.org>; Wed, 12 May 2021 05:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jCMkA+LtQQ/DDLwRyiiYjBP2m9wBFxS0BKU++u2OWwc=;
        b=SrxXL5vC597a2JIj5SzglwAbpQGt2QhWVHFLcOFZmNDC+LGoBOiaYhQOQzVasAlPs2
         WVtteZsaQJfceeVUuCERskYeonrxLMab59rKYbrdE9YKR9OwLgJB3NPHk/dd3W5yoot1
         I1H5/ASRuOnAdPety5g22yYiryIo3jmLUy2Aole+xtHEFm3rV2VpYVF4Uu6K48hHK0iP
         iVx0Ei1TGQW9WDppBpQ/UIlAVOqouay19XjIAZlp5nj6BEsT7Akc2+BWFa1jTLfIi0D0
         Wv68BVJrWEBEZ4ioYhFuThGC1aDz8GFn70sJlk/DwHsuHZ6vrd/aFjSkDmNYPPxqXKds
         w39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jCMkA+LtQQ/DDLwRyiiYjBP2m9wBFxS0BKU++u2OWwc=;
        b=Fi5hQbQPNwykZGLLaJishBGSH6hB2zLRI1TTb37ORefzS791kzNwYIj2NeK75alPLF
         IONWXYhN4QU/TQQAsBRx24xykIMjS/9IbYCSquNS2jGH3ukBDJeFQ9H0q9WW0j/H80QN
         Qq1PwGxIjqTY2a57Cr7MJlgwZVhPFh3M09JqA6PnTi2/9NUTzp0AU+EvAHEN9dECbdXq
         w+xfzSsvdDzu2f3HZ/vFhKvMd2UkSddH+nqZo6YADXXT9YBUtojS7DpIDnejruFLqnRQ
         Le81M/v5+MoGMW5addID9qJMZk6+HdTUxw6QrWhJrMlAOlFrWCdDSzTR17QVkqHJOcj7
         OLwA==
X-Gm-Message-State: AOAM532yLnhW8l7co0OFriGZuueVHM+HkpDwpG0g8PFHVCX8e/e7SU0X
        v4FMNAZRg+CcRBrwCNlQXoY=
X-Google-Smtp-Source: ABdhPJzMy4aWuBwY1ZvgPOmeHT52QhHNERnxcz6BzR86Untviw3aYuukeVUO0xsjFfBAGfHzbuZ/Bg==
X-Received: by 2002:a17:902:4:b029:ee:8f40:ecbf with SMTP id 4-20020a1709020004b02900ee8f40ecbfmr34256969pla.28.1620822001911;
        Wed, 12 May 2021 05:20:01 -0700 (PDT)
Received: from localhost ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id s30sm15452933pfw.77.2021.05.12.05.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 05:20:01 -0700 (PDT)
Date:   Wed, 12 May 2021 19:19:59 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v6 00/11] test-lib.sh: new test_commit args,
 simplification & fixes
Message-ID: <YJvH78MxAWy+Xg6e@danh.dev>
References: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-10 16:18:59+0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Changes since v5 only trivial commit message / comment fixes suggested
> by Đoàn Trần Công Danh. Thanks! Link to v5:
> http://lore.kernel.org/git/cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com

I skimmed over this series and I think it's in a good shape now.
So, FWIW.

Acked-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>

-- 
Danh
