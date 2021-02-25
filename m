Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F165AC433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 13:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABA5364EC4
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 13:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhBYNP0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 08:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhBYNPV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 08:15:21 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4E9C061574
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 05:14:41 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id n28so3989073qkk.4
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 05:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ry9kMw1BtP7ejRtM+YOYUCVrJWJewChw+NcTxaktQ9s=;
        b=ZSUyISADwQJtiFU2OpH25aMYK/bdC9xBXe3l1NiG/XfHnqj7Q+l5sD0sbeIQb9AqUo
         dDuMBJ4yhKAl6hYKXukNtueh27vudUKzZkLwvE2FvTEDhonEA/X8xYI8MlGOOjBOvJ10
         YQ9msk8+yN6xVFXAdhMI9ssV7V10y+jOtu/ItwMxPT8DtPYfyhnuZ6E+/z2LbIXWenKS
         kP2sA8JyaGuSRn7tn1Vk9h5r7Evt+uKzEYFJoSmeDb6wYkMiaCMpi6EhCNFskOshjzEM
         IcCl6WlxyA4+v46A1wAPFG2pKlUx2bhFyU0PY6qwjwQKlTd2bI6qBZdTXcq7JQfhYEmM
         ghmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ry9kMw1BtP7ejRtM+YOYUCVrJWJewChw+NcTxaktQ9s=;
        b=A5WEiWXOUQ6gYWUYJinEJncgK8H79bRgnB0gaK4ZDmpRldsdB1qk0C4LketOU91tfr
         wg+SjRJeKWRWmCk/g4ZAo8CnekzqkgpeBVYIm5Rvl3ToMwhZamL5L0QdAlwHCuGRHMyg
         ptIqn5MakujrXFraSq1B/hE+ATMNEW5ZHTV2Xn2z/HjTn7GWoxUjI3aOr5ip67lA3650
         xyojsHvj8HDK8hA1qiVIsJ/xrY9o2ak03L+FUMKh61yZnHr5HxaiUKTkSaXZlBkkrMty
         /SrghAtve9D/1/NZLk69oSzoFjkXvDEbAvkURaTuQHqaY+IAN1ROu/Zm69sbs5PhrFSs
         kfzA==
X-Gm-Message-State: AOAM531OZt7wayiTEcFZ3PQFlff05ZjmtiYleDnjaaadCUvlj/D5i32j
        szMoUXC8CMSVSz9v1rEsfi983uZHRjM=
X-Google-Smtp-Source: ABdhPJwH1y/TqVRxt4xYFtDt2MApZ3ed0lB0Oy7Si1nBmw/cE8sNTymcRwVVBT5eSBsI2X4IaxJIvQ==
X-Received: by 2002:a37:9c4a:: with SMTP id f71mr2559148qke.74.1614258880332;
        Thu, 25 Feb 2021 05:14:40 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id 197sm3842516qkf.33.2021.02.25.05.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 05:14:39 -0800 (PST)
Subject: Re: Help for the git patch with "---"
To:     =?UTF-8?B?5ruV6b6Z?= <dyroneteng@gmail.com>
References: <CADMgQST4wSH+bt5auGuO6KYoQzyrkhnY2RY4Q1jGLVczGrMG+Q@mail.gmail.com>
 <CADMgQSR8cOJs_XGuArqRoRxes6RxxgitMvDFYhpYVGxg6A2VZQ@mail.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Message-ID: <25082af3-e8fd-e9d6-e980-43871c5b4840@gmail.com>
Date:   Thu, 25 Feb 2021 08:14:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CADMgQSR8cOJs_XGuArqRoRxes6RxxgitMvDFYhpYVGxg6A2VZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dyrone,

[CC-ing the list]

Le 2021-02-25 à 04:36, 滕龙 a écrit :
> Oh, I reviewed the PR ((link: https://github.com/git/git/pull/745 <https://github.com/git/git/pull/745>)),  maybe I got the point of it.
> 
> It's caused by the first comment I leave on the PR,  so every new patch will attach it to the maillist.

Exactly. The first comment on the PR (the PR description) is used
as a cover letter for multi-patch series, and in the case of one-patch
series like yours is now, it is inserted as an "in-patch commentary", i.e.
it is added below the '---' line as you found out.

> 
> I decide to remove it from the PR.
> 
> So, did I deal the right way this time?

Well, if you are sending a subsequent version of your patch series,
this space is usually used to summarize in words what
has changed since the last version of the patch series.
For example, for your v4 you could have written:

Changes since v3:
- Improved <that> following comment from <insert reviewer name>
- Reworded the commit message
- etc.

This is a explained in the MyFirstContribution tutorial [1]. I would
encourage you to do that if your series needs a v5 (I haven't read it yet).
It's also a way to make sure that you modified your patch to account
for all feedback you got in earlier iterations.

> 
> Thank you
> 
> -dyrone
> 

One last thing: most people prefer not to be emailed directy, but instead
to be CC-ed on an email you send to the mailing list (git@vger.kernel.org).
You have much better chance of receiving an answer this way, as anybody who
reads the mailing list will see your message and might take the time to answer.

Cheers,

Philippe.


[1] https://git-scm.com/docs/MyFirstContribution#responding-ggg
