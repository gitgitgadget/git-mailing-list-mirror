Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481BFC77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 21:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjECVWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 17:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECVWP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 17:22:15 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9076190
        for <git@vger.kernel.org>; Wed,  3 May 2023 14:22:13 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-b9246a5f3feso9070179276.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 14:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683148933; x=1685740933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LZm1Nj3M4FPGb0R/uYH8ksxQ3CeVEbyZjGJFf/pR26c=;
        b=SpjaylB9yEMS4kR/H0Z5z6+VSY0VRFDdaG/SeQcXEKNDecs1+5iQEHFeEft+7JTE98
         PbFKG2aHIUBYN4z30FXE1mRqZAZhyArXLXTvJaSi/NrPDpWIz5jnTFD9tUQ6BD2pYiNv
         L2pLq9317GlH7VMhSAT7oe/fseF/9SKY6oZh/2IYoVeU46nRM+aC+id7XqOKtv0jGceu
         9xgGbLKzlx1IV2FhKWhk6M6q37K0y5CRF0qh6x5BV4SwtY6m3cknfBG15bUSUtp7IXpg
         ec+rmxpSRISY8cAGADMbaAAl6Aw7dgAyODR8tRfbvOUDX/dUc2RMJmyq0fPXEyD1u/pR
         wARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683148933; x=1685740933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZm1Nj3M4FPGb0R/uYH8ksxQ3CeVEbyZjGJFf/pR26c=;
        b=OTbmYJ6xWHjHkoO/fhZaCKc4nhI+4frIiRzaeAFPbEPr6hWRKorfNoJdQ+nH+U+MZY
         B8Fo3lvjnovr9FIU78Oz7o520P3hHjKs9C6Wg4UAmqJa82TpyrAK8LvCLG3vda5Wuswv
         mJJsCma5RatEWQWQ1AnFZkdwLZONHvyYvPij0XnYlyHmyuWKj5xV4XjAdikpkHPs9okP
         VY1qh6Wd1/9oUONY+VCAK3BMr/qKIANdSWu4IkN6quwphi1wCgrDoj9qsqkqc/XpOWn4
         ZSQAsRw2yRbTy2yYPgrua9l1jh6kgrxwr5RkHlccLgUUxecCm7/aS9GUe+21rT7DOOWN
         f1Mw==
X-Gm-Message-State: AC+VfDzubt2TbTDJQ3NBUaau0V3SQtiKsiGVhCtp9lVi3i2qKJmYq059
        V4ucCeFp7jTSaflK/PLwFkFR6Q==
X-Google-Smtp-Source: ACHHUZ5NoU+JbI0EsIz3qOzfvgRXyX9R6NbHtAlAuZJe2UELxojxsOimebkDtBs0BHAgK1YSub5ceQ==
X-Received: by 2002:a05:6902:154c:b0:b9e:45e1:3ff with SMTP id r12-20020a056902154c00b00b9e45e103ffmr11503479ybu.42.1683148932878;
        Wed, 03 May 2023 14:22:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i125-20020a255483000000b00b9a65b05384sm4205845ybb.15.2023.05.03.14.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 14:22:12 -0700 (PDT)
Date:   Wed, 3 May 2023 17:22:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] builtin/pack-objects.c: introduce
 `pack.extraCruftTips`
Message-ID: <ZFLQfMtIGcZHNERE@nand.local>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
 <73ad7b90e1fe6c15f41ff828651f7ab06076ffd8.1683072587.git.me@ttaylorr.com>
 <20230503195906.GA1796816@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230503195906.GA1796816@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 03, 2023 at 03:59:06PM -0400, Jeff King wrote:
> On Tue, May 02, 2023 at 08:09:47PM -0400, Taylor Blau wrote:
>
> > However, there is no option to be able to keep around certain objects
> > that have otherwise aged out of the grace period. The only way to retain
> > those objects is:
> >
> >   - to point a reference at them, which may be undesirable or
> >     infeasible,
> >   - to track them via the reflog, which may be undesirable since the
> >     reflog's lifetime is limited to that of the reference it's tracking
> >     (and callers may want to keep those unreachable objects around for
> >     longer)
> >   - to extend the grace period, which may keep around other objects that
> >     the caller *does* want to discard,
> >   - or, to force the caller to construct the pack of objects they want
> >     to keep themselves, and then mark the pack as kept by adding a
> >     ".keep" file.
>
> OK, I understand the use case you're trying to support, and your
> approach mostly makes sense. But there are two things I was surprised by
> in the implementation:
>
>   1. Does this need to be tied to cruft packs? The same logic would
>      apply to "repack -A" which turns objects loose (of course you
>      probably don't want to do that in the long term for performance
>      reasons, but it's conceptually the same thing; see below).
>
>   2. Why is there a separate walk distinct from the one that rescues
>      recent-but-unreachable objects?

> Conceptually it seems to me that the simplest and most flexible way to
> think of this new feature is: pretend these objects are recent enough to
> be kept in the grace period, even though their mtimes do not qualify".
>
> And then everything else would just fall out naturally. Am I missing
> something?

I originally shied away from it, thinking that I wouldn't want to do an
expensive walk with all of the recent objects during a non-pruning
repack.

The two code paths are quite different in practice. In the pruning case,
we add only new objects from the kept packs and then start our traversal
there. In the non-pruning case, we just do
`add_objects_in_unpacked_packs()` which is really just a call to
`for_each_packed_object()`.

So it gets tricky when you have a pack.extraCruftTips program and want
to invoke it in a non-pruning case. You could do something like:

  - call enumerate_and_traverse_cruft_objects() *always*, either because
    we were doing a pruning GC, or calling it after
    `enumerate_cruft_objects()` (in the non-pruning case)

  - ensure that enumerate_and_traverse_cruft_objects() is a noop when
    (a) cruft_expiration is set to zero, and (b) there are no
    pack.extraCruftTips programs specified

> > +static int enumerate_extra_cruft_tips_1(struct rev_info *revs, const char *args)
> > +{
> > +	struct child_process cmd = CHILD_PROCESS_INIT;
> > +	struct strbuf buf = STRBUF_INIT;
> > +	FILE *out = NULL;
> > +	int ret = 0;
> > +
> > +	cmd.use_shell = 1;
> > +	cmd.out = -1;
> > +
> > +	strvec_push(&cmd.args, args);
> > +	strvec_pushv(&cmd.env, (const char **)local_repo_env);
>
> Why does this clear the environment of local-repo variables? That seems
> unlike most other hooks we have, and would cause confusion if $GIT_DIR
> or various config variables are important (e.g., should "git -c foo.bar
> gc" persist foo.bar when running the hook? It usually does).
>
> I know that some hooks that try to change repositories by changing
> directories have the opposite confusion ($GIT_DIR is set, but they did
> not want it). But it makes more sense to me to remain consistent with
> how other hooks behave.

Copy-and-pasted from the core.alternateRefsCommand stuff, there is no
need for this here.

> > +	if (start_command(&cmd)) {
> > +		ret = -1;
> > +		goto done;
> > +	}
>
> This may be a matter of taste, but you can "return -1" directly here, as
> nothing has been allocated (and a failed start_command() will call
> child_process_clear() for you). This would mean "out" is always set in
> the "done:" label, so it wouldn't need a NULL-check (nor an
> initialization).

Very nice, thanks for the suggestion.

> > +
> > +	out = xfdopen(cmd.out, "r");
> > +	while (strbuf_getline_lf(&buf, out) != EOF) {
>
> is there any reason to be a stickler for LF versus CRLF here? I.e.,
> wouldn't strbuf_getline() be more friendly, with little chance that we
> misinterpret the result?

No reason, other than I happened to type this one out first ;-). We
should definitely be more permissive here, I agree that strbuf_getline()
is the friendlier choice.

> > +		struct object_id oid;
> > +		struct object *obj;
> > +		const char *rest;
> > +
> > +		if (parse_oid_hex(buf.buf, &oid, &rest) || *rest) {
> > +			ret = error(_("invalid extra cruft tip: '%s'"), buf.buf);
> > +			goto done;
> > +		}
> > +
> > +		obj = parse_object(the_repository, &oid);
> > +		if (!obj)
> > +			continue;
>
> This parse_object() can be pretty expensive, especially if you are
> rescuing a lot of objects (or if your program directly references large
> blobs). Can we use oid_object_info() here in combination with
> lookup_object_by_type()?

Yep, definitely. Nice catch ;-).

Thanks,
Taylor
