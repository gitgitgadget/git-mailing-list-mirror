Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5021FC432BE
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 08:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E9E61057
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 08:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbhG0IXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 04:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235970AbhG0IXk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 04:23:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE48C061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 01:22:47 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id qk33so2200028ejc.12
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 01:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=a5kw2DrIxYbhM7kRE0Q+4NyEIPuPDTzsgAuC/baYO74=;
        b=HFRip5+n3C/RT37w8wft/2XqxH0vXSxKADammm7ohwq0IOpgL8Xc1fh96cailYBla7
         6iALSLmMHR5KeSX31P6a4P2YynSrBjpvxeTMBet902o2P+bP7Jk6BWjvZw2HnrK1zo90
         Rwgy5ZarJ2uM5bxknHbb4jomGcDEKjEgd71C9YYWQbNrjD6l1WD64Hx/kHvEh5fbiRHI
         IAGUigiVMZ1oK2b24OGMEYMxfn6dCoJsviIthy0rq1zS/rl9lZUAe8U9ssbcjxZNlgpO
         M2mjqWzY7e06DFRyt5RHqiN2NJtpJk56y89TOI+I9XrykoFYoLmXIFNzbPkxrqKiHULo
         PXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=a5kw2DrIxYbhM7kRE0Q+4NyEIPuPDTzsgAuC/baYO74=;
        b=ZZZT/SrXXMruubITFIdNELp2DghYevIpiJYVam+ewtmmNCTD/XUYq7zh7xGYpDthmV
         nsnrxBlFVzOENw3gvubSk8YlsVl7N8LVVlRMOH8cGuWTiptwFFmrAv2LQ6xXnq8T2ct/
         b4FUb2shz+BvIai7E2rgCRi6GHIfEWKZ5+QXS8Yhq4GvYUMzQ6RlTTRZK/HrDQhUtCL2
         GUIOebeBD+3VSvmB/GKzRMb38VipB/D5zJmpMMs/LI/YO23RucWD70VTLbAyOc1GqzXU
         2SmrZq27ZoeQ4VIP+jHVkwG93xfQ8IpIvshTWiusciSPcK4tlcCzNINqju7jpNoBfbJY
         PxaA==
X-Gm-Message-State: AOAM533JoDVmLRfRqL2PUyL3iyGLBDv39/gSmcRpPyKzmCl+oC7+JUfG
        z8kOHWucJF9uz0RjygsomluxQQJzzCN6rg==
X-Google-Smtp-Source: ABdhPJwRenuSSuWvybFDHlDW90UDzlb/MDGYR2ONbJ3t8mZ5o2iXoL/jVYD0R4SX1WPJnvQDOSyF7A==
X-Received: by 2002:a17:906:9d17:: with SMTP id fn23mr21328549ejc.191.1627374165734;
        Tue, 27 Jul 2021 01:22:45 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id a5sm922411edj.20.2021.07.27.01.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 01:22:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] send-pack: fix push nego. when remote has refs
Date:   Tue, 27 Jul 2021 10:09:35 +0200
References: <cover.1624486920.git.jonathantanmy@google.com>
 <cover.1626370766.git.jonathantanmy@google.com>
 <c8416933035849e40b88c29f1d5fa91064ca0c8a.1626370766.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <c8416933035849e40b88c29f1d5fa91064ca0c8a.1626370766.git.jonathantanmy@google.com>
Message-ID: <87v94wqi6k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 15 2021, Jonathan Tan wrote:

> Commit 477673d6f3 ("send-pack: support push negotiation", 2021-05-05)
> did not test the case in which a remote advertises at least one ref. In
> such a case, "remote_refs" in get_commons_through_negotiation() in
> send-pack.c would also contain those refs with a zero ref->new_oid (in
> addition to the refs being pushed with a nonzero ref->new_oid). Passing
> them as negotiation tips to "git fetch" causes an error, so filter them
> out.
>
> (The exact error that would happen in "git fetch" in this case is a
> segmentation fault, which is unwanted. This will be fixed in the
> subsequent commit.)

Let's add the test from the subsequent here as a test_expect_failure and
flip it to "success".

> @@ -425,8 +425,10 @@ static void get_commons_through_negotiation(const char *url,
>  	child.no_stdin = 1;
>  	child.out = -1;
>  	strvec_pushl(&child.args, "fetch", "--negotiate-only", NULL);
> -	for (ref = remote_refs; ref; ref = ref->next)
> -		strvec_pushf(&child.args, "--negotiation-tip=%s", oid_to_hex(&ref->new_oid));
> +	for (ref = remote_refs; ref; ref = ref->next) {
> +		if (!is_null_oid(&ref->new_oid))
> +			strvec_pushf(&child.args, "--negotiation-tip=%s", oid_to_hex(&ref->new_oid));
> +	}
>  	strvec_push(&child.args, url);

This will run into my eff40457a4 (fetch: fix segfault in
--negotiate-only without --negotiation-tip=*, 2021-07-08) if we supply a
--negotiate-only without --negotiation-tip=, but trying it it looks like
even when you push to an empty repo and your repo is itself empty we'll
always add the tip you're pushing as the negotiation tip.

Let's add a test for that, i.e. I instrumented your test to check what
happens whe I do the push without any remote/local refs, both for
one/both cases (and both combinations), it seems to work...

For code that's doing a loop over "refs" testing that seems to be
worthwhile, i.e. we don't actually depend on "refs" in the sense that
they exist, but the refs we've constructed in-memory to be created on
the remote, correct?

I.e. this on top would be OK (not saying you need this, but I for one
would find it easier to follow with this):
	
	diff --git a/send-pack.c b/send-pack.c
	index b3a495b7b1..d1e231076c 100644
	--- a/send-pack.c
	+++ b/send-pack.c
	@@ -420,15 +420,20 @@ static void get_commons_through_negotiation(const char *url,
	 	struct child_process child = CHILD_PROCESS_INIT;
	 	const struct ref *ref;
	 	int len = the_hash_algo->hexsz + 1; /* hash + NL */
	+	int got_tip = 0;
	 
	 	child.git_cmd = 1;
	 	child.no_stdin = 1;
	 	child.out = -1;
	 	strvec_pushl(&child.args, "fetch", "--negotiate-only", NULL);
	 	for (ref = remote_refs; ref; ref = ref->next) {
	-		if (!is_null_oid(&ref->new_oid))
	-			strvec_pushf(&child.args, "--negotiation-tip=%s", oid_to_hex(&ref->new_oid));
	+		if (is_null_oid(&ref->new_oid))
	+			continue;
	+		strvec_pushf(&child.args, "--negotiation-tip=%s", oid_to_hex(&ref->new_oid));
	+		got_tip = 1;
	 	}
	+	if (!got_tip)
	+		BUG("should get at least one ref tip, even with no remote/local refs");
	 	strvec_push(&child.args, url);
	 
	 	if (start_command(&child))

But also: looking at the trace output we already have the ref
advertisement at this point, so in the case of an empty repo we'll see
it has no refs, but then we're going to provide a --negotiation-tip=*
pointing to our local OID anyway.

That seems like a fairly non-obvious edge case that should be called out
/ tested.

I.e. aren't we at least just going to engage in redundant work there in
trying to negotiate with empty repos, or is it going to noop anyway.

Or maybe we'll get lucky and they have the OID already, they just
recently deleted their reference(s), then we won't need to send as much
over? Is that what this is trying to do?

But hrm, won't that sort of thing increase the odds of repository
corruption?

I.e. now we make the implicit assumption that an OID we see in the
advertisement is one the server isn't going to aggressively prune while
our push is underday (Jeff King has a good E-Mail summarizing that
somewhere, not digging it up now, but I could...).

So such a remote will negotiate with us using that OID, but unlike with
advertised OIDs we can't safely assume that the OID won't be racily
deleted during our negotiation.

Or maybe I'm entirely wrong here....
