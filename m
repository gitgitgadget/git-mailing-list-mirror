Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3740FC4727E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 21:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA10A21741
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 21:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIK6d4CF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgIYV0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 17:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIYV03 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 17:26:29 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46D9C0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 14:26:29 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id k133so3654376pgc.7
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 14:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cal9+od6zTExkeN5Jduxv3ENE32d6MOq3rOAMyDO0nU=;
        b=JIK6d4CFZglYKQJC9KhIrsNhfZCw34IJiV2AnGNkfKFdmZkhn3cYwnvqGmwg1FxAhO
         l7N8Yih/yx9O6dHCjshUoTet5h/7oLJWwLUon27X8S+W9HFqh3USJQLh4dY99or9MzlM
         OVgldo0+wkalV+KQrgUDajRCE/qOwRfz66v612OVICB5ZWZDEDY2Wu+MrMHEoouNgSAx
         6rwgm0idHd+AgGvgrSQyhe4Ff2+c9vfvngAERCL5Sha++bIQ/jjiKmaPVvzsGXQReveG
         Kix/E3XVY2RWnnfosmRKWi8p/aot800S0fYZrVHQCPGUgJR6QpWL7dzCqXuA2jXdWIVR
         YAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cal9+od6zTExkeN5Jduxv3ENE32d6MOq3rOAMyDO0nU=;
        b=Yptczaa4MlpdTP9Y1AwhUVRn5F0nErd7VklEfKVKjQQv98gGPrCWL0ftYbT+02hWRs
         2nwYYDEig8idHBDWzq/fNqu6QTFJnJBsjGmxgzhsbVPrcwht/4wt21oZR8uCtZVnVc9h
         4H9vIYn0Z9bA7JUnRk6tZnV7qWIgt8ReYeElqkD3+xgdF6DaolROnolnmg1jyqJ/hLM7
         rRvSmJAf4+bNl9PEzN4iFfWMeU86FWL8+3U/pKTHzTiI/M/B7rynAd1rzj3AZA9BFl9C
         Tiy59COWAzLi9uWfSZs0LSxtDGfxPvFmrP6BsLjCPh27eMsruRRFGbqlXmhG9igaiQFV
         azZA==
X-Gm-Message-State: AOAM532H14qcaeVe0lALPV1BpPUYSY2Dx4FxSV5y43JbPJ2R1VSvggTH
        zjpWVSLhdUQvCyDPm51C608=
X-Google-Smtp-Source: ABdhPJzHmdRl5pYitsXYsTscR4H+5JEdOLmYPbczxdoSjJSHV5UIoSI5kPsrs6mKPAbZ1xzpbz6ZEQ==
X-Received: by 2002:a63:f807:: with SMTP id n7mr688418pgh.311.1601069188984;
        Fri, 25 Sep 2020 14:26:28 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id c127sm3554684pfa.165.2020.09.25.14.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 14:26:28 -0700 (PDT)
Date:   Fri, 25 Sep 2020 14:26:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Konstantin Ryabitsev <mricon@kernel.org>
Cc:     git@vger.kernel.org
Subject: Re: Patchwork housekeeping for: git
Message-ID: <20200925212626.GB1270882@google.com>
References: <160105219546.14506.13918434797892986172.git-patchwork-housekeeping@kernel.org>
 <CAMwyc-SZ_babReRWkSAgegJAQ1mUwzJ27PQVw2RYBzA-r60-dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMwyc-SZ_babReRWkSAgegJAQ1mUwzJ27PQVw2RYBzA-r60-dQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Konstantin Ryabitsev wrote:

> <spock_voice>Do not be alarmed.</>
>
> I enabled the patchwork-bot on the git patchwork project, in order to
> help keep the number of patches shown by default to a saner limit. You
> don't need to do anything in response to these, but I thought you
> should be notified of these changes. Please let me know if you'd
> rather not.

Yay!  Thanks for this.

I don't mind the noise.  If I change my mind later and want to disable
these notifications, where do I flip the knob?

Sincerely,
Jonathan

> On Fri, 25 Sep 2020 at 12:43, <patchwork-bot+git@kernel.org> wrote:
>>
>> Latest series: [v3] bisect: don't use invalid oid as rev when starting (2020-09-25T13:01:28)
>>   Superseding: [v2] bisect: don't use invalid oid as rev when starting (2020-09-24T06:03:44):
>>     [v2] bisect: don't use invalid oid as rev when starting
>>
>>
>> --
>> Deet-doot-dot, I am a bot.
>> https://korg.docs.kernel.org/patchwork/pwbot.html
>>
