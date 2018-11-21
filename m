Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7764F1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 11:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbeKUWID (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 17:08:03 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37638 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeKUWID (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 17:08:03 -0500
Received: by mail-yb1-f196.google.com with SMTP id d18-v6so2067538yba.4
        for <git@vger.kernel.org>; Wed, 21 Nov 2018 03:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0Oc56mJOWH7kBcRITCrR/b+f5sq+gvxEImhUyvv6zPU=;
        b=GNmGL7KZnh+ZD1XFzdlnkjEkstSIG1iXdOZuLhNMJ6uaMqLylxDm8kZ3ka1FSx5ho/
         U02WC23xVuw83epY+/NURMHF4EDV2N0Fh27mvHwZvkCc9aC03bhd7lNcvYwP7ThO9YQx
         oXmxIN0AdF+m/xYamGo+2xHE8wixJwQ2WSlF7KVlVu+gBvLsyvvlgDa+nINpBW2xOpT8
         eA//iBeA7xFQFxsLo0Y9NEKgJWWy0zNct0oWW0Q8X4C67d8sK8eaXLhp/N6HVf73jtfR
         Bt4mWCd0D9HCnHEodi/YB+fF9YAR/ljl4sZxlSCkGj5w2k7yIgjJJOqHlZoKdUiIzQpw
         nG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0Oc56mJOWH7kBcRITCrR/b+f5sq+gvxEImhUyvv6zPU=;
        b=IH8e1N8RzZVM8aN/ZZP+NHQScMoABNaEKTHCROLXxnLTjCVLFT7fFKAreiDkhMUhT5
         WX1CMKxIKZ9+OhUe9sQh52shP8yPpyR/Ohied39/Gq0REWNW24UIPMBujutD8M6LVeN9
         VSozuoFYzRQP6TuEWUUN/46uSDkr6JPoMGjibbt7e9Vrp+n2oLFCwD65P6FvU6Lw/JZP
         0qapZEZCcqar3nU15q5+dL0xMiTrYkfGHCfqETZL3w6mALP7cVJrK2Jse0B+DTI857J8
         daKT+DTzREFvAjrc/bK/NbverFRS+L377hg6E2If8NFzYUc/FtURtGHVYQ3ECJ9IVunV
         cxPA==
X-Gm-Message-State: AA+aEWbXa04sxQMOpeOiFOctAf6hxdx3fJdvDIYnts/2NYLpvNL4zYo6
        gaNE6xpmfLtZAk4joxyaTck=
X-Google-Smtp-Source: AJdET5di2cxXs220Xc+vIcbXkNPfYx3oS+aguCtCpyN20ys18sKj6VCn54tpyEr/ggiJekdzQa3pUg==
X-Received: by 2002:a25:718b:: with SMTP id m133-v6mr5624817ybc.79.1542800040229;
        Wed, 21 Nov 2018 03:34:00 -0800 (PST)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id c140sm24840633ywa.74.2018.11.21.03.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 03:33:59 -0800 (PST)
Subject: Re: [PATCH 2/2] commit-graph: don't call
 write_graph_chunk_large_edges() unnecessarily
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
References: <20181121012344.26711-1-szeder.dev@gmail.com>
 <20181121012600.26951-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6d9ce874-0d96-1312-5b9f-71a8db20ce9b@gmail.com>
Date:   Wed, 21 Nov 2018 06:33:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181121012600.26951-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/20/2018 8:26 PM, SZEDER Gábor wrote:
>   	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
> -	write_graph_chunk_large_edges(f, commits.list, commits.nr);
> +	if (num_large_edges)
> +		write_graph_chunk_large_edges(f, commits.list, commits.nr);

This is clearly correct, and the tests in t5318-commit-graph.sh would 
catch a dropped (or additional) large/extra edge chunk.

Thanks,

-Stolee

