Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C6FC433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15EF613DC
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhDUKjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhDUKjo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 06:39:44 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64942C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:39:11 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id p2so13934187pgh.4
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eB4JQ1TG4gTSLaMLSLIITChT4JIexvx9bgSSSJXvV+4=;
        b=cEny9OAODlMyx84uunzbhkQZj3RUra1Vvh4z5VwectiDdrKwzKfvXfeNWdpZFkKEI6
         bXdjqIq+6j/dwsG2Rdd4ulKLd9mW7gFNH+pmQNQAfCGLuFfgUOjR6p39H6pjZXnR6UjC
         YECgiaqtqVTFv9b+AbxjrTbAE6I48C4vdtklGaYPpChtQQnga17VNvBB+j4KtB7Fo91w
         z/+2gUIs5aVeiGDgdjh+zC4wDoPxMoGrke7N2B2qZg+4mEEWlf3AeWv+l28k66/8VpOh
         5GO/5CTiVRHUvRqXW5qm28ruusBverSVfiSO6R+et2DCX/c29opDgyrKr3MTmsXg5YfM
         cTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eB4JQ1TG4gTSLaMLSLIITChT4JIexvx9bgSSSJXvV+4=;
        b=kIRbFpIna+uHjIFAQ0MwGhxQjcuidfToYkfw6zwwDvAQAACgNwJJYz+JlhhWYE2HJY
         9C1EDAzGPzZ7cNxNdDAucV3Qra7a2aQEW2z8P+K5568mwh8mgD7jJUG4FpIKbVqyTLC9
         R1WO0tO7cqUPpQ7Rwt1DNjAJAwWbR5zisAPsZ/73PU0koCp70WyfMLuyv6bVR+uTrSXx
         d0K7n7fM7rhTzNPpyG1oxD5OhXmlRpgVudHDou83E36LlwI5bLUHP+R+v0KrB6fcI6bL
         oMMG4HW0scsIEpr/+iAU5ZczvGkns4ZxI44j8jDm04PjFZTiAroFVr3zRsJf4Su4xhE6
         v+RQ==
X-Gm-Message-State: AOAM532J0NI7KA7qpupAhOOdU6UvuqoqAijQhGgUTh9+dJJIkNvZvFQM
        DucWi6QYHikE2w7TXMkqMv4=
X-Google-Smtp-Source: ABdhPJyRi0gmCnZFDl/ypfxqwGe+RPXDmpjNTNHRTQT+VZESHPkxZb/2Gol/27pd/vGhouEumCQRww==
X-Received: by 2002:a63:1c22:: with SMTP id c34mr21212023pgc.408.1619001550919;
        Wed, 21 Apr 2021 03:39:10 -0700 (PDT)
Received: from localhost ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id q18sm1595826pfj.131.2021.04.21.03.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 03:39:10 -0700 (PDT)
Date:   Wed, 21 Apr 2021 17:39:08 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 01/12] check-non-portable-shell: check for "test
 <cond> -a/-o <cond>"
Message-ID: <YIAAzJTG1UitiWyu@danh.dev>
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
 <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
 <patch-01.12-a8b483bc77-20210420T121833Z-avarab@gmail.com>
 <xmqqwnsw3872.fsf@gitster.g>
 <87r1j42ffz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r1j42ffz.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-04-21 10:46:08+0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> 
> On Wed, Apr 21 2021, Junio C Hamano wrote:
> 
> > Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> >
> >> These will only match the simplistic forms of `test -X blah` (where
> >> "-X" is some single letter option), but will miss expressions such as
> >> `test "$foo" = bar`. We stop at "&" or "|" to try not to overmatch
> >> things like:
> >>
> >>     test whatever && ls -a foo
> >>     test whatever && foo -o outfile
> >
> > I still do not understand why you have to insist on dashed operator
> > as the first thing given to "test", like this:
> >
> >> +	/\btest\s+-[a-z]\s+[^&|]+\s+-a\s+/ and err '"test A && test B" ...
> >> +	/\btest\s+-[a-z]\s+[^&|]+\s+-o\s+/ and err '"test A || test B" ...
> >
> > IOW, what over-matching would we get if we simplified the condition
> > like so?
> >
> >     /\btest\s+[^&|]+\s+-a\s/
> >     /\btest\s+[^&|]+\s+-o\s/
> >
> > The one in the patch would miss things like
> >
> > 	test "$a" = "$b" -o "$a" -lt "$b"
> > 	test "$n" -a "$n" -lt 4
> >
> > but the only thing that we care about is that a command that started
> > with "test " has "-a" or "-o" before we see "&" or "|", no?
> 
> Applying your suggestion results in these false positives:
> 	
> 	t4038-diff-combined.sh:135: error: "test A && test B" preferred to "test A -a B": git commit -m "test space change" -a &&
> 	t4038-diff-combined.sh:147: error: "test A && test B" preferred to "test A -a B": git commit -m "test other space changes" -a &&
> 	t6400-merge-df.sh:89: error: "test A || test B" preferred to "test A -o B": test 0 -eq $(git ls-files -o | wc -l)
> 	t6400-merge-df.sh:91: error: "test A || test B" preferred to "test A -o B": test 1 -eq $(git ls-files -o | wc -l)
> 	t6400-merge-df.sh:110: error: "test A || test B" preferred to "test A -o B": test 0 -eq $(git ls-files -o | wc -l)
> 	t6400-merge-df.sh:112: error: "test A || test B" preferred to "test A -o B": test 1 -eq $(git ls-files -o | wc -l)
> 	t6402-merge-rename.sh:639: error: "test A || test B" preferred to "test A -o B": test 0 -eq "$(git ls-files -o | wc -l)"
> 	t6402-merge-rename.sh:646: error: "test A || test B" preferred to "test A -o B": test 2 -eq "$(git ls-files -o | wc -l)"
> 	t6402-merge-rename.sh:686: error: "test A || test B" preferred to "test A -o B": test 0 -eq "$(git ls-files -o | wc -l)" &&
> 	t6402-merge-rename.sh:865: error: "test A || test B" preferred to "test A -o B": test 0 -eq $(git ls-files -o | wc -l) &&

With: 7dbe8c8003, (check-non-portable-shell.pl: `wc -l` may have
leading WS, 2017-12-21)
Unless the situation has been changed, since.
I think those tests with quoted "$(.. | wc -l)" has been deemed
unportable and should be replaced with test_line_count anyway?
Does "test -eq" strip spaces from integer strings?

And I think we're working on moving "git" command to its own commmand
instead of put it in the left of a pipe.

2 followed patch will clean them out


-- 
Danh
