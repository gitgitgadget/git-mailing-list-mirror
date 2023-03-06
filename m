Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DB1C64EC4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 21:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCFVpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 16:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjCFVpU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 16:45:20 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1D84390D
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 13:45:19 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id pl10-20020a17090b268a00b00239ed042afcso7015646pjb.4
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 13:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678139118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hlcFvu3YenTpWWGAMh0pTGytzU8jfMSN1GVG0Gn3Ik=;
        b=mCoI+XzirgAt+hOGWFr1l7a+JgrJmBp9umLVX68vPnsmOC4IDmcsu7emJPeMEiaC7W
         yT19BWiP9X6iX8obQQrS2gCDVM4eHu7LAmP7QPcHpQockdgGOYZMP4v3/pORhYM8mgme
         dpFqZyUfbWSyusltmyg5CS3MClrXj2imZDv7aYK/KxVhJ/w5xY1d6t1y7Z0mjQ8DE/TR
         VxIMCRbhaiIJrdlhGY7BkBJ5wAi1b0eycutyq+GePittjHOG4NUDOFwlL8uD+9/ch6qB
         l6G4J6kPS7AZ4OkHc+r6KJQigqP/kqc3w9pz/+pLRn6+S8dmgeDjPG8fmJp3sQqHbV+V
         HXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678139118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hlcFvu3YenTpWWGAMh0pTGytzU8jfMSN1GVG0Gn3Ik=;
        b=i5AhjDB+nX1bJckBCFWl1dE6ioiO/yYiUizgf4O4CSr/3alCJzV8o/+W30xeKp6c7n
         3IbJYAvEn5As4v3JJvlXgbE0V0JBgWb1Bc+zFSUEmO3RSJNn0poRpBVabSMeiIf5aEe1
         C7amI37POc+61SflhBEKGZHAf05ZcLO3jdLmndXZCgq2myqgdtarnXqY/MqC3fvc8fRT
         3bK6M6X93GFy/tiXnVDvFgcpyTn79KTrn9eC70GZvkHUMgLHRPd5/rOxNFjntty/x1XN
         BQ4Hg27szCp/xqghTd/Y4Sz12iP+zX5ZaXtbOEv4Cb7K9OIpZ8sjBYYC/pa7TScB6QnR
         Vifg==
X-Gm-Message-State: AO0yUKXsyIdK4uPZpqjjZQ2L/w16S0e1k4iSRZC5ZUZG5mxR2MfTBEGx
        7tK1uVVcSTJyCKg6dKGsfw0s2poBIa7Paw==
X-Google-Smtp-Source: AK7set/ewKWCw+huu65T6N3O0VOyVy971XMZXy/JL1gXii0g3dMX0m6K4KACLYuEyqVsApSgGgVeMgHJSz2JVQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:903:44e:b0:19a:f63a:47db with SMTP id
 iw14-20020a170903044e00b0019af63a47dbmr4996403plb.2.1678139118645; Mon, 06
 Mar 2023 13:45:18 -0800 (PST)
Date:   Mon, 06 Mar 2023 13:45:16 -0800
In-Reply-To: <20230306195756.3399115-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20230306195756.3399115-1-jonathantanmy@google.com>
Message-ID: <kl6l356heeqb.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 0/6] [RFC] config.c: use struct for config reading state
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>  * We could create a new kind of "config_fn_t" that accepts "struct
>>    config_reader", e.g.
>>    
>>    typedef int (*config_fn_t)(const char *var, const char *val, void *data);
>>    +typedef int (*config_state_fn_t)(const struct config_reader *reader,
>>    const char *var, const char *val, void *data);
>>    
>>    and only adjust the callers that would actually reference "reader". This
>>    is less churn, but I couldn't find a great way to do this kind of
>>    'switching between config callback types' elegantly.
>
> To reduce churn, one thing that could be done alongside is to convert
> config-using code (which is...practically the rest of Git) to start
> using the configset interface (we seem to be using configsets internally
> anyway, as evidenced by repo_config()). That way, we would reduce the
> number of implementations of config_fn_t.

By configset interface, I believe you mean the O(1) lookup functions
like git_config_get_int() (which rely on the value being cached, but
don't necessarily accept "struct config_set" as an arg)? I think that
makes sense both from a performance and maintenance perspective.

>> = Questions
>> 
>>  * Is this worth merging without the extra work? There are some cleanups in
>>    this series that could make it valuable, but there are also some hacks
>>    (see 4/6) that aren't so great.
> I don't see 4/6 as a hack. It is true that the nature of the config_fn_t
> callback could change so that passing the reader would end up being
> done in yet another different way, but firstly, I don't think that will
> happen for quite some time, and secondly, it might not happen at all
> (right now, I think what's most likely to happen is that the rest of the
> Git code moves to configsets and only a fraction of the Git code would
> need to do low-level parsing, which would not have a problem passing the
> reader through the data object since they would probably need to pass
> other context anyway).

Given how painful it is to change the config_fn_t signature, I think it
is important to get as right as possible the first time. After I sent
this out, I thought of yet another possible config_fn_t signature
(since most callbacks only need diagnostic information, we could pass
"struct key_value_info" instead of the more privileged "struct
config_reader"), but given how many functions we'd have to change, it
seemed extremely difficult to even begin experimenting with this
different signature.

So I think you're right that we'd want to start by removing as many
config_fn_t implementations as possible. Perhaps we'd also want to
consider creating new abstractions for other situations where the key is
not known, e.g. "remote.<name>" and "branch.<name>".
