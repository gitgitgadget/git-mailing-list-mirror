Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35B6B1F600
	for <e@80x24.org>; Thu, 20 Jul 2017 23:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965410AbdGTXa4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 19:30:56 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34181 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936348AbdGTXaz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 19:30:55 -0400
Received: by mail-pg0-f66.google.com with SMTP id v190so3900626pgv.1
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 16:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UqSu7Tb2hPoz4bzd7U9yc6r/+sX7BE7FVpiTakXRz50=;
        b=lwfjaGznXvAsjuGGcxWOAi/jlELmKINe6PZjgShirKil+gV2iit9tFQlaqH/nPwZbL
         JRZ+kgRF1n5COp+ma1NnBZZcK3HJlltxuJ5Pt8eKsJHaYgQ6Jwi5oQ5KsyR9d5k2dJYx
         uM4WvxgNbVH+Qs5qKuN6cPrEPze7pe8sGwIKK+Ijo4NxPj4LlnzrT9yQPTdis3DmRR2l
         wYU51exry+Qb7curbDzyMbeZZtqeZ1BW+HljsdyN7LeZ0aAVQ0UKAKHT9tz943unXeI9
         tkmRGZRD1HpTQFqZQ7cBCxgnFuKZCqPvoexA/9194G29O6deMeB070I5wJy3eEB3Zuon
         SiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UqSu7Tb2hPoz4bzd7U9yc6r/+sX7BE7FVpiTakXRz50=;
        b=j+nyznh5CKAKoKJTpkWebHQ3GBHvZRWfArk58k+VZfTSZWJ8WLHV+VIE9zkuXFEC/M
         4Td+/KJxBPl74/A0g/Si/1CT/K9D+wYFjD2JQiWbPMG7Wx3jrxmXtBOK4jx2KFEZew3b
         HTPvHRCkHl52uxvQEN3hQy2nqQ7uI8QKDpUDTbQKd89FrDGg12mww1p20aZe1ayvn3V4
         mlxkclczo10DPnbKY+aOxs6gl7JmIPAL9BoGjrMpsAPpNExiEAEuZWI4IVCT+5CXWF6W
         /ee4LxVB1YaYCTbwBSnCoWd3WaWDn/Q1O5m+A3cNQXxUsW7cXQEenCNhCsXATa8lgHIg
         tGQQ==
X-Gm-Message-State: AIVw111H2/YZx2A0qDIM77hLj1FYVUaTHex54jwfEOm4ZOxwSNN/OaXA
        p7LWpF+1bWocMw==
X-Received: by 10.98.23.69 with SMTP id 66mr5575876pfx.305.1500593455271;
        Thu, 20 Jul 2017 16:30:55 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:1531:44e7:de5b:a840])
        by smtp.gmail.com with ESMTPSA id a82sm2928530pfc.120.2017.07.20.16.30.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Jul 2017 16:30:54 -0700 (PDT)
Date:   Thu, 20 Jul 2017 16:30:51 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 21/28] commit_packed_refs(): use a staging file separate
 from the lockfile
Message-ID: <20170720233051.GB159617@aiede.mtv.corp.google.com>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
 <2779ee9a75e75ff80898e51e46d561b8074e0dc2.1497534157.git.mhagger@alum.mit.edu>
 <xmqqy3riiu0f.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3riiu0f.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:

>> We will want to be able to hold the lockfile for `packed-refs` even
>> after we have activated the new values. So use a separate tempfile,
>> `packed-refs.new`, as a place to stage the new contents of the
>> `packed-refs` file. For now this is all done within
>> `commit_packed_refs()`, but that will change shortly.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>
> The layout created by "contrib/workdir/git-new-workdir" will be
> broken by this line of change.  "git worktree" is supposed to know
> that refs/packed-refs is a shared thing and lives in common-dir,
> so it shouldn't be affected.
>
> Do we care about the ancient layout that used symlinks to emulate
> the more modern worktree one?

I think we do care.  In the context of people's changing workflows,
"git worktree" is a relatively new tool.  Breaking the older
git-new-workdir (and tools that emulate it) would affect a large
number of users that don't necessarily know how to clean up the
result.

Thanks,
Jonathan
