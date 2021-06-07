Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7A2C47095
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 15:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5445761185
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 15:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhFGP3N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 11:29:13 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:43842 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhFGP3M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 11:29:12 -0400
Received: by mail-qk1-f179.google.com with SMTP id j62so3264482qke.10
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 08:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XcEDwAZTTUvGRldwqvnZly7fEwxCJwrxxfiZdpSFcdE=;
        b=Nu3/RNEp4Z/9geTimdBharJiF6/IRMhEAK4ke2BERF8/T7dRWB3X1X00XQnLmjVMwe
         UFT8S0aVo6Z7qigLpjTEs8UeDuclGY1+ExuoVJnppY4nyzZ5LBIdqR/aISfoQeVlMCS4
         urMZOWYxPXRoWzGEUwMYvJ0zP0HiQ8uC1lqfe00UUQV95lS6VFWSqoDF/ZOh6C2KMRZx
         /rLrN1zpOedTJD0TiD2bOPt38m0EkBNyMzrA1Q4eihiSRNzgkYUNUz4MLkuDJjpy/+Rz
         4aD8+KoX7SNoyLbCKQomoEUYTzrg5rYYS4mW+1eYVYV6E3+B5IeHox12kaL/RFDd4rZz
         GoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XcEDwAZTTUvGRldwqvnZly7fEwxCJwrxxfiZdpSFcdE=;
        b=FQ4sVwr8+t9DFTjROHvr5jn1zp0nkgZ5Kdxm/1Er8DNdw9iQ95cZASS+HD1sN47/+R
         BYVqKHlv1ViomYFlAVSlVbAlvj4ugc96+h228oXFzzP1u1kGI9iRXJ3qwIdGux50UXL8
         DwCcjnNMw7D3dU/0gMM7qMLH6BYba2z2Tb83D7HRHpYL/lEivNF4O/5Vaty3jgHcqX4I
         E/HJ21Q/RXFVcNrTKdF4PdKcuZ4fnPS9Y25LdR113EJIjMQCSREZSSs7Eh8vHm4eVzKf
         cPUv7dOmEUAvp0huKjiHj1/gF9mSeKXTvxe6PcKxhzSTlTPu9DNMSFviEuid/2NP7qKm
         O4UQ==
X-Gm-Message-State: AOAM533kH/kvgn9yn9kuspLFF6BWCoM2FmaDmi3TN3oFo60CvdWEtbe7
        rSXxgObgw44FYT8Hq5aH2bk=
X-Google-Smtp-Source: ABdhPJzbsMTdCLEDzIYhvBPqh4+81M/F2PfJyD7clBGhD7MJPXBBhmsPfpagRu1zSmtQVg2MxVKO2g==
X-Received: by 2002:a37:9e53:: with SMTP id h80mr14028543qke.150.1623079565526;
        Mon, 07 Jun 2021 08:26:05 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:58fa:fc7:3955:c1d5? ([2600:1700:e72:80a0:58fa:fc7:3955:c1d5])
        by smtp.gmail.com with ESMTPSA id c23sm996941qkc.3.2021.06.07.08.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 08:26:05 -0700 (PDT)
Subject: Re: [PATCH v5 10/14] diff-lib: handle index diffs with sparse dirs
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
 <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
 <b9b97e0112939d1787ff1d2a13c48e5b406408db.1623069252.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b2ce649a-00d0-8418-2a3f-9172ff69eccf@gmail.com>
Date:   Mon, 7 Jun 2021 11:26:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b9b97e0112939d1787ff1d2a13c48e5b406408db.1623069252.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2021 8:34 AM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
...
> +			old_entry = make_transient_cache_entry(
> +					entry[0].mode, &entry[0].oid,
> +					old_path, /* stage */ 0);

I didn't realize this before I started integrating with
v2.32.0 (which I should have done before submitting v5) that
make_transient_cache_entry() has changed its prototype to
include a memory pool parameter.

I'm working on a v6 that makes only this update and it will
probably be ready tomorrow.

Thanks,
-Stolee

