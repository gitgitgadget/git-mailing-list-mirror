Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143F9C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 22:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345052AbhK3WsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 17:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344866AbhK3WsC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 17:48:02 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2304DC061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 14:44:42 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a18so47836644wrn.6
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 14:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=O9S0n9NJ0lkitlDCSsoCk40Oks6St603EjnduNeYAiM=;
        b=jg1lx1qFIH8edGNzFUFE79VahFuiUoHU5haQSqHT/XJkUYRpEhnvcrJr/4MjF8v+zx
         f4S0XAkt7424N1dsVqGYBpRcY6wZ1blcyzyZkbDPWjZFdBK6rZRztA3TVKwdn1gNHPQa
         /5lbfRwDJTSuIact4VSRgSXLSISwTFDz6F6reQYkOd1qbW7TOgeIGeOoNvtaIbPhSDMr
         7Ua4QWdzntm9HsbOXRKi9NHLWqwgUUYna6IYN3xTXSDrE+A/1r0WJj3Y/epOdioqtBTF
         K9xGsid/7p+bNAnMnCGflbO1X0dOuknCtoH6pkZZk+B0CbWNVTNcjyX0vS1nNeI/z/1W
         dCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=O9S0n9NJ0lkitlDCSsoCk40Oks6St603EjnduNeYAiM=;
        b=Kw5QnIxCdIQiGInpXde/mGVO7i2Q2ZTcWz1mxuFOjyen0Q43qdL+3ltJLXRP5gzb4p
         yFO/AzZ+eH9PKMqQW5zymMPnpmum2ihA9SI/7KKF/EAuOaKgmjVGfGOvReePyosWGKYk
         uL5+XuXIO0whvbdKsJMA0q/zeqEiFhAzP2l6zLx5WFF0JOGywX8Rovz0vL8bZmCZH+50
         uSiFPgxLHsVgT2PaGMOxpfOiiNZVXRJsqMKSvptxDnQLl6wj0xDCb9j6kdzPgKTfit0K
         eDLDlcM/EfiOMFYe0eAh2tVcllef8Ow7eqv5sgneOtde55oft2FcyWyJtaYpZmFpYUHu
         zwqA==
X-Gm-Message-State: AOAM533OukQ6p9qo1FIfDoUZt9zxW+hNHKUMpbZ5nhAfpnfprHoBsxID
        Pgy13DnlnD23v2fH/pXEASk=
X-Google-Smtp-Source: ABdhPJwa8J40XDMtjaHa0LYaF10CPXg0jERjhjGiBQBnL5CalfNahEIZtPYuO7dnDaYD1/qSy/LZ8g==
X-Received: by 2002:a5d:6085:: with SMTP id w5mr2251677wrt.122.1638312280642;
        Tue, 30 Nov 2021 14:44:40 -0800 (PST)
Received: from szeder.dev (78-131-17-57.pool.digikabel.hu. [78.131.17.57])
        by smtp.gmail.com with ESMTPSA id s63sm3920390wme.22.2021.11.30.14.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:44:40 -0800 (PST)
Date:   Tue, 30 Nov 2021 23:44:35 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] test-lib.sh: have all tests pass under "-x", remove
 BASH_XTRACEFD
Message-ID: <20211130224435.GA1991@szeder.dev>
References: <pull.1085.git.1638193666.gitgitgadget@gmail.com>
 <patch-1.1-9f735bd0d49-20211129T200950Z-avarab@gmail.com>
 <YaaS4Idhdyo2wZ9q@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YaaS4Idhdyo2wZ9q@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 04:08:48PM -0500, Jeff King wrote:
> On Mon, Nov 29, 2021 at 09:13:23PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> > Once that's been removed we can dig deeper and see that we only have
> > "BASH_XTRACEFD" due to an earlier attempt to work around the same
> > issue. See d88785e424a (test-lib: set BASH_XTRACEFD automatically,
> > 2016-05-11) and the 90c8a1db9d6 (test-lib: silence "-x" cleanup under
> > bash, 2017-12-08) follow-up.
> >
> > I.e. we had redirection in "test_eval_" to get more relevant trace
> > output under bash, which in turn was only needed because
> > BASH_XTRACEFD=1 was set, which in turn was trying to work around test
> > failures under "set -x".
> > 
> > It's better if our test suite works the same way on all shells, rather
> > than getting a passing run under "bash", only to have it fail with
> > "-x" under say "dash". As the deleted code shows this is much simpler
> > to implement across our supported POSIX shells.
> 
> I'm mildly negative on dropping BASH_XTRACEFD.

I agree, using BASH_XTRACEFD is the most robust (and least hacky) way
to get reliable trace from our test scripts, and we should definitely
keep it.

> IMHO it is not worth the
> maintenance headache to have to remain vigilant against any shell
> function's stderr being examined, when there is single-line solution
> that fixes everything. Yes, the cost of using bash is high on some
> platforms, but "-x" is an optional feature (though I am sympathetic to
> people who are _surprised_ when "-x" breaks things, because it really is
> a subtle thing, and knowing "you should try using bash" is not
> immediately obvious).
> 
> Some folks (like Gábor) disagree and have done the work so far to make
> sure that we pass even with "-x". But it feels like this is committing
> the whole project to that maintenance. I dunno.

It's not that I disagree but rather it's in our best interest to keep
'-x' working with non-Bash shells as well, because:

  - We run our tests with '-x' in CI, because we want to get as much
    information out of test failures as possible.

  - We run our tests with dash in the Ubuntu jobs not only because
    that's the default /bin/sh, but more importantly because we want
    to avoid bashisms in our test suite.

