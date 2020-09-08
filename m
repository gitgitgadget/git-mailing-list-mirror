Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D87C43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF7E720578
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bW/GiX2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbgIHToW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729791AbgIHPvq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 11:51:46 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8463CC061348
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 08:49:08 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id v123so4280181qkd.9
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 08:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9rJz2VuY4IfP7+nNqN3pctJ1eYK9/4qdDjNdgoSdskE=;
        b=bW/GiX2HvwqykRQ3T3WXu/i7Ok7/+isz+XLXd2SlmmgcZku6VQoY9F5bHwSBxh8XAW
         voFc0DbJ05d8gg3hTpEUJZ8eqXdb4JXGeoULh6ohw2hL/AesLStUx1Uo8DKUiuNscfKo
         VjXNaCzq5u0e/J1u9t3dXi2vUuBFqZrAoVFPg6VWCqIeYSgmYpY8pCNO/ZKZXwxFZe42
         Uuq6I4ueXtvwscMWo5eoBfznNQ2GSA+yPctMkUbTm1t28n/uuQhUPK4WO/DMPsKmZnQ0
         2+ynw8awddZ3Mar8AlgIjIfHAH06ZLxPc7Z/wryZ8gFmd5RRlg37G4iF8EG4K7OiZQo4
         V60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9rJz2VuY4IfP7+nNqN3pctJ1eYK9/4qdDjNdgoSdskE=;
        b=ZZDXAONC3Vzy+lRqPTd9SsLPKD/7jemM9cHqdER93/Rzx750chpOArhdxhAcwb3Xah
         7f/GfhlTSa1HFQnlrdjrYx66oE6uUftqVxOATgsU8uyC+v88yrnx83c0cw7z/co+ESAk
         kFWWDWQ5gV4gAhcKfUZyc3ABwueGVTSjYrOqZ/2p3HtBx+rylLBD/UHNbmS2Q6x13hkI
         6iXBj6akVEdfF+98U7H9TPMF7wC2XL5qWL7ycceBQ+/Q7x4yWIDKCGdHTzRowpeu3fez
         +Eb5m2VAOXzOAybVVSTEVmxiKN/3b3YZGJtNg2E+EKngs58Vypg0w30ffIK2RKL1CsWp
         /lUA==
X-Gm-Message-State: AOAM5321XOtRK5YJFx+xzv0NYV+NOllk6ZpzPlvnk5ikpi6722rFCMQz
        185NvG8UldNzoknB484Sh2Nb41TgfNPqWQ==
X-Google-Smtp-Source: ABdhPJxuCMYl5Gyqmlh+OdzyanaIYKsfBEkeA8V1x3xHDE2DwCbEHd9NkeA7gMVJX55eRERwe38YOQ==
X-Received: by 2002:a37:68d4:: with SMTP id d203mr631049qkc.125.1599580147448;
        Tue, 08 Sep 2020 08:49:07 -0700 (PDT)
Received: from mail.clickyotomy.dev ([124.123.105.42])
        by smtp.gmail.com with ESMTPSA id h68sm11306521qkf.30.2020.09.08.08.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 08:49:06 -0700 (PDT)
Date:   Tue, 8 Sep 2020 21:18:59 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] push: make `--force-with-lease[=<ref>]` safer
Message-ID: <20200908154859.GA40807@mail.clickyotomy.dev>
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
 <624d9e35-29b8-4012-a3d6-e9b00a9e4485@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <624d9e35-29b8-4012-a3d6-e9b00a9e4485@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 09/07/2020 16:23, Phillip Wood wrote:
> [...]
> Thanks for working on this, making --force-with-lease safer would be a
> valuable contribution

:)

> > The `--force-with-lease` option in `git-push`, makes sure that
> > refs on remote aren't clobbered by unexpected changes when the
> > "<expect>" ref value is explicitly specified.
>
> I think it would help to write out
> `--force-with-lease[=<refname>[:<expect>]]` so readers know what
> "<expect>" is referring to

That makes sense; noted.

> > For other cases (i.e., `--force-with-lease[=<ref>]`) where the tip
> > of the remote tracking branch is populated as the "<expect>" value,
> > there is a possibility of allowing unwanted overwrites on the remote
> > side when some tools that implicitly fetch remote-tracking refs in
> > the background are used with the repository. If a remote-tracking ref
> > was updated when a rewrite is happening locally and if those changes
> > are pushed by omitting the "<expect>" value in `--force-with-lease`,
> > any new changes from the updated tip will be lost locally and will
> > be overwritten on the remote.
> >
> > This problem can be addressed by checking the `reflog` of the branch
> > that is being pushed and verify if there in a entry with the remote
> > tracking ref. By running this check, we can ensure that refs being
> > are fetched in the background while a "lease" is being held are not
> > overlooked before a push, and any new changes can be acknowledged
> > and (if necessary) integrated locally.

> An addition safety measure would be to check the reflog of the local
> commit and the tip of the remote tracking branch dates overlap.
> Otherwise if there is an implicit fetch of a remote head that has been
> rewound we still push the local branch when we shouldn't.

This sounds much better. My initial description of the check was perhaps
a bit confusing.

> > The new check will cause `git-push` to fail if it detects the presence
> > of any updated refs that we do not have locally and reject the push
> > stating `implicit fetch` as the reason.
>
> 'implicit fetch' is a rather terse message - can we say something along
> the lines of "the remote has been updated since the last merge/push"?

I was going by the "two-word" approach like "stale info", "fetch first",
"no match", and so on. But, I'll look into wording the reject reason
along those lines.

> > An experimental configuration setting: `push.rejectImplicitFetch`
> > which defaults to `true` (when `features.experimental` is enabled)
> > has been added, to allow `git-push` to reject a push if the check
> > fails.
>
> Making this available with features.experimental initially is probably a
> good idea, I hope it will become the default if in future versions.

I hope so. :)

> > [...]
> > +		case REF_STATUS_REJECT_IMPLICIT_FETCH:
> > +			res = "error";
> > +			msg = "implicit fetch";
> > +			break;
> > +
> >   		case REF_STATUS_REJECT_ALREADY_EXISTS:
> >   			res = "error";
> >   			msg = "already exists";
> > diff --git a/remote.c b/remote.c
> > index c5ed74f91c..ee2dedd15b 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -49,6 +49,8 @@ static const char *pushremote_name;
> >   static struct rewrites rewrites;
> >   static struct rewrites rewrites_push;
> >
> > +static struct object_id cas_reflog_check_oid;
> > +
>
> rather than using a global variable I think it would be better just to
> pass this value around using the cb_data argument of the reflog callback
> function

I have to admit that I was hesitant to use the global variable when
writing this. For some reason I thought the callback data was used to
store results from the called function only and not pass arguments.
Will fix that in v2.

> > [...]
> > +static int oid_in_reflog_ent(struct object_id *ooid, struct object_id *noid,
> > +			     const char *ident, timestamp_t timestamp, int tz,
> > +			     const char *message, void *cb_data)
> > +{
>
> using the callback data we would have something like
>
> struct oid *remote_head = cb_data;
> return oideq(noid, remote_head);

Got it; this and the callback argument to the reflog entry function
will be updated accordingly.

> > [...]
> > +{
> > +	int ret = 0;
> > +	cas_reflog_check_oid = *r_oid;
> > +
> > +	struct commit *r_commit, *l_commit;
>
> Our coding style is to declare all variables before any statements, so
> this should come above `cas_reflog_check_oid = *r_oid` but that line
> wants to go away anyway.

Noted; `cas_reflog_check_oid` will go away as suggested above.

> > [...]
> > +	ret = (r_commit && l_commit) ? in_merge_bases(r_commit, l_commit) : 0;
> > +	if (ret)
> > +		goto skip;
>
> Rather than using a goto it would perhaps be better to do
>
> if (!ret)
>	ret = for_each_reflog_...
>
>

OK, yes. The `goto` can be avoided here.

> > +
> > +	ret = for_each_reflog_ent_reverse(local_ref_name,
> > +					  oid_in_reflog_ent,
> > +					  NULL);
>
> using the callback data we'd pass r_oid rather than NULL as the last
> argument


> > [...]
> >   		else if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
> >   			oidclr(&ref->old_oid_expect);
> > -		return;
> > +		else
> > +			do_reflog_check = 1;
> > +
> > +		goto reflog_check;
>
> I'm not too keen in jumping here, can't we just check `do_reflog_check`
> below?

Yes, of course. I was trying conserve the original flow of returning
from the function right after the loop. Since this is just one condition
to check if `do_reflog_check` is set to 1; we can get rid of the `goto`
and use a `break` instead.

> [...]

Thanks for a thorough review.
--
Srinidhi Kaushik
