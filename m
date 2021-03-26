Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9C0C433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 19:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE0DC619C7
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 19:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhCZTyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 15:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhCZTyV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 15:54:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74799C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 12:54:21 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x21so7628677eds.4
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 12:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GewOPkwShpv/MXvDrbXESMReD+nle1goPbcuGPqYFPk=;
        b=TxepCQ6wi2TPP4COvq7TxHS6GmOc8BEj55Nl32xvjAaKkznMEdbqh2+8adP4iVL5OD
         lqmUsXHEc/tYjGV9saLLRP6frjrhhc/whV9dw5zUQnsaAq6JdUPBZgoFF6qUktRVofkw
         +A+7Pz9JLJqsI1kRYNtK0/DUuMfgclY+klyO/ypXiXp/zxUnEhZtOL7ECn6gXFYjr9gi
         sXmipl+jxSfXO/ikG8haUt5rn3YtAuh85cMB+hAvGLdbdlBQZE5b5sYQIKDOGdRyE42g
         vLFQUUmtkVDE+kiF2xdYEc8jdsC2oLXpXIrv35kqvX+CjwEtodlgzMQFmOvsMkPF4yMe
         D1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GewOPkwShpv/MXvDrbXESMReD+nle1goPbcuGPqYFPk=;
        b=Y+V5N0aKAwKDBxp96pPPn4zonst7k36wPBIcdEKhXwxRrsURoWcxj/ezfHDKETyddv
         O8cV8Od7zTmfPg9RdI60wjNqoVQ/pNYD8+vrny5mycDaNUoXq1xExK9txZ5Z40AjljTm
         Oe686/85tBdkSSCZZMGvEqZG8f8T+Y8jjYDMedDmoI1Bg9C3K8CJo072MLJ4iaqTqd/D
         9u3v7kYjYvcMVnWZCoEVnIFnebbykupkAxGkZSS6DhapOn92nzB+LMkFDXXEWnkcXavA
         UhdMoxvn92DNyjKrFA9UzrwtZRk56Ha4H5UjWym+q1GpgZiyk2szqjw+YckGeqxyeQLq
         8YYg==
X-Gm-Message-State: AOAM533uNKq3gwv6hxp5TU9gUZivsUiNPPQdCC9Aigy/GfwPiMmRErQ0
        n7uGcdxBHYa9cWzYo1i4wIU=
X-Google-Smtp-Source: ABdhPJwk+MTJobPbaQg0iuzjLHG1I2CrrDLC7EWF256epm31fnGu6kB1Ufa+28NRYz8YZ/o4vw/oiw==
X-Received: by 2002:a05:6402:4245:: with SMTP id g5mr17189008edb.306.1616788460250;
        Fri, 26 Mar 2021 12:54:20 -0700 (PDT)
Received: from szeder.dev (84-236-109-92.pool.digikabel.hu. [84.236.109.92])
        by smtp.gmail.com with ESMTPSA id eo22sm4289268ejc.0.2021.03.26.12.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 12:54:19 -0700 (PDT)
Date:   Fri, 26 Mar 2021 20:54:17 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 16/21] mingw: try to work around issues with the test
 cleanup
Message-ID: <20210326195417.GB2271@szeder.dev>
References: <pull.31.v5.git.gitgitgadget@gmail.com>
 <pull.31.v6.git.gitgitgadget@gmail.com>
 <991b41afa4a83a73f59a72504d269d64d12ecf8f.1548771561.git.gitgitgadget@gmail.com>
 <87zgzbgp1i.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2103191515430.57@tvgsbejvaqbjf.bet>
 <87a6qxzocs.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2103241257580.50@tvgsbejvaqbjf.bet>
 <20210324212051.GA2271@szeder.dev>
 <87lfacp3bp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lfacp3bp.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 24, 2021 at 11:57:46PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Mar 24 2021, SZEDER Gábor wrote:
> 
> > On Wed, Mar 24, 2021 at 01:01:49PM +0100, Johannes Schindelin wrote:
> >> Hi Ævar,
> >> 
> >> On Sat, 20 Mar 2021, Ævar Arnfjörð Bjarmason wrote:
> >> 
> >> > On Fri, Mar 19 2021, Johannes Schindelin wrote:
> >> >
> >> > >> On Tue, Jan 29 2019, Johannes Schindelin via GitGitGadget wrote:
> >> > >>
> >> > >> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >> > >> >
> >> > >> > It seems that every once in a while in the Git for Windows SDK, there
> >> > >> > are some transient file locking issues preventing the test clean up to
> >> > >> > delete the trash directory. Let's be gentle and try again five seconds
> >> > >> > later, and only error out if it still fails the second time.
> >> > >> >
> >> > >> > This change helps Windows, and does not hurt any other platform
> >> > >> > (normally, it is highly unlikely that said deletion fails, and if it
> >> > >> > does, normally it will fail again even 5 seconds later).
> >> > >> >
> >> > >> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >> > >> > ---
> >> > >> >  t/test-lib.sh | 6 +++++-
> >> > >> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >> > >> >
> >> > >> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> >> > >> > index f31a1c8f79..9c0ca5effb 100644
> >> > >> > --- a/t/test-lib.sh
> >> > >> > +++ b/t/test-lib.sh
> >> > >> > @@ -1104,7 +1104,11 @@ test_done () {
> >> > >> >  			error "Tests passed but trash directory already removed before test cleanup; aborting"
> >> > >> >
> >> > >> >  			cd "$TRASH_DIRECTORY/.." &&
> >> > >> > -			rm -fr "$TRASH_DIRECTORY" ||
> >> > >> > +			rm -fr "$TRASH_DIRECTORY" || {
> >> > >> > +				# try again in a bit
> >> > >> > +				sleep 5;
> >> > >> > +				rm -fr "$TRASH_DIRECTORY"
> >> > >> > +			} ||
> >> > >> >  			error "Tests passed but test cleanup failed; aborting"
> >> > >> >  		fi
> >> > >> >  		test_at_end_hook_
> >> > >>
> >> > >> I saw this sleep while reading some test-lib.sh code, doesn't this break
> >> > >> df4c0d1a79 (test-lib: abort when can't remove trash directory,
> >> > >> 2017-04-20) for non-Windows platforms?
> >> > >
> >> > > It does not really break it, it just delays the inevitable failure.
> >> 
> >> I still think this is the best answer to this (implicit) question:
> >> 
> >> > In any case, your patch clearly undoes whatever canary for gc issues
> >> > df4c0d1a792 was trying to put into the test-lib, but didn't say so in
> >> > its commit message.
> >> 
> >> I was not _really_ paying attention to that commit when I implemented the
> >> work-around you mentioned above. At the same time I think it does _not_
> >> undo the canary. If the trash directory cannot be removed via `rm -fr`,
> >> and if that is an indicator for something fishy going on, chances are that
> >> the second `rm -fr` a couple seconds later will _also_ fail, and we still
> >> get that error message.
> >> 
> >> The only reason why the second `rm` should succeed, at least that I can
> >> think of, is that something on Windows blocked those files from being
> >> deleted, and it is no longer blocking after a couple seconds, and that
> >> usually means that an anti-malware scanned those files.
> >
> > Both commits referenced in df4c0d1a79's log message fixed races
> > between 'test_done's cleanup and a still running background 'git gc',
> > and df4c0d1a79 was meant to draw our attention to similar issues in
> > the future.  And it did:
> >
> >   https://public-inbox.org/git/20190602091919.GN951@szeder.dev/
> >   
> > So no, the failure is not inevitable, there are other reasons why the
> > second 'rm' might still succeed after the first failed, even just a
> > fraction of a second later.  And yes, that 'sleep' added in the patch
> > above did unquestionably break that canary,
> 
> Having read that thread now I agree, but I also left with a "who cares?"
> and "so let's keep the sleep then?".
> 
> I.e. is this a problem that any of the software we're maintaining is
> going to care about in the wild, it's not like people are expecting gc,
> repack, fast-import etc. to behave well in the face of rm -rfing the
> directory they're operating on.
> 
> So it seems like just an issue that crops up because of how our test
> suite manages and removes per-test trash directories.

Not at all.  The real problem is that some stray background git
process is *still* actively writing to the test repository when the
test script is already supposed to be finished.

> So it seems better
> to:
> 
>  1. Just keep that "sleep a bit" and retry hack
> 
>  2. Maybe on some/most platforms we can use cgroups or whatever passes
>     for a reliable "I started a process tree starting at this PID, kill
>     -9 the whole thing please" before cleanup these days.

What really seems better:

  3. Keep that "sleep a bit" hack only on platforms that can't delete
     opened files.

