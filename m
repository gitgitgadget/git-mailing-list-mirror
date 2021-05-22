Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B63BC2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 19:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60CBE61073
	for <git@archiver.kernel.org>; Sat, 22 May 2021 19:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhEVTRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 15:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhEVTRU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 15:17:20 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59C9C061574
        for <git@vger.kernel.org>; Sat, 22 May 2021 12:15:54 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id eb9so12221770qvb.6
        for <git@vger.kernel.org>; Sat, 22 May 2021 12:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jGgO54k9il1uJGSa1/vxJ7wVKxDKjpNRwzOluR12sUQ=;
        b=A5LesfKtTPNxVi+gKBumAHGIwRCWlI3Il1PaB+ItD1Ix/VEcI9YParxqWFc1IsHCJE
         o4gXRScvqHBoR7RiyeqzuI55LYSG3Ctq1z6M9+zPgbSUQe7vCxLQSuwW1HNStamvZ0WD
         eM3PZvNFqcgtD8T9pr/iIHw1eE6b3i3DFsGNqFatpFJzE98vsMCklcAj/dE3CA3LggEG
         IdiJ2lEuSkN/Y7VPqVsEPIRRbe8ZlD7cPqIQjwqiHf9qMpB6Yp4hrBxp3dEPfvH5+vNp
         J02WFVd6pkuiV+14YMrCrCh4I7MPYO3s6+xuwmLWFckTlR3wUj7p1THYPo2ex0OJfAuo
         vnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jGgO54k9il1uJGSa1/vxJ7wVKxDKjpNRwzOluR12sUQ=;
        b=IYlobhbpcOOZMKAD7rgKRttlzSJdSrgDMmZwPy4o+7cxRaXr2889hC8PMomW092/xG
         k7/+esmhUX6h+WxYjbsIR2a4XhU8hfLW6JoYSSsqmeKWIGWeHT8LWm5xOwqVdKUGlQ4e
         oJ+QaCRvcTKEm7MurtuM31oRAHO3MOx2vP/aCYPS51hvSClegeJdmbVmZPed4U7o+C89
         q3hd0kukcsigrpbjcO/khq94xIXD9NDBMG/QE/BAVBQI3Tltq8hv6ZFaWn3T4SnAH6JK
         iklwV2dHe74c5SBcoNgayTB1sQ2ekXeMDhXuIyal+tw5HTxU3oBnqkh0gmbiynbG+b4Z
         8jNA==
X-Gm-Message-State: AOAM532EAzzKT7zHbhsna7wn3Xwtiph/875Ma+0FqOWiH3dUCZScMKf6
        0Wftp6x/DugyHIrBogOc+NRDdVi9AFGVRQ==
X-Google-Smtp-Source: ABdhPJwDfelH8WDKNLRhRt/pHTOb8wT2O9l5t34+rGPaVe1vG+0fMlPwlVpOgaJXVN6oAkCQWseDvA==
X-Received: by 2002:ad4:42b3:: with SMTP id e19mr20968824qvr.62.1621710953747;
        Sat, 22 May 2021 12:15:53 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id 7sm7358448qkd.20.2021.05.22.12.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 12:15:53 -0700 (PDT)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: Bug in git submodule update --remote
To:     Ben Avison <bavison@riscosopen.org>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
References: <c4b27662-1228-a1ff-26fc-637897ffc8e7@riscosopen.org>
 <EB55447C-538F-44DE-BFC0-A3BD1A970E99@gmail.com>
 <a727c1af-4993-684d-d299-00bf1a47cfc7@riscosopen.org>
Message-ID: <ae3baa2a-2f30-8e8a-f3cf-d8210e7225b0@gmail.com>
Date:   Sat, 22 May 2021 15:15:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <a727c1af-4993-684d-d299-00bf1a47cfc7@riscosopen.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

Le 2021-05-19 à 10:41, Ben Avison a écrit :
> On 19/05/2021 11:49, Atharva Raykar wrote:
>> If I understood you correctly, you'd prefer that the updating of the
>> submodule should be independent of the ref that is checked out in the
>> submodule's directory.
>>
>> While I am not sure of the reason why the design of 'update
>> --remote' uses the remote-tracking branch of the submodule, I can
>> imagine adding a switch like 'submodule.<name>.remote' that defaults
>> to 'origin'. Then the behaviour could be changed such that it always
>> pulls from the remote specified in that option.
>>
>> This would help make the behaviour consistent in all the cases you
>> mentioned, while also giving the option for a user to update the
>> submodule from the remote of their choice (which may not be origin).
> 
> I like that solution. 

I also think a new config is a good solution.

> Although, I should note that if the user has set
> submodule.<name>.remote to something other than 'origin', they will need
> to ensure that submodule.<name>.branch is also set, or they will still
> hit the "Unable to find current <remote>/HEAD revision in submodule"
> error that I initially stumbled on.
> 
> How about an implementation like the following? I introduced a new "git
> submodule--helper" command rather than modify "print-default-remote" for
> a couple of reasons:
> 
> 1) "print-default-remote" is also used for "git submodule sync" (I'm not
> sure if we should change its behaviour too)
> 
> 2) "print-default-remote" needs to be executed from within the
> submodule, and takes no arguments, whereas I need to parse the
> superproject's .git/config so need to be executed from the superproject
> and take the submodule path as an argument
> 
> The two functions I added are heavily based on "git submodule--helper
> remote-branch". However:
> 
> * Unlike with the branch name, I don't fall back to using the name for
> the remote cached from when we read the .gitmodules file, if it isn't
> found in .git/config. It doesn't make sense to me for the .gitmodules
> file to include this information, as any new clones will only contain
> "origin" remotes anyway.
> 
> * I removed "struct strbuf sb" since I don't think it's used.
> 
> Ben

I think that we would want to careful examine every use of 'get_default_remote'
(and the NEEDSWORK in submodule.c:get_next_submodule)
and decide for each one if it makes sense to respect that new config before failing
back to 'origin'. So I'm not sure about the approach here since it just fixes the behaviour
for 'git submodule update --remote' but not other scenarios where the user would like
another remote than 'origin' to be used for some operations in the submodule.

There was also another bug report recently [1] around the new 'clone.defaultRemoteName'
config and 'git submodule update --remote', so it might be good to also keep that in
mind when working on a solution.

Cheers,

Philippe.
P.S. I've CC'ed Emily who has plans for a big overhaul of submodule functionality
over the next months [2] so might be interested.

[1] https://lore.kernel.org/git/2d58fe40-9e8c-4653-8170-5411fd3cf6f4@www.fastmail.com/t/#u
[2] https://lore.kernel.org/git/0fc5c0f7-52f7-fb36-f654-ff5223a8809b@gmail.com/t/#u
