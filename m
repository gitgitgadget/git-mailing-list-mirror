Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952B0C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 11:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6107F2078B
	for <git@archiver.kernel.org>; Thu, 21 May 2020 11:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6klTxia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgEULyM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 07:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbgEULyL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 07:54:11 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC63C061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 04:54:11 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id b3so5912548oib.13
        for <git@vger.kernel.org>; Thu, 21 May 2020 04:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vt3V+NBwSFHYrc8YgLG77njnDGpWD5ELkAX1rQnMmEM=;
        b=I6klTxiaeEVWfEia7V/yQshKNICsziF6nGQQ+23/Uqn4WADK390YCEi5/AgiLl5uXI
         vHOSOWCUfmchUuZAtmuQYY+eti88EteJzyYsSe2qSPJ4iwf6Muoa7o6r1KpsLZpkJ23U
         CaBUwwG7VOZhEzf2E5X91RjHmFehoNCeRehJWh9p4Nu1jRMU2eayKzCQiNzYomiFt36B
         ERR5GgrIjr7CEGgXhl+qCC160Y9QmjJMRNPU6441XCtBKJ3SbUeg+6vfmiOyHpCvB9jL
         b9AE+A+FH88jODlXuDRiR07LXWpiMDG60pLo7idRhw2gvS/j3FQeW0oFrvlZDEgMyNbW
         DsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vt3V+NBwSFHYrc8YgLG77njnDGpWD5ELkAX1rQnMmEM=;
        b=oiZUqWf8GwJyMj86wnZzdFX3il37+fkUYsvkck3Cs4hh+gXRyHHuOSo2hQ58bN6EOj
         1fsA20dVYaM5vTB0j7l6IQ+eYbwP9gFBQj73pJopsARSvLkkz3uTiBTF6OsetRsG1+Vm
         GVq/0fhFX2eop1uFtmQFKvGVRA0Z0HRY5GF5sSKsrA1iBnFxFNsFRg7KqIabdeML8SEO
         umrSoQ9hu7C6ZojkyBr6zIpGJ1JXN+62DREz2Tv+ZYvWHmz1de8lTb4gNTnM+wjRwhAI
         hf8CgxfE8T+EPNkoOQdE6sMM2qDfjwoLLMqMCgf0cL3h3PJQ8QYJnsAHEz8tqT/lNMfJ
         LYQA==
X-Gm-Message-State: AOAM5307ryBwLbXuGFxYU3teRFLcyNMVmQQe3f4pcKiSMHSgY6Zp46+b
        Yvwl86/l+w2WBZcQnQCxDoU=
X-Google-Smtp-Source: ABdhPJzuOVE7p/Wh5qH4yamSEQ/fXM85kpLOrTBVTjLv8ejpTt2DebMMeiBc7ge5Ie47D+DGopGh8w==
X-Received: by 2002:aca:72d6:: with SMTP id p205mr6384093oic.128.1590062050271;
        Thu, 21 May 2020 04:54:10 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id s69sm1533057otb.4.2020.05.21.04.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 04:54:09 -0700 (PDT)
Subject: Re: Protocol v2 in v2.27 (Re: Re* [ANNOUNCE] Git v2.27.0-rc1)
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
References: <xmqqsgfuv2ko.fsf@gitster.c.googlers.com>
 <20200520193156.GA4700@coredump.intra.peff.net>
 <xmqq5zcquz4t.fsf_-_@gitster.c.googlers.com>
 <20200520220023.GB3648@google.com> <xmqqlflmtaxq.fsf@gitster.c.googlers.com>
 <20200521021533.GC3648@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1a3bf366-d888-74d3-5f81-78dfeb5eb79c@gmail.com>
Date:   Thu, 21 May 2020 07:54:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <20200521021533.GC3648@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/20/2020 10:15 PM, Jonathan Nieder wrote:
> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>>> Speaking of which, should we enable protocol v2 by default for people
>>> with feature.experimental enabled, like this?
>>
>> It is an excellent idea, but is something that had to have been
>> proposed before -rc0 to be in the upcoming release, no?
> 
> I would love to go back in time, but I only have the present to work
> with.  Here, I'm hoping it makes the switch of default back to v0 less
> of a regression for some interested users.
> 
>> The patch looks good; do we have the master list of things that are
>> under control of feature.experimental knob in the documentation, or
>> is it a feature that we do not have to have a centralized control?
> 
> Good catch.  Here's an updated patch with (1) a commit message and (2)
> that doc update.
> 
> -- >8 --
> Subject: config: let feature.experimental imply protocol.version=2

For some reason, I thought protocol v2 was part of feature.experimental
at some point, but it doesn't appear to be so, or ever even part of the
patch series.

> Git 2.26 used protocol v2 as its default protocol, but soon after
> release, users noticed that the protocol v2 negotiation code was prone
> to fail when fetching from some remotes that are far ahead of others
> (such as linux-next.git versus Linus's linux.git).  That has been
> fixed by 0b07eecf6ed (Merge branch 'jt/v2-fetch-nego-fix',
> 2020-05-01),

Should we really mention the merge here? Is it because the "fix" is
spread across two commits? Why not say the tip of the topic?

2f0a093 (fetch-pack: in protocol v2, reset in_vain upon ACK, 2020-05-27)

> but to be cautious, we are using protocol v0 as the
> default in 2.27 to buy some time for any other unanticipated issues to
> surface.
> 
> To that end, let's ensure that users requesting the bleeding edge
> using the feature.experimental flag *do* get protocol v2.  This way,
> we can gain experience with a wider audience for the new protocol
> version and be more confident when it is time to enable it by default
> for all users in some future Git version.
> 
> Implementation note: this isn't with the rest of the
> feature.experimental options in repo-settings.c because those are tied
> to a repository object, whereas this code path is used for operations
> like "git ls-remote" that do not require a repository.

(This may be why protocol.version wasn't included in the first place.)

> +* `protocol.version=2` speeds up fetches from repositories with many refs by
> +allowing the client to specify which refs to list before the server lists
> +them.

This is the appropriate tone for this section: it's more about _why_ than _what_.

> --- a/Documentation/config/protocol.txt
> +++ b/Documentation/config/protocol.txt
> @@ -48,7 +48,8 @@ protocol.version::
>  	If set, clients will attempt to communicate with a server
>  	using the specified protocol version.  If the server does
>  	not support it, communication falls back to version 0.
> -	If unset, the default is `0`.
> +	If unset, the default is `0`, unless `feature.experimental`
> +	is enabled, in which case the default is `2`.

Looks  good.

> @@ -17,6 +17,7 @@ static enum protocol_version parse_protocol_version(const char *value)
>  enum protocol_version get_protocol_version_config(void)
>  {
>  	const char *value;
> +	int val;
>  	const char *git_test_k = "GIT_TEST_PROTOCOL_VERSION";
>  	const char *git_test_v;
>  
> @@ -30,6 +31,9 @@ enum protocol_version get_protocol_version_config(void)
>  		return version;
>  	}
>  
> +	if (!git_config_get_bool("feature.experimental", &val) && val)
> +		return protocol_v2;
> +
>  	git_test_v = getenv(git_test_k);
>  	if (git_test_v && *git_test_v) {
>  		enum protocol_version env = parse_protocol_version(git_test_v);
> 

The context around this change is that we check "protocol.version" explicitly
before checking "feature.experimental", so that explicit setting wins. Then,
feature.experimental overrides the GIT_TEST_PROTOCOL_VERSION environment
variable.

LGTM.
-Stolee



