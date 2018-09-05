Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 610CD1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 18:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeIEXKK (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 19:10:10 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34406 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbeIEXKK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 19:10:10 -0400
Received: by mail-qt0-f196.google.com with SMTP id m13-v6so9346934qth.1
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 11:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GC2r/gH/jDBHqHlrC1Cx3xNBHePvk9gxD3ZHbIZZXXI=;
        b=k7KeQFsAJ5sAym8UZGEY/Zkszr/VmkjKzA4efiyPq/AfE2y6+g955qrPXjpLSsx4Pm
         Bw36ZlU/O7JMGq4Xhlr75Ny5HjmwgOtSYoC5s+RtkZKPIlJ24h7hqT5PsGMP3s5fpHsd
         tOOlwZiRqgaYwyqzXyQ0VL+j7OTyfSkKZdmIi26PJGij2MwVhvV3zGX88pYa4hRzxnZv
         ra/V1wT4O4dSkKFKQ2bYrYrAbMlvgPPg8/4TvdOyUr2Qgigiz/7M8VIaRGvZG6PqFx54
         n+yzVY6POkr1OlD6/GdjrrGmmPMVV0Ab31Jg+bpm4cw3YBOmOAVbA0l/3bOOGlAoH/pG
         lRCg==
X-Gm-Message-State: APzg51CVx2+5RwFaR5puOOouaVZ/uB2xIOzda76mxxmUy8TRaLPnmBft
        X5n26m/gYruitBr4zQz9G++OSZ+7QxSB/9Vj0bc=
X-Google-Smtp-Source: ANB0Vdahs39b3heeZtCjgTU3arVx/TkFk/8grqG0DCwmeWrYrIHNDQ/+8ttFA4GBROJ/7KbG2xPff4F1UuVToDDm+C8=
X-Received: by 2002:aed:304b:: with SMTP id 69-v6mr11372594qte.220.1536172725930;
 Wed, 05 Sep 2018 11:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.31.git.gitgitgadget@gmail.com> <942bf423a461a3b44e2ff254c90907a539d7abbe.1536009027.git.gitgitgadget@gmail.com>
 <CAPig+cRGHPfNqdgRr6H_D_siKCFZBDsUrcp0F+CWNCx884AJVg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1809041304450.71@tvgsbejvaqbjf.bet> <CAE5ih7_GgkEaVXONy8ZY9j43PX6GD-mkD9vJ1t93upAfTkM8tw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1809051430390.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1809051430390.71@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 5 Sep 2018 14:38:34 -0400
Message-ID: <CAPig+cQkC4-6DyQdJHc8QUfBx+L6o1SK4ODy4MoP44+VHHk96Q@mail.gmail.com>
Subject: Re: [PATCH 7/9] tests: include detailed trace logs with
 --write-junit-xml upon failure
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Luke Diamand <luke@diamand.org>, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 5, 2018 at 8:39 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> So let's hear some ideas how to improve the situation, m'kay?
> Just as a reminder, this is the problem I want to solve: I want to run the
> tests in a light-weight manner, with minimal output, and only in case of
> an error do I want to crank up the verbosity. Instead of wasting most of the
> effort to log everything and then throwing it away in most of the common
> cases, I suggest to re-run the entire test.

What about the very different approach of capturing the full "verbose"
output the executed tests in addition to whatever is actually output
to the terminal? If a test fails, then (and only then) you can insert
the captured verbose output into the JUnit XML file. This way (if we
always have the full verbose output at hand), you don't need to re-run
the test at all.

I've cc:'d Peff and Jonathan since I believe they are more familiar
with how all the capturing / output-redirection works in the test
suite.
