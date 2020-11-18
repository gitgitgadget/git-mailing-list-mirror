Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B77C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 17:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C206A248B5
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 17:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgKRRVV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 12:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgKRRVU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 12:21:20 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2C5C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 09:21:20 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1605720077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=0wo5zPQ/S2tqYriBgdU7IKttDS/WIOtlk70JNTCOMag=;
        b=TXkrQIjZbthfk/MAL7hABTy0cVT3RBlOXdWvp03eAvMkKzvVbzTEQSdshW21A6alUtM4J0
        sGi6ASaN0sF8fGDMXcaA9JmuQEpD/SuI+k2DINUmRHnY100pwBW9n+eiNUTGJDsAk6rAaX
        D/f8+Ae5BK5I1T8FDx5svXAeApzMD3v9uQyU6NISHO8/0EEgRhyT93H/fZqFReYJ3isN/Z
        G6m8YWtDsOQGueuYdmH2dlsKr18dPk4Um2wFu35/TinNqzVm032F9gcx62sxjva0fs3Mc/
        FMNhu4PYO1dgsS2co/Lsp+fLc1mJTAuxmFPxaKP9XvLO17UQbZW6Jf/J40fDYw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH v3] help.c: configurable suggestions
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, "lanodan" <contact+git@hacktivis.me>
Date:   Wed, 18 Nov 2020 12:17:43 -0500
Message-Id: <C76K6Q09ATLR.1OI5KW390LKFX@taiga>
In-Reply-To: <xmqqima237qt.fsf@gitster.c.googlers.com>
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed Nov 18, 2020 at 12:16 PM EST, Junio C Hamano wrote:
> It is unclear from this description alone why this is needed. The
> seller of this change needs to emphasize how this is better than
> setting the variable to "0" (do not autocorrect). My guess is that
> some users do not even need the suggestion of correct spelling when
> they made a typo?

This is one reason. Another is that spell checking can be
computationally expensive, and take an annoyingly long time on low-end
devices.

> > @@ -706,10 +725,16 @@ NORETURN void help_unknown_ref(const char *ref, c=
onst char *cmd,
> >  			       const char *error)
> >  {
> >  	int i;
> > -	struct string_list suggested_refs =3D guess_refs(ref);
> > +	struct string_list suggested_refs;
> > =20
> >  	fprintf_ln(stderr, _("%s: %s - %s"), cmd, ref, error);
> > =20
> > +	if (autocorrect =3D=3D AUTOCORRECT_NEVER) {
> > +		exit(1);
> > +	}
>
> I am not sure how the change in this hunk is justifiable.

I think this was caught up in the move from a new config option to
changing the meaning of help.autocorrect.

> This is a tangent, but it seems to me that help_unknown_ref() is way
> under-used and lacks usefulness too much---probably these contribute
> to each other.

Given that this is under-utilized anyway, and no longer applicable to
the essential purpose of the patch, I'm just going to pull this change
out of the patch. If this function starts to enjoy broader usage within
git, we could revisit a config lever later on.

Thanks for the feedback, sending v4 shortly.
