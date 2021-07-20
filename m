Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236F2C636C8
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F286113B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhGTUbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 16:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbhGTUbG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 16:31:06 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13E1C0613DB
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 14:11:42 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id l188-20020a6325c50000b029022dedbd542bso11432221pgl.8
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 14:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sdf/ujj1KNLtMCV0NmD7P8FcOkGvwLPwlRlJ4E+bj+E=;
        b=uQ6mxinpCKTmuYWDYq5blhIiSFSuIGfG2vD0hmdvG+xpG5lpQJuW3NHENQtV6yDKu8
         NPPbmxL7z6AwIhxPtADbkycf4ND1uJhgP7cCrWJhhrVUPZXVrIZe870JAz6EAkjtJ179
         OheCkBiM+MOmi4V0bstYr6s4wKeV8r+9Luv4yispTOFx8ZTHBtUTqVN/Xp4qA/3Lah21
         o3y+1pu52SXRTAgxPQPuFjcrfmB9iw1E70UMRNJ+tQDn1tvA1vmPof3ptmNw9fvWoe51
         E1AVmGT/g8etD5s+jwjw0/GzJIG+fvkGsH8TG8BX9vDxHXhrzWzNewxEnMcR9FkojFz0
         OERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sdf/ujj1KNLtMCV0NmD7P8FcOkGvwLPwlRlJ4E+bj+E=;
        b=QUPoREJWqTjGHjSov38QwqHMtsmqcCL7HDjeTAl37v4f03LFXQyos/G7T5xlyWES6M
         fWTgXo1VzGnkjdLEjoUpRyKWZ+ybY9RfMYDqumF6utQXKjHje7ap0puk9Uem5X3KiBaF
         DqFlHo/sLNPzy7XG5FPsyTLsVRPZ58zcYM2WYn01tML9fZchZz2YXcTOhsctE3QHavDN
         OaIc2kqO/8q0F2kPjpqO7I71mKG2TlllO2Uziu88Yx4R34HEnGej6A0ta1sB4LClfqC+
         s2cqfa+7pMMaKklKk2OZZd1nT0/UQz5l1EVIsrnVw9jc13+yZrw4lCGLRNqrsuvzmcpl
         AgZQ==
X-Gm-Message-State: AOAM5318bDE9gdZTeU5GW9QYD7QSyeqfi4LYGT1HPB4d4GofbkqFMgiL
        pyYqXyy//669DFKVhHZR9pkcDHi2vqageSVBOHc9
X-Google-Smtp-Source: ABdhPJweoCGI7AsM8i0/WpZTW0cU7BeJ/+WJ07b7oaek+pdc/JoTSvmFcDFTef2ImTCzhC5PcplJtfjtN2xnlPQryqWx
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:4acd:: with SMTP id
 mh13mr1762749pjb.26.1626815502199; Tue, 20 Jul 2021 14:11:42 -0700 (PDT)
Date:   Tue, 20 Jul 2021 14:11:39 -0700
In-Reply-To: <xmqqzguij8nq.fsf@gitster.g>
Message-Id: <20210720211139.3592182-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqzguij8nq.fsf@gitster.g>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: Re: [RFC PATCH v2 2/2] hook: remote-suggested hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, iankaz@google.com,
        sandals@crustytoothpaste.net, avarab@gmail.com,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> OK.  Let's take this more as WIP.

Sounds good.

> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 2a2a03bf76..c2c8596aa9 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -1393,6 +1393,18 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
> >  			   branch_top.buf, reflog_msg.buf, transport,
> >  			   !is_local);
> >  
> > +	if (hook_should_prompt_suggestions()) {
> > +		for (ref = mapped_refs; ref; ref = ref->next) {
> > +			if (ref->peer_ref &&
> > +			    !strcmp(ref->peer_ref->name,
> > +				    "refs/remotes/origin/suggested-hooks")) {
> > +				fprintf(stderr, _("The remote has suggested hooks in refs/remotes/origin/suggested-hooks.\n"
> > +						  "Run `git hook install all` to install them.\n"));
> > +				break;
> > +			}
> > +		}
> 
> Hmph, do we really need to iterate over these mapped refs array?  It
> seems to me that it would be vastly simpler to check if that single
> ref exists after "clone" finishes depositing all the refs we are
> supposed to create.

Good point. I'll do that.

> > @@ -1313,6 +1314,22 @@ static int consume_refs(struct transport *transport, struct ref *ref_map)
> >  				 ref_map);
> >  	transport_unlock_pack(transport);
> >  	trace2_region_leave("fetch", "consume_refs", the_repository);
> > +
> > +	if (hook_should_prompt_suggestions()) {
> > +		struct ref *ref;
> > +
> > +		for (ref = ref_map; ref; ref = ref->next) {
> > +			if (ref->peer_ref &&
> > +			    !strcmp(ref->peer_ref->name,
> > +				    "refs/remotes/origin/suggested-hooks") &&
> > +			    oidcmp(&ref->old_oid, &ref->peer_ref->old_oid)) {
> > +				fprintf(stderr, _("The remote has updated its suggested hooks.\n"));
> > +				fprintf(stderr, _("Run 'git hook install all' to update.\n"));
> > +				break;
> 
> Again we _could_ do "remember if we had it and at where, and then
> compare after we fetch", but this _might_ be simpler.
> 
> I however do not know if it makes sense to have a separate loop just
> for this.  This should be done as a part of store_updated_refs(),
> no?

I'm OK with it in either place, but it seems to me that this is separate
from storing refs - the suggestion of hooks does not influence how the
refs are stored.

> On top of this patch, if we wanted to add yet another "this ref is
> special and pay attention to it when it got updated", it makes a lot
> more sense not to add yet another loop that is a copy of this one in
> consume_refs(), but roll the handling of that new ref into a loop
> that already exists.  And for the purpose of such an update, I do
> not see why that "loop that already exists" should not be the one
> that goes over ref_map in store_updated_refs().  For the same
> reason, "the remote-tracking ref 'origin/suggested-hooks' is special"
> can and should go to an existing loop in store_updated_refs(), no?

I think 2 loops makes sense - the existing one to store the refs, and
the new one I introduced in this patch that handles the special ref.
(And the handling of "yet another" special ref would be rolled into the
latter loop.) In this case, I think that these 2 loops should be
independent. For example, if the refs in Git are changed to be stored in
an append-only journal, the former loop would be deleted while the
latter loop remains; and if the refs were to be stored as a sorted
array, the former loop would be retained while the latter loop would be
changed to a binary search.

Having said that, I don't feel strongly about this, so if consensus is
that we should move it into stsore_updated_refs(), that's fine too.

> How does this interact with the "--dry-run" option, by the way?
> What if ref_map proposes to update this suggested-hooks ref, but
> "--atomic" fetch feature finds that some other branches do not
> fast-forward and we end up not updating the suggested-hooks ref,
> either?

Good point - I'll have to check these.

> So, unlike my earlier guess, it _might_ turn out that "remember the
> state before the fetch, see if the fetch actually updated and then
> report" could be simpler to design and implement.  I dunno.

That's true. Right now I'm using the refmap data structure, but perhaps
it's better to consult the ref from the ref backend before and after the
fetch.

Overall, thanks for taking a look. If you have time, I would also
appreciate comments on the overall idea of this series (the concept of
remote-suggested hooks in general, the way that the user finds out about
them, and how the user can make use of them). (Same message to other
potential reviewers - general design comments are potentially more
useful, because specific code comments can become moot if there needs to
be a change in the overall design.)
