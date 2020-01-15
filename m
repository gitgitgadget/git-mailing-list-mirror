Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED107C33C9E
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 03:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AD4206D7
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 03:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4YQwXga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgAODno (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 22:43:44 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:40109 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbgAODno (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 22:43:44 -0500
Received: by mail-pf1-f180.google.com with SMTP id q8so7797915pfh.7
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 19:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dvJNMYchpjwXjtPEV7rXODF9d988Vx5zew995NTfOlQ=;
        b=n4YQwXgaA2hW2KUOV9I1VW4nnFePXK57fhSKOP1r6hrC/VmFp3iUW1YfCiVT1PFKB/
         v77M8zFXBNw2dKXirMamiECNL1H+C3p/rlCu6AfvAVwyrG4enKwukn5K1oR+baYcBwk/
         V8iltmXVUweTuJqFVe51eDQVSlMe3E0ySqLBtxPGS3WoqpvzqIZ2h4bRLFsOvoymd34R
         3soNrGffsxHx8OFcHIqc6ZKNO9OoUG1tM78TGyFOqsjPYMm79ACMWLNDe7CSIhIg9H2z
         fZB3yB9tNlYVGZluKShZPbB0NFogV6Jgn2YZhwClUjI4J12vZKC9Gv+Wpfj4oZu8IrkH
         kkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dvJNMYchpjwXjtPEV7rXODF9d988Vx5zew995NTfOlQ=;
        b=GVHqlA/qZOcxBPgg2YBq0E1LbztXxmfdQtv0XRw89zTG6POZm1bvUArd6GqFvcPaCA
         Ye2zbDEeAug1jK7m4EQuldzrWJoNx9au1oA14HcDYy0vHI/NgoR4NylF2tKdW2UHL92b
         RJm+YiJ6RE09wBN5vz45rA7geUMBi9VzABAfcEdZAZaa/TvqziB1n2e6Ou92VRFsCBxZ
         WMKcu2M7O9OmN4W68WUShBe82UW6swuHOA3M8DcQnYmuitAYk+Bnl3dGna7wiwWyUigL
         hhWQlMWs2WUbp/nEm0ppaCu1WpoXx+oI6LnQPCuVh/lS03SJ7fayrcSBgidp+1t1SJmB
         ekow==
X-Gm-Message-State: APjAAAWOfLgmKqMhVFx05dSvJKWrDlBoJuzPVcPSiTOjbFWJ+N4JYL7Y
        TNkBayrZefYH0A4UNh5RMzU=
X-Google-Smtp-Source: APXvYqzRPbOfSFuYKLqsfFIAl8CxGbIG2XSZrqSTbntfcE1thyE4SoKXmhQPQGIcE7ZRwu1ZHCihoA==
X-Received: by 2002:a62:1783:: with SMTP id 125mr29616216pfx.189.1579059823691;
        Tue, 14 Jan 2020 19:43:43 -0800 (PST)
Received: from google.com (240.242.82.34.bc.googleusercontent.com. [34.82.242.240])
        by smtp.gmail.com with ESMTPSA id gc1sm18561906pjb.20.2020.01.14.19.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 19:43:43 -0800 (PST)
Date:   Wed, 15 Jan 2020 03:43:41 +0000
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     1234dev <1234dev@protonmail.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: Can Git repos be hacked or otherwise manipulated?
Message-ID: <20200115034341.GA218782@google.com>
References: <fOv65WlolaWZ638trkwZ6nnWIaRu14wx8bYkLdqzidlHPvhYpg1f6TSa_Z7w7iFEsXSLkMzQ6EYTwo3ggF3oXrDh5U4LM_i2Rzx0BkMh7zI=@protonmail.com>
 <20200114220826.GB3957260@coredump.intra.peff.net>
 <bvMqhQOr4uENl8j2zcFOY0ogJmUqTRofCGyPlPc_xaXQXSP5ds9lgdglXkjTZng9U5WSpo-Uc2_SzCTdpAvLTeruT-tW3GTDkWj9dfLznuM=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bvMqhQOr4uENl8j2zcFOY0ogJmUqTRofCGyPlPc_xaXQXSP5ds9lgdglXkjTZng9U5WSpo-Uc2_SzCTdpAvLTeruT-tW3GTDkWj9dfLznuM=@protonmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

1234dev wrote:
> Jeff King wrote:

>> It is absolutely not safe to run Git commands from a tarball of an
>> untrusted repo. There are many ways to execute arbitrary code specified
>> by a config option, and you'd be getting recipients .git/config.
>> Likewise for hooks.

(By the way, this is an area of active work.  If you'd like to help,
that's welcome. :) See also
https://lore.kernel.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/
and https://lore.kernel.org/git/20191116011125.GG22855@google.com/.)

>> And while we would consider it a bug if you can trigger a memory error
>> by reading a corrupted or malicious on-disk file, that's gotten way
>> less auditing than the code paths which take in objects from a remote.
>> So e.g., I would not be surprised if there are vulnerabilities that
>> could cause out-of-bounds reads of a corrupted .git/index.

Cc-ing Josh Steadmon in case he has pointers for how to add some fuzz
tests to harden this kind of thing.  We definitely want to find any
vulnerabilities in this area.  (In addition to the case of "ask a
friendly sysadmin or member of GitHub tech support to debug my broken
repo", this also would affect any users collaborating on a repository
on a shared filesystem.)

[...]
> To work around this problem, should we instead host this repo on a
> public service? If so which one would you recommend?

If you want to use ordinary file transfer mechanisms to share a
repository, you can use "git bundle" to create a copy of your Git repo
in a form that is meant to be safe and straightforward to pass around.
See "git help bundle" for more details.

Thanks and hope that helps,
Jonathan
