Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9415C433E3
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 14:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 875042054F
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 14:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ar0XHfzd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgH0Oy3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgH0NLt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 09:11:49 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E44C06121B
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 06:03:00 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id p4so5762268qkf.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 06:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ng+4gbgXryNz3wSaxOnA0VwuFYP9p22kBm9GVSQpyV4=;
        b=ar0XHfzdcXGSvBGmMb3gH1DO2WhXvjItm/FsR2CZOYX6uSCgZ1K40RNpb3vW670Y6L
         ynnl53IMYMOEJ/xKDWm55ZMdFO/b87PEBWoKvf5TN+0s+aBEQ5TLw+loGj1mpVHNW7MV
         XdFsk0oU/Yvhk5K+DqsXY37ncOU5PENhUz+9EQsJ6oXycI7DvY9a+zdJrShok+vSffrs
         DOkdt98JT9bKAaEf7LqAQ4LTmiv5GQUUS1+6m3kxQv4ACkHM7/TT0DiQHfi3m9wUupn8
         mqs1wv/WBqB9/3zKXNagzlHhYRDDtZi24VyjhVXWr/u/OaYcqHj5GxF/bj34bA7vJ0/4
         lxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ng+4gbgXryNz3wSaxOnA0VwuFYP9p22kBm9GVSQpyV4=;
        b=VV+kytTj+ZR53vIYdQmXpsISisLKOvNlmBfszZ93EhT8++8QZbK2bU550BdmKdhtlv
         tanmz7XC2xdb4H3nNdS8g9sUWkret77WRtfv/HKJvwRRqRxTa6BCjIXguQbTpgQqrvZl
         bgSGD3X7tlHUlGbePF1mQA3UMLZ2l/MwO0AHxJil6uGbCprjsuRNaD3FLnm8fNt+4TUD
         WdYKqfJGcUtiiV3dDacKww33sVX9K8G4MAR+88PchseeDtr+Fsv2YLo3JFxK9pfHg7B/
         D0wFyCIhwDoXupUG8XwQ48i6loMqNYA+oxp2hYt2hUSvboZUdIaWfa2XNDzkMow3OFeW
         9+7w==
X-Gm-Message-State: AOAM530beey+ZqIFU7LFyHq1H/4mEXo82GC9NGiTV7WZq2+e4QmhF/m6
        R5l42Y1I1MbeB4c04zNSt4c=
X-Google-Smtp-Source: ABdhPJzTt44T4hyu36g1DYY4XzeVk5xnxqoy5QBPUoQ7AaiSiaQfyoL58HXbaWEg+y1bxz1nqEBliQ==
X-Received: by 2002:a37:9b8f:: with SMTP id d137mr541911qke.459.1598533379469;
        Thu, 27 Aug 2020 06:02:59 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:b932:a679:4c12:1a2a? ([2600:1700:e72:80a0:b932:a679:4c12:1a2a])
        by smtp.gmail.com with ESMTPSA id u7sm1754531qkm.20.2020.08.27.06.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 06:02:58 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] maintenance: store the "last run" time in config
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
 <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
 <e3ef0b9bea4a31c72ce88841639e88355408f0c1.1598380805.git.gitgitgadget@gmail.com>
 <xmqqh7sqz93k.fsf@gitster.c.googlers.com>
 <4fe41132-c8f5-6b85-414f-5a1e5fcccdc9@gmail.com>
 <xmqqzh6huyoi.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c30d745f-4d30-0404-420f-2009870da95b@gmail.com>
Date:   Thu, 27 Aug 2020 09:02:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <xmqqzh6huyoi.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/26/2020 1:03 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>>>  1. The time the task takes to execute should not contribute to the
>>>>     interval between running the tasks.
>>>
>>> ... as long as the run time is sufficiently shorter than the
>>> interval, that is.  If a task takes 10-30 minutes depending on how
>>> dirty the repository is, it does not make sense to even try to run
>>> it every 15 minutes.
>>
>> Definitely. The lock on the object database from earlier prevents these
>> longer-than-anticipated tasks from stacking.
> 
> Hmph, I actually was (anticipating|hoping) that you would give a
> good argument for having maintenance subsystem in change of
> scheduling rather than cron, as it can monitor how the already
> running job is goind and skip one cycle if needed.  The above is
> instead a good argument that independent cron jobs can still
> coordinate and there is no central and custom scheduler in the form
> of 'maintenance run'.

While the lock does prevent concurrent 'maintenance run' commands
from colliding and causing unpredictable behavior as they both
modify the object database, this does not help ensure that maintenance
tasks actually happen if certain tasks are fired independently by
cron and consistently collide.

This is the main motivation for me using a single crontab entry.
More discussion of all of the tradeoffs is in [1].

[1] https://lore.kernel.org/git/bd4e18b7-6265-73e7-bc1a-a7d647eafd0a@gmail.com/

>>>>  2. If the task fails for some unforseen reason, it would be good to
>>>>     indicate that we _attempted_ the task at a certain timestamp. This
>>>>     will avoid spamming a repository that is in a bad state.
>>>
>>> Absolutely.
> 
> Somebody already mentioned that using the configuration file for
> recordkeeping may not be a good idea, and I tend to agree, by the
> way.  I may want to periodically take a snapshot of my configuration
> to notice and remember changes I made myself intentionally
> (e.g. switched access method of a hosting site from ssh:// to
> https://, added a new branch that builds on something else, etc.) by
> comparing the snapshot with previous ones (and might even put it
> under version-control) and mechanical noise would interfere with it.
 
I will think of another way to handle this, then. If we cannot infer
that "this task was launched, therefore it is due to run" from an
optimal cron schedule, then I'll probably create a new file in the
.git repository that stores these values. That file would be in the
config format to make parsing easy.

Thanks,
-Stolee
