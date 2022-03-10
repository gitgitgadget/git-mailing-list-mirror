Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80609C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 01:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbiCJCAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 21:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiCJCAl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 21:00:41 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0BE27FED
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 17:59:40 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id 1so2748221qke.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 17:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bpm5/TLxPmov9Bafut5xTmLu/k36Bb+pMCC3CDwY5mA=;
        b=WdhAH+oVv94WbPGZ+Pl5wcS8dwcwfod/I9ObB6tu0HD265PVlms2nDSqWOx0QxjfD1
         U0/VJgbx97nREaiyhXV9OQ4Qeq56wrXjH7ElxLTb0emZ+fr3D8coeMXHg5a81RnsBE5h
         aklCStX71I/nCenGVrxLyf6zogOYn5lYvdzLtGv5uJb3tdG3D/d3nZf0TQYkFxBLgxlt
         rTyrRfXR6Ep7l+cW7byzfZhruy/rXfBTQsw3RDQuE1j/bURzGXlIYlmjNep7A+g4TrjK
         RBlJ46dBOpvDefcuNKoI0k52PpKf/pdTaJx73od6tSWyPtxj7W0xSVoF+Xs6pzzhLvPH
         V06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bpm5/TLxPmov9Bafut5xTmLu/k36Bb+pMCC3CDwY5mA=;
        b=kfNhwIcmd+e9ZtUcC7HoY2uEHk1MU6Q//wCsaMJUg/8RDiuQs9ajYawPfk6i5KTxfZ
         EUCWjBFpb7mytv6yJWkknzyMT0myDOUOCOjXSTq6xmi8iktiPCg45B2+h+Q0A9HRh6qq
         h/sYSy5BDGQtahAjI0TES6idKfMo4xv9vXoMMVh944VD0GdFz25K27MH5bi5rNRURHMH
         FnPRCM03Jw0nwt2Rgpo++buIJ2qQZst6ylx1cTO5NyS+nhu6ao9iFqEqvpbnkXBJhWVQ
         2MVjKTgLquFEkW3kMIIXyNIsXMF9Id1hrwjIBKb21eSCqMs24Ty0t7BKGTBr6DOZMkzC
         B0IA==
X-Gm-Message-State: AOAM530HgttsxElafY5LqqjdgGOjn0LgdZPy7iRuA7ZSc2FyV+SxxXiR
        fSdMp9TUO0t+eGnXYrbSYU8=
X-Google-Smtp-Source: ABdhPJyqBNpQ4srIM7Ob2Nf8TMSD758eA7D1+Vda+O6p0KF7opJc4w6nlVkZM0EmX4u3LMiLDv19Pw==
X-Received: by 2002:a37:9dd4:0:b0:67b:1899:4b08 with SMTP id g203-20020a379dd4000000b0067b18994b08mr1709343qke.57.1646877579921;
        Wed, 09 Mar 2022 17:59:39 -0800 (PST)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id y17-20020a05622a121100b002e0702457b2sm2377735qtx.20.2022.03.09.17.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 17:59:39 -0800 (PST)
Date:   Wed, 9 Mar 2022 17:59:37 -0800
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] block-sha1: remove use of assembly
Message-ID: <20220310015937.tx5hgpr75at7kvrm@carlos-mbp.lan>
References: <20220307232552.2799122-1-sandals@crustytoothpaste.net>
 <20220308022240.2809483-1-sandals@crustytoothpaste.net>
 <220308.864k48y35f.gmgdl@evledraar.gmail.com>
 <Yikl2eGbc8sPsy5G@camp.crustytoothpaste.net>
 <Yikq7POhuxeN1UPQ@nand.local>
 <220310.86cziulls6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220310.86cziulls6.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 10, 2022 at 12:52:31AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Mar 09 2022, Taylor Blau wrote:
> 
> > On Wed, Mar 09, 2022 at 10:10:33PM +0000, brian m. carlson wrote:
> >> On 2022-03-08 at 13:38:06, Ævar Arnfjörð Bjarmason wrote:
> >> >
> >> > On Tue, Mar 08 2022, brian m. carlson wrote:
> >> >
> >> > I think the $subject of the patch needs updating. It's not removing all
> >> > the assemply from the file, after this patch we still have the
> >> > ARM-specific assembly.
> >> >
> >> > I don't have a box to test that on, but I wonder if that also triggers
> >> > the pedantic mode?
> >> >
> >> > Perhaps:
> >> >
> >> >     block-sha1: remove superfluous i386 and x86-64 assembly
> >>
> >> I suspect it has the same problem.  My inclination is to just remove it,
> >> because my guess is that the compiler has gotten smarter between 2009
> >> and now.
> >
> > Almost certainly. I don't have a machine to test it on, either, but I
> > would be shocked if `make BLK_SHA=YesPlease DEVELOPER=1` worked on
> > master today on an arm machine.
> 
> Why is that? The -pedantic error is specifically about
> "gnu-statement-expression", i.e. the bracket syntax, not the inline
> assembly per-se.

not sure how gcc version (as mentioned elsewhere) might affect this, but
had built it successfully in aarch64 with gcc 4.8.4, and arm32v6 with
gcc 10.3.1.

Carlo
