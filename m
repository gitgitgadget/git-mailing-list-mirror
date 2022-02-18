Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE5AC433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 19:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbiBRTj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 14:39:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237596AbiBRTj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 14:39:26 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8766E8F6
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 11:39:09 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id x3so16712339qvd.8
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 11:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=elbWaPp56oXW39xhR9FbxWAKZwO7UWHfHTjJs10hu0Y=;
        b=k8CSERMnYDiDldadSpoY/AFvn3fUkF1RIIqty096XmijVlW0Ay1jPviWeidqSVzStU
         SHPGebQvL15WSZGwq9DLcWmY7kciw56jT5bb9jlz4ZafAEHrOZhq5M+QhKKhigfuLuwe
         7KeZ9TPkd+GxV5qh9FNLiKGM4D39I8qGle+9tcef3iH2goPoQxZsl4Qv4woLa/ewjG/m
         hghYJuHgaUIjJ7tr3oUyMEJNfTAdAA/8s0Z+w5Shz+GD/UDvY8zmPY75wrq19qr75Txj
         0KxJPJQVnbiQiqnFFnj1d43zSYSksJ4w2UGYRjuK6a4qOTjNVlSsJrceWmFiCzVfdXT8
         BpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=elbWaPp56oXW39xhR9FbxWAKZwO7UWHfHTjJs10hu0Y=;
        b=JGLaVRYaQSHI+TXoxLGVVq7lLJqdp2ffr7DYZy2TXWYpfUYED/PIFqasCBCU/OC9M0
         xsG4/a2t9WQ/iCTzSxuBKL2QFlHZrrUZYoR8NZ4xBi6Fr5t0IuvMIwByBrI2KnM98Bnr
         dtM4pveg/5ni9voAF7g3jpJrHEDyLcg2lcv57Jn0N7jn1ap79iM7wxsMUhL216gbYgeh
         vopMO7cn5kuczSJ7jCuiE8FB44Lp549/ghHY7Pt39a6TgSZs01z94Xdo/VcVWnklCJf/
         f4S+v5Of1d0fHxHYY2JMR24Dv1KjXdhn+EG1S9slvb6VetBJctxywJBeITuuDpgZzQ/Y
         YSsQ==
X-Gm-Message-State: AOAM531UJiA0GexbIMlNixCJOPV3f+l0J0vKDomrE9Wo1u5fvDxTaVjD
        wTTBk3PhcchMhWWfiIolA83dzQ==
X-Google-Smtp-Source: ABdhPJyIJG1PeGv5kSNp8jALzmff8sktr3ZD0HfH0J5W2CPODFG4xJaCyTHko4P5ISCZA5O+iRzUuA==
X-Received: by 2002:a05:622a:116:b0:2cd:5be1:3838 with SMTP id u22-20020a05622a011600b002cd5be13838mr8028620qtw.494.1645213148482;
        Fri, 18 Feb 2022 11:39:08 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i4sm24054276qkn.13.2022.02.18.11.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 11:39:08 -0800 (PST)
Date:   Fri, 18 Feb 2022 14:39:07 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/3] reflog: libify delete reflog function and helpers
Message-ID: <Yg/1205sTdqE2mC5@nand.local>
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <9e17ece8d8956c7fd41b7be2f5c0475b1f9af6ec.1645209647.git.gitgitgadget@gmail.com>
 <220218.86wnhsgf5n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220218.86wnhsgf5n.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 18, 2022 at 08:10:07PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > +int reflog_delete(const char *rev, int flags, int verbose)
> > +{
> > +	struct cmd_reflog_expire_cb cmd = { 0 };
> > +	int status = 0;
> > +	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
> > +	const char *spec = strstr(rev, "@{");
> > +	char *ep, *ref;
> > +	int recno;
> > +	struct expire_reflog_policy_cb cb = {
> > +		.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
> > +	};
> > +
> > +	if (verbose)
> > +		should_prune_fn = should_expire_reflog_ent_verbose;
> > +
> > +	if (!spec) {
> > +		status |= error(_("not a reflog: %s"), rev);
> > +	}
> > +
> > +	if (!dwim_log(rev, spec - rev, NULL, &ref)) {
> > +		status |= error(_("no reflog for '%s'"), rev);
> > +	}
>
> For these let's follow our usual style of not having braces for
> single-line if's.
>
> Buuuut in this case doing so will make the diff move detection less
> useful for 1..2.
>
> So probably best to leave it, or do some post-cleanup at the end maybe.

Hmm. I don't think the diff detection mechanism would have an
opportunity to kick in here, since the code is added in one patch and
then removed in another. I think I may be missing what you're trying to
say here ;).

In any case, I don't think it's a huge deal if we can't accurately
colorize this with `--color-moved`, so I'd probably just as soon clean
up the style nits in this patch.

> > +int reflog_delete(const char*, int, int);
> > +void reflog_expiry_cleanup(void *);
> > +void reflog_expiry_prepare(const char*, const struct object_id*,
> > +			   void *);
> > +int should_expire_reflog_ent(struct object_id *, struct object_id*,
> > +				    const char *, timestamp_t, int,
> > +				    const char *, void *);
> > +int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
> > +		const char *email, timestamp_t timestamp, int tz,
> > +		const char *message, void *cb_data);
> > +int should_expire_reflog_ent_verbose(struct object_id *,
> > +				     struct object_id *,
> > +				     const char *,
> > +				     timestamp_t, int,
> > +				     const char *, void *);
> > +#endif /* REFLOG_H */
>
> Just a style preference, but I for one prefer the style where we retain
> the parameter names, it helps to read these, especially when we add API
> docs here.
>
> Some of these are mis-indented. We align with the opening "(" with "\t"
> = 8 chars, so e.g. 2x \t + 5 SP for the count_reflog_ent() arguments
> etc.

Thanks for noting on both.

Thanks,
Taylor
