Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379C0C71153
	for <git@archiver.kernel.org>; Mon,  4 Sep 2023 10:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbjIDKQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Sep 2023 06:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjIDKQf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2023 06:16:35 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11461B4
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 03:16:31 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-402c1407139so13886425e9.1
        for <git@vger.kernel.org>; Mon, 04 Sep 2023 03:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693822590; x=1694427390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xClqB1Sf+LDfbBtxkdqOar+zKOtVdFVzNGms4y6p2o0=;
        b=COi3bX2dcVLVAlRN4tgomTC2V7Nr0CJMvQa9XoCc3bxgimEUcYlM5utRNZCHrjDsTe
         /IF9TVfLIaBlMA+R9SUcMUVzIe0w444pmSxYWSeeExKSQsq0izcs0Eu1He1jEsuPt9OB
         b0O2WOpJ2YUp80/tFrl/m/kbniwEmkoWEqkeA+5syTOoJWBKCIPlpcooXTsucIal6S4O
         z0X3KjKVF4Hoi0vaJ2uuaSt16/xTV022w/sQCTRtOqsx0Ymk2OaAFmAlQRSerHEYiu+9
         Kc02YUyLaXBHf3xPB4kxlY/E+1S4uG8tCG0n51bJ3svx81oz/FOhBUevURjQ6EgqPz6Q
         utfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693822590; x=1694427390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xClqB1Sf+LDfbBtxkdqOar+zKOtVdFVzNGms4y6p2o0=;
        b=Ga9GHOTatjKhSgwztWzG4jrYrKpTnh5HTXBUvV4P58WKLTuh2/yT+b6VoYgGpY4jE2
         UDP5XR05ATPxSe23YO7XUvqkOvm2pct551tfKgKaNWHg3hPoMGOoglXwoUtqearlku3j
         dDw5qA+Cxrl9TTV+gLifFEVE0PaH2BKRQAbE3WHsuMg4Wz+TvLhyet+F0AEWfLhLFHd9
         IO6P2QuP6UKrz4/2w5oC3UsjX35iUckzVjUJmKwOhEqsNXlAnwT6mBSK4KkiswMtrMp9
         4Y6ru64HlQpdHECNT8RCX8fAoUXyLnDOjBlRN3NTIVTcnWrStGP3yGK4Ftxvz1p5SBNU
         Sx4w==
X-Gm-Message-State: AOJu0YyGDMvDUi4+YIjVJP02wQjn/spxKrLS3JTZyN7WTTeqby2SZr75
        NkFgav5pdA6JTkP4Ls1dPmvwuo6mrXFWGg==
X-Google-Smtp-Source: AGHT+IHNv/JiqNLf51eh09pdr5UKizzpFqDwHt28E8y8oX0MkmGzIE//g5b7P+q0fF0obLZwQ1+fZg==
X-Received: by 2002:a05:600c:218d:b0:401:cffd:995e with SMTP id e13-20020a05600c218d00b00401cffd995emr6856571wme.35.1693822589945;
        Mon, 04 Sep 2023 03:16:29 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id n8-20020a7bcbc8000000b00401d8810c8bsm16630417wmi.15.2023.09.04.03.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 03:16:29 -0700 (PDT)
Message-ID: <d9710161-ddb8-4b0a-9729-6b54cd56427d@gmail.com>
Date:   Mon, 4 Sep 2023 11:16:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/3] builtin/rebase.c: Emit warning when rebasing
 without a forkpoint
To:     Junio C Hamano <gitster@pobox.com>,
        Wesley Schwengle <wesleys@opperschaap.net>
Cc:     git@vger.kernel.org
References: <xmqq1qfiubg5.fsf@gitster.g>
 <20230902221641.1399624-1-wesleys@opperschaap.net>
 <20230902221641.1399624-3-wesleys@opperschaap.net>
 <xmqq4jkckuy7.fsf@gitster.g> <xmqqlednuagl.fsf@gitster.g>
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqlednuagl.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09/2023 05:50, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> If you rewind to lose commits from the branch you are (re)building
>> against, and what was rewound and discarded was part of the work you
>> are building, whether it is on a local branch or on a remote branch
>> that contains what you have already pushed, they will be discarded,
>> it is by design, and it is a known deficiency with the fork-point
>> heuristics.  How the fork-point heuristics breaks down is rather
>> well known ...
> 
> Another tangent, this time very closely related to this topic, is
> that it may be worth warning when the fork-point heuristics chooses
> the base commit that is different from the original upstream,
> regardless of how we ended up using fork-point heuristics.

I think that is a good idea and would help to mitigate the surprise that 
some users have expressed when --fork-point kicks and they didn't know 
about it. I think we may want to compare "branch_base" which holds the 
merge-base of HEAD and upstream with "restrict_revision" to decide when 
to warn.

Best Wishes

Phillip

> Experienced users may not be confused when the heuristics kicks in
> and when it does not (e.g. because they configured, because they
> used the "lazy" form, or because they gave "--fork-point" from the
> command line explicitly), but they still may get surprising results
> if a reflog entry chosen to be used as the base by the heuristics is
> not what they expected to be used, and can lose their work that way.
> Imagine that you pushed your work to the remote that is a shared
> repository, and then continued building on top of it, while others
> rewound the remote branch to eject your work, and your "git fetch"
> updated the remote-tracking branch.  You'll be pretty much in the
> same situation you had in your reproduction recipe that rewound your
> own local branch that you used to build your derived work on and
> would lose your work the same way, if you do not notice that the
> remote branch has been rewound (and the fork-point heuristics chose
> a "wrong" commit from the reflog of your remote-tracking branch.
> 
> Perhaps something along the lines of this (not even compile tested,
> though)...  It might even be useful to show a shortlog between the
> .restrict_revision and .upstream, which is the list of commits that
> is potentially lost, but that might turn out to be excessively loud
> and noisy in the workflow of those who do benefit from the
> fork-point heuristics because their project rewinds branches too
> often and too wildly for them to manually keep track of.  I dunno.
> 
> 
>   builtin/rebase.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git c/builtin/rebase.c w/builtin/rebase.c
> index 50cb85751f..432a97e205 100644
> --- c/builtin/rebase.c
> +++ w/builtin/rebase.c
> @@ -1721,9 +1721,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	if (keep_base && options.reapply_cherry_picks)
>   		options.upstream = options.onto;
>   
> -	if (options.fork_point > 0)
> +	if (options.fork_point > 0) {
>   		options.restrict_revision =
>   			get_fork_point(options.upstream_name, options.orig_head);
> +		if (options.restrict_revision &&
> +		    options.restrict_revision != options.upstream)
> +			warning(_("fork-point heuristics using %s from the reflog of %s"),
> +				oid_to_hex(&options.restrict_revision->object.oid),
> +				options.upstream_name);
> +	}
>   
>   	if (repo_read_index(the_repository) < 0)
>   		die(_("could not read index"));
> 

