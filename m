Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA268C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 14:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9603761002
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 14:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhGOOfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 10:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhGOOfD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 10:35:03 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1167C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 07:32:09 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id w1so5147165ilg.10
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i1l9YJb+P1B8X6rBeVBpIBrdZkLD1UlLiIlWT+VTs0s=;
        b=Oa1iDBvIlAr/A9HaD2W40HxSAU89RpVk/G0x+NtiU/waJO+YV6OpWBWCoVhFfCnhq+
         LePLJeGSEYOOR4uh4Tfk9tsuACsAIi9m4h8cr2ZsoFjxF0lOpBICs2MhzA4s/P/jr7l/
         K3c+fDArIiyV7ZLauNxMhhYnOyStAiPEWGegYhCXZRlHuqdZV3lFH3sDKBQMXkw5/YPE
         ypYKM6s8xIHK6iAQkuXnOZqXaWUrZp0geJEyxZtSipJOOe1UBcqzHbSd2ga1vZcADOW/
         H0kI2S2hLhNJB71UG5fmVWh7by2za1xKEn8Wtr+eypGQTgNk73nAGdnoMbc5FSXK9rN8
         3vpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i1l9YJb+P1B8X6rBeVBpIBrdZkLD1UlLiIlWT+VTs0s=;
        b=YkjzX66pxbdLCgpgIh8xeDajPHYBPjmd7V1gr23ICxNd8uWrh9bMjNL6bLWUS8jdDy
         rkitGzK360Lt9cBXimXu7jWu2oPnCGiOoaLimHOE+GKeushIB1Tv6EAtE7synlb5ov5b
         +HIDdQ3C3bMIVa08V12dkSwBQTl9EKFiepHVlN1+mg13w3TLnoopKCLZpO04kTBHlSKl
         dicKg2G4aA5MmaYEC23x5CMYA5s2JMrzoOwFQZvF1g0P87ZLFr1ik3GrwLrJWk0GpPKi
         LPNdDmJIfiysN6pdtFyDlya0eP+2FP6Cdqd3YyDOrpw2PeY4f/XCDAoasbuwz0tzmxCw
         /4fQ==
X-Gm-Message-State: AOAM531lRQJQZDhkFws6Q8xpUL7FZxBpVqWwRNZ/ze30RbItpP/4l8Tz
        kWmBU7W6xfY/4J2vrttUKEE=
X-Google-Smtp-Source: ABdhPJyOh6fV0pCxbceLoRARZgF+/8k7wOfIdgEVr/DroSDJBh15wbMCCz+laf5n+LFRdsjkWZzDMQ==
X-Received: by 2002:a92:c524:: with SMTP id m4mr2834469ili.42.1626359529130;
        Thu, 15 Jul 2021 07:32:09 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:b51d:31f1:a0d6:7fc2? ([2600:1700:e72:80a0:b51d:31f1:a0d6:7fc2])
        by smtp.gmail.com with ESMTPSA id l18sm2247412ioc.13.2021.07.15.07.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 07:32:07 -0700 (PDT)
Subject: Re: [PATCH v2 4/7] merge-ort: add a handle_deferred_entries() helper
 function
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
 <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
 <7e28323b624ad2d8d12123783f00f5a8fbb248e8.1626204784.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4aa2f487-ad4b-b7fc-2ee0-b78c3703d955@gmail.com>
Date:   Thu, 15 Jul 2021 10:32:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7e28323b624ad2d8d12123783f00f5a8fbb248e8.1626204784.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/13/2021 3:33 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> In order to allow trivial directory resolution, we first need to be able
> to gather more information to determine if the optimization is safe.  To
> enable that, we need a way of deferring the recursion into the directory
> until a later time.  Naturally, deferring the entry into a subtree means
> that we need some function that will later recurse into the subdirectory
> exactly the same way that collect_merge_info_callback() would have done.
> 
> Add a helper function that does this.  For now this function is not used
> but a subsequent commit will change that.  Future commits will also make
> the function sometimes resolve directories instead of traversing inside.
...> +MAYBE_UNUSED
> +static int handle_deferred_entries(struct merge_options *opt,
> +				   struct traverse_info *info)
> +{
> +	struct rename_info *renames = &opt->priv->renames;
> +	struct hashmap_iter iter;
> +	struct strmap_entry *entry;
> +	int side, ret = 0;
> +
> +	for (side = MERGE_SIDE1; side <= MERGE_SIDE2; side++) {
> +		renames->trivial_merges_okay[side] = 0;

We are unconditionally setting this to zero? I will await the
use of the method to see how that affects things.

> +		strintmap_for_each_entry(&renames->possible_trivial_merges[side],
> +					 &iter, entry) {

The rest of this loop seems like standard logic for handling
these tree walks.

Thanks,
-Stolee
