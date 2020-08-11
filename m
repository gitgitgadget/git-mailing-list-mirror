Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3A1C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 00:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F382075D
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 00:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9eQQnEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgHKAeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 20:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgHKAeD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 20:34:03 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8663C06174A
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 17:34:02 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j21so5856638pgi.9
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 17:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q4kYkuDiyXyGnPV+zrJh/KPzLrlh+cbgo8vEEJL0G38=;
        b=P9eQQnEUNqOC2Ukj00H4pArx47XkDoUYDDzZcIZgpAtzOKZGj75kSZI2R861HJ1MJy
         /EcGyImWK2DtTHm1ul92z6cw6nwwKNtH1c160K0l6uuPkT6zh10VM0vIIxsIJQ9eOpfo
         RK/OWwm3aweDztNIL84Dwt5fPa0InouS6oQX7VaRCEzBej5e5rX966dvSyk0KnBoJ6za
         FfZZPqXbb/Q//m1NnpRi3cFqowL1JA8Z1/Veh5kUEc+6jflbGCb/iugbUBJN3JZTAUEO
         wGYQUguHgUx0j0melraAH8TmGBAJwswIsyWllqDAGQJgQ4t4k8FC4L9sVE4JSDZOknTG
         HWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q4kYkuDiyXyGnPV+zrJh/KPzLrlh+cbgo8vEEJL0G38=;
        b=e5XuYJkQE+V46BG8C2n6IBwIfjyPgsJXgEGieZzKLOxGvcF2pwm73A6lOQnFBvW2V0
         Ur6eWBCc5hAEvO95bytopVxmbSoOCdTH0yblmVGgbCHZdSKO0CLqTTVeemI7d4wIkWbh
         XcIPYQypq7QaeOpv6yV5+b06qPdV8g1H3eSL2rwHf3Xp1TZZ+N+2mvlSfjh2C1ek2trV
         GQOb3CLChyGIFuhMY9zw9rRIQePSGjjaLd8yiFmNvot4LFHKPPKYHj/qFi7w0HTlP5AV
         nZGzJv7SSwes+COq9Pr+h0UhtpH9je2YXe7D2Q7gM+d2k5IarZLkx7hoyejMka0oDNt2
         QWaw==
X-Gm-Message-State: AOAM532n2PG/hT6YKtgvoCOhC9HvwVINrHlyHqL+uobrh9GY26UuTXh9
        anEJWzWy6DY2Jo1rjNdcqmc=
X-Google-Smtp-Source: ABdhPJybzuzq1XeYMaLwvdA2MUhcuC0auH4Y/OHtDHsV/8AUBZIw3xA4+tG7j7tPu6DcfGl/57STqw==
X-Received: by 2002:a05:6a00:81:: with SMTP id c1mr3808295pfj.189.1597106042158;
        Mon, 10 Aug 2020 17:34:02 -0700 (PDT)
Received: from localhost ([2402:800:6375:ea17:7ad5:df16:a252:473b])
        by smtp.gmail.com with ESMTPSA id w16sm23278897pfq.13.2020.08.10.17.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 17:34:01 -0700 (PDT)
Date:   Tue, 11 Aug 2020 07:33:59 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] extend --abbrev support to diff-patch format
Message-ID: <20200811003359.GD17119@danh.dev>
References: <cover.1596887883.git.congdanhqx@gmail.com>
 <xmqqd03zej8w.fsf@gitster.c.googlers.com>
 <20200810100038.GB37030@coredump.intra.peff.net>
 <20200810123148.GB17119@danh.dev>
 <xmqqy2mmcz1e.fsf@gitster.c.googlers.com>
 <20200810152705.GA61606@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810152705.GA61606@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-08-10 11:27:05-0400, Jeff King <peff@peff.net> wrote:
> On Mon, Aug 10, 2020 at 08:15:41AM -0700, Junio C Hamano wrote:
> 
> > > 	A lot of those patches couldn't be applied cleanly to old
> > > 	versions of said software, thus requires some changes from
> > > 	developer and they needs to be regenerated from their trimmed
> > > 	tree. Because the archive tree has significantly fewer
> > > 	objects, the abbreviation in the index line is usually shorter
> > > 	than the original patch. Thus, it generates some noise when
> > > 	said developers try to compare the new patch with the original
> > > 	patch if there's an exact file-hunk match.
> > >
> > > 	Make the object name's abbreviation length configurable to
> > > 	lower those noise.
> > 
> > I agree with Peff that with the above as the sole motivating use
> > case, the "--full-index" option is the right approach.  It is a much
> > more robust solution than "--abbrev=16 would be long enough for all
> > project participants to avoid length drift".  IOW these four
> > paragraphs do not argue _for_ this change, at least to me.
> 
> Yeah, that's what I was getting at: if you care about robust
> machine-readability, then the full index is the best solution. Reading
> between the lines, I think the argument may be "using --full-index is
> too long and therefore ugly, so people like the short-ish names but with
> a bit of extra safety".

My argument was people can either easily fetch the patch via HTTP like:

	curl -LO https://github.com/git/git/commit/eb12adc74cf22add318f884072be2071d181abaa.patch

or take it from a mailing list archive, bugzilla, instead of
cloning a full repository. With those options, we can't say,
"we prefer full-index, please send us the patch with full-index
instead".

> 
> There's an extra challenge here, which is that you have to convince the
> sender to use the extra --abbrev option, even though they themselves
> won't be the ones running into the problem when applying.

Not really, since the sender tree is usually larger than the archived
tree, their abbrev is usually long enough, and the receiver will use
--abbrev to lengthen their abbrev to reduce the noise instead.

> But I don't
> think there's an elegant solution to that (we could just bump the
> default abbrev everywhere to 12+, which is enough in practice).
> Though I'm not 100% sure that "git apply" is smart enough to only look
> at blobs (i.e., if "1234abcd" is ambiguous between a tree and a blob,
> ignore the tree since patches always apply to blobs). That might be
> another avenue that would make things more likely to work without
> anybody having to configure anything.
> 
> > On the other hand, I think you could argue that "--full-index" is
> > merely a synonym for "--abbrev=40", and the patch fixes the
> > inconsistency between the object names on the "index" line, which
> > can choose only between the default abbrev length and the full
> > abbrev length, and all the other places we show object names, which
> > uniformly honor the "--abbrev" option.

I think this argument could be a way to go.
In fact, I always try to use --abbrev with diff family because I know
it works with a handful with other tools, (describe, blame), then
I surprise that it doesn't work, and the documentation tells me
`--abbrev` only works with diff-raw and diff-tree header line.

Then, I keep forgetting that documentation, and I tried again.

For now, I filtered out the index line before comparing 2 patches.

> Yeah, I certainly don't mind the extra flexibility between "full" and
> "default" for "index" lines. I do wonder if people want to configure the
> abbreviations for those lines separately from other parts. I don't know
> that I've ever particularly cared about that flexibility, but the fact
> that they were set up separately all those years ago makes me think
> somebody might.

I don't think people particularly care about the index line (and to
the extent, its length) that much, since the default is number is
actually a minimum number, if Git can't differentiate object with that
number of characters, Git will show a longer object names anyway.

I think most people scripts will put a regex for:

	/index [a-z0-9]{7,}\.\.[a-z0-9]{7,} [0-7]{6}/

Or even:

	/index [a-z0-9]+\.\.[a-z0-9]+ [0-7]+/

For the former case, we could change the code in 2/2 to set the minimum
default to DEFAULT_ABBREV instead of MINIMUM_ABBREV?

For the historical case that users put both --full-index and --abbrev
into there scripts, we still keep our promise to not break their
script by always respect --full-index, regardless of --abbrev.

-- 
Danh
