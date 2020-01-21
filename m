Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C859AC2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 18:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941BB24125
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 18:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKbGARm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgAUSBw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:01:52 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39478 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgAUSBv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 13:01:51 -0500
Received: by mail-ot1-f68.google.com with SMTP id 77so3759074oty.6
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 10:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=850fUBELQjNRjU3wVa8L6l3HcDx4Y2oGw6K4PW4DY1w=;
        b=IKbGARm6H5gdskd/qFLHUVvQbqfYAZc0j/mY12aF5lFxIBr0BvGM4zc/IWM3BSSOxs
         6bwp93B6+a/W1SqENaLbp6EyGYm/aV+Xeb0wWqZ5aUvxg2+WqP7Rzr97aSDb+at6HW55
         2Va4B5Rc790k1QdkRogg1I72THvFXri6o4H1WL71ElGjbQ88ChwXjxJ82w6aKnBQ9zqr
         hJmb6ZSJkzz0rBcy2hHCCSr3PrxBYa3ET887he8iU/eebG9+1CCcpMYdBussyQHD6Gy6
         wyM6DYbqfStoxsqi8doj7vEvlQQ9/4JjxAdXDKdtclAW+4ijSTT8f+a5Pkn3i9yisUSB
         Porg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=850fUBELQjNRjU3wVa8L6l3HcDx4Y2oGw6K4PW4DY1w=;
        b=DC37JNh8TEt/AiYf2arKYwnO/dOeVtl6lx2XoOArhwrwlalI0xUvbPtu6Dl2BiC/J/
         uRM6O91Bw/q8QX3OkkOOtG5Z/Ww2H4I26XbNPBwKvRCgvz9i+06gbpcUiwzg9bmUVZ2A
         l6X1FhJlRq39LFeRmyKGdBBX0a4OH8dU8TbmVG9gQzZrboAy7rgraUcoRBg0yCsJEm5F
         plj492RLxlKM6MX3SjEcKMvfyRGlDyrCEe+QfbwFsPxbdTH7bY/vVGXivppqJ22PC3Yb
         YKHXRGjwkipunGayTJgxNc2LC6thHB7dZh0CLz2QIE+tHD2RgTbTmtCEyyl/7CZ78yXq
         uG1w==
X-Gm-Message-State: APjAAAWhfEtPshZ9LKinippYrxOIlq74WzZGltfZGHK91A60vLFz5NKs
        tU41/b5PflDg2AkQRAjeDNk=
X-Google-Smtp-Source: APXvYqwcjpm3Qg1Hn0OTRWcboL2Cjy+vUgoigOpU6gbM+Cjr0v5nyXQP+IpREBKpTDJ6k8YIaIwBpA==
X-Received: by 2002:a9d:4902:: with SMTP id e2mr4571676otf.116.1579629711218;
        Tue, 21 Jan 2020 10:01:51 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id x17sm12433494oix.18.2020.01.21.10.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 10:01:49 -0800 (PST)
Subject: Re: [PATCH v2] fetch: document and test --refmap=""
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.532.git.1579274939431.gitgitgadget@gmail.com>
 <pull.532.v2.git.1579570692766.gitgitgadget@gmail.com>
 <20200121162433.GA6215@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a87b9fc2-dae4-7e39-5aab-243ba9679531@gmail.com>
Date:   Tue, 21 Jan 2020 13:01:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20200121162433.GA6215@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/21/2020 11:24 AM, Jeff King wrote:
> On Tue, Jan 21, 2020 at 01:38:12AM +0000, Derrick Stolee via GitGitGadget wrote:
> 
>> Update the documentation to clarify how '--refmap=""' works and
>> create tests to guarantee this behavior remains in the future.
> 
> Yeah, this looks like a good solution to me.
> 
>> This can be accomplished by overriding the configured refspec using
>> '--refmap=' along with a custom refspec:
>>
>>   git fetch <remote> --refmap= +refs/heads/*:refs/hidden/<remote>/*
> 
> This isn't strictly related to your patch, but since the rationale here
> describes the concept of a background job and people might end up using
> it as a reference, do you want to add in --no-tags to help them out?

That's a good idea. I keep forgetting about that. It's interesting that
tags are fetched even though my refpsec does not include refs/tags.

>>     Thanks for all the feedback leading to absolutely no code change. It's
>>     good we already have the flexibility for this. I'm a bit embarrassed
>>     that I did not discover this, so perhaps this doc change and new tests
>>     will help clarify the behavior.

> Anyway, I wasn't at all sure that a blank --refmap= would do what you
> want until I tried it. But it was always intended to work that way. From
> c5558f80c3 (fetch: allow explicit --refmap to override configuration,
> 2014-05-29):
> 
>   +static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
>   +{
>   +       ALLOC_GROW(refmap_array, refmap_nr + 1, refmap_alloc);
>   +
>   +       /*
>   +        * "git fetch --refmap='' origin foo"
>   +        * can be used to tell the command not to store anywhere
>   +        */
>   +       if (*arg)
>   +               refmap_array[refmap_nr++] = arg;
>   +       return 0;
>   +}
> 
> At first I thought the comment was wrong, since we don't actually
> increment refmap_nr. But the ALLOC_GROW makes refmap_array non-NULL,
> which is what triggers the "do not use configured refspecs" logic.

This works due to a subtle arrangement of things, like a non-NULL
but "empty" array. That justifies the test even more.
 
> This code switched to refspec_append() in e4cffacc80 (fetch: convert
> refmap to use struct refspec, 2018-05-16), and I think we actually do
> push an empty string onto the list. Which then triggers the "do not use
> configured refspecs" logic, but doesn't match anything itself. I'm not
> sure whether that behavior was entirely planned, or just what the code
> happens to do. So it's doubly useful to add a test here covering the
> expected behavior.

Excellent. Glad I'm not just adding test bloat for now reason.

-Stolee
