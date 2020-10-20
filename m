Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B47C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 21:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A93A2224A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 21:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="aOMI5j9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390165AbgJTVsV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389709AbgJTVsU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 17:48:20 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2483C0613CE
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 14:48:18 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 188so179891qkk.12
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 14:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oPbckqQL43ixTXUa9MFhb7SG23NrEewWD32Yh6i6Q5U=;
        b=aOMI5j9d0m7UDRFTR95Tdyl84u8J42DegoUsISkMuKGetAODcrhLXoAeei018J8fGT
         yZ/i6GtKPy+pcsfkZNgiQO5wbIYlmUeFOjR6cwqU6itdwODIWJMYcp7CJRgAZI3KBQPs
         NKg00Mo8CuZ4M2xnOQccQOaVtBKToO4X6ARBukCL+S/UrsNSEjfmgBLbRpo2pFxWru5o
         mq5+QXyDKmJCeU9En8O0jM8W2al7WVB7WXXR/neJhFI30/MkijuA/UfyXiE87alivhjy
         uMlr97WleM3rVm2gr4KhGVv9K4nOwHoSqrvil1jm/CfIQL3CtxfNPqIoAmIv57qO/4Rr
         yWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oPbckqQL43ixTXUa9MFhb7SG23NrEewWD32Yh6i6Q5U=;
        b=aE1eXar43Kwrx5Z7HjwjmbHgw5SXJDF4pxx4KfsA6FJ6I+VcYS75Novk1JxTv5Sc55
         36f8RcXhiNNU8WdWBd5psr4RBQvR6/iyyUfeWu0v9cnDKmBZdgw3vBTWEqxpFhhowI3w
         MWwOBOFdL2o4CSxOFG6gs3kIi1p3Dj767UmwyMvzcswnJ6RIOVcmk9niJi6dO4/HOB2g
         6PbwlbYmM2fMIjJxr1pKpDFXAIGEb0RkhlsPW5jHcM1oqrMZiLF3sbi63hTTZ8SIyO7o
         CXL9JLDfJ6QQgcl0+AjKKUZGajyOJhWlBHP/p4XmcbFDtGBAuGlVnHBFl5Enkuoa5kxr
         oo0g==
X-Gm-Message-State: AOAM530GBwXY2SO3YA6MVw+eW8aySut7Sm8QVDVgg1tkjE8YGQPVu4P8
        aGqNO0GRwy2NNUPfJ1YqC0VsvVmVvUeJ38yL
X-Google-Smtp-Source: ABdhPJz211POsFQm/Wv4cp5xvgTvBjwtbxPIaQ/BILN5sg1PJeZ+zjUoNWj1pkQT+7JB0B8t0dmuIA==
X-Received: by 2002:a37:a187:: with SMTP id k129mr297645qke.435.1603230497715;
        Tue, 20 Oct 2020 14:48:17 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:5440:c3ba:60f:b745])
        by smtp.gmail.com with ESMTPSA id r8sm92633qkm.115.2020.10.20.14.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:48:17 -0700 (PDT)
Date:   Tue, 20 Oct 2020 17:48:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] clarify meaning of --signoff & related doc
 improvements in describing Signed-off-by
Message-ID: <20201020214814.GD75186@nand.local>
References: <xmqqy2k1dfoh.fsf@gitster.c.googlers.com>
 <20201018233136.GA4204@nand.local>
 <20201018194912.2716372-1-gitster@pobox.com>
 <xmqqmu0it6ls.fsf@gitster.c.googlers.com>
 <cover.1603142543.git.bkuhn@sfconservancy.org>
 <37a4932d48c1d36c3c512e9f8c0bcac878de6b76.1603142543.git.bkuhn@sfconservancy.org>
 <20201019220214.GB49623@nand.local>
 <cover.1603155607.git.bkuhn@sfconservancy.org>
 <20201020023407.GB54484@nand.local>
 <20201020212820.GA1368742@ebb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020212820.GA1368742@ebb.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bradley,

On Tue, Oct 20, 2020 at 02:28:20PM -0700, Bradley M. Kuhn wrote:
> The remainder of this email is purely an edification question that may help
> serve to improve Documentation/SubmittingPatches:
>
> > I'd be happy to discard what's currently in seen (integrated as 1b98087e0f
> > (Merge branch 'bk/sob-dco' into jch, 2020-10-19 at the time of writing) in
> > favor of what's here.
>
> I wasn't sure what I should be doing with the patch set once it was already
> in 'seen'.  The only two references in SubmittingPatches I could find were:

The conclusive answer is that you can do anything you want when the
patches are in 'seen', but when it is in 'next', things have solidified
and the series is not meant to be changed. The one exception to that
rule is immediately after a release, in which case 'next' is rewound
(and thus some topics can be ejected from next).

> From Documentation/SubmittingPatches:
> >> In any time between the (2)-(3) cycle, the maintainer may pick it up from
> >> the list and queue it to `seen`, in order to make it easier for people
> >> play with it without having to pick up and apply the patch to their trees
> >> themselves.
>
> and
>
> >> `git pull --rebase` will automatically skip already-applied patches, and
> >> will let you know. This works only if you rebase on top of the branch in
> >> which your patch has been merged (i.e. it will not tell you if your patch
> >> is merged in `seen` if you rebase on top of master).
>
> The former hints that you *shouldn't* change the workflow if some of your
> patchset is in `seen`, and the latter hints that maybe you should, but
> neither section tells you what to do differently, if anything, once your
> patches are in `seen`.

I think the latter is really only talking about branches based on
'master' (of course, the same thing is true of branches based on any
branch, but it's uncommon to base topics off of 'seen').

The former is saying that 'seen' may change zero, one, or multiple times
during the lifetime of a topic. The latter says if you track upstream's
'master' and then 'git pull --rebase', 'git rebase' will tell you if
your patches are already applied upstream (in which case you can drop
them).

> I'm curious to know if I went wrong somewhere and the workflow and would be
> glad to propose another patch to improve SubmittingPatches with a section of
> what to do when patches show up in `seen`, but since I'm a n00b (at least as
> an upstream Git contributor :), I'd need to know how to DTRT in this case to
> do that.

It couldn't hurt to add something to the effect of:

  Since 'seen' is a convenience branch that contains the current state
  of the in-flight topics, it is subject to be changed and rebuilt
  multiple times (c.f., link:howto/maintain-git) so the presence of your
  patches in 'seen' (but not 'next' or 'master') should not affect your
  workflow.

Thanks,
Taylor
