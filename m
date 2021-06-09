Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE79CC47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87A6261073
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhFIEyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 00:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhFIEyV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 00:54:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB56C061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 21:52:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 22-20020a250d160000b0290532b914c9f4so29840882ybn.9
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 21:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=F06U0ABQ4vxa49jkE/EoXQ3VIYKSh+Vi0SdWCgQiITc=;
        b=vtES9WkEc+LEScrV1QCvFcB3fcT1q5irD8pSoKf9RmzViX7KOTkesSBUbFNW74NpHz
         gyTbiDhFho4dfaLa0LuRfwvV406eQrvwiwt3PnSN1rjLNnbcs/u+MrVIcSqbpgrxYvFG
         BoFNQTXyS1OWTkTC2UXIphVQzVbVw5duxw2x8BRKRW64ChxZXt1PfP6b0nW1xatNHxb/
         YF0p6Wg9/T7V/wFjzSUWGvBAK/GXstIhokouuFVEEDQCEB2kpQsYivr03uLOIefTjAmU
         IGP6Pe2S0J+qmMVFt6PCAYiIizApno5VPaHyb/WMYkclkPzxZtmYqK7C5s/TD6Xz1U2O
         gYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F06U0ABQ4vxa49jkE/EoXQ3VIYKSh+Vi0SdWCgQiITc=;
        b=jmp3AYlkxsXunI52qCfZ4IJkXjxPzUX/sLtWPHqMbswSWKCrREFBI9OSgHe249eSoY
         5rVJ/22J2pb6ON2qfVOfUIPXUcazMJjvMElAKUHgGkIKeURQCfS5iU1zv3tK67JhdxSV
         OuOUX0inWFQ00d5DL/t1ArN0ZyvfCN6FHwK9xIoSrf9rdSPRIGoGvXyLzSLTbAmbXIM6
         75beTEifUVGJSGTY9RpcOe/SxcqAywxdlVPZHSlqWpqZaZ5cJTwrjoDngVqIpD4w0t96
         YFaPttJgIU73I8cpmh21VqyA7OQF5PERdC3Jd8jiTcA4NLDTZNTqnwSOLJ8Z5gdU4qHj
         AbVA==
X-Gm-Message-State: AOAM5337lVmiPoLN/wusFsKkcPblwFOChgBg3B/mIuAGAo8dsNOuAsf3
        vN8nZSJ2/nSWX+gEs7iyAPNxc+pnGqoLU4Vo895Y
X-Google-Smtp-Source: ABdhPJwNNUPGSu+Yu9pJPhrr5ZAXLQ/qOo+O7St61kVcBBfNO32w+7DVXGpekwZKi/B4OQkdgRPkrl7Gtcmwtot8MSEA
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:f812:: with SMTP id
 u18mr25920999ybd.402.1623214330191; Tue, 08 Jun 2021 21:52:10 -0700 (PDT)
Date:   Tue,  8 Jun 2021 21:52:08 -0700
In-Reply-To: <YL7K5fuoBPMAYZlu@google.com>
Message-Id: <20210609045208.2328267-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YL7K5fuoBPMAYZlu@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: Re: [PATCH 4/4] promisor-remote: teach lazy-fetch in any repo
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> >  		    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
> >  			/*
> >  			 * TODO Investigate checking promisor_remote_get_direct()
> >  			 * TODO return value and stopping on error here.
> > -			 * TODO Pass a repository struct through
> > -			 * promisor_remote_get_direct(), such that arbitrary
> > -			 * repositories work.
> >  			 */
> >  			promisor_remote_get_direct(r, real, 1);
> 
> And this seems like a stale comment, since I see we were already passing
> 'r' here. But arbitrary repositories still don't just work, right? Or, I
> guess your point was "partial clone + submodules don't just work,
> because of the alternates thing" - so maybe this part is OK?

This part is OK (arbitrary repositories work here), yes.

> > @@ -150,7 +156,7 @@ static void promisor_remote_init(struct repository *r)
> >  		xcalloc(sizeof(*r->promisor_remote_config), 1);
> >  	config->promisors_tail = &config->promisors;
> >  
> > -	git_config(promisor_remote_config, config);
> > +	repo_config(r, promisor_remote_config, config);
> 
> Should this change have happened when we added 'r' to
> promisor_remote_init? If r==the_repository then there's no difference
> between these two calls, right?

Good point - yes, it should have. I'll change it.

> > +test_expect_success 'lazy-fetch when accessing object not in the_repository' '
> > +	rm -rf full partial.git &&
> > +	test_create_repo full &&
> > +	printf 12345 >full/file.txt &&
> > +	git -C full add file.txt &&
> > +	git -C full commit -m "first commit" &&
> I think there is some test_commit or similar function here that's more
> commonly used, right?

Taylor Blau suggested a similar thing, and I have changed it in v2.

> 
> > +
> > +	test_config -C full uploadpack.allowfilter 1 &&
> > +	test_config -C full uploadpack.allowanysha1inwant 1 &&
> I wasn't sure what these configs are for, but it looks like .allowfilter
> is to allow 'full' to serve as a remote to a partial clone. But what do
> you need .allowAnySha1InWant for here? Are we expecting to ask for SHAs
> that 'full' doesn't have?

We are expecting to ask for SHAs that 'full' doesn't *advertise*, yes (namely,
the hash of a certain blob).

> > +	git clone --filter=blob:none --bare "file://$(pwd)/full" partial.git &&
> > +	FILE_HASH=$(git hash-object --stdin <full/file.txt) &&
> > +
> > +	# Sanity check that the file is missing
> > +	git -C partial.git rev-list --objects --missing=print HEAD >out &&
> > +	grep "[?]$FILE_HASH" out &&
> > +
> > +	OUT=$(test-tool partial-clone object-info partial.git "$FILE_HASH") &&
> > +	test "$OUT" -eq 5 &&
> 
> Hm. I guess I am confused about why this fetches the desired object into
> partial.git. Maybe the test-helper needs a comment (and maybe here too)
> on the line where fetch will be triggered?

I've added a comment to the test-helper code in v2 - could you take a
look and see if that clarifies things? But in any case, the answer is
that this test-tool invocation attempts to read an object in the
submodule while running as a process in the superproject. The read
attempt is a read of a missing object, so that object is lazily fetched.
