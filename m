Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E14AC48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 21:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FAAB60FE3
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 21:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFIVS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 17:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhFIVS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 17:18:28 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F43C061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 14:16:33 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id if15so2776095qvb.2
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 14:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6WYZFtROzQInCm0YJ40Y3yA4SDNia8juUSZy+msvslI=;
        b=VbJhuEcKEhmNSMu8cBPlxFUfUmVS1UNB2W5FHkc2Rw9tnG3n1eeO6b+C79O9Bu6JaP
         Ic8bVloWbG5s1Wc4G2E3NI4Gp9Bi//NoFapsXmaSfuzACf0awln0zr6mznxcCbqMMUfg
         mWsZyWIRwosc1mLEr9+wHYuMIpTxxOj81T2oKQfXn4eNyi0+rnbZSmhL0FLkHipfctVA
         WP0zmJX8ihLpcfHvLt3xq5UsGNM6E3DnFGCAXhAfBCmm9c5KyMfFWiQDI8+NQgNBFQ6b
         QPC3y9gcIxqh5lwvHFT6/A5yA9SKfIu8zfNM4zUtFHW9kQLgUK1FeJZ7tdpd8ueLSO5E
         8vTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6WYZFtROzQInCm0YJ40Y3yA4SDNia8juUSZy+msvslI=;
        b=ZelhK+j3bYF/D1bGvz4uSNnmWz2CX7syoEV8j+p0R1J4JD2QLbdmtCuO7WNRSuuWyO
         aOxaCIL9m9FTMMhlXM4sxEGLd+tIf6K4I1ib1lNjnlnguS472fryRPrSD/lfCQveUOXl
         bw3i6xobg9hr7RFElyDSyxutXfUtsqjBGrkmAaky1xtc4pQ0CTifu1LjFsPmXlzpZo8g
         LCGY4I/Oyuo8vRc6ErtJBhEGxKTy0SQBPBh0lZVM4uLpvJlvu3nNX2meZqqIVxxQ2yPK
         83eLD2pfiNAC+6pOHSaSWzml5QdPyA1Wr4GZ6dDSMJC0g8uV9TJRyDVd3JuZNY+0NTLV
         jNAQ==
X-Gm-Message-State: AOAM530HWwyeaGL0jWs5+xWcRzdWOfc5EW0cyDO3EF2v10iDXYc+Lc6H
        9Fa4gXARXUrVSkTDqnEabP4=
X-Google-Smtp-Source: ABdhPJy/HIxIdSdIdrwNdIkEbMf/7rwBEBJbp9FxCdRq9zvFG0ix/K8X5V/oE3OGGRU9LI8Xj65t+g==
X-Received: by 2002:a0c:e942:: with SMTP id n2mr1722672qvo.5.1623273392778;
        Wed, 09 Jun 2021 14:16:32 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:757b:21f8:d6f2:dd1b? ([2600:1700:e72:80a0:757b:21f8:d6f2:dd1b])
        by smtp.gmail.com with ESMTPSA id p7sm885495qkk.104.2021.06.09.14.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 14:16:32 -0700 (PDT)
Subject: Re: [PATCH 2/5] t6421: add tests checking for excessive object
 downloads during merge
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
References: <pull.969.git.1622856485.gitgitgadget@gmail.com>
 <6462bb63310dbc889a3442951ef261bc7fd7e0dc.1622856485.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7fb76c82-bc54-01c1-451f-7dc05177d58f@gmail.com>
Date:   Wed, 9 Jun 2021 17:16:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6462bb63310dbc889a3442951ef261bc7fd7e0dc.1622856485.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/4/2021 9:28 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
...
> +test_expect_merge_algorithm failure failure 'Objects downloaded for single relevant rename' '
> +	test_setup_repo &&
> +	git clone --sparse --filter=blob:none "file://$(pwd)/server" objects-single &&
> +	(
> +		cd objects-single &&
> +
> +		git rev-list --objects --all --missing=print |
> +			grep '\?' >missing-objects-before &&
> +
> +		git checkout -q origin/A &&
> +
> +		GIT_TRACE2_PERF="$(pwd)/trace.output" git -c merge.directoryRenames=true merge --no-stat --no-progress origin/B-single &&

nit: this long line could be split up with \ marks.

> +
> +		# Check the number of objects we reported we would fetch
> +		cat >expect <<-EOF &&
> +		 ..........fetch_count:2
> +		 ......fetch_count:1

I'm concerned that the number of dots here could change for various
reasons (e.g. adding regions). Could the 'cut' below cut everything
after the dots, so we only care about "fetch_count:X"?

> +		EOF
> +		grep fetch_count trace.output | cut -d "|" -f 9 >actual &&
> +		test_cmp expect actual &&
> +
> +		# Check the number of fetch commands exec-ed
> +		grep d0.*fetch.negotiationAlgorithm trace.output >fetches &&
> +		test_line_count = 2 fetches &&
> +
> +		git rev-list --objects --all --missing=print |
> +			grep ^? >missing-objects-after &&
> +		test_cmp missing-objects-before missing-objects-after |
> +			grep "^[-+]?" >found-and-new-objects &&
> +		# We should not have any NEW missing objects
> +		! grep ^+ found-and-new-objects &&
> +		# Fetched 2+1=3 objects, so should have 3 fewer missing objects
> +		test_line_count = 3 found-and-new-objects
> +	)
> +'

Generally, this idea of using trace2 to determine internal activity
that affects performance is a good one. The balance to strike is to
ensure that future changes don't suffer too much due to the how
rigid the tests are. The dots are the only example of a way to relax
these tests a bit more.

Thanks,
-Stolee
