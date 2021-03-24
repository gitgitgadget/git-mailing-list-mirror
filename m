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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB943C433E1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 21:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C631561A1E
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 21:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbhCXVVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 17:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238228AbhCXVU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 17:20:58 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E497C06174A
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 14:20:57 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id e7so49665edu.10
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 14:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7uY2ElOkEdFP3vPhsCP8XbAQtsuQQX0U3uh/wRBa8xc=;
        b=bSi3g76ObS6fSIkP0nXNQ6EAZ0Q16StRD7kuXQ5jQBY6DqENrYkVfMUxU2sgtbbPlc
         4nS8p5hbPbeP6t6bDmysdgE7VRnAZEQ+xYbjg6a1loNV6kS9rNbIyNeb6MJIziJSLmKo
         ZeXkDrIbxWPRSZ9sBHQGWXGPF+gnPWAAOCpLXB7174JN9ILahtn8pr4wKflV+qAYPXji
         IGsFliLOSm7myHfEtlfJIAZVwymX0hbRt+c4lOCfqJ9J0sPNovqHX5RxIG0OLbXgoSB8
         knYoWgWcqDGzfoN7Zg1FIXelGgtoSrfJSFDTGpJ+TDrw9efnogkbgw0SdE3MBqmHnfrq
         Pt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7uY2ElOkEdFP3vPhsCP8XbAQtsuQQX0U3uh/wRBa8xc=;
        b=KD+wp3tw2rT4l9n6dvHdEG1pMLcOFQTbntnAncmk8ocu+e4v5hEe9mGAQQxSkJZYDs
         vVUIv9/F73fBrSQkEmlLhAikPD16hpMch3j0KaC1OiyxhjNb7TvQttlKVgWBfLn86KMs
         6JbLhBKsiQ0/NsWDa0dpUSohFaP98jvP+WJPlbJJJPrlsXWQXqu5g+d64sjdpyww3uLv
         EW30ewpAkxyBYcpwcJkagD/+LofrHof9LxphElVGoRpcY1ANo8HnDGOTL0hQzGn86Lxk
         mrmcKMD/Un8iYGe/bURfSsDGTGpc9CRzY5cPimPNsacerh/VTRaASeHjhYo1FH3h0bwk
         BUug==
X-Gm-Message-State: AOAM531LbGUfJr/cbPSgpuv+83Wpsaa3Og0I5SNMeegNm7WZottvEMNZ
        NSnUcl7thBflsqL6b3uOltM=
X-Google-Smtp-Source: ABdhPJxa27pXM182cvXP9ydUuUtkop1MwKDC2qzSo7kmibW258sI4MaWnwk8BxC0fZBdAGx1Kzqcdg==
X-Received: by 2002:a05:6402:3049:: with SMTP id bu9mr5712190edb.104.1616620856325;
        Wed, 24 Mar 2021 14:20:56 -0700 (PDT)
Received: from szeder.dev (84-236-109-92.pool.digikabel.hu. [84.236.109.92])
        by smtp.gmail.com with ESMTPSA id q25sm1731367edt.51.2021.03.24.14.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:20:55 -0700 (PDT)
Date:   Wed, 24 Mar 2021 22:20:51 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 16/21] mingw: try to work around issues with the test
 cleanup
Message-ID: <20210324212051.GA2271@szeder.dev>
References: <pull.31.v5.git.gitgitgadget@gmail.com>
 <pull.31.v6.git.gitgitgadget@gmail.com>
 <991b41afa4a83a73f59a72504d269d64d12ecf8f.1548771561.git.gitgitgadget@gmail.com>
 <87zgzbgp1i.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2103191515430.57@tvgsbejvaqbjf.bet>
 <87a6qxzocs.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2103241257580.50@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2103241257580.50@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 24, 2021 at 01:01:49PM +0100, Johannes Schindelin wrote:
> Hi Ævar,
> 
> On Sat, 20 Mar 2021, Ævar Arnfjörð Bjarmason wrote:
> 
> > On Fri, Mar 19 2021, Johannes Schindelin wrote:
> >
> > >> On Tue, Jan 29 2019, Johannes Schindelin via GitGitGadget wrote:
> > >>
> > >> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >> >
> > >> > It seems that every once in a while in the Git for Windows SDK, there
> > >> > are some transient file locking issues preventing the test clean up to
> > >> > delete the trash directory. Let's be gentle and try again five seconds
> > >> > later, and only error out if it still fails the second time.
> > >> >
> > >> > This change helps Windows, and does not hurt any other platform
> > >> > (normally, it is highly unlikely that said deletion fails, and if it
> > >> > does, normally it will fail again even 5 seconds later).
> > >> >
> > >> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >> > ---
> > >> >  t/test-lib.sh | 6 +++++-
> > >> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >> >
> > >> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > >> > index f31a1c8f79..9c0ca5effb 100644
> > >> > --- a/t/test-lib.sh
> > >> > +++ b/t/test-lib.sh
> > >> > @@ -1104,7 +1104,11 @@ test_done () {
> > >> >  			error "Tests passed but trash directory already removed before test cleanup; aborting"
> > >> >
> > >> >  			cd "$TRASH_DIRECTORY/.." &&
> > >> > -			rm -fr "$TRASH_DIRECTORY" ||
> > >> > +			rm -fr "$TRASH_DIRECTORY" || {
> > >> > +				# try again in a bit
> > >> > +				sleep 5;
> > >> > +				rm -fr "$TRASH_DIRECTORY"
> > >> > +			} ||
> > >> >  			error "Tests passed but test cleanup failed; aborting"
> > >> >  		fi
> > >> >  		test_at_end_hook_
> > >>
> > >> I saw this sleep while reading some test-lib.sh code, doesn't this break
> > >> df4c0d1a79 (test-lib: abort when can't remove trash directory,
> > >> 2017-04-20) for non-Windows platforms?
> > >
> > > It does not really break it, it just delays the inevitable failure.
> 
> I still think this is the best answer to this (implicit) question:
> 
> > In any case, your patch clearly undoes whatever canary for gc issues
> > df4c0d1a792 was trying to put into the test-lib, but didn't say so in
> > its commit message.
> 
> I was not _really_ paying attention to that commit when I implemented the
> work-around you mentioned above. At the same time I think it does _not_
> undo the canary. If the trash directory cannot be removed via `rm -fr`,
> and if that is an indicator for something fishy going on, chances are that
> the second `rm -fr` a couple seconds later will _also_ fail, and we still
> get that error message.
> 
> The only reason why the second `rm` should succeed, at least that I can
> think of, is that something on Windows blocked those files from being
> deleted, and it is no longer blocking after a couple seconds, and that
> usually means that an anti-malware scanned those files.

Both commits referenced in df4c0d1a79's log message fixed races
between 'test_done's cleanup and a still running background 'git gc',
and df4c0d1a79 was meant to draw our attention to similar issues in
the future.  And it did:

  https://public-inbox.org/git/20190602091919.GN951@szeder.dev/
  
So no, the failure is not inevitable, there are other reasons why the
second 'rm' might still succeed after the first failed, even just a
fraction of a second later.  And yes, that 'sleep' added in the patch
above did unquestionably break that canary,

