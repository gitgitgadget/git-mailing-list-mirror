Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992BBC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 714ED60F90
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhG0VLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhG0VLr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:11:47 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA65FC061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:11:46 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id r11-20020a17090a2e8bb029017382031497so652596pjd.5
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XJlxBybq94qX8zVq3G14D4GU89uXNf0LVb6u+EVaiJI=;
        b=XUAsMUJB3hXfsgk3Qr9azXkacNQMXVvehyGzGsXdzmKJ3N98b4uUgA3hNi0BZY5ms1
         HV/2IJFSNVjZT4W1f5lGhtxGHd/Ex9LExkEsYk3vevUlmPE7jONSclMzpB6yWjkbPowI
         dG5/3udiv9EiO1VMbwTE750W3HkzMu2+1x10VOYB1tHQvf0vd1sqMF5XXiBDhI1fR3lV
         B6VSW72hkLZML8U4ACYyVpcgzUD9DoOryzJa41DcPAlXzLC58HwUVDBcIRPaj093mHbU
         +4JjrniKzJ9QrIsGam74MMja88MC9IWeA1rUB1nLwDCm2bjgAhDEwlRA3kOk3xHixA2t
         rSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XJlxBybq94qX8zVq3G14D4GU89uXNf0LVb6u+EVaiJI=;
        b=ibgZcNeHhA1a+wAxROJJtaGDe0/9x6HwXGyuGECKHKB9JevqFpLbQK8QGlEVWM3CB0
         Y5ILr5NHls+b3e0eJXJ1k07jR7rpg5RZhwR0bmE+CzUA4eIFlduFdFc2N30NIc822Tlm
         //6mnkE2n3Fln4YPwSGM4k4eMqesCgy4vCqsx8wWsHlW2bMBev5cyhcWITMZuSRVu9Xz
         hrP/AXmo9I3264SITcSVvo+w4EyJRm9Qyu8q4k4JkSPzg4h11yolheLnUE5/MApu1FIR
         e9wG59Gtj5imuQq2rgUlJSw80u0ipBph6K1cYWuO2Dhwe4KJS0Ty2LMZ9jxd/CADDodx
         ebyQ==
X-Gm-Message-State: AOAM533b7aTI34WLZuAUhfOaYARn2nsflqeqAXUM1NrOZl7KldfHfd2f
        tk+0S+CpVCea/VF+hAPSQl+MDjY6PfVEqR1ZwYtk
X-Google-Smtp-Source: ABdhPJxpFjZSM+ON+ZEx1LwnBU7pVSr/9xcqF3VgHpvRwH8y4ZyonmlFTRJzEhVD6b6nHkftiyuQKbVHtMLwzp4xg2QB
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:7b93:b029:12b:a0a5:78d2 with
 SMTP id w19-20020a1709027b93b029012ba0a578d2mr20275593pll.51.1627420306052;
 Tue, 27 Jul 2021 14:11:46 -0700 (PDT)
Date:   Tue, 27 Jul 2021 14:11:42 -0700
In-Reply-To: <87v94wqi6k.fsf@evledraar.gmail.com>
Message-Id: <20210727211142.2570867-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87v94wqi6k.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: Re: [PATCH v2 2/3] send-pack: fix push nego. when remote has refs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        emilyshaffer@google.com, gitster@pobox.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Thu, Jul 15 2021, Jonathan Tan wrote:
> 
> > Commit 477673d6f3 ("send-pack: support push negotiation", 2021-05-05)
> > did not test the case in which a remote advertises at least one ref. In
> > such a case, "remote_refs" in get_commons_through_negotiation() in
> > send-pack.c would also contain those refs with a zero ref->new_oid (in
> > addition to the refs being pushed with a nonzero ref->new_oid). Passing
> > them as negotiation tips to "git fetch" causes an error, so filter them
> > out.
> >
> > (The exact error that would happen in "git fetch" in this case is a
> > segmentation fault, which is unwanted. This will be fixed in the
> > subsequent commit.)
> 
> Let's add the test from the subsequent here as a test_expect_failure and
> flip it to "success".

What is the subsequent?

> > @@ -425,8 +425,10 @@ static void get_commons_through_negotiation(const char *url,
> >  	child.no_stdin = 1;
> >  	child.out = -1;
> >  	strvec_pushl(&child.args, "fetch", "--negotiate-only", NULL);
> > -	for (ref = remote_refs; ref; ref = ref->next)
> > -		strvec_pushf(&child.args, "--negotiation-tip=%s", oid_to_hex(&ref->new_oid));
> > +	for (ref = remote_refs; ref; ref = ref->next) {
> > +		if (!is_null_oid(&ref->new_oid))
> > +			strvec_pushf(&child.args, "--negotiation-tip=%s", oid_to_hex(&ref->new_oid));
> > +	}
> >  	strvec_push(&child.args, url);
> 
> This will run into my eff40457a4 (fetch: fix segfault in
> --negotiate-only without --negotiation-tip=*, 2021-07-08) if we supply a
> --negotiate-only without --negotiation-tip=, but trying it it looks like
> even when you push to an empty repo and your repo is itself empty we'll
> always add the tip you're pushing as the negotiation tip.
> 
> Let's add a test for that, i.e. I instrumented your test to check what
> happens whe I do the push without any remote/local refs, both for
> one/both cases (and both combinations), it seems to work...

I'm not sure how useful this no-ref test will be, because if my existing
tests are correct, the thing we're pushing is guaranteed to be in this
list (so the list will be non-empty).

> For code that's doing a loop over "refs" testing that seems to be
> worthwhile, i.e. we don't actually depend on "refs" in the sense that
> they exist, but the refs we've constructed in-memory to be created on
> the remote, correct?

Yes.

> But also: looking at the trace output we already have the ref
> advertisement at this point, so in the case of an empty repo we'll see
> it has no refs, but then we're going to provide a --negotiation-tip=*
> pointing to our local OID anyway.

Hmm...are you running under protocol v0? In protocol v2, there should be
no ref advertisement at this point.

> That seems like a fairly non-obvious edge case that should be called out
> / tested.
> 
> I.e. aren't we at least just going to engage in redundant work there in
> trying to negotiate with empty repos, or is it going to noop anyway.
> 
> Or maybe we'll get lucky and they have the OID already, they just
> recently deleted their reference(s), then we won't need to send as much
> over? Is that what this is trying to do?
> 
> But hrm, won't that sort of thing increase the odds of repository
> corruption?

No, trying to be lucky in finding an OID that the server has no plans of
advertising is not the aim.

> I.e. now we make the implicit assumption that an OID we see in the
> advertisement is one the server isn't going to aggressively prune while
> our push is underday (Jeff King has a good E-Mail summarizing that
> somewhere, not digging it up now, but I could...).
> 
> So such a remote will negotiate with us using that OID, but unlike with
> advertised OIDs we can't safely assume that the OID won't be racily
> deleted during our negotiation.
> 
> Or maybe I'm entirely wrong here....

There's always the risk that the server will say it has something and
then aggressively prune it, but I think that all fetch/push code has to
deal with it. A more realistic scenario is that one server in a
load-balanced arrangement advertises a commit that the other does not
have, but we are unlikely to be affected by that here because the ref
negotiation would usually concern old commits that the local user has
built upon, not the very latest commits that someone else just pushed.
