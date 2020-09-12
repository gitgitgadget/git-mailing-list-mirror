Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2AEC43461
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 21:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1D3D207FB
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 21:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sG9rHkeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgILVZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Sep 2020 17:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgILVZe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Sep 2020 17:25:34 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB068C061573
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 14:25:33 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x18so2601572pll.6
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 14:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ppLdS1WIhp9z4HLJiJ9dpuqWN28dBsgS1Np4KJ30hPo=;
        b=sG9rHkeUcmSa5hzDU9Odm7TINFW0z/nIMz2llLVS2IpcXZHM1Sdt3jiiokgXtBPOlo
         bjBKAwFhlHxN8dTUg67HO+e9K+wPt/7MGJZn9Vfkn+VQXyc8TxfuaYUv4D237Nf0HGhL
         0LZcH767F2iBXuqJNxs8sFOhGQ6oykl52dW/ALylkt07+/GRI/lt5emFf2Cc9E53pEPX
         szSP/l6GSLXKqaQapqPTqz29kySuamubfwsjI1gMyY+BKA3jEEzADnCl1eIQMh6Bx3m7
         qKCmbZI8lKeSlzx4oha+dPP/49wVfrSEf7KzuLKScGPE0ZVWdB8Ks+f7JKGROuEoUA1I
         e7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ppLdS1WIhp9z4HLJiJ9dpuqWN28dBsgS1Np4KJ30hPo=;
        b=afWlFdY6Edhj3fHmAEcyLR/yLzLG16Swss0fK+NL0HvNNTtRb8sJOT0ksqx1f+Ft/G
         bZVROyWavwkMgaCw1CgxaY5gDUdzC1tUTxInhPfHX5qBcW19T3eLGIwRNC8OE2Eodwit
         2rnylf8aTaisYyJgx8XnrIx0856xaNQmN0I5TK0APexSsYMdN5XyXebsjJqnxoZgt3OQ
         dlSN/yOgPhz5KSf0L+n7L766niP7Po6iZfJw4p7079OlFtVHIc/txtJtRqbWXxyXUtlu
         pgFlRv6WKH4EyWba3+fGJM1gXf5j+QTu4AFhcsrtcThAx6u1XmSTaLhZuqi47qMdVdv0
         DXJA==
X-Gm-Message-State: AOAM531rWRNBGJ0riv0u+RegmhzwcWtAKT0Fc48XlUbhCCkb0ZjMjlqi
        K7VtUD5lIU7w7EkQAenIvWQCbV+AgYvZoA==
X-Google-Smtp-Source: ABdhPJwWLodXM1/MjeDF07s96ExPIJrl25S9mnW4FRp0HBs6W6J9eNVFgCy6qHs5MLFOgHWaDWqZFw==
X-Received: by 2002:a17:902:704b:: with SMTP id h11mr7980392plt.57.1599945929033;
        Sat, 12 Sep 2020 14:25:29 -0700 (PDT)
Received: from mail.clickyotomy.dev ([124.123.104.38])
        by smtp.gmail.com with ESMTPSA id gj16sm4894840pjb.13.2020.09.12.14.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 14:25:28 -0700 (PDT)
Date:   Sun, 13 Sep 2020 02:55:24 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] push: add "--[no-]force-if-includes"
Message-ID: <20200912212524.GB55022@mail.clickyotomy.dev>
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
 <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
 <20200912150459.8282-2-shrinidhi.kaushik@gmail.com>
 <xmqq5z8ioo15.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5z8ioo15.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/12/2020 11:20, Junio C Hamano wrote:
> Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:
> 
> > Add a new option: `--force-if-includes` to `git-push` where forced
> > updates are allowed only if the tip of the remote-tracking ref has
> > been integrated locally, by verifying if the tip of the remote-tracking
> > ref on which a local branch has based on (for a rewrite), is reachable
> > from at least one of the `reflog` entries of the local branch about
> > to be updated by force on the remote.
> >
> > This option can also be used with `--force-with-lease` in setups
> > where the remote-tracking refs of the repository are implicitly
> > updated in the background.
> >
> > If a local branch is based on a remote ref for a rewrite, and if that
> > remote-tracking ref is updated by a push from another repository after
> > it has been checked out locally, force updating that branch to remote
> > with `--force-with-lease[=<refname>[:expect]]` without specifying the
> > "<refname>" or "<expect>" values, can cause the update that happened
> > in-between the checkout and forced push to be lost.
> >
> > Specifying `--force-with-includes` with `--force-with-lease` as an
> > ancillary argument at the time of push, ensures that any new updates
> > to the remote-tracking refs are integrated locally before allowing a
> > forced update. This behavior can enabled by default if the configuration
> > option `push.forceIfIncludesWithLease` is set to `true`.
> 
> This step seems to do too many things at once.  Split into logical
> progression of improvements, or nobody can sensibly review it, I am
> afraid.

OK, I will break the commit up into smaller change-sets in the next
patch.
 
> > diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
> > index f5e5b38c68..1b4948faa0 100644
> > --- a/Documentation/config/push.txt
> > +++ b/Documentation/config/push.txt
> > @@ -114,3 +114,11 @@ push.recurseSubmodules::
> >  	specifying '--recurse-submodules=check|on-demand|no'.
> >  	If not set, 'no' is used by default, unless 'submodule.recurse' is
> >  	set (in which case a 'true' value means 'on-demand').
> > +
> > +push.forceIfIncludesWithLease::
> > +	If set to `true`, adds `--force-if-includes` as an ancillary argument
> > +	to `--force-with-lease[=<refname>[:<expect>]]`, when "<refname>" or
> > +	"<expect>" values are unspecified at the time of push.
> > ++
> > +Note: Specifying `--no-force-if-includes` to linkgit:git-push[1] as an
> > +argument during the time of push does _not_ override this configuration.
> 
> I do not see why you still want to link these two unrelated
> features.  I may want to do forced push with lease when I know I am
> rewinding, and I may want to do a if-included force when needed, but
> I do not see why I want to ask the former and implicitly see it also
> trigger the latter.

I am actually thinking of getting rid of the configuration option
altogether. Sadly, I realized that after I sent out the patch.

> I haven't seen the details, but if we severe the (unnecessary?)
> entanglement of these two features, perhaps this patch will become a
> lot smaller and more focused?  I dunno.

Other than the configuration setting (which will be removed), tthe only
parts that overlap are checking to see if "--force-with-lease" specified
with `use_tracking` and `use_tracking_for_test` modes only. The new
option does not modify the "strict" version of "compare-and-swap"
because in that case, it is not needed at all.

However, I think it can be cleaned up a bit more; will look into it.

Thanks.
-- 
Srinidhi Kaushik
