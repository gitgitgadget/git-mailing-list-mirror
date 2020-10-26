Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD57C55178
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 10:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCAAB20791
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 10:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4XPbmHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770046AbgJZKiV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 06:38:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34910 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1770044AbgJZKg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 06:36:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id h22so811874wmb.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 03:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4RhNkVpBxyAZswterqxOiZaTNdbD52LLzMOXXRFNEaE=;
        b=Z4XPbmHnk39p21cGuj/0v0yEgXyC4t+11gTP1+BOsAjVmls++vM4s6lp4M/VVJCxg/
         NnCYM8ZqUizp+fozZVQ3Jail8AWPkjPqwwf9od32B4rL5HGrF+XwYhC5j7PoyNEVPWQU
         s/QHWWZrGpw5L3oINS1K2/kOxMbtaNs/eTXC1qOqPo+1/+lrEiWpWte08hPkLT+RUpFT
         3mcWn7S3378MxcLtGH0MdHct+qJIH3YIcxF7L+2dBAe+r28zk10H8Zm4XrDu0NGE0mIN
         Qmhd3wQ7SHgEN9Vtn6va/b3aSwqb1TNXH/xp96M2gxUpncA8eslfK4nOWOO4vahsRCUq
         pqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4RhNkVpBxyAZswterqxOiZaTNdbD52LLzMOXXRFNEaE=;
        b=UDKXwFp9xu0uxDxZvWheI3/mTB2X17qcOIILwE5DDesckO6y2VRPrug/Z/szOSep8d
         LMmKgP2j+JeuNV6HKsupM1z5KQ4PBrsLEdaolIKRQUvI1Cz4xeEyVEiJLPmQY14p5i1R
         Fu5EciLrV57wxB7yk2MNvqJNebDJ5Qz1EocdwVmu6UL8udVRp1AzvF/Wy9P1xqMVECxC
         Jf/PX8TFi+itKy+eC2BshcxNC9CtlITU9JPoPMzogB1ZGHPC93Npc+tnZ7vVgzbqPZyo
         +XErlxjP91ov1S0/r9N/I0AwW5axKcA5+OxgWD/rVz224egpjw+xPO1bsSoIYYwr42YR
         NZ/Q==
X-Gm-Message-State: AOAM532VCSohX3AWINy/jBoiuwpezn12R26TrS8E2dznHPD3HfDYxHj+
        In5hcqEsZYk++QKtXch0Y1A=
X-Google-Smtp-Source: ABdhPJw3ou+rvHoqPmG0vUVYzzidFSfPE/lA7VNQruSKogNaH15a4o29L5xSn9ww0iS10AhJ+3NZlQ==
X-Received: by 2002:a7b:c8d4:: with SMTP id f20mr14866321wml.36.1603708615716;
        Mon, 26 Oct 2020 03:36:55 -0700 (PDT)
Received: from [192.168.1.201] (13.45.90.146.dyn.plus.net. [146.90.45.13])
        by smtp.googlemail.com with ESMTPSA id z5sm10337281wrw.87.2020.10.26.03.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 03:36:55 -0700 (PDT)
Subject: Re: [Outreachy]: Help for Outreachy Application
To:     Charvi Mendiratta <charvi077@gmail.com>, git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>
References: <CAPSFM5e9tXx_LuwNK+e1wOjaHb6kiTCEt3WeL851KAbTPNsEow@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <6a2005e7-6b8b-2bf4-91fa-55feadd65897@gmail.com>
Date:   Mon, 26 Oct 2020 10:36:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAPSFM5e9tXx_LuwNK+e1wOjaHb6kiTCEt3WeL851KAbTPNsEow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Charvi

On 25/10/2020 07:43, Charvi Mendiratta wrote:
> Hi Everyone!
> 
> It has been about more than two weeks, since I joined the mailing
> list. Till now I have contributed to the microproject - "Modernize the
> test script" [1] that is accepted by Junio. Also I would like to Thank
> you all for the help and feedback on my first patch series. I learned a
> lot about the git command itself, how to work in a community with the
> mailing list and will try my best to get involved in the review
> discussions.
> 
> I have read the Outreachy projects and am interested in the project
> "Improve droping and rewording commits in Git interactive rebase". I
> spent some time understanding the project and have gone through its
> detailed explanation in the issue[2].

Thanks for your interest in the project

> As mentioned that the first task is to implement --reword option in
> 'git commit'. Regarding this, I am unable to understand how it will
> work upon rebase --autosquash?

The idea is that --autosquash will rearrange the todo list so that the 
reword! commits get squashed into the commits they reword (by changing 
'pick' to 'fixup' or maybe a new command) and the message from the 
reword! commit is used for the new commit rather than the message from 
the original commit that we squash the reword! commit into.

> and regarding the task to include --drop option. In issue[2] it's
> clear to add this as an option in git revert but at the Outreachy page
> in the Internship task section, it's mentioned to implement --drop
> option in git reset. So, there is a bit of confusion regarding the
> correct way to implement.

Yes getting the user interface right for creating the drop commits will 
be part of the project I think.

> I also looked into archives of the mailing list and found the
> patches[3] submitted by Philip for --reword option in git commit and
> need some more pointers about its status and how to start with its
> code ?
> Also, in the issue[2] as commented by Phillip regarding the patches[4]
> that implements reword. I would like to know if I can start with that
> mentioned work, if available.

Whoever takes on this project is very welcome to use my patches as a 
starting point. The code in the patches is sound as far as I know and 
the I believe the test coverage is reasonable (though that would need to 
be checked). They are lacking any documentation and there has been a 
change to the way empty commits are handled by rebase since they were 
written so "rebase -i: always keep empty amend! commits" will need 
looking at and could probably be dropped.

We will also need to decide on the best UI for the --reword idea. My 
patches were developed a couple of years ago before I was aware of 
dscho's idea and so implement a slightly different UI to the one 
outlined in the github issue (they call 'reword!' 'amend!' instead). I'm 
not that keen on adding another option to `git commit` to create yet 
another flavor of fixup commit, we'll need to agree a way forward on that[1]

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/95cc6fb2-d1bc-11de-febe-c2b5c78a6850@gmail.com

> 
> Thanks and Regards,
> Charvi
> 
> [1] https://public-inbox.org/git/20201021124823.2217-1-charvi077@gmail.com/
> [2] https://github.com/gitgitgadget/git/issues/259
> [3]
> https://public-inbox.org/git/pull.736.git.1600695050.gitgitgadget@gmail.com/
> [4] https://github.com/phillipwood/git/commits/wip/rebase-amend
> 

