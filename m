Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6273BC433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 16:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F27D61606
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 16:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhBWQwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 11:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhBWQwG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 11:52:06 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B423EC061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 08:51:24 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id k16so10333948plk.20
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 08:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=sNidQv+oZlXi/mkLEef+JCwGZVblVeV54JKul6RSWik=;
        b=pl2IIvZnwwX9uaaW4kwue7ZHGZDRjWft0a2cnkT8qiosL2fUErUE67URkVO3YMZsyd
         RYrLF8aBitrqJmb+6Ya1edjTTEQB/QKcLRYyaDpLyl7iQv+xa9JP+S6BmVm/lcGRa1/u
         zMmGRtPA3kdLCx+T2H6zF68MPwC357Vo1Rgs1EP0f3Fl1V4+SzzHQySf0PWcKmS+yHVp
         7y2opMPBPEpeLp7U6t0CKARbgqaAyS6jDxNrIm9aUfZFoB3mDS4I2puAInI0K4w0x1CM
         z1wIPIAwA7vkjRkuqh2UlixvoSY9hT3jeHkx37DiHyAjQ62njl5DeJFz95dRkLyT1QWR
         W/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sNidQv+oZlXi/mkLEef+JCwGZVblVeV54JKul6RSWik=;
        b=JCBp+04RQRdz3sWHytTPC1Ilzt0m70lJWV2hAPvPQhEviKtv6V4VgQ807XQW+9saPD
         PRRLovEYcXkdFR8wp3EzGt8UhCaftRw6kQ80bVsD6pvRkjeSmSBBzKiuxAWzq/kmB2T1
         me8/pYja0Xp4DinivJ/BXHIWP45bVtm8XkT2cXf3wb4GLM7QHHLMmJykABWO7NXmszdC
         LFumtnkpptyHTRNWkAJomx89al+QjUCacQX6oRnZsUDLvTbS0cJx2lthNj8iJNWR9jjS
         GptdLXYhLe7G9mVKxavcSDLzzcgn4+BOFNHvVd24+ZvDVAKtXiiB35V2hgVJ5BLeLIlt
         6JCQ==
X-Gm-Message-State: AOAM533qbofqO4O+aTOIYBYtbsK7tWFl4dlL05H01PWucR0I8X40+B0e
        LoZ1Yeo1LafR5xwCYisMdhwEwV7gI3pFGUt8wcto
X-Google-Smtp-Source: ABdhPJxjN0Ag7Iy5yeoWzlDKtx4V4zNmR8KmSgJEZxFHRL9svUXKz94Krq/+o05qTrpdpVXv/0iImDsnRQBlGLrCV9fJ
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:16cd:b029:1c9:6f5b:3d8c
 with SMTP id l13-20020a056a0016cdb02901c96f5b3d8cmr27597750pfc.1.1614099083714;
 Tue, 23 Feb 2021 08:51:23 -0800 (PST)
Date:   Tue, 23 Feb 2021 08:51:20 -0800
In-Reply-To: <874ki29b53.fsf@evledraar.gmail.com>
Message-Id: <20210223165120.1561659-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <874ki29b53.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: Re: [PATCH v2 2/4] http-fetch: allow custom index-pack args
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
> > index 4deb4893f5..9fa17b60e4 100644
> > --- a/Documentation/git-http-fetch.txt
> > +++ b/Documentation/git-http-fetch.txt
> > @@ -41,11 +41,17 @@ commit-id::
> >  		<commit-id>['\t'<filename-as-in--w>]
> >  
> >  --packfile=<hash>::
> > -	Instead of a commit id on the command line (which is not expected in
> > +	For internal use only. Instead of a commit id on the command
> > +	line (which is not expected in
> >  	this case), 'git http-fetch' fetches the packfile directly at the given
> >  	URL and uses index-pack to generate corresponding .idx and .keep files.
> >  	The hash is used to determine the name of the temporary file and is
> > -	arbitrary. The output of index-pack is printed to stdout.
> > +	arbitrary. The output of index-pack is printed to stdout. Requires
> > +	--index-pack-args.
> > +
> > +--index-pack-args=<args>::
> > +	For internal use only. The command to run on the contents of the
> > +	downloaded pack. Arguments are URL-encoded separated by spaces.
> >  
> >  --recover::
> >  	Verify that everything reachable from target is fetched.  Used after
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index 876f90c759..aeac010b0b 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -1645,6 +1645,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
> >  		strvec_pushf(&cmd.args, "--packfile=%.*s",
> >  			     (int) the_hash_algo->hexsz,
> >  			     packfile_uris.items[i].string);
> > +		strvec_push(&cmd.args, "--index-pack-arg=index-pack");
> > +		strvec_push(&cmd.args, "--index-pack-arg=--stdin");
> > +		strvec_push(&cmd.args, "--index-pack-arg=--keep");
> 
> The docs say --*-args, but the code checks --*arg, that seems like a
> mistake that should be fixed to make the code/tests use the plural form,
> no?

Thanks for catching that. Originally it was plural since this single
argument would give multiple arguments to index-pack, but now each
argument gives only a single argument, so "arg" is correct. I'll update
it in the next version.
