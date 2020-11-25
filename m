Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD46C5519F
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 06:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83005206E0
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 06:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tmkzph6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgKYGZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 01:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgKYGZU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 01:25:20 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F04BC0613D4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 22:25:20 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id v8so649479vso.2
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 22:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oOFsPKzON/8shMikDciScYAjjXRIt9HGnDif0b6/JWE=;
        b=tmkzph6/VJmWuJsdm/FdM89ncL7DySUA97nwZYE0cQ8m1/+L1e6UBjA4bEwZOStFBI
         nuaeiqQgixSD0HsuHifGFulLLGshgYM7/lrOo3ZZudB4Epf53YVM+mE2IxY3UFjUxZhR
         1m8G41FLvcTsN7Oh0lXWVcWNmuiIE4nTvrPcj5mUtBacIcsYVWXHFv6s3A8iIYmkW0nv
         V0H+EcRDh9aTCGoN2G1ak9ZqPP/uAskkL8xBRYwkRb/h2TED6kHEqVIMbBWmQUXQ5tTt
         1rNzyZAtCEIb3xO8p4I4Zb5YZba74nk5ET32ABCLHV9yQFl+uBLV1v8qiwzfL4PsyygL
         2f6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oOFsPKzON/8shMikDciScYAjjXRIt9HGnDif0b6/JWE=;
        b=avU7SSuCovAnNhz2k0ZwOxP/kvnkpdjoibrO2bx+fHb6m13KjbUBS8lYw0kYkFDpjd
         1b64a6FVf6cMAMm4NMoLjeYCByOushY11APQvDYlQFol4ALe1qE5InOBKl1vh731x92R
         aC7siCj62dHKkuxxlpdklgFCYSSSKm4TkcdX56uN3GF9IRsusKxg24pwIoLtV4+8Qx2n
         HCpbtkwo0QigFUyMTALyqvs2n4Bzn2A+QktR/YqLMdnfPkIZ9jW0DbhDoEyVcSjvA42G
         csCpK/3qwqaQ3CXMSq8tqShHTxe2OsovCeFicTHz8q2RSfjh52HHyvluSeO9Ujn1enPK
         +/+A==
X-Gm-Message-State: AOAM531+vjb/s2VOXdyZ4bwXKd9Xs+anUNk39tiRcTZ3U4iBoxATM+n9
        VXjygDeHKvG8lsqlm6RAvCeR1wu8nnHmrYhUw50=
X-Google-Smtp-Source: ABdhPJwNuxWyUtXUpFFNyTAS5/p8dqRsktzGzcDiBoPMTv5Sbk/jgrnuvyGpT/CBWupXYe7lPKPIXZHov6h+2tUzKjw=
X-Received: by 2002:a05:6102:22fb:: with SMTP id b27mr957617vsh.49.1606285519338;
 Tue, 24 Nov 2020 22:25:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605972564.git.martin.agren@gmail.com> <cover.1606251357.git.martin.agren@gmail.com>
 <359355fb4eff6d99cb1baad9b72ff96e7dcda51d.1606251358.git.martin.agren@gmail.com>
 <xmqqsg8ygza7.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsg8ygza7.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 25 Nov 2020 07:25:07 +0100
Message-ID: <CAN0heSoM+qQe8BdKHVpqhA0RAqzyyL3Qr98G=O8kD504diruCg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] grep: copy struct in one fell swoop
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 24 Nov 2020 at 23:34, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > We don't have any ownership issues with what we're copying now and can
> > just greedily copy the whole thing. If and when we do need to handle
> > such elements (`char *`?), we must and can handle it appropriately.
>
> That is correct, but ...
>
> > This
> > commit doesn't really change that.
>
> ... I suspect this is not.
>
> In the original code, those who are adding a new field would notice
> that it is not copied over to the new instance (because they didn't
> add anything to grep_init() to copy the field) and at that point
> they must stop and think how the new field need to be copied.
>
> The structure assignment of the outer shell done in this patch means
> they are robbed of the opportunity to stop and think, because most
> of the time it "works" out of the box.  I'd feel safer if we left a
> clue to future developers if we were to do your clean-up, perhaps
> like:
>
> diff --git c/grep.h w/grep.h
> index b5c4e223a8..388d226da3 100644
> --- c/grep.h
> +++ w/grep.h
> @@ -115,6 +115,14 @@ struct grep_expr {
>         } u;
>  };
>
> +/*
> + * grep_config() initializes one "default" instance of this type, and
> + * it is copied by grep_init() to be used by each individual
> + * invocation.  When adding a new field to this structure that is
> + * populated from the configuration, be sure to think about ownership
> + * (i.e. a shallow copy may not be what you want for the type of your
> + * newly added field).
> + */
>  struct grep_opt {
>         struct grep_pat *pattern_list;
>         struct grep_pat **pattern_tail;

Ok, that makes sense. Maybe put it in `grep_config()` though? We can add
anything we want to to this struct and initialize it from the command
line. It's when we start pre-filling it in `grep_config()` that we need
to think about this. What do you think? We could also do both of
course to really hedge our bets...

  /*
   * The instance of grep_opt that we set up here is copied by
   * grep_init() to be used by each individual invocation.
   * When populating a new field of this structure here,
   * be sure to think about ownership (i.e. a shallow copy in
   * grep_init() may not be what you want).
   */

Thanks
Martin
