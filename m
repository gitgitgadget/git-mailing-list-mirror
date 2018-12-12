Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0253120A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 07:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeLLHky (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 02:40:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51990 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeLLHky (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 02:40:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id s14so4699964wmh.1
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 23:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ld0dpkl+rKXlDIx8cc6wGJHFoKt5NhsJXuGjy0q6l84=;
        b=qA+bi9iyWJxP6kC+YKm2mP002W68jifC+6T6uS5cbs4s2Eq4kg9H+DTPlxAKokpFKd
         EQTyPnTQ8PYDVXdjxBt54/+FOwHjnkMFMUpGFq1wZ9Bg+OSdnZRFrV50hXfyHRuJNMXU
         tpW1whajfeTjdBRYdRevIUJtB3IP//lB9eiqFfWE22p5Pv14h45spF9fgq3CI+nEGQe6
         qi47vMm9fyXIYABmITBWwsfQeWFqUplam5xAuZ2wbmVvgydB6suHkMu1ZyZdFEoF4ZRS
         RyEJky2s4T64o5bsm15bBIQoyRKheU2VpWgYWPvGimLJTwsAMV3WlcBw4R4QYwf8Clae
         Aabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ld0dpkl+rKXlDIx8cc6wGJHFoKt5NhsJXuGjy0q6l84=;
        b=qqot5x/GxhYAHNskkH0eRbQGfafL0NA1hQkkvXMfwbvqDPY7rLfcc7HAVMFqjY1Ljz
         afq3LcgUwv5tRSqM8wrO9oYPOUI0/fCgC9/xn4/3bLUtROEAFPc50U5YagffxwC7Tk6i
         D4HfeNugS5YX26Os8Pimdnr0sO6bel6U121iXKbHeNeG0/b1sLymsSI5QxGMlbFw4s4I
         1aG5XYnfdLVVi4REhv91uAwvESmj0+x0yjuvuu/IGF/HesPDu3qr8rZp2XLdwYxC+Spl
         GGTZ8JRszuPU73+q9Q5wNle3sH+6aPhIqE4I0OsajQS4UpDLcPM/uf54HGeFyRw2XJ3f
         DpLA==
X-Gm-Message-State: AA+aEWZdAK9UXD4/8FkioOHiSYiDgv1cAzxRnK3hZA128WtVdIj2tXe4
        FznUy8v9ZbYbdJlXuSchWq0=
X-Google-Smtp-Source: AFSGD/UozUnmILDTVfStei5Fzw5qVLnaYdS1KvePOfkLc73DcvwmIJ90+yCBjXms8T9FMV2w8+avkg==
X-Received: by 2002:a7b:c315:: with SMTP id k21mr5094468wmj.145.1544600452513;
        Tue, 11 Dec 2018 23:40:52 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 202sm4026390wmt.8.2018.12.11.23.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 23:40:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 5/5] midx: implement midx_repack()
References: <pull.92.git.gitgitgadget@gmail.com>
        <41ef671ec8361a9635dc78c078d2d84e9d985236.1544465177.git.gitgitgadget@gmail.com>
Date:   Wed, 12 Dec 2018 16:40:51 +0900
In-Reply-To: <41ef671ec8361a9635dc78c078d2d84e9d985236.1544465177.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 10 Dec 2018
        10:06:25 -0800 (PST)")
Message-ID: <xmqqbm5rjipo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +		SECOND_SMALLEST_SIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 2 | tail -n 1) &&

awk is capable of remembering $5 from each line of input, sorting
them and picking the second smallest element from it, isn't it?

> +		BATCH_SIZE=$(($SECOND_SMALLEST_SIZE + 1)) &&

... or incrementing the number by one, before reporting, for that
matter.

