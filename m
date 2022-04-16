Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E06C4321E
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 02:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiDPCIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 22:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiDPCG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 22:06:27 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901FB27B18
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 19:02:28 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id k62so3219378pgd.2
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 19:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ezx6uSamVjDq/CaNYgpRKvOfu+m+XSJSPod7ZusxlVM=;
        b=4R0pZ5M9yZaGrS8G43jMxCgc8KvfN7BkWyZuoarzdb3UOlZh+OdtAx9nuGFzAIuJnS
         yvaQ/Zs+FUixHkxOIEc7+goU6nZmmkJJ59lm/qghU3K+Jv5rDwPSZFUQ51ABDI5FsJ47
         txrwyUPLbHd5qbaP+VRiaDENGJ2kN0hwMB4FAB4jNErsyKJirghymP6gTIwgmq+J5WMe
         ok13q+Dwn4HF3+wRY+l9Qr1IgsM6lci0UKgeg87mTPPQZPXS+hHR1yhP0054w3g7KXJ1
         vdW6yWNpLQAZuWVJ6d3dS961yFuFGpeZSDikHhkNNI5M3hOzjQxxRHOloljuBtHRfDU2
         MDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ezx6uSamVjDq/CaNYgpRKvOfu+m+XSJSPod7ZusxlVM=;
        b=BmIrOQtp9wjwJgs2wqnii9Cr3xNcbd1bS27oq/xJ8RSIE8LPTnJwJgrpl40+7TkbJ1
         X63EU2JQ4fvSbigl9Yc7AIYHBTrsIra+iUoLtMfD1pNB4MD+WOeWtkAzxb+4ahWjnE+z
         BbCbw9SSJEEReks1NoPhcbHFiAjwtzN7uTcpwLltIhWVaVmNkbCMdLqzsrPspccMpmeu
         Ido5+eABehelxL1S7YjLJkQSRDMI8yOJ0LpPuD+LQJgM0mScylpv1+kw+jPKAZWN1xKN
         +9lY/JrhKAXbn7zpmhH4BbR7wueNdl16kFwDtA7EG87oqN8ZdReEp1yAFJ4hgAPwGKwC
         61uA==
X-Gm-Message-State: AOAM533gh89zYAwVc1qODjlDZpx7Wqw7TZc0SuXDSpHHhH1lFBWjVKhc
        4TMfFGA1qZ0+3Cgn8ESpbfGMpSxyg7PbKyMY
X-Google-Smtp-Source: ABdhPJyI4bGIO81DTxaDbDpXN48CTOThF5oKWcFE0mO7jlDqf6mk3sZ1t0f2cMDOluyFTygaIpAC2w==
X-Received: by 2002:a05:6602:399a:b0:653:ff79:2510 with SMTP id bw26-20020a056602399a00b00653ff792510mr199916iob.170.1650072632567;
        Fri, 15 Apr 2022 18:30:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n12-20020a92dd0c000000b002cac22690b6sm3506449ilm.0.2022.04.15.18.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 18:30:32 -0700 (PDT)
Date:   Fri, 15 Apr 2022 21:30:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Glen Choo <chooglen@google.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        justin@justinsteven.com, martinvonz@google.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Bare repositories in the working tree are a security risk
Message-ID: <YlocN5bbvPuN3Dn9@nand.local>
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lv8vc90ts.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqwnfs4kud.fsf@gitster.g>
 <kl6lh76v8vnj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqh76ucdg6.fsf@gitster.g>
 <kl6l5yn99ahv.fsf@chooglen-macbookpro.roam.corp.google.com>
 <YloVFn0SC/SF33b3@nand.local>
 <xmqqy2057rmx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2057rmx.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 15, 2022 at 06:18:14PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Is the proposal to only detect bare repositories that are called `.git`?
> > I think that's what you're suggesting, though can't we just as easily
> > embed a bare repository named ".git" in a clone as long as its not in
> > the root directory?
>
> I do not think "you can use your bare repository as before ONLY if
> the directory is named .git; otherwise you must use GIT_DIR to point
> at it" would fly; the Glen's exception may help many uses of ".git
> subdirectory of a non-bare repository as if it were a bare" you can
> find in tests, but does not help real-world use cases where there
> may be bunch of bare repositories named "$project.git" at all.

Agreed.

> But I have to point out that your attack above would not work, as we
> do not allow ".git" directory in the index to begin with.  IOW, you
> as an attacker may be able to prepare such a tree with nonstandard
> tools, but the victim won't be able to check it out (and
> fsck-during-transfer would probably block the cloning).

Makes sense, and thanks for the reminder; I agree.

Thanks,
Taylor
