Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A884FC4332F
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 21:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiJFVOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 17:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiJFVOm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 17:14:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F4313D13
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 14:14:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bj12so7236891ejb.13
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 14:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/H5s7PR5rLaBmZuDEbu+64EEC5Aq9w/YPRLRYoS6Kk=;
        b=LSIcw/rsgJxXNd1AwjTLAePCtdSdVa52lNnGWbBG/vRgiWPB05uaT/iQeunPujP4zR
         3Hh70SaepNseUaKnPgyq2Gy5jXftwR6yhz01jSoB9CIxJ9QtU4fZUYoN/LbkB6J24Rpw
         ex8u5jbjdHgAA0If/ieXl/vNQ6gGhgFpFkPAxuDhfOTzLCpeyIbU/5mB7aGwhHDx+n5V
         ukbTLRrzbnBXrSwyrFquVK9bMyra/EQvNYkRwSPMTZW/FlLUIJaLDcauIXpRBd40C/XR
         5h515VpvLezpofsF3gwBwsEymlk5G6rtvKppar3Y46u+BiU8PvHS4Lm4RoqWUS70ydgc
         WkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/H5s7PR5rLaBmZuDEbu+64EEC5Aq9w/YPRLRYoS6Kk=;
        b=26+RgSqHtrj3LrxKlE4F569aWv4QOW8tlEmfX2SLecYUuD6C7Pi1hevQRsTVJoSS5f
         QeJVtr8MGuHVudLTZqzlX2FsgyUDk+jhxWiJRcCgvVcNjtIia6U0CMCjwlliJzDbUoVx
         ZFHdqK0dFdS+EKlJr/sWt48a6rQ8uzhXUHj26E+DtJyNFYW0IcpMoTU+TFyyfxTR2Cd3
         SxJ7N1mLlqzTbxfc82+Qas5RXLbrlQjcmzSzdAKLPc6931L1Pl7QMSFdUaDQyvxB8kyA
         gEABeM7fwoErhZ1yWq2POFBmqJALo6YAjWIebCUp3wJLaTzYU0MJeCOw1M2E4/fpOm/u
         dn5w==
X-Gm-Message-State: ACrzQf3hf0wmVQrsRxDAx8PfZKgExvy9FU2ArWNVkmic3pKZANiNzpsl
        SNm1sG3KcNYycV8hDqPTOi0=
X-Google-Smtp-Source: AMsMyM4KG/VZdpQiXXrsmj8GBXWqGxdQLU2tEx+7+Ae+7i8Kzuth1hm0Gdot5tnqmLjZI6eRkwjxAA==
X-Received: by 2002:a17:906:5d0d:b0:783:10cb:2829 with SMTP id g13-20020a1709065d0d00b0078310cb2829mr1462060ejt.209.1665090879348;
        Thu, 06 Oct 2022 14:14:39 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b20-20020a17090630d400b0077f20a722dfsm191301ejb.165.2022.10.06.14.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 14:14:38 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ogYCU-0035KV-05;
        Thu, 06 Oct 2022 23:14:38 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 6/9] trace2: convert ctx.thread_name to flex array
Date:   Thu, 06 Oct 2022 23:05:12 +0200
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
 <6492b6d2b989e08bb539fff3ffe5bdf50fa0a195.1664900407.git.gitgitgadget@gmail.com>
 <xmqq7d1eqhbf.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqq7d1eqhbf.fsf@gitster.g>
Message-ID: <221006.86ilkwr6wy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 05 2022, Junio C Hamano wrote:

> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Convert the `tr2tls_thread_ctx.thread_name` field from a `strbuf`
>> to a "flex array" at the end of the context structure.
>>
>> The `thread_name` field is a constant string that is constructed when
>> the context is created.  Using a (non-const) `strbuf` structure for it
>> caused some confusion in the past because it implied that someone
>> could rename a thread after it was created.  That usage was not
>> intended.  Changing it to a "flex array" will hopefully make the
>> intent more clear.
>
> Surely, "const struct strbuf name;" member would be an oxymoron, and
> I agree that this should follow "use strbuf as an easy-to-work-with
> mechanism to come up with a string, and bake the final value into a
> struct as a member of type 'const char []'" pattern.
>
> I recall saying why I thought the flex array was overkill, though.
>
> You have been storing an up-to-24-byte human readable name by
> embedding a strbuf that has two size_t plus a pointer (i.e. 24-bytes
> even on Windows), and as TR2_MAX_THREAD_NAME is capped at 24 bytes
> anyway, an embedded fixed-size thread_name[TR2_MAX_THREAD_NAME+1]
> member may be the simplest thing to do, I suspect.
>
> If we were to allow arbitrarily long thread_name[], which may not be
> a bad thing to do (e.g. we do not have to worry about truncation
> making two names ambiguous, for example), then the flex array is the
> right direction to go in, though.

We don't even need that, AFAICT. My reply at [1] is rather long, but the
tl;dr is that the interface for this API is:
	
	$ git grep '^\s+trace2_thread_start'
	Documentation/technical/api-trace2.txt: trace2_thread_start("preload_thread");
	builtin/fsmonitor--daemon.c:    trace2_thread_start("fsm-health");
	builtin/fsmonitor--daemon.c:    trace2_thread_start("fsm-listen");
	compat/simple-ipc/ipc-unix-socket.c:    trace2_thread_start("ipc-worker");
	compat/simple-ipc/ipc-unix-socket.c:    trace2_thread_start("ipc-accept");
	compat/simple-ipc/ipc-win32.c:  trace2_thread_start("ipc-server");
	t/helper/test-fsmonitor-client.c:       trace2_thread_start("hammer");
	t/helper/test-simple-ipc.c:     trace2_thread_start("multiple");
	trace2.h:       trace2_thread_start_fl((thread_hint), __FILE__, __LINE__)

And we are taking e.g. "preload_thread" and turning it into strings like
these, and saving it into "struct tr2tls_thread_ctx".

	"preload_thread", // main thread
	"th01:preload_thread", // 1st thread
	"th02:preload_thread" // 2nd thread
	[...]

So, we don't need to strdup() and store that "preload_thread" anywhere.
It's already a constant string we have hardcoded in the program. We just
need to save a pointer to it.

Then we just format the "%s" or (if ".thread_id" == 0) or "th%02d:%s"
(if ".thread_id" > 0) on-the-fly, the two codepaths that end up using
this are already using strbuf_addf(), so just adding to the format there
is easy.

1. https://lore.kernel.org/git/221005.86y1tus9ps.gmgdl@evledraar.gmail.com/
