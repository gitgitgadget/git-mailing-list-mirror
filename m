Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B771C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 20:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0E060EE4
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 20:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbhHMUYX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 16:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbhHMUYW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 16:24:22 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AB5C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 13:23:55 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f3so13510283plg.3
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 13:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z1Y5LQFFIs3W+2iLdcIq9zUS3BhrVeY48E+v5nF6qiI=;
        b=UO0nwbXxr5eK/VtX2oH99k1fjHxS85auWWPg97aEy+vQ7bJfETq7T243mKngddoXt7
         kjUDx2sPgKo8eOdhmbjQhjD8endTzCQpaCWEDpZxZMbLWL6m1zB7KNW2WSMhJto4Bkab
         ozILIiJLusvHuegY0hE2Kvvg1Dhk5ueY3WqIBu+sppgCCNYwZwDKGenAMN8gi1X6kinE
         3EP8zbwW9AA1U6MgRLFcBnuU1UM5TsmN5mQGFlZYkkigfZcl/suUM7BHmjgVbaza4g1G
         QpzBNf8L0R/qClZwhOPO+tY7TZT0m6gYlaIylin3/VvcrqFue2k4Dq2RjAiFE5FvVoz3
         vT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z1Y5LQFFIs3W+2iLdcIq9zUS3BhrVeY48E+v5nF6qiI=;
        b=orXpg18yhC3WsQo0sT+0Aiwef3grBU/zplFK1tL1mwhlbCFHi8JI8m7j1zKsMEW2Fa
         0wwvECUymdMde+FSXYdCNeVLfU4SrHCrRVqNDkJoWz3Omqf4r9T6i3rUKD/L/WvHE0fK
         qa20pZqvXUvGRy9Cd32m6AW3LmrcPh6KbwEg7jT4KFuTNucH66MW4wM9F7FBmaJhFflF
         GWIhDIuC7re+jQJUOj0gjIj6TDkhygGn9PK8g2VbkHTT6vBEw3UMBiKahsa0/emO8udr
         bLvJJm/96lGrf5Wg5HWSBknCrN8y8ISRA2b5xqSi3fppdNpUPjMK50myBj3isfsA71s3
         gkzg==
X-Gm-Message-State: AOAM5329GGM35yq1lp6ub6B90I+R0ybamgucHRyBVcxzdW/E5gtv6PH8
        p7KsM/bcpBD0mAkYAx8GoFF2sQ==
X-Google-Smtp-Source: ABdhPJxjUcBgCQ3MFb3WWVVVU05eUy15A4rw0UYwNnC5IeUaO8UwdHr/uBu1C4aEm3o8+7skRAcwBg==
X-Received: by 2002:aa7:90d4:0:b029:3b3:2746:5449 with SMTP id k20-20020aa790d40000b02903b327465449mr4136851pfk.81.1628886234930;
        Fri, 13 Aug 2021 13:23:54 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:258f:eefb:8f2e:157])
        by smtp.gmail.com with ESMTPSA id b8sm2660065pjo.51.2021.08.13.13.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 13:23:54 -0700 (PDT)
Date:   Fri, 13 Aug 2021 13:23:46 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Mahi Kolla <mahikolla@google.com>
Subject: Re: [PATCH v5] clone: set submodule.recurse=true if user enables
 feature.experimental flag
Message-ID: <YRbU0uBxqinQ1EnE@google.com>
References: <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com>
 <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com>
 <xmqqeeaz70ph.fsf@gitster.g>
 <YRW0pGXXWnY7C470@google.com>
 <xmqqpmuiynbs.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpmuiynbs.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 12, 2021 at 09:34:47PM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > It seems surprising to me that a user would want to clone with all the
> > submodules fetched *without* intending to then use
> > superproject-plus-submodules together recursively. I would like to hear
> > more about the use case you have in mind, Junio.
> 
> You may need full forest of submodules with the superproject to
> build your ware (i.e. you'd probably want to clone and fetch-update
> them), but you may only be working on the sources in a small subset
> of submodules and do not need your recursive grep or diff to go
> outside that subset, for example.  You'd need to ask the people who
> recursively clone and not set submodule.recurse to true (I am not
> among them).
> 
> > One scenario that did come to mind when I discussed this with Mahi is
> > that a user may provide a pathspec to --recurse-submodules (that is,
> > "yes, this repo has submodules a/ and b/, but I only care about the
> > contents of submodule a/") - and in that case, --recurse-submodules
> > seems to do the right thing with or without Mahi's change.
> 
> Please be a bit more specific about "the right thing".  Do you mean
> "the submodules that matched the pathspec gets recursed into by
> later operations"?
> 
> If so, "git clone --resurse-submodules=. $from_there" may perhaps be
> the "there is no way to we make this opt-in?" I have been asking
> about (not "asking for")?
> 
> > It seemed to me that trying out this change on feature.experimental flag
> > was the right approach, because users with that flag have already
> > volunteered to be testers for upcoming behavior changes
> 
> Yes, if we already have a consensus that a proposed change is
> something we hope to be desirable, then feature.experimental is a
> good way to see if early adopters can find problems in their real
> world use, as these volunteers may include audiences with different
> use pattern from the original advocates of a particular feature, who
> might have dogfooded the new feature to gain consensus that it may
> want to become the default.
> 
> By the way, I am not fundamentally opposed to the feature being
> proposed.  I would imagine that such a feature would be liked by
> those who want to keep things simpler.  I however am hesitant to see
> it pushed too hastily without considering if it harms existing users
> with different preferences.
> 
> IOW, I was primarily reacting to the apparent wrong order in which
> things are being done, first throwing this into feature.experimental
> before we have gathered enough confidence that it may be a good
> thing to do by having it in shipped version as an opt-in feature.

Yeah, since writing my reply I was very helpfully reinformed on the
convention around 'feature.experimental' by Jonathan N off-list. Thanks
for being patient with me.

I think the right move, then, is to explore whether your suggestion in
https://lore.kernel.org/git/xmqqeeaxw28z.fsf%40gitster.g is appropriate
- I have the sense that it is, but I want to make sure to think it
through before I say so for sure. 

 - Emily
