Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0C9C2D0C6
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 14:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB47208C4
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 14:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKb13+ia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfL0OxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 09:53:25 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43619 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfL0OxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 09:53:25 -0500
Received: by mail-qk1-f193.google.com with SMTP id t129so21649798qke.10
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 06:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Re0w9q8XtL9nXkkAhrYiroYqXwczjxCndrL5fDeIlTA=;
        b=tKb13+iauehbNSDU9x1BUtEDr6hp/eG90Y8rpPEc9PYjT4SkNxpVDtKNuPK+mOb416
         XodnjpZNqeCoLRAd1psJI9HNukI65SKMydZnqXtz6MYU45kBSn5AwcVtojHtQtjVfgvH
         9U0+AlhKKHbta8aWvAkWAjN7w3D7dKzsK56nzFAFBihRhq/ff+Y5kDBAwV4z7GG4ZGdt
         6o3TasDlR0DdkGnRgOgBboyxx0k6zfADI2FdG2VVmA6hGI9h3jrRRfkVv1HNq3+BC6Os
         TGiFP2n0lopNAuLJGn8o2DA/U6yKABPZFGnIAOTzNKz+s7P6uVvfbSq2NpVBeA9h9GRy
         fcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Re0w9q8XtL9nXkkAhrYiroYqXwczjxCndrL5fDeIlTA=;
        b=e2mwIZuUyPqhFHXY4pVfg96gjHMdF4qov5VX7pcA8AACt7HjO6gcGTKlH8ApRJ8mys
         QKfGy/43WbYap6067jk55vR0BR0uGvW1GavKthRGpeiDcqGpWoEOQs3qlCqPPkjvNqML
         q7Mf9ZH5EgDceTGiBytHByzqz3pI9fdwrtDybCoVt+preC/GQEeaiY+CMLiVclimqYqm
         y42k4A/o3T1LJmqSyyaXWbLsPTzNojiEJUvFMi7BOu0BHFnYqE9yRfPeyPo7Xx3KsKWS
         pk8V0DAjjbM18VBf38UwoscHgHoRtcE880KC/+4HInUKIZJXZHsAcECcshBB8EP8QnwM
         LQ4A==
X-Gm-Message-State: APjAAAWPkhpfUc+ZcBOVpX0tEELUxqJxd9VJr+X722svhdouoI6vr1ZX
        9iETtv4ksvZ3fg/WobSrGRI=
X-Google-Smtp-Source: APXvYqxEkbgsEGjTMv9EkeCs39dPEgQVwkse6Gpd8wYhM29l6Bj1KedlGV/pIQTpWRv9SY9ISSjZvw==
X-Received: by 2002:a05:620a:12cf:: with SMTP id e15mr44763192qkl.120.1577458404137;
        Fri, 27 Dec 2019 06:53:24 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:9d29:38a1:5885:e8b3? ([2001:4898:a800:1010:4e5f:38a1:5885:e8b3])
        by smtp.gmail.com with ESMTPSA id i7sm7451172qkf.38.2019.12.27.06.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2019 06:53:23 -0800 (PST)
Subject: Re: [PATCH 3/3] commit-graph: stop using full rev_info for diffs
To:     Jeff King <peff@peff.net>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>
References: <20191222093036.GA3449072@coredump.intra.peff.net>
 <20191222093222.GC3460818@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <061c6800-1516-ddd9-968d-a1274e93d6a1@gmail.com>
Date:   Fri, 27 Dec 2019 09:53:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191222093222.GC3460818@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/22/2019 4:32 AM, Jeff King wrote:
> When we perform a diff to get the set of changed paths for a commit,
> we initialize a full "struct rev_info" with setup_revisions(). But the
> only part of it we use is the diff_options struct. Besides being overly
> complex, this also leaks memory, as we use the fake argv to
> setup_revisions() create a pending array which is never cleared.
> 
> Let's just use diff_options directly. This reduces the peak heap usage
> of "git commit-graph write --changed-paths" on linux.git from ~4GB to
> ~1.2GB.

In my testing, this went from ~6gb to ~4gb.

I'm guessing that my memory difference is related to how poorly my
packs are repacked/redeltified.

Thanks,
-Stolee

