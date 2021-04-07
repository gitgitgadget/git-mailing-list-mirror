Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2009AC433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 12:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2F861153
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 12:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352013AbhDGMK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 08:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbhDGMK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 08:10:57 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59134C061756
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 05:10:47 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t140so12877338pgb.13
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 05:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=3puQgPLbNsDSLqyTY2Zr6IJA+Dm2rl2fbMCUvljUnaY=;
        b=swT1N9YpG6sE0a963pzgy5JQQykVxTi9MQ7eTp7tan1y/Ofs/lmE3UF/GMsVUzX9Pp
         omRjRam63nKbD6/K203FmwGCb8JF29RrPu/eoplK0UZAYhpBaeCxUM5VVuItESxq/Wbx
         YYHIQSTx+DwqEFCsLUsoznXvi8Pzx6tr7A/QqiKV618T7EYw0KXFQOHZcXnFdY68Ui5c
         l93dL3E+k1NYqvVhoMlCs9jsB6PCKCaZeB8k3ccMwb0+5NyWYA81slOHkXPPfTiQ55VO
         cyoTf5JHMuy7Gae2pv5JERgJOA55xaOiCFpLLPm2hn0fQO4fQUu2ZqxuyAkDao5CdLe+
         IU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=3puQgPLbNsDSLqyTY2Zr6IJA+Dm2rl2fbMCUvljUnaY=;
        b=O+twZMLf6fxtRPClJpJeK3uMZ82kPzOeKgQKEd/57kL6Zgu3L/NQKTsl5J94h+gWf/
         jHImdUznYUWWl5S257uPqwnGpo0rxGvo4O7MVhAEZrpLEym8YHl4FNbc4C68XJ/rj9kj
         g/5+irhWIdrIhC00IaUr/MU6AqAgmn4Y3ro6GMEc+BRqX43G5JG+iuyhGdHq90jaEvjx
         Qg5c/rKdyxkawL37ANzP2QgEG3Z9RGsxjcVms28umCYvqjMkrytL3AUuG4C6DjR8i4/I
         AdaRy+4vqKLYRrApqcfrcJwGii2YNfhGUpvDhMprKYBk21xTsQPFv4pfk9oe78F96w+M
         SqyA==
X-Gm-Message-State: AOAM530YZKbV7tvWvq76ZD58AL/+3QPFxFL86mhTw98WFjHaEfJwZYvw
        ghqvn9qdSKRiW9diBVmMzW27bdMRa/p/Gw==
X-Google-Smtp-Source: ABdhPJwf2v4aBP6NxD8U+EN34MGRwYEQ1dYws8+W53NvANwYTgTJhWEZZUZ6VLX4L20KLy7FKnbTFg==
X-Received: by 2002:a63:b59:: with SMTP id a25mr2972660pgl.235.1617797446675;
        Wed, 07 Apr 2021 05:10:46 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-31.three.co.id. [116.206.28.31])
        by smtp.gmail.com with ESMTPSA id q5sm4790186pfj.131.2021.04.07.05.10.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 05:10:46 -0700 (PDT)
To:     git@vger.kernel.org
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: There should have be git gc --repack-arguments
Message-ID: <b35a68a1-e693-5502-7a28-a1dd8222d3a0@gmail.com>
Date:   Wed, 7 Apr 2021 19:10:43 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I request that git gc should have --repack-arguments option. The value
of this option should be passed to git repack.

The use case is when I have very large repos (such as GCC and Linux kernel)
on a server with small RAM (1-2 GB). When doing gc on such repo, the repack
step may hang because git-repack have to create single large packfile which
can be larger than available memory (RAM+swap), so it must be necessary to
do git repack --window-memory=<desired memory usage> --max-pack-size=<desired
pack size> to create split and smaller packs instead.

There should also git config item gc.repackArguments, which have the same
effect as git gc --repack-arguments, with the option takes precedence over
the config.

-- 
An old man doll... just what I always wanted! - Clara
