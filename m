Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591D4C2D0C6
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 14:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2879E208C4
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 14:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMa7gcI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfL0OwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 09:52:12 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41061 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfL0OwL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 09:52:11 -0500
Received: by mail-qt1-f194.google.com with SMTP id k40so24707801qtk.8
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 06:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fN/S+4qr0J08Xw56ipVlCWb80adf/JP3Kg+8zmOGedQ=;
        b=lMa7gcI5X/04dR00/2M7K9x0XQgJkobvyOkKNYuGP9QO8oECRVJS3XUGYYbTldcURv
         CT/IW0jJg4zIJR76KV2iaEhTP5oboQBUgYdj763O8Erv+VYSn/z4jeYlSj2bxDogeGzF
         6yp7fSQqAQBkyOcN8TdYjp21pC5neWK68VNqsH9Ab6Kgy7qbmROnTKpJIVJhLIQ/78ka
         hHD7CvUU4nVmLxEShSqKUojowWbf8ahv4OYBJQ9/LB8CVqg85P+uDxmOzJ4jaJYPqTZ/
         mp7dXyn7L1aSZpKNd1vEXMFYaY7cGWTN/+gz/8LWZ1WA5+XWlHl4glTCx4a7+E0LFsYz
         d0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fN/S+4qr0J08Xw56ipVlCWb80adf/JP3Kg+8zmOGedQ=;
        b=ble6uceyD8RmoFVu2HeHsMdIsbDsVV9DEJ8nO/ctPHoOdxOmvRSYKzrV7JQsNq//Td
         8XiodT36fKYRFKhUu3vLdKHo2n3H2Cob7QcsDRksbrIPoCpZPOQ29coDMmv8QK0S3AlW
         sjyil+2tfgK6HUrLPQby52mLEUKtbI2ur2ZOI8Wogg3/AJFevxknXJnCT06nl+HKcXwN
         HY+d9oQMaW5hWijT3PW24xe4ihXZK7NYdXrusOLNQKY2P7or5S7Xe/+b9Ljvbwjgtjyq
         aYnCHpNpcHi5ipfjASImya5+fMOfbgmrWd4ni0p0JjKuB2BuVNe+rS3WnVmhLvQGoYB8
         jjDQ==
X-Gm-Message-State: APjAAAUn7z/l+5LKCDbWiU3GpOsCEsjxPGIHsg2nR1u7jZwz3hvP/Lwe
        K1UN6nJXKWEkUth1FmifR4U=
X-Google-Smtp-Source: APXvYqyYKyAhVH1Znu7jnGfmZYgQLjTFh0sBdWXfDdDO/RghrV6XGrxZRiJlg8rblBvP96J2PSXTHA==
X-Received: by 2002:ac8:32c6:: with SMTP id a6mr38053467qtb.11.1577458330728;
        Fri, 27 Dec 2019 06:52:10 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:9d29:38a1:5885:e8b3? ([2001:4898:a800:1010:4e5f:38a1:5885:e8b3])
        by smtp.gmail.com with ESMTPSA id k4sm9728579qki.35.2019.12.27.06.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2019 06:52:10 -0800 (PST)
Subject: Re: [PATCH 2/3] commit-graph: free large diffs, too
To:     Jeff King <peff@peff.net>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>
References: <20191222093036.GA3449072@coredump.intra.peff.net>
 <20191222093216.GB3460818@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e932bed5-f90c-da51-7d45-54e14aa27734@gmail.com>
Date:   Fri, 27 Dec 2019 09:52:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191222093216.GB3460818@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/22/2019 4:32 AM, Jeff King wrote:
> If a diff we compute for --changed-path has more than 512 entries, we
> don't bother generating a bloom filter for it. But since we don't
> iterate over diff_queued_diff, we also don't free the filepairs and
> filespecs from the diff before clearing the queue. Let's make sure we do
> so.
> 
> This drops the peak heap usage of "commit-graph write --changed-paths"
> on linux.git from ~8GB to ~4GB.

In my testing, the heap size went from ~10gb to ~6gb.

Thanks,
-Stolee
