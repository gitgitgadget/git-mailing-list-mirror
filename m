Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D82C07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 23:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60706608FC
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 23:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhGKXV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 19:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhGKXVy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 19:21:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EB1C0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 16:19:06 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id he13so30383746ejc.11
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 16:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=hP1/6bmlHUwPsM9nBXvJc19MFpOhXUnhTO1qNWaHnbo=;
        b=Of8mf0QJNEy2Lxe4sUD2F2m8ItqnJjYgawcQZKQMgMBzpqV1UNRCA8e763du3PhBr8
         5X226M/S96RQlW2seFwypwzGOL2+HeBFtpm8qOOMoEhTEr8kOxzrwPf8/Rbm/ye8D50c
         D03ZBuffUT97l1cNT0E3auhVwk+InymaqSfsAVsznzKj0eMp4xu6O+fLExKr/SbzIfBN
         vPHpMbG8Ss7LTJJAvW4cd4WlcPTcZM+QwAC8WZBhdyoqtdshVo95XYBWjJFcrDiqm4ZM
         n1Pe8ms6HEJ3N024yP3T8U7JylQHiA+zK5d+Lxn3ZHUOZS7eRwwovc2sdYTHVPuetBWe
         Qtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=hP1/6bmlHUwPsM9nBXvJc19MFpOhXUnhTO1qNWaHnbo=;
        b=PGdEKDpLEPL4LzK9oIhFocl7ckDWbafhJfEH5za672q9ouKq5BEYSIejukhvrBMhze
         WooMmjF3O59v0f0o3y9ry8Y0lLfSyGFUI6RaocDlc4HK+eO1WlnX8UPzQa+phJI9VmQt
         1LWdyG6GPn7s/OYJuxI7SRnLnHf0BgdKE7N48ELTJ/ptZNOvcB5t5LKqRC5pkFux8Kuz
         Smwwhvj1qFDb5uLsvAMGjcfVovDwCQYl1pA3TKDQCjF/l9YU+rUtnaaXYKu7kODbN+GN
         IImg55NCrvG3lt0JjYPmxvFIL86Nw9zrBiijtIou6obgFJPpvF+KbuZONKSwTbbWI2U7
         9kOg==
X-Gm-Message-State: AOAM5305URmz1f3ttSTADG7i4pK5eE1UffYrAd1FeKE9KxqflVWXfH5k
        fopkmo4PRszweVQ8g42oyG+ujCq0r8EXfZhZ
X-Google-Smtp-Source: ABdhPJxnmKa8Y8adcqdzpqlxen63SMXpWk13L4t+NRoOl9+XQKAjrpRT1+ToezOCDFIY+mIsHysHrA==
X-Received: by 2002:a17:906:6c8f:: with SMTP id s15mr13365580ejr.498.1626045544991;
        Sun, 11 Jul 2021 16:19:04 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n6sm1482757ejc.120.2021.07.11.16.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 16:19:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 4/6] *.h: add a few missing  __attribute__((format))
Date:   Mon, 12 Jul 2021 01:05:53 +0200
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
 <patch-4.6-3bf8637c16a-20210710T084445Z-avarab@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <patch-4.6-3bf8637c16a-20210710T084445Z-avarab@gmail.com>
Message-ID: <877dhw4exj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jul 10 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

So this:
> [...]
> For strbuf_addftime() let's add a strftime() format checker. Our
> function understands the non-portable %z and %Z, see
> c3fbf81a853 (strbuf: let strbuf_addftime handle %z and %Z itself,
> 2017-06-15).
>
> That might be an issue in theory, but in practice we have existing
> codepath that supplies a fixed string to strbuf_addftime(). We're
> unlikely to run into the "%z" and "%Z" case at all, since it's used by
> date.c and passed via e.g. "git log --date=3D<format>".
> [...]
>  /**
> @@ -425,6 +426,7 @@ void strbuf_vaddf(struct strbuf *sb, const char *fmt,=
 va_list ap);
>   * `suppress_tz_name`, when set, expands %Z internally to the empty
>   * string rather than passing it to `strftime`.
>   */
> +__attribute__((format (strftime, 2, 0)))
>  void strbuf_addftime(struct strbuf *sb, const char *fmt,
>  		    const struct tm *tm, int tz_offset,
>  		    int suppress_tz_name);

Fails with compat/mingw.[ch] doing:

    [...]
    compat/mingw.c:#undef strftime
    compat/mingw.c-size_t mingw_strftime(char *s, size_t max,
    compat/mingw.c-               const char *format, const struct tm *tm)
    [...]
    compat/mingw.h:#define strftime mingw_strftime
    [...]

What's a good macro idiom to dig oneself out of that hole? The only
similar thing I could find was NORETURN in git-compat-util.h being
defined differently on various platforms, and then things like:

	+#if !defined(__MINGW32__) && !defined(_MSC_VER)
	 __attribute__((format (strftime, 2, 0)))
	+#endif

Which seems to work, and may be the simplest workaround...

