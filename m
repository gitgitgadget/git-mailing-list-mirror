Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE9FC433E6
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 16:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D69F664E95
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 16:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhBKQUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 11:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhBKQSa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 11:18:30 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A15C061756
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 08:17:50 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id s77so5683121qke.4
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 08:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mZJxdjxM+DIgiXNIRWcitHrRHZEJp8xZFlj7XYmbDUA=;
        b=Z5fTUkzfl5dXOrJP20PpuUjSLrcx9TujbKnw09729tgaEhbkcxOCHWBwH4q4VFHqI+
         kDzQTZspp4jifc16qn72RGPPBg/xNfe1LFU9m7U/njnFCwBpx/+Lwvfe6kHGcUe5LuI+
         xQ2q8333QQDNTM0Cqwl4ALhwpiM5FE9bjF98oFw3rWLDpK1kzGxyGQcyiVRIlQRsiKuN
         Yp3nBb9JiyxIBkAC0nUKRCw7/Lvg0BrpB2QTsF04UWscBjkUzVYG0FErYVW2J9swo7Hz
         NyV1Od+fko89eWc+HoPZjZABLE+9M8JK4ogDQEpJv5Ykijn+A78iXJNo602gVYbEOyHn
         Tn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mZJxdjxM+DIgiXNIRWcitHrRHZEJp8xZFlj7XYmbDUA=;
        b=uW8SDIBnHGaRW3+B0I/LhKtRh7bNMN0M/4YvA+AclIHfGPRck0EbroHawF9tSZXqlh
         QpEGprEEa43cwsOnnhTmnKilcGbfkjBUVgyOX++VQM6uWdCUKmy+TTlMkpQFzHVxAEpR
         BwmiW0N3gu7dU8Kissr1diKa6LYwNP08kE0o//PFNm0KCHJ0ga0PJI4iqKppkCcU2iQ9
         EK8T7lP3RtL8tMjI/89cH/he/2ClI4zOtwC43j5HgsUWHrmjgUtiiNpbA0ckt7ykW+0O
         uJrc/ioBQLa4wta0JfbSsk1JJlz/lnPuqdm9xeNxoPxKiupCDHiAov0ahfbkk+MGQ5Ju
         Gdag==
X-Gm-Message-State: AOAM532Qho/5ssjBPMXVojaSSUYp5612wm6ak9gOaBBXuhMCss4gtAtO
        FcXPEjQXWmtjxGoWoqZwcts=
X-Google-Smtp-Source: ABdhPJzkvGb5VcNOUflyA+9iSIxA2akw7239RSJH/9FJrsj72hJDykwcKBn9Pq5yf/XnO9ITca2oqg==
X-Received: by 2002:a05:620a:98d:: with SMTP id x13mr4028074qkx.432.1613060269404;
        Thu, 11 Feb 2021 08:17:49 -0800 (PST)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:5030:63f6:1d3e:64d9])
        by smtp.gmail.com with ESMTPSA id 199sm4307730qkm.126.2021.02.11.08.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 08:17:48 -0800 (PST)
Subject: Re: [PATCH] commit-graph: when incompatible with graphs, indicate why
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.875.git.1613057954213.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <aa368496-2875-c383-e862-06e9c587af60@gmail.com>
Date:   Thu, 11 Feb 2021 11:17:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <pull.875.git.1613057954213.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/11/21 10:39 AM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When `gc.writeCommitGraph = true`, it is possible that the commit-graph
> is _still_ not written: replace objects, grafts and shallow repositories
> are incompatible with the commit-graph feature.
> 
> Under such circumstances, we need to indicate to the user why the
> commit-graph was not written instead of staying silent about it.

This feedback is valuable for these corner cases, especially now
that the commit-graph is getting less and less "optional" as time
goes on.

> +		if (hashmap_get_size(&r->objects->replace_map->map)) {
> +			warning(_("repository contains replace objects; "
> +			       "skipping commit-graph"));
...
> +		warning(_("repository is shallow; skipping commit-graph"));

These warnings make sense to me.

Thanks,
-Stolee
