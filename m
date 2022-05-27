Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F49C433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 17:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244739AbiE0Rzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 13:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbiE0Rzu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 13:55:50 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62065D9E88
        for <git@vger.kernel.org>; Fri, 27 May 2022 10:55:47 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4L8ssq32vwz9snt
        for <git@vger.kernel.org>; Fri, 27 May 2022 19:55:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m-reimer.de; s=MBO0001;
        t=1653674143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FBLLis+RwyR/5a8zR6ezdUajxn/u0VwxCT/kXfUZt3Q=;
        b=mPRkam38JAicDUsmukiQFSOw9fOMIx/C5bL9ZnZzHV1RUlFR9o7saIbpREpb+A3pVQ448k
        FUafa+WqIaDATfyG+i8JngpPd/Qzw2v1TRoONB+jGnPmccXJjxz842u8vnvH+pGFpEFZu1
        Bbz4bugnkpsPJ7IaQqG5TBRHlpaqIu4NaYqsoQJqAxZ2EjxU/WR5cX3DEIW9ttid5u5Zma
        ICq8zYa35I3iEqRSePwC5aYesllQl193YdMkRPyBld0dFBvhS42JylkcSiLotmvFyQiK26
        Ev6Xa8h5IBYRcZNp7jk02HteTGsa+yTYuheALnTX3750xiWITrux+VAHAVdKeQ==
Message-ID: <393b5026-e861-b5b1-a474-5d56464dba91@m-reimer.de>
Date:   Fri, 27 May 2022 19:55:42 +0200
MIME-Version: 1.0
Subject: Re: How to properly use git-subtree (and prevent it from adding merge
 commits)?
Content-Language: en-US
From:   Manuel Reimer <mail+git@m-reimer.de>
To:     git@vger.kernel.org
References: <3DEED6A1-6344-472C-9E03-39ADF3076B2D@m-reimer.de>
In-Reply-To: <3DEED6A1-6344-472C-9E03-39ADF3076B2D@m-reimer.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4L8ssq32vwz9snt
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I tried the "subtree push" and now the merge commit did not get pushed. 
I'm sure it was when I still had my old subtree repo before rebuilding.

So probably the reason why git went crazy was because the initial 
subtree repo was created based on one of my projects repositories by 
filtering the commits down to just the files I wanted to extract.

So probably some internal references matched when pushing. I recreated 
this subtree repo from scratch now and imported all relevant commits 
using "git am". I hope this guarantees that I don't get unwanted 
references from the source repository.

What will happen if I get a pull request which covers both, project 
files and subtree files and then "subtree push" the changes? Will this 
cause the merge commit to get pushed to my subtree repo?

Thanks

Manuel

On 27.05.22 16:54, Manuel Reimer wrote:
> Hello,
> 
> maybe it's a bug in later GIT versions (2.36.1 here) but I kind of struggle to get git-subtree to work properly.
> 
> I even recreated the repo, I use for the subtree, from scratch to get sure there are no backreferences to the repo I've added the subtree to.
> 
> This is the repo, I want to have as "subtree" in other repos:
> 
> https://github.com/M-Reimer/webext-utils
> 
> I now pulled this into two projects as subtree using the command
> 
> https://github.com/M-Reimer/undoclosetab
> https://github.com/M-Reimer/savescreenshot
> 
> For both projects I used the command:
> 
> git subtree add --prefix utils git@github.com:M-Reimer/webext-utils.git master
> 
> In the first project (undoclosetab) I then added a new commit ("Add managed preference support") and pushed this back to the "subtree repo" using:
> 
> git subtree push --prefix utils git@github.com:M-Reimer/webext-utils.git master
> 
> If I now try to pull this into my second project (savescreenshot), then git creates a merge commit for no reason.
> 
> 
> git subtree pull --prefix utils "git@github.com:M-Reimer/webext-utils.git" master
> remote: Enumerating objects: 5, done.
> remote: Counting objects: 100% (5/5), done.
> remote: Compressing objects: 100% (2/2), done.
> Unpacking objects: 100% (3/3), 1.94 KiB | 497.00 KiB/s, done.
> remote: Total 3 (delta 1), reused 3 (delta 1), pack-reused 0
>  From github.com:M-Reimer/webext-utils
>   * branch            master     -> FETCH_HEAD
> Merge made by the 'ort' strategy.
>   utils/storage.js | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 56 insertions(+), 1 deletion(-)
> 
> 
> Why does this happen? As soon as I have this merge commit a following "subtree push" also pushes this merge commit to the subtree repo and also pushes tags that are not relevant there.
> 
> I'm out of ideas now.
> 
> What I want to do: I want to be able to develop on modules, I have in the "subtree repo" in every project I want and then push the changes to the subtree repo for pulling into the other projects. That's why I don't want to use "squash" as I don't want to do development only in the subtree repo directly.
> 
> Thanks for any hints.
> 
> Manuel

