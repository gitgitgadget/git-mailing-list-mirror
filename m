Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8421CC07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6474E61C81
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhGFUpR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 16:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFUpR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 16:45:17 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99794C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 13:42:38 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id d27-20020a05683018fbb02904ae64d1b56bso61497otf.9
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 13:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=pWHxmav575noY9x57bfQr/UTRsciHkEffiTj7/079WI=;
        b=iIPL6X8C57gUol0REWr712dOzlbeCxzwGQBzI1iuOqhlgrXoYQYMbkV8HmKQzi7P4j
         Vf6/IvvEN4rUywMidh1pv32BCL8LhXYGinkKBNY2svsdC96zPSfurHza6IHbsMHKs1le
         v1LrYyUaBggxMnF+OshmAm6bTg7pJXGswEwuB/BvMe05bOhsIcqzNN9FnMVdBO0gsxyp
         0K4YzX5w4k0PUbx98Hd/fpU4Iw+Km+Fd54nyDM1tK8yxQ+CvblcnNm3pqC/l5dO1NDdP
         sPXWI7VyaHfJ9DTXEknaUxjL6t2goOQwjEgZB9kMMwdarNK/owDThBXyBcXT5yYw/ubS
         ZLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=pWHxmav575noY9x57bfQr/UTRsciHkEffiTj7/079WI=;
        b=Hg9FI4isr0z00cn+rBLHgVr19FuTXejwSD9ik0AK5aOwl9ccU3VFYPIn56NBbTTPvh
         c0Ec+af7Iqra1c4iNjO0JBo6c326Gq6lRc/j2WBEvPV6xyC25DpwaNmNMHn+SO9keXUV
         XG7gSzigYgU4iLvRg9X4ZlvIrZsCGda73VxUmfFTu+ePjdO/Zr/3Ue9/W4phKUoRBsSs
         jeaw4BmU008hVBpOkiFonUzTZyUeNFDAJJmqfZXfqL0SFQ7FUmbFYqiMWyu33T/hq04f
         3E7g9eczwXFOEPFwqrANSC6gMgzQPRLnDiqQOGdSPKXJgc4ocl+6ueItxEQCD8cA+QoM
         +7og==
X-Gm-Message-State: AOAM531gj1brw9vi9CLWy5iAMDGx2MyUGejVQczgmOS9hH3giEo3AQOq
        rJHvJxhuZ58/Th7IDzeyOPo=
X-Google-Smtp-Source: ABdhPJzm+u2g3xbdp+ktq0/qlLbx0RQrJB7+828luy87tayCQhFj7owsDpogEh8/UvTjNiGBHQO1+g==
X-Received: by 2002:a9d:4901:: with SMTP id e1mr16902456otf.103.1625604157945;
        Tue, 06 Jul 2021 13:42:37 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id g66sm2740440oob.27.2021.07.06.13.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 13:42:37 -0700 (PDT)
Date:   Tue, 06 Jul 2021 15:42:36 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60e4c03c58a45_1c4281208cb@natae.notmuch>
In-Reply-To: <878s2j5hk6.fsf@evledraar.gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
 <20210705123209.1808663-6-felipe.contreras@gmail.com>
 <878s2j5hk6.fsf@evledraar.gmail.com>
Subject: Re: [RFC PATCH 05/35] fast-forward: add advice for novices
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Jul 05 2021, Felipe Contreras wrote:

> > --- a/builtin/merge.c
> > +++ b/builtin/merge.c
> > @@ -1625,8 +1625,10 @@ static int merge_common(int argc, const char *=
*argv, const char *prefix,
> >  		}
> >  	}
> >  =

> > -	if (fast_forward =3D=3D FF_ONLY)
> > +	if (fast_forward =3D=3D FF_ONLY) {
> > +		diverging_advice();
> >  		die(_("unable to fast-forward"));
> > +	}
> >  =

> >  	if (autostash)
> >  		create_autostash(the_repository,
> =

> ...ah, and re my comment on the earlier patch here's where we're adding=

> advice.
> =

> I'd think just squash that into this, or mention in the commit message
> "a later commit will add an advice() before this, where this new wordin=
g
> will make more sense" or something...

I don't think we lost any information in the previous patch. In fact
with my suggestion we gained a little bit.

-- =

Felipe Contreras=
