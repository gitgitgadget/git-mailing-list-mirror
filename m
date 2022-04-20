Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9124DC433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 17:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381043AbiDTRV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 13:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352331AbiDTRV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 13:21:56 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A40D45AFA
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 10:19:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mp16-20020a17090b191000b001cb5efbcab6so5517917pjb.4
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 10:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=pXJF7Qk2wUrQq6YvCKYKJzKF9OHVK+3vapWp33omEWc=;
        b=f0DZXu61M+TKmXW6omxu9UnytFxPGkKsgcJSkqP80hwlUtU2xSVhvavVakiwam5Hqj
         L3nnUQSA8hCqIpUsIBrTEgt80guAhhoNyv0EO8jhoQDMHo4t9SZzng99XviYQDa7HisL
         2esH2OQRHswZOKaHl7s534WbKIJ5gs5Iw+CfueY/3TV8lED1ymAeBsqGIPZBssH2H3pI
         Tdg/hZDPXSmXg5cQB/wv34wJTBvaLgka4GGxCnpDpwTkd5+cXP2BCy+n7OOzzY3SSKwg
         FXvMG/BNRdeDliWqaaMdCPKORJaUBIuj17kO8JV68wwGI3TWnNTgV/gJCWfopKFUE0Co
         18xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=pXJF7Qk2wUrQq6YvCKYKJzKF9OHVK+3vapWp33omEWc=;
        b=Fd8NHBejDanjkdOTqdki6lSdBmE5lr9brDz0BkQcM+ty6aFgSmy3w7jCYlo1AG+Q5o
         RdQ92k9zXF2KMh+wrNFbP8M8bn8fxdkbEGXLeqZ3dqTZ1XnKD0ablrBqrGn6a2LOOAvK
         DbbPgTN5c1jlXgbL3dQ9KddOeq5XhtnvH2xGMK/49VrqiwGDOfOH5KbiBdmUGsIgzzsi
         NLxU2+ISE7Z8bI/t6CsUcKZoDF1/8/0RPt81tG8eK5LD4W/Ib6LLgshaOCrVzlJ5mRsj
         MRjJhAUQ4v/ezHFwvKAYRGQ2o8eTRbvNPdfnpqcXcES5xA1cL3hogCReQGCDhwpOqS47
         pwlQ==
X-Gm-Message-State: AOAM530jLCf+JWMsKbm7GJpjvUJo4Mr9WpgotU3dG4Ry3eX1t/Pvz+ru
        Qk1p0nkTw/dNbMEFJXDyGUW93w==
X-Google-Smtp-Source: ABdhPJzRBE7JZ98+rGp8sDzRCEanqbO+z+7pHXKYDV/hLmAhyNHWwcQjf1O98a0IPCyB+Sc3WF99RA==
X-Received: by 2002:a17:90b:4a85:b0:1d2:aee9:23ce with SMTP id lp5-20020a17090b4a8500b001d2aee923cemr5702819pjb.99.1650475149502;
        Wed, 20 Apr 2022 10:19:09 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:38bb:c96d:6b90:377a])
        by smtp.gmail.com with ESMTPSA id d6-20020a056a00244600b004f701135460sm22002388pfj.146.2022.04.20.10.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 10:19:08 -0700 (PDT)
Date:   Wed, 20 Apr 2022 10:19:02 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] merge: new autosetupmerge option 'simple' for
 matching branches
Message-ID: <YmBAhjR7rwAuHylN@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Tao Klerks <tao@klerks.biz>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com>
 <pull.1161.v4.git.1647843442911.gitgitgadget@gmail.com>
 <Yl2qwO0SMPOhb5h9@google.com>
 <CAPMMpogY5vZU8gyRSYh+BM4goPPtJw0cCiM-31sy-s_uGRv8uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPMMpogY5vZU8gyRSYh+BM4goPPtJw0cCiM-31sy-s_uGRv8uA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.04.20 07:12, Tao Klerks wrote:
> On Mon, Apr 18, 2022 at 8:15 PM Josh Steadmon <steadmon@google.com> wrote:
> > It seems appropriate to me to add one,
> > perhaps at the point where a user with "autosetupmerge=true" would run
> > into a failure when trying to push?
> 
> Having thought about this a bit, I agree. On the one hand I'm a little
> nervous about adding this kind of public behavior change as I would
> imagine it's more likely to encounter resistance here, on the other
> hand I do think it will make the changes themselves much more useful.
> Also, this patchset hasn't moved in a while, so "holding it up" with
> new changes may not be a significant concern.
> 
> the current advice looks something like:
> ---
> fatal: The upstream branch of your current branch does not match
> the name of your current branch.  To push to the upstream branch
> on the remote, use
> 
>     git push origin HEAD:master
> 
> To push to the branch of the same name on the remote, use
> 
>     git push origin HEAD
> 
> To choose either option permanently, see push.default in 'git help config'.
> ---
> 
> I would propose to add one sentence at the end along the lines of:
> ---
> To instead avoid automatically configuring upstream branches when
> their name doesn't match the local branch, see option 'simple' of
> branch.autosetupmerge in 'git help config'.
> ---
> 
> Does that make sense to you?

Sounds good to me.
