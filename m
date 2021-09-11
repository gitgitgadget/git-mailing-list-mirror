Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B2CC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 01:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84B86611AD
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 01:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhIKBmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 21:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIKBmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 21:42:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD33C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 18:41:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id h9so7913252ejs.4
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 18:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5HaK08rQmproZCtTCn0T70AnuYw0kdUtqdeQ1/zurMQ=;
        b=NzNGgeSrxdKGBdIJ0OpF/jjPNVkoqWjGrKOHDkyHHyqvuu6Mt7Za4Emju+utznROFr
         q6PmWkQiPFy3Czv0KYPkVYBf8Lze1Qf/nsbF/UmY7aQUmlV3PFT7NaZK+knv20hvkXOO
         Ilh726BLVEb//fcpUYnum+LuCItQpzXNhM/i4xKWv6f9aHhR8+xJ1jI2wNoIwAl1TVMc
         ZDVPgUVHio98zxHKxZVcXauD5kgxIA5jPlJoFFSmvGmf20R1S8wXpQLvUR5PLswPaYtW
         5DdZPu1yK/OhVsGqaMk6jjiOKojTV/fUXvgRowg2tM8+Z8xrhRIlh6O7/2vKCC5g+AMl
         HXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5HaK08rQmproZCtTCn0T70AnuYw0kdUtqdeQ1/zurMQ=;
        b=Ypx4l45ybs2U5e0orxJIJx8lQ6u6weDkaP/kpEHGs2zlkbQn9uAieQOqYifjamedLd
         dYYA975SS4sgnWFuv/IY2ooVrBCz7iqYMLRLaJAP4HoJn9YNGP9T/+l1OXz6ghnvIz4K
         8tzVHzUX+6+lKy+S2rAvph8GIc2CcdzCnsQJ7iu5qsXkNqRoeAkQGrUv73SC+HIaZwaz
         XUGViGdCyJSszUWjBb1mY6ypeim+behJ8MwNJXLn0pPsZs70LrdQ0Vc2V749Bd94Mtit
         cN5E1oLAQS+0kXedebOgoh8ZD7iPLylLSBfXqhXiKVLtqKgS3211qkchgydObwFaUV5h
         74Eg==
X-Gm-Message-State: AOAM531Bp/7ZYjtQkT0h00MfQJeuxbQ8l6ZMU/FZo6XrtWtA3tQpWIZd
        VGSFssL8IFh65W+DuuecczQ=
X-Google-Smtp-Source: ABdhPJyiSK1tAOmtR4258me8ths3UIq1ST4e35lcBMnESX/orFwiGq49LFPqh0b3NVBnNsFDGtNUMQ==
X-Received: by 2002:a17:906:8450:: with SMTP id e16mr534764ejy.305.1631324463236;
        Fri, 10 Sep 2021 18:41:03 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gz22sm118647ejb.15.2021.09.10.18.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 18:41:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Gwyneth Morgan <gwymor@tilde.club>,
        Fangyi Zhou <me@fangyi.io>, git@vger.kernel.org,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Birger Skogeng Pedersen <birgersp@gmail.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        CB Bailey <cbailey32@bloomberg.net>,
        Christopher =?utf-8?Q?D=C3=ADaz?= Riveros 
        <christopher.diaz.riv@gmail.com>,
        Christopher =?utf-8?Q?D=C3=ADaz?= Riveros <chrisadr@gentoo.org>,
        Ed Maste <emaste@freebsd.org>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Jean-Noel Avila <jean-noel.avila@scantech.fr>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Kazuhiro Kato <kato-k@ksysllc.co.jp>,
        Kazuhiro Kato <kazuhiro.kato@hotmail.co.jp>,
        Kevin Willford <Kevin.Willford@microsoft.com>,
        Kevin Willford <kewillf@microsoft.com>,
        Peter Kaestle <peter@piie.net>,
        Peter Kaestle <peter.kaestle@nokia.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>,
        Slavica =?utf-8?B?xJB1a2nEhw==?= <slawica92@hotmail.com>,
        Slavica Djukic <slavicadj.ip2018@gmail.com>
Subject: Re: [PATCH] .mailmap: Update mailmap
Date:   Sat, 11 Sep 2021 03:31:49 +0200
References: <20210910130236.40101-1-me@fangyi.io>
 <YTt4RymWg+TOEmUf@tilde.club> <YTt6RTwJw64tYJRw@coredump.intra.peff.net>
 <xmqqa6kkosst.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqa6kkosst.fsf@gitster.g>
Message-ID: <87czpfc2j6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> On Fri, Sep 10, 2021 at 03:22:47PM +0000, Gwyneth Morgan wrote:
>>
>>> The line for Jessica Clarke should probably just be
>>>=20
>>> Jessica Clarke <jrtc27@jrtc27.com>
>>>=20
>>> That works the same and doesn't put a reference to an old name.
>>
>> Thanks, that's a good suggestion. I kind of wonder if these mass
>> mailmap-cleanup patches are a good idea in general. They are making
>> assumptions about how people want their names to be represented, and
>> whether and how they want any mappings to appear. Maybe that's something
>> we should be leaving to people to propose for their own identities.
>>
>> Of course people who aren't active in the project anymore may not bother
>> to do the cleanup, and of course messy data makes me sad. But on the
>> whole, I'm not sure it's that big a deal either way.
>
> I am not enthused by the idea of replying to this thread, knowing
> that many of the CC'ed addresses will bounce X-<, but I agree with
> you on all three counts.  Even for those who are no longer active,
> it makes sense to unify multiple idents that are spelled differently
> to help "git shortlog", but which one to unify to is not something
> we can decide without their input.
>
> Which leads me to suggest something like the attached patch.  I
> wrote "Please notify us" for those who are no longer active and
> forgot how .mailmap entries are spelled to ask for help correcting.
>
> Of course, the updated instruction does not prevent a motivated
> volunteer to contact the people _individually_ and then send in
> a patch with entries that the volunteer secured consent, perhaps
> in the form of Acked-by ;-)
>
>
>  .mailmap | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git i/.mailmap w/.mailmap
> index 9c6a446bdf..20b581c879 100644
> --- i/.mailmap
> +++ w/.mailmap
> @@ -4,6 +4,11 @@
>  # and/or not always written the same way, making contributions from the
>  # same person appearing not to be so.
>  #
> +# If you find an incorrect entry that affects yourself, please notify us
> +# at <git@vger.kernel.org> and suggest corrections.  Because the way peo=
ple
> +# want their names to be represented varies, please refrain from touching
> +# entries for other people unless you positively know that the updated
> +# entries are what they want.
>=20=20
>  <nico@fluxnic.net> <nico@cam.org>
>  Alejandro R. Sede=C3=B1o <asedeno@MIT.EDU> <asedeno@mit.edu>

That seems too high a burden for edits that are likely to be
uncontroversial.

I.e. this seems targeted at someone who's changing someone's name
without their approval after the fact and when they can't be contacted.

Whereas most if not all edits to this file are likely to be janitorial
work such as de-duplicating E-Mail addresses, or cases where the people
involved even if they can't be contacted have already shared this
information unambiguously with the world, it just happens to be in the
mailing list archive, not in .mailmap.

E.g. I'd think these were fine, even assuming you can't contact the
parties involved:

 * The ML history reveals someone who's clearly the same person was
   using N E-Mail addresses in succession, we should probably map it all
   to the latest one, unclutters shortlog and the like.

 * Ditto even for their name in some cases. Is someone's commit history
   200 commits of abbreviating their middle name, with 1-2 commits at
   the start where they don't? Seems fine to just normalize that.

 * Is the E-Mail they last used bouncing their E-Mails ("this person
   doesn't work here anymore"), domain expired etc?

   It would be useful to other contributors to map that to
   this-is-unreachable@example.org or whatever so they won't waste time
   CC-ing a bad address.

Which doesn't mean that there aren't things we shouldn't be doing
without asking:

 * Changing a name from Alice to Bob? Yes, ask and have the person ack
   it.

 * Found the current E-Mail address someone who contributed years ago
   but not under that address to git.git? Ask them first, they may not
   wish to be contacted at all.

etc.
