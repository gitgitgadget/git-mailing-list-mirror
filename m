Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8C8C433DF
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 23:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52B8F22266
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 23:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="pL9TCYXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgJRXgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 19:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgJRXgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 19:36:16 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FACC061755
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 16:36:16 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u19so10996194ion.3
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 16:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D25XCi6/0VBsudVQKCtWgsHDuita/Jf8xbLEhEkD4f4=;
        b=pL9TCYXrR7hqFUKOdnkSP9VZyCGD2/TbWd0xRDpLwK9OIIRdAEUQER/KwY9oiiJjNS
         EbWtde95VVYNEc4eOxSIqe9Pkti2iTgCS2gWhO3CvekFlBPizBfgAyRrHbFA5K1JUdha
         P86XvFPyi4wsY+MwO8jHsCdJBh4kwQG0BtPoGO7+q347dTF8E6EBY6KViNp1WJDS/387
         Qcc7M19AQjtxua8DQJX/yR/18TS6IyVXlV7Ftebg5Fritsao3gQVI6WmQ+na/OJV4vcC
         rKthg+hs78IwHTxrmUlVi0KqpQzLQXS/cYOhflUXy/L1CyBg3DoZ8aaA9kEasTX6eyYw
         n+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D25XCi6/0VBsudVQKCtWgsHDuita/Jf8xbLEhEkD4f4=;
        b=b/ZH4EZrJOXvPHl9NB4ajFghFniyequ8Z3XT3RHnd2UsmanDbPTnD5v3+GB6zu1zii
         n+IiUuly/bijUpvPYMi+jSNhhBNzpd2sVBt7/dslvYwQNURJav69BVyH87AmhBc3KBZN
         ErgoAyozSOwSZzKhoO3cEy/9ijjI/Jwd4QD/PaJGPZ9AO91EWRwksxk9FlpevaVRCAwf
         9KOygJ/VwmJo5NM3816nW4lEeIvOUFOlryCgdf2hnVeFCWAs7CIy0n/nq+93tgKmSNhi
         FaaFjYFdV7ubSY4S/5xGzheob3iqgwGT8y1aZhntWammFbvIrfUZT5I6XXA7sCfVYgcV
         84Tw==
X-Gm-Message-State: AOAM532T1OKyUIgzz5DSB7L3hPYEkwiKIxPU9fYYP1nNJUqFZRK7KCz+
        aVA6l6VI4E0IXvUg5Wt0EEqlfw==
X-Google-Smtp-Source: ABdhPJwmu5j3EnSi4p//MI6dDWQD+huvdn0TLHCSpbYcIvXDFyrr0CifKlRRl+S8ZGA+OxOxMwgZcQ==
X-Received: by 2002:a05:6602:208c:: with SMTP id a12mr8958614ioa.55.1603064175305;
        Sun, 18 Oct 2020 16:36:15 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:c096:f5e9:cd72:773e])
        by smtp.gmail.com with ESMTPSA id p17sm8536392ilh.34.2020.10.18.16.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 16:36:14 -0700 (PDT)
Date:   Sun, 18 Oct 2020 19:36:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     caleb.tillman@gmail.com, git@vger.kernel.org
Subject: Re: [Outreachy-Microproject][PATCH 1/1] t0000: replace 'test -[def]'
 with helpers
Message-ID: <20201018233612.GB4204@nand.local>
References: <20201018061052.32350-1-caleb.tillman@gmail.com>
 <20201018130219.GA6749@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201018130219.GA6749@konoha>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 18, 2020 at 06:32:19PM +0530, Shourya Shukla wrote:
> 'git format-patch -v2 @~n', where 'n' is the number of commits which you
> want to include in the patch. So in your case it will be:
> 'git format-patch -v2 @~1' and a patch mail will be generated.

(Note also that providing the name of the branch that yours is based off
of is just as good, i.e., 'git format-patch -v2 master').

> Also, you need not put the '[Outreachy-Microproject]' tag in the
> subject, '[OUTREACHY]' will suffice.

Thanks for saying this.

> Now, coming to the meat of the patch.
>
> > The test_path_is* functions provide debug-friendly upon failure.
>
> This commit can be redone to be even more better. This does not exactly
> reflect what has been done. I understand that yes 'test_patch_is_*'
> functions are better and why they are better. But where did you replace
> them, this is left unanswered.
>
> This is one example of how the commit messages can be, not too verbose
> and not too short, somewhere in the middle:
> https://lore.kernel.org/git/20200118083326.9643-6-shouryashukla.oo@gmail.com/

I'm actually perfectly happy with the patch text; let's not
overcomplicate something as straightforward as using a built-in test
helper instead of 'test -f'.

> The change is fine but I feel you can easily find files in which you can
> do the same type of change but in a large quantity. This way you will
> get an even better idea of how the tests work at Git. To find such
> files, one way can be to look here:
> https://github.com/git/git/tree/master/t

I'm also fine with Caleb just working on t0000; sending this patch on
its own would usually look like unnecessary churn unless it was either
(a) preparation for some other modification to t0000, and we want to
start from a modern-looking base, or (b) it is in the name of removing
'test -f' from 't' en-masse, in which case I'd expect this to cover all
of our tests.

Since this is just to get Caleb's feet wet, I'm fine with them starting
small :). Sending this patch to the mailing list in a good format with a
well-written commit message is exercise enough.

> Here if you try finding files which had commits over 11-12+ years ago,
> you will find some ancient relics to modernise too! Great that you took
> Taylor's advice ;)

:-)

Thanks,
Taylor
