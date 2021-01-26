Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CE4C4332E
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 907EE20674
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbhAZWBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392812AbhAZSOn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 13:14:43 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD33C061573
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 10:14:02 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id l2so10489527pgi.5
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 10:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8C6knr57ZecR7KsjCwhtEIg2h5ZPwMLc5mWkqrbqCvI=;
        b=D2FIODBYL2IEPzSuOxJd4MnJP9nmb0VJGrLOzQOOoJzaRtjJftTBy7cvIF09yvfnMe
         sJedibv7x7RyfADMB8tIpEIkR6A/kFycgaqrJcLErWqk8lwfRcwoA0SrJeY5FDsxEvg+
         zqtq2JBCsdc5QYet8qkc8eqjbA+3KRWcn+PQFnKoky069QVimhKwNuIenoADGKSoIRR8
         ReAeD+xVKGyatG91Qhrk+2sJCVvQ8ESJb8Q123GQCO/Qs/PUQh0xLtVzJO4J3sQ84GRm
         S0LBBT3WXtWFyUSRQzEwjaH90OkswP18QOLmWAiRKJU8YzKVe4Ak+iwJeE5KY4fDoGfF
         WinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8C6knr57ZecR7KsjCwhtEIg2h5ZPwMLc5mWkqrbqCvI=;
        b=n6kDe1++Gary8FKS5NNwcKdhLgQ6ztBQXUwKlc937Sif7EOM83Fro3sfO/5tX7sW3T
         c+JdXLZ81k0mzsawmEh7mPVHSgkkkfBnoeXlB74B0vyiVuTfOLrjOnW1qtah3RGUCBa4
         U+WTTjMxAZcV0IXQgfD9W58cdqcfR7MAYEe4ZPcg/zu/Wb7Y3Raboq+Yt8xPkf3qWP98
         3JSSXR137fp/B9DP6QiX40YLxqlVsVH8EF5GEKzhjqbP7+VXla3ZP1Q1likROr3ZUXRI
         hGrw1xq7LfHFcnbQwJPPfi0KMYOdRolkyoBmGH9duG7Bmq6y1/fDmTHhZtvGl7qwWXND
         mqSg==
X-Gm-Message-State: AOAM532eXgnuufPrIkFLswj81V8CGAZvhIsI8yhXMmqdVLX0iADeOxui
        VAKoc0C9DAsB9ezlEgVEHXoQS4mnIqZApDLtodDX
X-Google-Smtp-Source: ABdhPJy+qIYea5fpsLY1Wz0yh3hOmU+uynEm+gtc6tpuQBa+NTU1jEdgYgPkjOeJ7U8KGxUbopU4w+YKqbqiRwfVT/nQ
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:79d8:0:b029:1bf:1fdb:4ae8 with
 SMTP id u207-20020a6279d80000b02901bf1fdb4ae8mr6573715pfc.58.1611684842038;
 Tue, 26 Jan 2021 10:14:02 -0800 (PST)
Date:   Tue, 26 Jan 2021 10:13:58 -0800
In-Reply-To: <YAnotHAiuSz4Du/0@coredump.intra.peff.net>
Message-Id: <20210126181358.2333028-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YAnotHAiuSz4Du/0@coredump.intra.peff.net>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: Re: [PATCH v4 1/3] ls-refs: report unborn targets of symrefs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Dec 22, 2020 at 01:54:18PM -0800, Jonathan Tan wrote:
> 
> > -static int ls_refs_config(const char *var, const char *value, void *data)
> > +static void send_possibly_unborn_head(struct ls_refs_data *data)
> >  {
> > +	struct strbuf namespaced = STRBUF_INIT;
> > +	struct object_id oid;
> > +	int flag;
> > +	int oid_is_null;
> > +
> > +	memset(&oid, 0, sizeof(oid));
> > +	strbuf_addf(&namespaced, "%sHEAD", get_git_namespace());
> > +	resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag);
> 
> It feels weird to call resolve_ref_unsafe() without checking the return
> value. How do we detect errors?
> 
> I think the logic is that we make assumptions about which fields it will
> touch (i.e., zeroing the flags, and not touching our zero'd oid), and
> then check those. That feels a bit non-obvious and intimate with the
> implementation, though (and was presumably the source of the "oops, we
> need to clear the oid bug between v3 and v4).
> 
> I feel like that deserves a comment, but I also wonder if:
> 
>   refname = resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag);
>   if (!refname)
> 	return; /* broken, bad name, not even a symref, etc */

From my reading of this part of refs_resolve_ref_unsafe():

                if (!(read_flags & REF_ISSYMREF)) {
                        if (*flags & REF_BAD_NAME) {
                                oidclr(oid);
                                *flags |= REF_ISBROKEN;
                        }
                        return refname;
                }

it seems that resolve_ref_unsafe() returns non-NULL if the ref is not a
symref but is otherwise valid. But this is exactly what we want -
send_possibly_unborn_head() must send HEAD in this situation anyway.
Thanks - I've switched to checking the return value.

(It was a bit confusing that refs_resolve_ref_unsafe() returns one of
its input arguments if it succeeds and NULL if it fails, but that's
outside the scope of this patch, I think.)

> > +	if (!oid_is_null ||
> > +	    (data->unborn && data->symrefs && (flag & REF_ISSYMREF)))
> > +		send_ref(namespaced.buf, oid_is_null ? NULL : &oid, flag, data);
> 
> It likewise feels a bit funny that we determine the symref name in the
> earlier call to resolve_ref_unsafe(), but we do not pass it here (and in
> fact, we'll end up looking it up again!).
> 
> But that is not much different than what we do for normal refs passed to
> the send_ref() callback. It would be nice if the iteration could pass in
> "by the way, here is the symref value" to avoid that.

Yes, that would be nice.

> But in practice it
> isn't a big deal, since we only do the lookup when we see the ISSYMREF
> flag set. So typically it is only one or two extra ref resolutions.

OK.

> > @@ -91,7 +118,7 @@ int ls_refs(struct repository *r, struct strvec *keys,
> >  
> >  	memset(&data, 0, sizeof(data));
> >  
> > -	git_config(ls_refs_config, NULL);
> > +	git_config(ls_refs_config, &data);
> 
> You will probably not be surprised that I would suggest defaulting
> data->allow_unborn to 1 before this config call. :)

I don't think many people have made comments either way, so I'll go
ahead with defaulting it to true. I can see arguments for both sides.

> > @@ -103,14 +130,31 @@ int ls_refs(struct repository *r, struct strvec *keys,
> >  			data.symrefs = 1;
> >  		else if (skip_prefix(arg, "ref-prefix ", &out))
> >  			strvec_push(&data.prefixes, out);
> > +		else if (data.allow_unborn && !strcmp("unborn", arg))
> > +			data.unborn = 1;
> >  	}
> 
> So if we have not set allow_unborn, we will not accept the client saying
> "unborn". Which makes sense, because we would not have advertised it in
> that case.
> 
> But we use the same boolean for advertising, too. So this loses the
> "allow us to accept it, but not advertise it" logic that your earlier
> versions had, doesn't it?

Yes, it does.

> And that is the important element for making
> things work across a non-atomic deploy of versions.
> 
> This straight-boolean version works as long as you can atomically update
> the _config_ on each version. But that seems like roughly the same
> problem (having dealt with this on GitHub servers, they are not
> equivalent, and depending on your infrastructure, it definitely _can_ be
> easier to do one versus the other. But it seems like a funny place to
> leave this upstream feature).

Well, I was just agreeing with what you said [1]. :-)

[1] https://lore.kernel.org/git/X9xJLWdFJfNJTn0p@coredump.intra.peff.net/

> Or is the intent that an unconfigured reader would silently ignore the
> unborn flag in that case? That would at least not cause it to bail on
> the client in a mixed-version environment. But it does feel like a
> confusing result.

Right now, an old server would ignore "unborn", yes. I'm not sure of
what the intent should be - tightening ls-refs and fetch to forbid
unknown arguments seems like a good idea to me.
