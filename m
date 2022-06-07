Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6CCC43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 02:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382781AbiFHCqt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 22:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391947AbiFHClH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 22:41:07 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA61D24F96E
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 15:06:04 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q18so15951505pln.12
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 15:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tB3+SQTg+Ja5RG83Y5AZBYTMNT2t/TFMGhGNYSKCpxI=;
        b=AI9L2ZneJnr6UiPNbOeG54vSLpS8rzl6DFJc1x2lVpB9IU8mrZSrVPpp9C//ZLLYho
         kWTCKxCttFGc8XW9D8iZNp8yBcabV2WRN73XYk3bu515mUg3MLI+3opsI3HTIQ3hZ/sZ
         olTKH/+lVeCoMbyXuOQ3IBlu1+Di2MNFsROs+UGgVWCE2FRfGDxTDRtr7ac1Cy4HDqLD
         aUjuR1ZNlbaKnbkROUxJmaL/feWsolTny8zsczmB82DfwPmWLPaUP1Kfr5nneso4TZCM
         G6N1Qp75i31UYrKA3sN1xBJ4mLQR2QnuDiDKxhmqluO53qXMaKA2xfpJwdAwPCSSIVt7
         xf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=tB3+SQTg+Ja5RG83Y5AZBYTMNT2t/TFMGhGNYSKCpxI=;
        b=mCiXeguM9gzrE39RN1/xJ1M5qR//5ExiPnY+tGyc1ZwAPaW2GGcs1RWqfl6hSln+Pm
         YA8LG1KQf8TQqmimohyLPeUJSX8hg30udwgE36qM0g1AB4N9QUKAV43iSihzz91SybiE
         KB9VKiaR1tmrrb3o/nTmsOxn+eL/YmMJ3WYRN3f8Y3oq7eJ6YXgswYq8QjhBn1WaBr6n
         hJAaTYoAglw4UCQWlRakeNKQvIVYTGaCDz0hH+3FnHLDvVNSBWHAhOssp5eu3z0RmrLF
         6dTB1ft5ChBGtWybgdLCiiIy2p9k9/D1rh3xVW5SuA3ilTcSNUGoXEg25sQ8B2+A0Mdu
         3P7w==
X-Gm-Message-State: AOAM531VhlAl0ba+qh0UPeOoLCivitNRmCo8OyercpsYRaJ+lM6Uo2dY
        +sNbVrVuGDc+GpaLZZwl2Sltsw==
X-Google-Smtp-Source: ABdhPJySMz6MBjyKhpOBYhMTdX84cCIwIN/A+Dw+mMau52jDJaxbutaxtigswvJNjYMZzUEJyu1tfw==
X-Received: by 2002:a17:902:f708:b0:153:839f:bf2c with SMTP id h8-20020a170902f70800b00153839fbf2cmr31243349plo.113.1654639563426;
        Tue, 07 Jun 2022 15:06:03 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:e7e0:a701:982f:c785])
        by smtp.gmail.com with ESMTPSA id jh17-20020a170903329100b001636d95fe59sm13078509plb.172.2022.06.07.15.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 15:06:02 -0700 (PDT)
Date:   Tue, 7 Jun 2022 15:05:57 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v3 1/6] common-main.o: move non-trace2 exit() behavior
 out of trace2.c
Message-ID: <Yp/LxRguys1FRJHH@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Glen Choo <chooglen@google.com>, Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
 <cover-v3-0.6-00000000000-20220602T122106Z-avarab@gmail.com>
 <patch-v3-1.6-9c4f8d840e9-20220602T122106Z-avarab@gmail.com>
 <Yp+wjCPhqieTku3X@google.com>
 <220607.8635ggupws.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220607.8635ggupws.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.06.07 23:12, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Jun 07 2022, Josh Steadmon wrote:
> 
> > On 2022.06.02 14:25, Ævar Arnfjörð Bjarmason wrote:
> >> Change the exit() wrapper added in ee4512ed481 (trace2: create new
> >> combined trace facility, 2019-02-22) so that we'll split up the trace2
> >> logging concerns from wanting to wrap the "exit()" function itself for
> >> other purposes.
> >> 
> >> This makes more sense structurally, as we won't seem to conflate
> >> non-trace2 behavior with the trace2 code. I'd previously added an
> >> explanation for this in 368b5843158 (common-main.c: call exit(), don't
> >> return, 2021-12-07), that comment is being adjusted here.
> >> 
> >> Now the only thing we'll do if we're not using trace2 is to truncate
> >> the "code" argument to the lowest 8 bits.
> >> 
> >> We only need to do that truncation on non-POSIX systems, but in
> >> ee4512ed481 that "if defined(__MINGW32__)" code added in
> >> 47e3de0e796 (MinGW: truncate exit()'s argument to lowest 8 bits,
> >> 2009-07-05) was made to run everywhere. It might be good for clarify
> >> to narrow that down by an "ifdef" again, but I'm not certain that in
> >> the interim we haven't had some other non-POSIX systems rely the
> >> behavior. On a POSIX system taking the lowest 8 bits is implicit, see
> >> exit(3)[1] and wait(2)[2]. Let's leave a comment about that instead.
> >> 
> >> 1. https://man7.org/linux/man-pages/man3/exit.3.html
> >> 2. https://man7.org/linux/man-pages/man2/wait.2.html
> >> 
> >> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> >> ---
> >>  common-main.c     | 20 ++++++++++++++++----
> >>  git-compat-util.h |  4 ++--
> >>  trace2.c          |  8 ++------
> >>  trace2.h          |  8 +-------
> >>  4 files changed, 21 insertions(+), 19 deletions(-)
> >
> > Just realized that this unexpectedly breaks the fuzzer builds:
> >
> > $ git checkout ab/bug-if-bug
> > $ make CC=clang CXX=clang++ \
> >    CFLAGS="-fsanitize=fuzzer-no-link,address" \
> >    LIB_FUZZING_ENGINE="-fsanitize=fuzzer" \
> >    fuzz-all
> >
> > [...]
> >     LINK fuzz-pack-headers
> >     LINK fuzz-pack-idx
> > /usr/bin/ld: archive.o: in function `parse_archive_args':
> > archive.c:(.text.parse_archive_args[parse_archive_args]+0x2cb8): undefined reference to `common_exit'
> > [...]
> 
> Hrm, that's a pain, sorry about that.
> 
> > The issue is that we don't link the fuzzers against common-main.o
> > because the fuzzing engine provides its own main(). Would it be too much
> > of a pain to move this out to a new common-exit.c file?
> 
> I could do that, I actually did that in a WIP copy, but figured it was
> too much boilerplate to pass the list.
> 
> But why it is that we can't just link to common-main.o? Yeah the linker
> error, but we already depend on modern clang here, so can't we just use
> -Wl,--allow-multiple-definition?
> 
> This works for me with my local clang & GNU ld: 
> 
>     make CC=clang CXX=clang++ \
> 	CFLAGS="-fsanitize=fuzzer-no-link,address" \
>         FUZZ_CXXFLAGS="-fsanitize=fuzzer-no-link,address -Wl,--allow-multiple-definition" \
> 	LIB_FUZZING_ENGINE="common-main.o -fsanitize=fuzzer" fuzz-all
> 
> It seems to me that the $(FUZZ_PROGRAMS) rule is mostly trying to work
> around that by size, i.e. re-declaring most of $(OBJECTS).
> 
> But maybe it's a no-go for some reason, maybe due to OSX ld?

Ah yeah, that would probably work. The main concern is that we want
these to run via OSS-Fuzz[1], but I believe I can send a change to our
build script there to add that flag. Thanks for the suggestion!

[1]: https://google.github.io/oss-fuzz/
