Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2389C433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 15:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C88123382
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 15:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390241AbhATPXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 10:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403812AbhATPWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 10:22:16 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA37C061757
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 07:21:36 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id g12so34063904ejf.8
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 07:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=owF2uWhozNmKVBtDfkIrK5nDjCZpaZkmv70bw55xQXU=;
        b=LupBMMl54RnxXYLng9y0Qy1CubCX8fz1sgifBEmDHBgm3vIDe3AV0Wcr96m4n63Pw/
         JcNyZXzMbGS1UneKkh17yG4Wj6aC7vya/GTkK27EBaa6BpjKpkScyBTyWwaZlFApvpWc
         kizDuVK0FgJlU2duDLtn2RAOpqcXyPM1eMINenmrwLJT4TYeb6qtFhgxcd4HqtXcBDj+
         cD2WfsKnldaxBBc+MmXZpQKwPKsc//++kiKJUxXBEXB0Z3L3fjR85SkQJPyP9HgxI/sJ
         5CAFDWg+y6cLh+lnB3hJa5CMuExT1ROWCL52l8tkIVqY3YXVK3v+fdh1GE35z8ZOYi0o
         G+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=owF2uWhozNmKVBtDfkIrK5nDjCZpaZkmv70bw55xQXU=;
        b=spXqy2w6AmY24/zfAPIQq1+k1y+r2zfR3+yqxkMCGtg3oYtK/iz8Tc3ALbeJ/j8BLV
         ra60gf9D1PpkWidrJfLOtVLd2afP12gUE+EfF1LDjwY+5Tlwm0RrNaXsUJ/YwED7wNYM
         DOffaThDv+l6vBZuZnfp151lP29gS/vQ6xeMDKYZPqfL4RFnBo/84ApGVIy8f95YUla9
         HN85YbnwPu5xcDb+DE4wPyr6iURCEV0RlK+xEP+OU8txqtLLwrpnNw3jUrWOGlT0N0KO
         gzX3c8krp6zHR7Y5HqQrAQmykaaYmylbX9gVyooHdeme79TkBSnuDfP06fEhhBpsDOS4
         bQQw==
X-Gm-Message-State: AOAM5323k4Z/jm+weP/fXTPLjXaNkgUYP47hy7Vqv3rTts6p6Nfes0NK
        pkB7LnhMqX++H5OJNTzpzr0I2YOY6fk=
X-Google-Smtp-Source: ABdhPJzeTrdv//ca19gOKgNsnCDjc4o4+isdsQywPt3W3Tw+6VokJw/xldVN+n/Zv+iZ8rpj3Vnt4w==
X-Received: by 2002:a17:906:c78b:: with SMTP id cw11mr6554772ejb.448.1611156094982;
        Wed, 20 Jan 2021 07:21:34 -0800 (PST)
Received: from szeder.dev (92-249-246-25.pool.digikabel.hu. [92.249.246.25])
        by smtp.gmail.com with ESMTPSA id bo20sm1268316edb.1.2021.01.20.07.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 07:21:34 -0800 (PST)
Date:   Wed, 20 Jan 2021 16:21:32 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Should you use test_i18ngrep or GIT_TEST_GETTEXT_POISON=false?
Message-ID: <20210120152132.GC8396@szeder.dev>
References: <20201223013606.7972-1-avarab@gmail.com>
 <20210105194252.627-13-avarab@gmail.com>
 <20210110132155.GT8396@szeder.dev>
 <87y2h062jd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y2h062jd.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 10, 2021 at 07:59:50PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sun, Jan 10 2021, SZEDER Gábor wrote:
> 
> > On Tue, Jan 05, 2021 at 08:42:41PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> We need to provide GIT_TEST_GETTEXT_POISON=false here because the
> >> "invalid object type" error is emitted by
> >> parse_loose_header_extended(), which has that message already marked
> >> for translation. Another option would be to use test_i18ngrep, but I
> >> prefer always running the test, not skipping it under gettext poison
> >> testing.
> >
> > This is fairly unconvincing.  Why do you prefer it that way?  What is
> > so special in these tests of 'git mktags' that could possibly warrant
> > this special treatment WRT gettext poisoning, as opposed to the other
> > ~1500 invocations of test_i18n{grep,cmp}?
> 
> You prodded me about this and Johannes also did off-list. So given that
> this is already in "next" I think it's best to let usage in this mktag
> series land as-is.
> 
> I promise I'll follow-up with something to (at least start to) fix this
> generally one way or the other on "master" after that. It's a trivial
> part of this particular series.
> 
> I.e. either document & migrate away from test_i18ngrep (mostly, in some
> cases it's still convenient), or git rid of this and the few existing
> GIT_TEST_GETTEXT_POISON=false uses.
> 
> Anyway, as both the initial author of this poison facility & of its
> current runtime incarnation in git.git, some context on it:
> 
> The need for test_i18ngrep was always a wart. When I submitted the
> initial i18n patches a big selling point at the time to a (rightly so)
> skeptical audience on the Git ML was that it could almost entirely be
> turned off at compile-time, and that we had something in place to make
> sure we didn't introduce plumbing bugs by overtranslating.
> 
> For a while the mass-i18n patches were about as noisy on-list as the
> sha256 conversion patches were in more recenty memory.
> 
> So if you look through the history you'll see that first we skipped
> whole tests with the C_LOCALE_OUTPUT prereq, and then test_i18ngrep was
> a more granular way to do that:
> 
>     git some-command >output && 
>     test_i18ngrep "c locale string" output
> 
> But since 6cdccfce1e0 (i18n: make GETTEXT_POISON a runtime option,
> 2018-11-08) this hasn't been needed. But yes, we have a bit under 10
> years of test_i18ngrep usage in the test suite now.
> 
> But that stuff is the wart, and purely a historical artifact of this
> having once been compile-time only. We don't do this sort of thing with
> any other GIT_TEST_* option, e.g. we have tests like:
> 
>     t/t5512-ls-remote.sh:   GIT_TEST_PROTOCOL_VERSION=0 git ls-remote --symref --heads . >actual &&
>     t/t5512-ls-remote.sh-   test_cmp expect actual &&
> 
> Not:
> 
>     t/t5512-ls-remote.sh:   git ls-remote --symref --heads . >actual &&
>     t/t5512-ls-remote.sh-   test_protocolv0cmp expect actual &&
> 
> Because that doesn't make sense. If we know we're testing protocol v0
> here why wouldn't we just pass that as a parameter in the test? Same for
> GIT_TEST_GETTEXT_POISON=false.

I think it's the comparison of GIT_TEST_GETTEXT_POISON and
GIT_TEST_PROTOCOL_VERSION that doesn't make sense in the first place.

For the sake of users who might be stuck on Git version not yet
understanding protocol v2 or have to connect to a v0-only remote, we
must make sure that both v0 and v2 protocols work, so a simple
'make test' must exercise both.  Since protocol v2 is the default
nowadays, we need a way to tell some tests to use v0 instead, and
setting GIT_TEST_PROTOCOL_VERSION=0 ended up our standard way to do
that.  Besides, the uses of GIT_TEST_PROTOCOL_VERSION is quite
contained, as it is set in only 34 times in 13 test scripts.

GETTEXT_POISON is purely a developer aid (of questionable usefulness
as you explained above), no end user would ever see it, and yet the
test_i18n* functions are used ~1500 times in 250+ test scripts.  I
sure dont't want to see 1500+ uses of 'GIT_TEST_GETTEXT_POISON=false
git cmd...'.  Besides, what would be the purpose of
'GIT_TEST_GETTEXT_POSION=true make test' if it would eventually be
overriden all over the place?

> I have also wondered if a better approach at this point isn't to just
> remove the thing entirely. We're just doing incremental i18n-ization at
> this point, so the odds that it's catching accidental plumbing
> translations is rather low compared to 2011-era git.git.

I wouldn't mind seeing it go...  well, I think I would welcome it,
actually :)  I can only recall cases where a failure of the
GETTEXT_POISON CI job was resolved by another replacement of 'grep'
with 'test_i18ngrep', but I don't seem to remember a case where we
decided that "Nah, this message should not have been translated in the
first place".

I would, however, really miss the error reporting of 'test_i18ngrep',
though, i.e. that it shows the contents of the file when it doesn't
find a match.

