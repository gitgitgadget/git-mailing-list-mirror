Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0762C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 11:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF53764DDA
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 11:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhBPLfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 06:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhBPLeI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 06:34:08 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C514C061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:33:19 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id q186so6915708oig.12
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Th++PKlNW2TJ0pZZMhWWFRbP9+h4HtdRuZKLKpy7J9I=;
        b=Vdgy9Otd2IibjiTiVdiZbVBN6GCdVJ3mhlihzJ6PW+liKKNOj35SQjnlsa5X16M1Z7
         xiGEcsRVq7tdyA/r0IouEMK5MmgZ/hP1JAdPRDurO8anJWhvwL1+AB0pzvgOkcxJT4qI
         yPYVm0ppPOV94jjj/NyDuCGLCzESPPnApwWV+qp48ny8YcmFXJNiV8Il1szwrVJj8Lya
         ukKs9HBU34seXjcZHvLhvSCgqaJv3kFeiQNbb14Mn2UdAaD4bYSoLSjXdB04HZ1BUuyK
         xBU1Kdyh+1H4vO78+rZ34Y8gonHKtyiBSfYAxcrT8vBq3klzf9DTuyfOCx/4fSVbzQN1
         lL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Th++PKlNW2TJ0pZZMhWWFRbP9+h4HtdRuZKLKpy7J9I=;
        b=hHVRwB/CCzDG/8+Rx8ezLbOMaq4IFRzFjguQLNepNjpG43v76pgPR9r1z3hSFFnnKr
         IvmWG1btPStpeUfjhU9ow47mv5DiiHOq5SnSMOprCQ5hAAwAFa6fIDGVkxGu+lkPh3l3
         7z3MU/sLAstek498/MJbs7nJ5JFY1i1BOo179XU/6dH0mCyDA0j96vdJcZAjBTdjEq4S
         SKKlQC97ZzgIfbD/WTU14QKdS82mUX1LRoNYCd3BX80OwYkiw0SSscmAA6ALemMyBS1F
         tbynvMNV19lV3QTth19DfHlDFaKPns+QZPF+ySukBiVlqYxlYcGylZu1K5SriqFF+ghD
         QcdQ==
X-Gm-Message-State: AOAM532wb2bBYLSlvsoEifGIMwt9ZOEP5pE6PnLN5+jhhcjVxWVDX4M2
        aLD5o9yygp/12Lrh0DOiV/I=
X-Google-Smtp-Source: ABdhPJzrpKq+IUMsuqM/bCl1pyFyHCpMDC72qmKXs3bFnZqCHQdgTZWl6lcQnQ9K/RhSss9RCmNbIw==
X-Received: by 2002:aca:c786:: with SMTP id x128mr2248575oif.120.1613475198509;
        Tue, 16 Feb 2021 03:33:18 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:bccc:aed3:3481:8d68? ([2600:1700:e72:80a0:bccc:aed3:3481:8d68])
        by smtp.gmail.com with UTF8SMTPSA id y13sm1273345oih.31.2021.02.16.03.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 03:33:17 -0800 (PST)
Message-ID: <8ac1dcc5-c21c-4c93-b762-1cc0a27bbeae@gmail.com>
Date:   Tue, 16 Feb 2021 06:33:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 1/5] commit-graph: define common usage with a macro
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        dstolee@microsoft.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        peff@peff.net
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <20210215184118.11306-2-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20210215184118.11306-2-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2021 1:41 PM, Ævar Arnfjörð Bjarmason wrote:
> +static const char * builtin_commit_graph_verify_usage[] = {
> +#define BUILTIN_COMMIT_GRAPH_VERIFY_USAGE \
> +	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]")
> +	BUILTIN_COMMIT_GRAPH_VERIFY_USAGE,
>  	NULL
>  };
>  
> +static const char * builtin_commit_graph_write_usage[] = {
> +#define BUILTIN_COMMIT_GRAPH_WRITE_USAGE \
> +	N_("git commit-graph write [--object-dir <objdir>] [--append] " \
> +	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] " \
> +	   "[--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress] " \
> +	   "<split options>")
> +	BUILTIN_COMMIT_GRAPH_WRITE_USAGE,
>  	NULL
>  };

This seemed very unnatural to me, but it all makes sense in the end:

> +static char const * const builtin_commit_graph_usage[] = {
> +	BUILTIN_COMMIT_GRAPH_VERIFY_USAGE,
> +	BUILTIN_COMMIT_GRAPH_WRITE_USAGE,
> +	NULL,
>  };

Clever!

Thanks,
-Stolee
