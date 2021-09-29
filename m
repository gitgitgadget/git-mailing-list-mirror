Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83502C433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 06:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 611656128E
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 06:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244166AbhI2GVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 02:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244007AbhI2GVo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 02:21:44 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2230C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 23:20:03 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id h129so1752566iof.1
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 23:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9pOQky5AVTrxZPr7KHOx0PRKuytAO7in1QUk6uTjCy8=;
        b=RmH24tTBkF7oFLBZv0JVMvaD3eJd6s8lYJhHtioHzEnp5lFSPcyMEWg9Q+0AwY6FTf
         GE5ZZBpzvqnW8auyC0FXhRWag4AtGrHRv9/QzrseU81S4Q5bNFUb/K2im+EtnLpEWE6r
         qElwDl0Sz5AxOgBzijjhlFtpJMWbY6dM1wEKpvtbMS+sDYBKXv5jKh2hr2OM7QbT5Nhc
         HfG07cDuMcVFWBIbgQSUjpo3FFNY24DMgPkO8PJizhylESk/Swhg1S+TogGsJh4ufzd/
         bAv86Zaw3n5tfY+INyAyrWv2SInb7hebxk6Y5X8NpJ1csWiyWpLPQ6R9thqH1AXiTE6O
         054w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9pOQky5AVTrxZPr7KHOx0PRKuytAO7in1QUk6uTjCy8=;
        b=RWC0xT7VyvCyULqDJcGdtqsicbEuoO+JifGRFKTuTbKf84Xp9bgoirloXPh546g76V
         /yFL0AdfleBZRTQZ4ee2OEs41r1etQjMxHd21GWaDkn57pQ3OVvjXzmc6/9A9HW2iPYt
         u6bGAo2V01A8lAh+u5mEOJHwCXhp5S7IxL4tiXZsoFLfcePcm5bF7moOsrI3XdnWCtF+
         fRKs8zAqyZQlBHMvwO794cRRlheIJIoQJV/zUGEHW9Hdb2cMf9lJ9z1wUl2s3vfWerP2
         RNe37ZgnI2vwo5knBlsegL8s4PVixmBsTN4kOA6HbUWpGjbq9WBxbEHpnFY3tGpueV00
         FiRQ==
X-Gm-Message-State: AOAM532mHCQKB09bf+BmH2Al9apM6kcl8E57HIpBHCKTrNe3Na7zrNJW
        bT8DmelSDUNvGjjp9pzl6ggkzKtZ8K5PxQ==
X-Google-Smtp-Source: ABdhPJxfAyNU+cV3WS8eubdYmtF7EGPgG3jQn0yaZtdIdPayKb9nFzW2wfmL4WV8POolrYOM4tgZcA==
X-Received: by 2002:a02:c9d9:: with SMTP id c25mr8071031jap.81.1632896403073;
        Tue, 28 Sep 2021 23:20:03 -0700 (PDT)
Received: from flurp.local (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id v7sm830744ilm.19.2021.09.28.23.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 23:20:02 -0700 (PDT)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH v2 2/3] fsck: verify multi-pack-index when implictly
 enabled
To:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
References: <20210913181221.42635-1-chooglen@google.com>
 <20210917225459.68086-1-chooglen@google.com>
 <20210917225459.68086-3-chooglen@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Message-ID: <ebe894b4-af25-f79e-c43f-1839e075908d@sunshineco.com>
Date:   Wed, 29 Sep 2021 02:20:01 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210917225459.68086-3-chooglen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/17/21 6:54 PM, Glen Choo wrote:
> Like the previous commit, the_repository->settings.core_multi_pack_index
> is preferable to reading "core.multiPackIndex" from the config because
> prepare_repo_settings() sets a default value for
> the_repository->settings. This worked fine until core.multiPackIndex was
> enabled by default in 18e449f86b (midx: enable core.multiPackIndex by
> default, 2020-09-25).
> 
> Replace git_config_get_bool("core.multiPackIndex") in fsck with the
> equivalent call to the_repository->settings.multi_pack_index.
> 
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> @@ -407,7 +407,9 @@ test_expect_success 'verify incorrect offset' '
>   test_expect_success 'git-fsck incorrect offset' '
>   	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
>   		"incorrect object offset" \
> -		"git -c core.multipackindex=true fsck"
> +		"git -c core.multipackindex=true fsck" &&
> +		test_must_fail git fsck &&
> +		git -c core.multipackindex=false fsck
>   '

I guess the newly-added `test_must_fail git fsck` line is checking the 
fallback case then `core.multipackindex` is not set. We could make this 
check a bit more robust by _ensuring_ that it is unset rather than 
relying upon whatever state the configuration is in by the time this 
test is reached. Perhaps something like this:

     ...
     "git -c core.multipackindex=true fsck" &&
     test_unconfig core.multipackindex &&
     test_must_fail git fsck &&
     git -c core.multipackindex=false fsck

The indentation is a bit unusual. It aligns nicely and is, in some 
sense, easy to read, but the two new lines are over-indented considering 
that they are siblings of the corrupt_midx_and_verify() call.

Don't know if any of this is worth a re-roll, though.
