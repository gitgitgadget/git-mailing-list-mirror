Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D7DC35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 02:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E8720661
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 02:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="OclrTzeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgBFCvd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 21:51:33 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:41154 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgBFCvd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 21:51:33 -0500
Received: by mail-pl1-f173.google.com with SMTP id t14so1703110plr.8
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 18:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wLXudRl3wPZJYgVgUjv7NNzrAn17+SWvYgRjWzY4unQ=;
        b=OclrTzeoWVNXJQRfYXtfc7DiYyovxqNlFjc6xTWBmESkpn8nfQF5z9L4Sz0JbxHa4C
         Du78N/qBTyDN8yQtzF3jc4RwXB46dlvYxyzrxZB2OLAhoCIgza9AaPAhWZYO+iFY7q9e
         Y/lkst6ha4UKMZgkhx8DSVRlBQqQmSwbqJE9Ff7SIipZZjV3ilmoSUwybUXSbz+VvLKP
         Okqc0dY6Ax5YRaCwmPi7wUkDjQ2Ym5G+ypJ01lQYtfyTbu/kuR5ZveUhkOL4Tl6pLKCE
         NVONt6q1nKDMyxOEFmgGVViUkWEvLD7B5aU/rGs/wM2KiAMX6H5lDkfdurDaNqeJFnZ5
         xXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wLXudRl3wPZJYgVgUjv7NNzrAn17+SWvYgRjWzY4unQ=;
        b=ZnnHvmqTOBoIVb1/HXEGZ/e2mMhu+5Uki1EZQLm4WiMUqvwYM+ZrDiH3eko3Ur0SzE
         TfEL+5uwK/1AY6qGPzK/cm24lD/T4vQLpZVHkT/wnisW5BzxA9quifuSSo8enNreM6Ao
         jCE0jcdIkNxnJJ9dvR2CZcgGoPuyjxxpbM9Be89WUFMnIUdRSGSe3bNzYzjG1rmgg+Tb
         NXAEITSS0kkgW4nFM/W3SeGWwRRkwjEViM8dWpsvt0Bi6V1ADXGHolufrhajkEqSHTw8
         LwYpu1bsaOCW4W08CEYkTSihi1v/9DiCasCaSWrNvVBwJ3AsshtMX/Z9iiDnq+HXL2Jj
         CpGw==
X-Gm-Message-State: APjAAAWb4bCzvsCPHUNLD77gApvtN0Y6XmR0LkVIZ1GHByuAFNLZ9hLN
        UoEt0nJ7JTWOm47qstmK4HlnZQ==
X-Google-Smtp-Source: APXvYqztpVGwvq8CJ0Eui9P3XVwTx+j0Yz4hMA8Hvgaqi0WruIfW13c/WywvK/7oX+Jkve69Ezq1fA==
X-Received: by 2002:a17:90a:2223:: with SMTP id c32mr1643027pje.15.1580957492599;
        Wed, 05 Feb 2020 18:51:32 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:b864:71ea:bf75:81e6])
        by smtp.gmail.com with ESMTPSA id a69sm874466pfa.129.2020.02.05.18.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 18:51:32 -0800 (PST)
Date:   Wed, 5 Feb 2020 18:51:30 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, martin.agren@gmail.com
Subject: Re: What's cooking in git.git (Feb 2020, #01; Wed, 5)
Message-ID: <20200206025130.GA22748@syl.local>
References: <xmqqpnesfw74.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqpnesfw74.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Feb 05, 2020 at 03:31:11PM -0800, Junio C Hamano wrote:
> * tb/commit-graph-object-dir (2020-02-04) 5 commits
>  - commit-graph.h: use odb in 'load_commit_graph_one_fd_st'
>  - commit-graph.c: remove path normalization, comparison
>  - commit-graph.h: store object directory in 'struct commit_graph'
>  - commit-graph.h: store an odb in 'struct write_commit_graph_context'
>  - t5318: don't pass non-object directory to '--object-dir'
>  (this branch is used by tb/commit-graph-split-merge.)
>
>  The code to compute the commit-graph has been taught to use a more
>  robust way to tell if two object directories refer to the same
>  thing.
>
>  Will merge to 'next'.

This topic is ready to go. We've been using this at GitHub for a few
days without any issue, but we weren't users of '--object-dir' to begin
with, so take our usage with a grain of salt, I suppose :-).

> * tb/commit-graph-split-merge (2020-02-05) 3 commits
>  - builtin/commit-graph.c: support '--input=none'
>  - builtin/commit-graph.c: introduce '--input=<source>'
>  - builtin/commit-graph.c: support '--split[=<strategy>]'
>  (this branch uses tb/commit-graph-object-dir.)
>
>  The code to write out the commit-graph has been taught a few
>  options to control if the resulting graph chains should be merged
>  or a single new incremental graph is created.
>
>  Will merge to 'next'?

I think that this is ready. Martin Ågren and I discussed a little bit
about the rationale behind why the new options were chosen over
alternatives, but I think we reached consensus (at least, the thread has
been quiet for a few days after sending 'v2').

So, if you're asking whether or not this is ready to merge to 'next',
I'd say that it is, but I'd like to hear from Martin's thoughts, too.
(For what it's worth, we're *also* running this at GitHub, and without
issue).

Thanks,
Taylor
