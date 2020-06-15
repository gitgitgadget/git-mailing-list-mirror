Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55B5C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 02:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 934A520747
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 02:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="yFsumuTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgFOCRD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 22:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbgFOCRD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 22:17:03 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049A7C061A0E
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 19:17:02 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h22so3024898pjf.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 19:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AyaJ+7Z+VDpMjuI5Re69W6iCbCGSxjmGIVlF9qDcU+w=;
        b=yFsumuTjQxuN4pEPnwZa19Nm9Z7m/eNZ+iuhIvXqLI39h0xcwPB6/km2OI20R0Hj38
         PU37qkCQT8rt4FFRAOkqj1tvp/6LmbIDwmpCw3neNZRYqiOWETOwvYJBF0L4r6maDWfS
         2fJEIZqb5rmTSjMG64wL1aou8APFJiUUgqFRxN63YY26LiFfQfvGhxkvHcGsqICwui0j
         sglRWw1//Ir0TAuZN/XCLszkr1iOSE4mneS5nK6R5mFe9g2QMf4ZQwQ4fhbNtOCd2Sp5
         ABsC5RNRUdcF8/HrLOxpF0DYS1P8XH1klWnXJUjKScMn3DMdoCUJ3wxk4YhY51Uep8Kt
         V2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AyaJ+7Z+VDpMjuI5Re69W6iCbCGSxjmGIVlF9qDcU+w=;
        b=YQmihNSAcNibQmXwsEZ4mNVgYmpnnfsYlYwRU4ab+/SIVuYYZyRnupG6siCb3CdB5e
         fjMkSPplYA3id643W/WlVNGSuaYPaJN4att3Xu4v/rVKzxUtCgh6wl/MyCkKO/khDuGg
         c3Ruj+LIIyBchcSSPfPQzKmhR8ExO+M0nX92cs8oi5M53PVGITE5bmOYvYd8D8Lt4ajH
         ocS1NklnC0oM+i+0Bee8BgQqff5UAOpNc/W/VceZV/jnNoHHH/38s84BO4oNv3yyiLI5
         izE9jAWndeW7iYKiBMHBAwjDHWfLglsiTce3pBbKVJJ9P6Ljqe5KA3NOTHmVM2vYbixC
         PLUw==
X-Gm-Message-State: AOAM532lFUuWQK/EuGqc5c2XBP89lnWlKw76OPRAIii6BcvbsJT/fgx2
        QeN6ZGcdsoY+rOhWMyEUtktLUg==
X-Google-Smtp-Source: ABdhPJzv7bvrYR+mlfuj8Zfa0Q40k5yosYMgl8qha7VOp1dC5ZTQGIk73xwOI+ablL7lETeWVYngkQ==
X-Received: by 2002:a17:902:b48d:: with SMTP id y13mr15184503plr.79.1592187422041;
        Sun, 14 Jun 2020 19:17:02 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y18sm11855775pfn.177.2020.06.14.19.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 19:17:01 -0700 (PDT)
Date:   Sun, 14 Jun 2020 20:16:59 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?Q?S=C3=A9rgio?= Augusto Vianna 
        <sergio.a.vianna@gmail.com>, don@goodman-wilson.com,
        git@vger.kernel.org, simon@bocoup.com
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200615021659.GA67624@syl.local>
References: <CAGA3LAcDpQQhcmaQG3+s6XNnth54KmNC+padAXXYsc5C33p7kA@mail.gmail.com>
 <fcad8e8f-e853-d754-e3f7-644a5c717f84@gmail.com>
 <20200614190842.GC6531@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200614190842.GC6531@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Sun, Jun 14, 2020 at 07:08:42PM +0000, brian m. carlson wrote:
> On 2020-06-14 at 00:05:33, Sérgio Augusto Vianna wrote:
> > No one here has to explain why something not racist is racist. The problem
> > are the perpetually offended that see racism in literally everywhere.
> > Specially when there's virtue signaling points in the table.
>
> I want to take a second to respond to this because I think there's
> something this discussion may be missing that I want to make explicit.

Thank you for this thoughtful and personal response. I appreciate you
sharing your perspective, and I think that it is helpful, patient, and
powerful.

> When we use language, that language has a context.  Part of that is
> situational and part of it is based on how the receiver perceives it.
> Very little of it actually comes from what the actual intent of the
> sender is, because we can't be 100% certain of the sender's actual
> intent without explicitly asking them (and not always even then).  Even
> if we can, that doesn't usually change the perception of the receiver,
> so it doesn't change the message that was received.  And it's important
> to note that the message that was sent and the one that was received can
> be very different.
>
> There is nothing we can do to avoid this context because it's inherent
> in language and in the enormity of human experience.  We can only
> control what context we deliver to others by being aware of how other
> people perceive our words.
>
> I'd like to illustrate this with an example from my own experience.  In
> Britain, the word "faggot" refers to a type of meatball which many
> people enjoy.  In many English-speaking countries, it's also a slur for
> a gay, bisexual, or queer man.  Even if, when I hear that word in a
> culinary context, I can objectively tell myself that the word is meant
> with neutral intentions, it still brings to mind the fact that I and
> many of my friends have been called that and with that, my experiences
> of discrimination and harassment.  One could say that I'm just easily
> offended, but whether I want to be reminded of those experiences or not,
> I am.  My mind just goes there.  The context here has nothing to do with
> the sender, who probably meant well, but the message I received in, for
> example, reading a restaurant menu, was a negative one.
>
> A reasonable person who wants to communicate well will be aware of this
> context and will choose to use a different phrase if they don't want to
> communicate that negative context.  For example, the restaurateur may
> choose to use the phrase "savory ducks" on their menu instead.  If they
> choose not to, then we may draw conclusions about their intent when they
> use the language they use.
>
> Similarly, when we use the words "master" or "slave", even in contexts
> where they have different meanings, we send context along with that use.
> Black people, although able to objectively distinguish the two contexts,
> may receive a reminder that they or people like them have been subject
> to bondage, inequality, oppression, or discrimination.  If that is not
> the context we wish to send to them, then we should consider using
> different language.  Nothing prevents us from using those words except
> for our desire to communicate or not communicate a certain context.
>
> And while I admit that in this discussion one may say that one word is
> an obvious slur and one is not, that doesn't mean that the context the
> receiver receives is necessarily that different.  It may vary in its
> intensity, but the underlying negative context may still be there.

I want to echo this as much as I possibly can. Language has meaning.
Sometimes intentional, sometimes unintentional; but words matter, and
words can hurt. Changing the name of the default branch away from
'master' is not intended to solve all of the world's problems, nor will
it. But, it's a small thing that we *can* do to make a difference in
*this* project.

If we take the argument that our efforts here are being wasted because
of other uses of 'master' in the English language, then nothing will
ever get done since everybody will always be waiting on everybody else.

Doing this is the right thing to do. It is *easy* for us to do, given
our extreme privilege, and it should be done.

Thank you for highlighting the many ways that language and our choice of
words matters and affects people. I understand that this is a deeply
personal experience that you are sharing on the public mailing list, and
so I thank you for your courage in using your voice to do so.

> I do want to underscore that free software is not exempt from this
> phenomenon because we use language, and all communication with words is
> subject to these same limitations and to the human experience.
>
> The proposed patch series makes the branch name configurable, so you may
> choose to use a default branch name which suits you.  It sounds like you
> may choose to stay with "master", and you are welcome to make that
> decision.  However, as with all language, that comes with context, and
> others will receive and interpret that context and draw their own
> conclusions about your intentions.

I think that I am on a slightly different topic by now, but please note
that this change does not *break* anything. It doesn't force people to
change the names of their branches. Any user of Git is welcome to name
their branches however they like, so long as they accept the
consequences of doing so.

> On a final, slightly different note, I also want to remind folks that
> are here that we have a code of conduct, which encourages us to use
> welcoming and inclusive language and be respectful of differing
> viewpoints and experiences, and to refrain from insulting or derogatory
> comments.  I know that this isn't always easy, but I encourage community
> members to consider their comments carefully with that in mind,
> especially when feelings are as strong as they are here.  If you want to
> take some time to remind yourself of what it says, it's available as
> CODE_OF_CONDUCT.md in the root of the repository.

Thank you. It is for exactly these situations that the CoC is useful.
Nobody--certainly not you--is trying to force any ideology on anybody.

The CoC should serve as a reminder to us all that there are people on
the other side of our emails, and that we should treat those people with
respect, and as we would ourselves wish to be treated.

> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204

Thanks,
Taylor
