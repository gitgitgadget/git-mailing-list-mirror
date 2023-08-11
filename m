Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B111C001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 17:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbjHKRff (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbjHKRfd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 13:35:33 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E8326A2
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:35:29 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d3d729a08e4so2060778276.3
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691775329; x=1692380129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lONLaBF745T5gDfEHQxKO4/CV+3s/iV6ZUlhSyn0Y4w=;
        b=ZS2gqyo3U5cexLYe7+fNLMGLbOWnfmCeIZnHbl9MC1k5Xj2QFLZuwrVI+SI/hT+gJU
         cASczWV/B2W6l26ZG+9BYvOKikN69FSFT0RSPO7AHqgB6vNlGPzjQEGnptI0eQ48ifFr
         aY+nhDhXrRIgBoDAJcT+v0fBv6X1zVy/QUFPOmuWhuLKpsdBERn/kuBsDRfWcac83nBD
         GUTnuX3OIkBTO7M0NDU7DJ90DM+73DuUeSnaEvG/CcdhOKkQE/yqATMC+raCrpHTdycK
         Deh3a1QcqrswXmGjvboFMyRxOqISFROCv3Q0NaRs/Dl0IIaw2DVI8sQ3QGaP46Csy/FW
         +otA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691775329; x=1692380129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lONLaBF745T5gDfEHQxKO4/CV+3s/iV6ZUlhSyn0Y4w=;
        b=dh6DVO3JCHQUgD2Qf9nHflJFY/dvQ7DU7rala5I3Fh2frSG2tgSuJbobHBeunH2LWz
         gmxugew3tQ8jw2WrrZq7B+ZK5JYh2v+uNmNgxqsNKRRwUU4BK1nPUXzlI8jBEMyo6G6F
         GHP5SVNPTAfmNzyPluM5Ze8LO8+rUBWZWyNB+duxIfyzTc/IKpa4h9/IvAXgYhWFJXfo
         S2UR2kepqwEqsv/QiPQylnQBLPNEeYvFTeMv3H6xSowbHyKO7ByhnlQdS5vpefKhEPrv
         xLfiVlX5Re/nJJwhXQS4wSJHyPw6Y3ll26bubinN6/npBGc4NNaFfAHhYqTu3waPKgOr
         YNTA==
X-Gm-Message-State: AOJu0Yx6mAhgWig76gWOZGl+1BQR88tuIluah9gf+eXGfeuf6IkGVE07
        YqgwI1HEItTrGVPlv5kOsJ8HeA==
X-Google-Smtp-Source: AGHT+IFEE3zNrEsSF+L0ImwpfxB41oLPHXP+vG7Whqg3czh5I5Lcv/RdbGjpaZKqOSu3lw8nSV2LXg==
X-Received: by 2002:a25:ce01:0:b0:d06:f99e:6345 with SMTP id x1-20020a25ce01000000b00d06f99e6345mr2731536ybe.22.1691775328692;
        Fri, 11 Aug 2023 10:35:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x206-20020a25e0d7000000b00d57155d4ec3sm1041123ybg.15.2023.08.11.10.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 10:35:28 -0700 (PDT)
Date:   Fri, 11 Aug 2023 13:35:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ryan Williams via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ryan Williams <ryan@runsascoded.com>
Subject: Re: [PATCH] ls-tree: default <tree-ish> to HEAD
Message-ID: <ZNZxWdUHMwGxWdbJ@nand.local>
References: <pull.1566.git.1691412557518.gitgitgadget@gmail.com>
 <xmqqmsz2hl9m.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmsz2hl9m.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 07, 2023 at 09:25:57AM -0700, Junio C Hamano wrote:
> "Ryan Williams via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Ryan Williams <ryan@runsascoded.com>
> >
> > When no positional arguments are passed to `git ls-tree`, it currently
> > prints "usage" info to stderr and exits with code 129. A more intuitive
> > default would be to operate on the `HEAD` commit's tree (similarly to
> > `git show`, `git log`, and possibly others).
>
> As 'ls-tree' is a plumbing command meant for script writers, it was
> designed to require the users to be more explicit.  So, similarity
> to "show" and other Porcelain commands do not weigh much here.  Same
> for "rev-list" that does not fall back to HEAD.
>
> This was a very deliberate design decision to help use of the
> plumbing commands.  A buggy script may say
>
>     TREE=$(some command to find a tree object)
>     git ls-tree $TREE
>
> without making sure something sensible is in $TREE (and not even
> quoting it like "$TREE"), and if ls-tree defaulted to something, the
> script will silently produce a wrong result, instead of failing,
> robbing the script writer a chance to notice a bug in their code to
> come up with the TREE object name.

Yeah, I am similarly torn. On one hand, I think that it is true that
people use ls-tree for various tasks more than we'd expect from a
typical plumbing command (but less than a porcelain one, to be sure).

So in that sense I am inclined to agree with Ryan that their suggestion
is a good one. ...But, I think even more important than that is avoiding
buggy invocations like the kind you describe above that would produce
subtly wrong results.

I think you could make an argument that you could implement that
behavior and also emit a warning() when tree-ish is blank and the output
isn't going to a TTY. But that seems kind of gross to me, so I'd just as
soon not change the existing behavior here.

Thanks,
Taylor
