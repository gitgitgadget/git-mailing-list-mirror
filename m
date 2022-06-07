Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B240C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384622AbiFHA3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1454825AbiFGXRd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 19:17:33 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215BE3C966C
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 14:13:37 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id cv1so13194223qvb.5
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 14:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/an/JKPdMJSBuOc95sbh927QTE2ymMvi79qlEvCXCDk=;
        b=6CeX2AkqpCxM5pWGVbFWoRWIL0sszA8dU+p1YEf+ArXoqE6Vn3mJLLWCEW1PaT4zKo
         j8EWvZIT+IcAvX3NlI1ag0QTXfGZk4Y0ADSH9AL6ko4z0CNZV0kZj0sPihk5UJ8lmFCd
         Xz/IGZkd0mJf4xqFgspZclMd3VA1Ux9P/0iES7Qg8Dezao5WxnhTaS2XxGLrxfWYoCzo
         gO4MpDn9ogVqNhT+Qd6MsWjg8C/Le82+ajH667TPe1aDYfUE2i4zOyDVU5gHFKGFuRkG
         e3eVN8+axmuYeAazRrdfTWL0zQrjRK2FF3p8a8As4ksRXLXSUFsLluWyoZm2ff0wY9o3
         QYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/an/JKPdMJSBuOc95sbh927QTE2ymMvi79qlEvCXCDk=;
        b=0JJHN9DBMs9cIEXMV5/eQY8PvpIv6riBgSJqOa7SNfXv0tKzX8MppVl0IvoL+vIqFF
         zRQOzSQepc2v5bOfeSo2ekTvB8JrAI/CEhwxR4ScY/aoiYmvrnWiv9D5mq6EHJB7O/XQ
         7S/yaGyH+HuZgd6t5sWc99ElrrjAu9sXjwIl1058gc/IGHf0F+4Sp7EeQySO+yA3vvYB
         Hc2uGkmGY2TqvVq7OIovDtu+XPbgOZwZSt6YzyrW5LtiI2ZRLtqV9goAnfg2YNdc4mQL
         i5hyOHOCpi9YSPNE1Cg07tycqOxVCSO6LavbrXSQQroR2GrOF0ExOOw0FnIMgAIzGty5
         xgzA==
X-Gm-Message-State: AOAM53131u58FN2KeuoKtV9kQYnhQhEshWtD/hbMrhsSGjRbqX5Nkw7I
        WCqgv8OtsLhdj+ff61RNu3n6JQ==
X-Google-Smtp-Source: ABdhPJzhIePPh0qX3f2Pw8Aq6aUpZE5SC8Zq1msImDERVdcGRdHWJGJCyE/EGLctR2uXot6dixOdXg==
X-Received: by 2002:a05:6214:2a88:b0:464:463a:7a84 with SMTP id jr8-20020a0562142a8800b00464463a7a84mr40515999qvb.53.1654636410767;
        Tue, 07 Jun 2022 14:13:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f9-20020ac80689000000b002f3e127be41sm12575603qth.20.2022.06.07.14.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 14:13:30 -0700 (PDT)
Date:   Tue, 7 Jun 2022 17:13:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com
Subject: Re: [PATCH 2/2] builtin/show-ref.c: limit output with `--count`
Message-ID: <Yp+/eXNg4tjiCn5a@nand.local>
References: <cover.1654552560.git.me@ttaylorr.com>
 <3fcf1f555715e925385d37712ffe880bb869741e.1654552560.git.me@ttaylorr.com>
 <220607.86r140vqc4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220607.86r140vqc4.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 07, 2022 at 10:07:32AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Mon, Jun 06 2022, Taylor Blau wrote:
>
> > diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
> > index ab4d271925..28256c04dd 100644
> > --- a/Documentation/git-show-ref.txt
> > +++ b/Documentation/git-show-ref.txt
> > @@ -10,7 +10,7 @@ SYNOPSIS
> >  [verse]
> >  'git show-ref' [-q|--quiet] [--verify] [--head] [-d|--dereference]
> >  	     [-s|--hash[=<n>]] [--abbrev[=<n>]] [--tags]
> > -	     [--heads] [--] [<pattern>...]
> > +	     [--heads] [--count=<n>] [--] [<pattern>...]
>
> In addition to what Junio noted, the SYNOPSIS is now inaccurate per your
> documentation. I.e. if this option is incompatible with --verify and
> --exclude-existing we should use "|" to indicate that, e.g.:
>
> 	[ [--verify] [--exclude-existing] | --count=<n> ]

Good catch. Should this be squashed into the first example in the
SYNOPSIS, the second, or a new one?

> > +	if (max_count) {
> > +		int compatible = 0;
> > +
> > +		if (max_count < 0)
> > +			error(_("invalid --count argument: (`%d' < 0)"),
> > +			      max_count);
> > +		else if (verify)
> > +			error(_("--count is incompatible with %s"), "--verify");
> > +		else if (exclude_arg)
> > +			error(_("--count is incompatible with %s"),
> > +			      "--exclude-existing");
> > +		else
> > +			compatible = 1;
> > +
> > +		if (!compatible)
> > +			usage_with_options(show_ref_usage, show_ref_options);
>
> Instead of this "int compatible" and if/else-if" just use usage_msg_optf().
>
> That or die_for_incompatible_opt4(), at least the new _() messages
> should make use of the same translations. I.e. we recently made these
> parameterized.

Good catch again. I wasn't aware of usage_msg_optf(), but it's exactly
what I'm looking for here. It does mean that we'd only print one warning
at a time, but I think that's a fair tradeoff, and unlikely to matter in
practice anyways.

And I must have dropped the parameterized msgids on the floor when
preparing this patch, since I definitely have it locally. Oops, fixed.

> > +	}
> > +
> >  	if (exclude_arg)
> >  		return exclude_existing(exclude_existing_arg);
> >
> > diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
> > index 9252a581ab..b79e114c1e 100755
> > --- a/t/t1403-show-ref.sh
> > +++ b/t/t1403-show-ref.sh
> > @@ -196,4 +196,25 @@ test_expect_success 'show-ref --verify with dangling ref' '
> >  	)
> >  '
> >
> > +test_expect_success 'show-ref --count limits relevant output' '
> > +	git show-ref --heads --count=1 >out &&
> > +	test_line_count = 1 out
> > +'
> > +
> > +test_expect_success 'show-ref --count rejects invalid input' '
> > +	test_must_fail git show-ref --count=-1 2>err &&
> > +	grep "invalid ..count argument: (.-1. < 0)" err
>
> The use of .. here seems odd...
>
> > +'
> > +
> > +test_expect_success 'show-ref --count incompatible with --verify' '
> > +	test_must_fail git show-ref --count=1 --verify HEAD 2>err &&
> > +	grep "..count is incompatible with ..verify" err
>
> ...i.e. this looks like a way to avoid "--" at the beginning, but then
> why use it in the middle of the regex?

Muscle memory ;).

> > +test_expect_success 'show-ref --count incompatible with --exclude-existing' '
> > +	echo "refs/heads/main" >in &&
> > +	test_must_fail git show-ref --count=1 --exclude-existing <in 2>err &&
> > +	grep "..count is incompatible with ..exclude.existing" err
>
> Seems like you could avoid it entirely by escaping it, e.g. "[-]-" at
> the beginning, or in this case I think "test_expect_code 129" would be
> more than sufficient, we use that to test "had usage spewed at us"
> elsewhere.

I like having the extra test to ensure the error we got made sense, but
I agree either would work. I modified the grep expressions to replace
leading "."'s with "[-]", and "."'s in the middle of the expression with
"-".

Thanks,
Taylor
