Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72B501F576
	for <e@80x24.org>; Wed, 24 Jan 2018 09:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932784AbeAXJLr (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 04:11:47 -0500
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36175 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932356AbeAXJLm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 04:11:42 -0500
Received: by mail-oi0-f41.google.com with SMTP id w135so2374846oie.3
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 01:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TzoHZJUV7VpeqqK+t9pGzA6PH73FZls4EoPLRPk4Vfg=;
        b=AXzkA54KRoueFQz4+yhvISSKc08/9YQfv2bYec/ahHy2GcRl2e3oAckdmb0XsIgMa6
         T+lDDck+rsIBc0UA6W4SYLK9gbEu8KWrQ/sopddmzea58QPB/7crR4SU0hOJ8ZSX7RlC
         EA3JYO8GdP0DePDPlrKafSzNV4trHGr33FocEgZhG8E0DKNSLEJO1glRr04MSSuDWIIl
         73W/EVcHJLw4ldmohbKj0nKEbg5QaoU/rOW/I/CzZtalZxyM0XEBMihNATuxcMuxS4ix
         qIPi1OJNuWSNTODL0ahNSxFTGiK68NE5XmZYnGa2lkmUP1ef4JOodOv0C0dHsgiydMFS
         a/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TzoHZJUV7VpeqqK+t9pGzA6PH73FZls4EoPLRPk4Vfg=;
        b=XmSpDzUltHPA5t1U62LWBagn+ZNkaKhQkNWsKWpIFfNuz7IwoHRPcbPpE/hhJOP+X7
         3OmvQIU4yuNknqTtDpq/JvMNFgcFhqBLDHGNF3wPbffIKMFvNJaFGj1QldGprMtFXxjU
         pSwiTlXNxll8GDVOukovMufeD/Mxpy5y0HXdeaqdT3ABCCv9jvFX0EL/Lb5FWc9JrGq8
         JdfBpxWDt1nXlF01vw42WLxY8TIPSl6LbEkqUJzjAh57gIb9TKy7sYtdvCxzDxQTOfre
         JLs69rCf3qMdqIq1khZ/R8/RItt+kVe87sh04fT/w2MkQ5jrHymeC8CFhdvYIQORBqMy
         K22w==
X-Gm-Message-State: AKwxytfbiV8a5B9kBq+5sd46JMv3cZORkq0Pz24D+r2l0ODmsnE4tqlF
        TFr8V7j2dpT1jIdKqJLtuReUAwpG8hEN3iR5pQc=
X-Google-Smtp-Source: AH8x226Jb9Q9R1Cfi4+stXZsCbbEU7p+ohlRmgVgKXPt7sIvs4PEjk1TawyqvuORadjXggX8W8zQvTIDU7tVTgp2/w4=
X-Received: by 10.202.196.208 with SMTP id u199mr7772644oif.117.1516785101967;
 Wed, 24 Jan 2018 01:11:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.144.218 with HTTP; Wed, 24 Jan 2018 01:11:11 -0800 (PST)
In-Reply-To: <20180122182717.21539-1-szeder.dev@gmail.com>
References: <CACsJy8BBXQ9KErfiuf2ty_4szE2fiHLDiKvMig1LbSefzf-o7w@mail.gmail.com>
 <20180122182717.21539-1-szeder.dev@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 24 Jan 2018 16:11:11 +0700
Message-ID: <CACsJy8AVL4HzPxRjwT9qSc8g_5FwAVgpbEPQ5TfDuxr9C91wqA@mail.gmail.com>
Subject: Re: [PATCH 3/3] read-cache: don't write index twice if we can't write
 shared index
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 23, 2018 at 1:27 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
>
> On Thu, Jan 18, 2018 at 1:47 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Thu, Jan 18, 2018 at 6:36 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com=
> wrote:
>>> This series, queued as 'nd/shared-index-fix', makes the 32 bit Linux
>>> build job fail on Travis CI.  Unfortunately, all it can tell us about
>>> the failure is this:
>>>
>>>   Test Summary Report
>>>   -------------------
>>>   t1700-split-index.sh                             (Wstat: 256 Tests: 2=
3
>>>   Failed: 1)
>>>     Failed test:  23
>>>     Non-zero exit status: 1
>>>   Files=3D809, Tests=3D18491, 401 wallclock secs ( 7.22 usr  1.60 sys +=
 263.16
>>>   cusr 49.58 csys =3D 321.56 CPU)
>>>   Result: FAIL
>>>
>>> because it can't access the test's verbose log due to lack of
>>> permissions.
>>>
>>>
>>>   https://travis-ci.org/git/git/jobs/329681826#L2074
>>
>> I may need help getting that log (or even better the trash directory
>> of t1700).
>
> Well, shower thoughts gave me an idea, see the included PoC patch below.
> I can't really decide whether it's too clever or too ugly :)

I can't comment on the patch. But there is one thing I think I should
mention. As someone new to Travis, I didn't know that I could set up
my own Travis jobs and get the logs myself. Maybe you should point
that out when you point people to travis test failures (which I
appreciate).
--=20
Duy
