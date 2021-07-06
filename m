Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E25C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E923B61C85
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhGFUmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 16:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhGFUmg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 16:42:36 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB860C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 13:39:56 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id l17-20020a9d6a910000b029048a51f0bc3cso35161otq.13
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 13:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ypGRnniyuhSj/+uIKtssk/wxVjW5jsQ3q9qnmYw6O58=;
        b=ugmf8t/d+9JdyUJNRM4rucj9pNDMmec8byYMFUF6ajJqcePRAQHvWcSe6UCo40Mued
         WRyz4+YekflVJf+a2D0JLrT+EjVHY6AAKj4vMg5tG/u8fuSGGmKoyqwVhLj5ZgpOOcoF
         kBUqUvU5hIuIIMS6YurtYyppyMjn7VY7felJolr0VBaTO6VSscwY1GBR9gbSWB76ZOSd
         nEMZ0h+Rxm2CBQGKkgzTKnWaNOh9Qqo/bPqxVgybRrE3NZV06HqjMeItK6pvMiYCGal+
         JK9jS8dFtWUK8ImimLJcMEilPftTDVJZWO32F/oo15VVsD6/U44H7QHO7ZqdjXySNbVY
         txlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ypGRnniyuhSj/+uIKtssk/wxVjW5jsQ3q9qnmYw6O58=;
        b=ETo2sBwW9j6u5YUw51XYXHOic75L7tUprFJ00lLy5VS1jvkgDcB2hHLm+/04t472cV
         MGVJRSfxaJlewcakgGh+wxRiOC+qgdAN7Ey9fQLK2/ENtxpz7Cd1MQURER0y1qPokxCc
         gdsTFgVqGKBhDAg6dneDCqQczlbqG6WQ9BVY9Rv9ccZUETG4PHtpAg2mc9P9uTnP9pdX
         oA8SsMrJ+X1V/S2jVBUDvCvg+GCj9RC+eLGUi8V5BlslVmU5S8SiByxsNdimlhPACgcl
         4GXLRnmyFJOsXp+F+7YNHshJ84z0loIIpHP83bg8UM7ju+yPvtorP6BzUrzQRt2/pUTo
         9p7Q==
X-Gm-Message-State: AOAM532vLATRuTA1h3Y6RyxCN95TO0665R2IbN/45JSzio06YefECu9T
        VM2xyHiH1o0RWIg63bSR0m0=
X-Google-Smtp-Source: ABdhPJz57VQaM9vOPGiA8yhVWENK2g4LXYvGaW+VGkxZp1UwadOg5jO12tg4eizSUOc7AC5MJEwSnA==
X-Received: by 2002:a05:6830:18d:: with SMTP id q13mr16330861ota.253.1625603996195;
        Tue, 06 Jul 2021 13:39:56 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id h24sm3585659otl.41.2021.07.06.13.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 13:39:55 -0700 (PDT)
Date:   Tue, 06 Jul 2021 15:39:54 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60e4bf9a6a628_1c4281208b@natae.notmuch>
In-Reply-To: <87bl7f5ho1.fsf@evledraar.gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
 <20210705123209.1808663-2-felipe.contreras@gmail.com>
 <87bl7f5ho1.fsf@evledraar.gmail.com>
Subject: Re: [RFC PATCH 01/35] merge: improve fatal fast-forward message
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Mon, Jul 05 2021, Felipe Contreras wrote:
> =

> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  builtin/merge.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/builtin/merge.c b/builtin/merge.c
> > index a8a843b1f5..05e631229d 100644
> > --- a/builtin/merge.c
> > +++ b/builtin/merge.c
> > @@ -1620,7 +1620,7 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
> >  	}
> >  =

> >  	if (fast_forward =3D=3D FF_ONLY)
> > -		die(_("Not possible to fast-forward, aborting."));
> > +		die(_("unable to fast-forward"));
> =

> I read the existing message a bit more like "this makes no sense
> anymore" (correct) and the latter more like "we encountered an
> error".

I mean, this is the documentation of --ff-only:

  With `--ff-only`, resolve the merge as a fast-forward when possible.
  When not possible, refuse to merge and exit with a non-zero status.

So if you do `git merge --ff-only` you are telling git: "I want you to
exit with an error when the fast-forward is not possible".

If you do:

  % git merge --ff-only
  fatal: Not possible to fast-forward, aborting.

That "aborting" part is redundant; we know `git merge` should abort if
the fast-forward is not possible, we explicitely told git to do that.

Moreover the "fatal: " prefix also indicates that git aborted.

Then you have "Not possible to fast-forward", which if memory serves
well should be in lowercase (altghough can't find that in the
guidelines).

"unable to fast-forward" is simply a more succinct way of saying
"not possible to fast-forward". Sure, we are not explaining why,
although I can't think of any other reason why we could not fast-forward.=


> Perhaps something like:
> =

>     "Can't merge X with Y, in --ff-only mode, would need to create a me=
rge commit", tip_name

I don't think die() messages should be that big, how about?

  branches diverged, can't fast-forward

-- =

Felipe Contreras=
