Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76809C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 18:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4496120722
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 18:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YSRrBI3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfL3SiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:38:06 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:54638 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfL3SiF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 13:38:05 -0500
Received: by mail-vk1-f202.google.com with SMTP id b68so7977064vkh.21
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 10:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BXor36qigWiytS67QOq7/kGUwZRz6hgn6BHuHQ5JTYU=;
        b=YSRrBI3r2HRxcYsBaaUfyDsIIiZy1+xuGLWpCEpdn2RnCeBiYV5uMjuGKq52NbN8Ik
         ueo/f94ppeCiBEmor/5BZuStAV2PmmJ84gK2mE/WT1HsKacuPp945gU4HTPSn9VWAdYV
         Wp5O54M6jgfnk7IZ2sLTbNS2/DuYiRa5+61RThGbFs60X6AWUT5YATG92KHoTkv7JC9a
         PL1kANjOVwBcdXYWzU3SncWIBvKgXKN995SG/wvp6NSxLH9MPqlEnKUIUuuA5ygwC2kN
         1gPTS1qGK5TrSkzyWEVTK3nSLUo4CDDlXjeGVMyYiTFlooml/wAnJEX2DNhUpsFgvhPg
         BvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BXor36qigWiytS67QOq7/kGUwZRz6hgn6BHuHQ5JTYU=;
        b=V9GlyurvDA472GoMLxyFcX0oC04S6fxhNkXszk4dQtv/mQskKitKSFYaLPR+QaPX8Q
         wTYml6jbfpM1xR9/ElMZSfwZJj7kjTXpgZJQ3gJGyoc6QY9GePwzUGtFXlxT1W4HX40h
         g4X20oiv2vVTn2/rGCyvMsF7H2woGFKTWcMb9pBG16GYYKUa89tAWqzLP0b6VzIhP/Uv
         o51fz8c8u5YAZBQbNZxKJz/sRx8/g6ScxaV38ZweRC/D4CF63dhUAfxBURactCXxJ1q3
         PdfxXnnWJBQe4tZpqeOpoXBZsgP730aUhf1gruIdldlCkUkmmjSGwxDrsb0d91lnhwMV
         CImQ==
X-Gm-Message-State: APjAAAU+c6UzGjnVLWpRYKL/h8MvPovWnf1uG9GDac0BMFaDiV5f4Jro
        6Ps6LqJOTLNq/DFWSTxe1x6hDuFrugLXTa3zmKYy
X-Google-Smtp-Source: APXvYqxUgbrI/EvsYdsQ3fdfxLuGaitnuerZLFcIlXR9+B+IapSkAmFYsBioRuxemlaxvUFztxWE2wQnr6mPCWZjY5FL
X-Received: by 2002:ab0:2e92:: with SMTP id f18mr39770800uaa.143.1577731084573;
 Mon, 30 Dec 2019 10:38:04 -0800 (PST)
Date:   Mon, 30 Dec 2019 10:38:01 -0800
In-Reply-To: <xmqqlfqxhzvu.fsf@gitster-ct.c.googlers.com>
Message-Id: <20191230183801.28538-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqlfqxhzvu.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: Re: [PATCH] revision: allow missing promisor objects on CLI
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, matvore@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >  	object = get_reference(revs, arg, &oid, flags ^ local_flags);
> >  	if (!object)
> > -		return revs->ignore_missing ? 0 : -1;
> > +		/*
> > +		 * Either this object is missing and ignore_missing is true, or
> > +		 * this object is a (missing) promisor object and
> > +		 * exclude_promisor_objects is true.
> 
> I had to guess and dig where these assertions are coming from; we
> should not force future readers of the code to.
> 
> At least this comment must say why these assertions hold.  Say
> something like "get_reference() yields NULL on only such and such
> cases" before concluding with "and in any of these cases, we can
> safely ignore it because ...".

OK, will do.

> I think the two cases the comment covers are safe for this caller to
> silently return 0.  Another case get_reference() yields NULL is when
> oid_object_info() says it is a commit but it turns out that the
> object is found by repo_parse_commit() to be a non-commit, isn't it?
> I am not sure if it is safe for this caller to just return 0.  There
> may be some other "unusual-but-not-fatal" cases where get_reference()
> does not hit a die() but returns NULL.

I don't think there is any other case where get_reference() yields NULL,
at least where I based my patch (99c33bed56 ("Git 2.25-rc0",
2019-12-25)). Quoting the entire get_reference():

> static struct object *get_reference(struct rev_info *revs, const char *name,
>                                     const struct object_id *oid,
>                                     unsigned int flags)
> {
>         struct object *object;
> 
>         /*
>          * If the repository has commit graphs, repo_parse_commit() avoids
>          * reading the object buffer, so use it whenever possible.
>          */
>         if (oid_object_info(revs->repo, oid, NULL) == OBJ_COMMIT) {
>                 struct commit *c = lookup_commit(revs->repo, oid);
>                 if (!repo_parse_commit(revs->repo, c))
>                         object = (struct object *) c;
>                 else
>                         object = NULL;
>         } else {
>                 object = parse_object(revs->repo, oid);
>         }

No return statements at all prior to this line.

>         if (!object) {
>                 if (revs->ignore_missing)
>                         return object;

Return NULL (the value of object).

>                 if (revs->exclude_promisor_objects && is_promisor_object(oid))
>                         return NULL;

Return NULL.

>                 die("bad object %s", name);

Die (so this function invocation never returns). In conclusion, if
object is NULL at this point in time, get_reference() either returns
NULL or dies.

>         }

Since get_reference() did not return NULL or die, object is non-NULL
here.

>         object->flags |= flags;
>         return object;

Nothing has overridden object since, so we're returning non-NULL here.

> }

So I think get_reference() only returns NULL in those two safe cases.
(Or did I miss something?)
