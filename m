Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8A9C433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 13:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E6D2070E
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 13:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oU97d9oK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgFVNp2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 09:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgFVNp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 09:45:27 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFED5C061573
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 06:45:26 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id s21so15622800oic.9
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 06:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K1qcPmodWU4byqW3B7kTubKdHGYl3Oc+txyM91zs7F8=;
        b=oU97d9oKLSlOjnzJ6Nlk1yy6oiAXOF1rdw/74YRUqovFUSNY85W4SutvV8XwloLSaD
         4BwE9BrWxlyxXmMGSgUzp7iEwvvuvNOzyZH47vTehgz+OpiArxDrRUvZO7A/UmzbPVms
         iCYTx/erLFO5ofShsdeTlO2aEB3suV+ckvQrBPM1jF/Ktvk4RrmUntOaEbnuSzGWd7qE
         58xsrlfS3xb86G3IDH4cH1UWAgHge7dh+zIDI5JoMyyTEDPzcA+afb7OUIcrbqep/n0x
         FbmxmtMpiJFimqor30i9nayMlRt0hOOEWRhFGGEZw2tbkeaMI117hp0vIZzq3CqLcm0v
         MoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K1qcPmodWU4byqW3B7kTubKdHGYl3Oc+txyM91zs7F8=;
        b=ln4BuMOj317JYoJuD3C/o/Qv97mHD80vEZDrIxOrpIR3t/365PjbDJX6RQDpFjpokT
         8+hU4UxMvLAtbF3dzp0ExvZldSvqS+xZaGOE1zNyspj4RQWJiwlr5mhSnrkZujyx05dB
         me+PvzswlazdbQ7pmAisAGcLc0VJ46bEhm455y/iMJ6fk8GnKfhPJjXhpsSzTI5Qe3E7
         1Fy0aBOoBMNNKk5CVWw0Y3IHq5yERIW+Gc2n/UcaHUiH8+0vOeec6aWmtn3ZcG9mgoCL
         lPMTCwB9m5bMWKy9ffCuK2YHYllIwdM0GK40vPauZlJvLlkxVcPS/C52JUWQ1phnc+RD
         CfTg==
X-Gm-Message-State: AOAM5311j3HgKx41dZDgJIu3tUk5bw6FTiDRNCzN/0LTY61sYh50Bc8X
        OWZ0gVWrzeOMq1TV75daC/w=
X-Google-Smtp-Source: ABdhPJyt6b06kcl9LMIpgodsW6goHBwCsfd/WRTjE9I87zctds6N8Bsd1axhE2YWZlJ8m/LdMBYLYw==
X-Received: by 2002:aca:4c95:: with SMTP id z143mr12142527oia.43.1592833525964;
        Mon, 22 Jun 2020 06:45:25 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id v14sm3202085oie.20.2020.06.22.06.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 06:45:25 -0700 (PDT)
Subject: Re: Possible git bug in commit-graph: "invalid commit position"
To:     Michael Forney <mforney@mforney.org>,
        Alex Riesen <alexander.riesen@cetitec.com>
Cc:     git@vger.kernel.org, Gary Oberbrunner <garyo@oberbrunner.com>
References: <CAFChFygiaMsUJC5Kfpnk26DLWbY0gPdNJpZ_gLMf4utZ6_oZxA@mail.gmail.com>
 <CAFChFyi5J-mb+rshtF7U2m=MtPzEPUa+V1_qbEXC=-LdQ218yA@mail.gmail.com>
 <d4313777-ce8c-0b64-997e-17cb719c9ab8@gmail.com>
 <CAFChFyhZYm88cCo6X_XikT=HRQG9Pp0vyveXmAuComFUJYjRcA@mail.gmail.com>
 <20200515120333.GA4677@pflmari>
 <CAGw6cBuEshq18O_PrrGYuJi5VZ82XK3T9KuShneUqO2Ju0jtHw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0f03151c-d8ec-effc-a8f9-c4a3fc1325c7@gmail.com>
Date:   Mon, 22 Jun 2020 09:45:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <CAGw6cBuEshq18O_PrrGYuJi5VZ82XK3T9KuShneUqO2Ju0jtHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/21/2020 4:45 PM, Michael Forney wrote:
> On 2020-05-15, Alex Riesen <alexander.riesen@cetitec.com> wrote:
>> Gary Oberbrunner, Tue, Feb 04, 2020 23:33:42 +0100:
>>> Sorry for the long reply delay; the bug went away and only just showed
>>> up again. Here's the info you requested.
>>> I'm now running git 2.25.0.
>>
>> I hit a very similar problem today with 2.26.0. Also in a submodule.
>>
>> Removing and regenerating the commit graph did not help and I did not have
>> the
>> commit-graphs directory (only a file). "git commit-graph verify" does not
>> find
>> anything. Switching writeCommitGraph on and regenerating the commit graph
>> makes no difference.
>>
>> I can trigger it reliably by visiting the broken(?) commit in supermodule
>> with:
>>
>>     git show --submodule=log <commit>
>>
>> I see nothing special in the commit invovled. It is just a single commit in
>> my
>> case, and the commit is a merge of two branches.
> 
> I hit this bug a while back, and it went away after I deleted the
> commit-graph in the submodule and regenerated it (IIRC).
> 
> I just ran into it again (on 2.27.0), and this time, I did some digging.
> 
> I have a repository containing a number of submodules, and the bug
> appeared after I updated one of the submodules, and then looked at
> `git log -p` with diff.submodule = log. Just like Alex, I can reliably
> trigger the error with `git show --submodule=log <commit>`.
> 
> I rebuilt git with some print statements to try to see what's going
> on, and got the following:
> 
> 	/src/oasis/.git/modules/pkg/file/src c81d1ccbf4c224af50e6d556419961dba72666c7
> 		pos: 4986, num_commits: 6452, num_commits_in_base: 0
> 	/src/oasis/.git/modules/pkg/file/src 9f2f793847c6aeab9501287b6847dc842c84630f
> 		pos: 3964, num_commits: 6452, num_commits_in_base: 0
> 	/src/oasis/.git/modules/pkg/file/src fd7eb1f793944635b92bfa56a84a4dc1dbefb119
> 		pos: 6383, num_commits: 6452, num_commits_in_base: 0
> 	/src/oasis/.git/modules/pkg/file/src d955cefc956ba537cfc0556023a65fe80bd2d82b
> 		pos: 5436, num_commits: 6452, num_commits_in_base: 0
> 	/src/oasis/.git/modules/pkg/file/src 0c79c693d6a86f7ad7ada2a9a1eb3bdf483f77cc
> 		pos: 301, num_commits: 6452, num_commits_in_base: 0
> 	.git fa09b87efa9b9664e4e53ab768cfa5f51a6c6fa2
> 		pos: 6292, num_commits: 5177, num_commits_in_base: 0
> 	fatal: invalid commit position. commit-graph is likely corrupt
> 
> Using `git commit-graph verify`, I confirmed that the main
> repository's commit graph contains 5177 commits, and the submodule
> repository's commit-graph contains 6452 commits. Commit fa09b8 is part
> of the submodule, not the main repository, so it makes sense that it
> is an invalid commit for the main repositories commit-graph.
> 
> So, this seems a little fishy. fill_commit_in_graph is getting called
> with the main repository and a commit belonging to the submodule.
> Looking through the call stack in gdb, I see that the initial calls to
> fill_commit_in_graph come from show_submodule_header, which computes
> left, right, and merge_bases. Then, those commits are passed to
> prepare_submodule_summary, but this function does *not* accept a
> submodule parameter. prepare_submodule_summary calls
> repo_init_revisions with the_repository, which seems to be the source
> of the problem. I think it should be using the submodule repository
> instead.
> 
> I changed prepare_submodule_summary to accept a repository and to use
> that instead, but the issue persisted. Digging deeper, this is because
> revision.c:process_parents uses parse_commit_gently, which is a
> synonym for repo_parse_commit_gently(the_repository, ...). I changed
> it to use repo_parse_commit_gently(revs->repo, ...), and this time,
> the problem went away.
> 
> I'm not very familiar with the git codebase, but am I on the right
> track here? I also noticed a number of other calls to
> parse_commit_gently in revision.c, and I think those should pass
> revs->repo as well. Does that sound right? If so, I can send a patch
> to fix these issues.

This is some good digging, and I think you are absolutely correct
with the root cause. The dependence on the_repository is still
something that is being worked on in the Git codebase (but less
frequently lately) and trips up submodule things like this.

I think a simple method swap would be a good patch to send, and
you can include many of the details above in the commit message.
Is that a contribution you have time to make? I'll gladly review
it.

Thanks,
-Stolee



