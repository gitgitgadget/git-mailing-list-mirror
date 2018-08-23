Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 664361F954
	for <e@80x24.org>; Thu, 23 Aug 2018 18:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeHWV7E convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 23 Aug 2018 17:59:04 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46017 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeHWV7E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 17:59:04 -0400
Received: by mail-qk0-f194.google.com with SMTP id z125-v6so4240093qkb.12
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 11:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KSO+Sb5NcLuwtSppTwUwsuX/TvQr0cIEUAyhIRCq148=;
        b=DLPp/h/2uN6cBiug/Vfu7PCTkzu1fkSXI0SVpzNoVBeEkwSDDVgjb4QUcYW7cC0ySO
         pfDRKwWq6IJGMGEPBTZNEn0roNjfgmLvMjoQQpcfNpww4xFKpxPiWu1akQ+SEMOApXuB
         I7uvL9+7Qj3NQBZJ3eW5p+7sJBzAaaGsDGqZqJlNsp/iEjnWyvO/zKQNZB/r0DpWVp3q
         U0ml2TB67iTU/hy1pBNVDTi1JHAZJ57cYhgLokh6roVr+frCF9FpKhkedmwueodK3jkh
         MWqei6FPOSs3+YEqsCUrA56orC0nRadL3djZKsa5yAo5XzeIcR2LGZVdROInHaHlpArm
         mXzg==
X-Gm-Message-State: APzg51DGOqtF9G/Ewg7h9+RK7D/uzb8dc2USc44UICW35vce3TELIpfq
        FOgZ5euicAXamfx20t50SZ8GqxxtXYbhjOkFHVU=
X-Google-Smtp-Source: ANB0VdYPlLYOT6W5M3eE9l//6v5sbaJz20HjyYAGyDQklCPzwe0Kq9XSZEvZ4cOaAmCPcSIcAu79bOHsVBBoZbQEiP0=
X-Received: by 2002:ae9:ef13:: with SMTP id d19-v6mr20233041qkg.152.1535048888151;
 Thu, 23 Aug 2018 11:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180711064642.6933-1-sunshine@sunshineco.com> <20180711064642.6933-2-sunshine@sunshineco.com>
 <871sapezba.fsf@evledraar.gmail.com>
In-Reply-To: <871sapezba.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 23 Aug 2018 14:27:57 -0400
Message-ID: <CAPig+cTTbU5HFMKgNyrxTp3+kcK46-Fn=4ZH6zDt1oQChAc3KA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 23, 2018 at 2:02 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Found in some 2.19 testing on AIX:

Thanks for reporting these issues.

> > +     /^[     ]*EOF[  ]*$/!bhereslurp
>
> AIX sed doesn't like this, and will yell:
>     :hereslurp is greater than eight characters
> This on top fixes it:

Fix make sense, and checking POSIX[1] , I see that it says that
behavior is unspecified for labels longer than 8 bytes.

[1]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html

> > +# bare "(" line?
> > +/^[  ]*([    ]*$/ {
> > +     # stash for later printing
>
> AIX sed doesn't like this either, and prints:
>     sed:    # stash for later printing is not a recognized function.
> I have no idea what the fix is for that one.

That's the only indented comment in the entire script, so it's almost
certainly that. How about we move the indented comment up to the
comment for the enclosing block, so it reads:

    # bare "(" line? -- stash for later printing
    /^[  ]*([    ]*$/ {
        h
        bnextline
    }

I could prepare such a patch, although perhaps it would be better for
you to do so since you are in a position to test it (and because you
discovered the problems)?
