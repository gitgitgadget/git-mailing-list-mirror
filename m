Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71BAC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 21:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJTVOq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 17:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJTVOp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 17:14:45 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDA932058
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 14:14:41 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id e10-20020a17090301ca00b00183d123e2a5so279311plh.14
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 14:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5oljR3kmG56xVLhaB2JGfhzWTwsCgrdOuvy5aQWF8Pc=;
        b=rFwI+Dy0gxB7o+eg8YCAriBQ0ncsdKMHFMVK+fN6KS2JaHJlq7u8kXqS3C70dapoaK
         S8i45GhM2sR86BcdT+tZ15rVXjRXZhaRo1325mIkGwEEYhhEo0x1RLAFlW7N8Wb9Kous
         ZO98dF6uj+PK8MalZFvHPc7pv/DaQJDLBkB3qdB+vxHbfb/uU7vzgdX7Lb25qRdlcfCz
         J/tdidDLi8KrHOL25hn7+mcqooS8YBwNIVt0OTO40QHVQLH36Q13m2sgNaJS8kRSl5hF
         NHbPgLA6xvP+vuhVAmQcs+WvDST5CIRaxpxEC04xu5oc2Txi11T+a5qdqURq1WR59CO+
         /QFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5oljR3kmG56xVLhaB2JGfhzWTwsCgrdOuvy5aQWF8Pc=;
        b=MNQIfm30GH5JkQVMZFJ8lmLCvwBk19rwSdKFLjqh6Bu0KEsXW3nmZUs0ljmzsHVh0b
         Xw9lrUHbtmbMVvuExLgndIu4bsqDEld8VHfRRBSxm31/Y/bRTx46HhUaigyLuDI6rXXt
         6wI5RILf4cphGXU76q/VwPOXu0FnBeyD5c6nd6+mNnQFCPZXKCnxAxi9rN6EfP0GSmX1
         /PJJMqM5P7W279+QqZYMRxqYsyqIqfgnYlfxcGH2cNIUDb70uBrYI0ZllOMqWIFxoIz0
         Vwbv2Bav33HF8q/IuAuPCoX6Vk4NHWwzdqqu/EWIJWzdHI9sFrJdYB5CP7EVYoNRhclr
         jGHA==
X-Gm-Message-State: ACrzQf3U120k6jpKENInqLqWjytOSneIASx65p4LB2f7tRYMWOw7xWTq
        KuekTui/02o4quY7QoSI+ILFKqNndDL4cg==
X-Google-Smtp-Source: AMsMyM6b3CP6SYYwk9J8YVGhYDjWH0ExD3Q0vsvDa5Hk3Cd3A9jO85odH0iMhT1T4yLMivNTpeRwm809ioNBzQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:52d8:0:b0:562:3c8d:d427 with SMTP id
 g207-20020a6252d8000000b005623c8dd427mr15898253pfb.44.1666300480794; Thu, 20
 Oct 2022 14:14:40 -0700 (PDT)
Date:   Thu, 20 Oct 2022 14:14:39 -0700
In-Reply-To: <patch-04.10-db6a09ee42a-20221017T115544Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com> <patch-04.10-db6a09ee42a-20221017T115544Z-avarab@gmail.com>
Message-ID: <kl6ly1taxkn4.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 04/10] git-submodule.sh: dispatch "foreach" to helper
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonas Bernoulli <jonas@bernoul.li>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Dispatch the "git submodule foreach" command directly to "git
> submodule--helper foreach". This case requires the addition of the
> PARSE_OPT_STOP_AT_NON_OPTION flag, since the shellscript was
> unconditionally adding "--" to the "git submodule--helper"
> command-line.

The commands in the previous patch also unconditionally add "--", so
this wasn't clear to me on first read.

It might be clearer to include some extra context, which is that "git
submodule foreach" is different because everything after "foreach"
should be treated like a single comand to run even if they are passed as
separate strings, e.g. from t/t7407-submodule-foreach.sh.21, these two
should be equivalent:

  git submodule foreach "echo be --quiet"

vs

  git submodule foreach echo be --quiet

So PARSE_OPT_STOP_AT_NON_OPTION is necessary in order to stop us from
intepreting option-like args as args to "git submodule foreach" instead
of as part of the command to run. Without PARSE_OPT_STOP_AT_NON_OPTION,

  git submodule foreach echo be --quiet

becomes more like

  git submodule foreach --quiet "echo be"

There could have been a subtle change in behavior, since "git submodule
foreach -- --foo" will be parsed as if "--foo" is the command, but
PARSE_OPT_STOP_AT_NON_OPTION will happily accept "--foo" as an option.
But we could never get into this situation anyway since we used to emit
usage on the first option-like arg...

> -# Execute an arbitrary command sequence in each checked out
> -# submodule
> -#
> -# $@ =3D command to execute
> -#
> -cmd_foreach()
> -{
> -	# parse $args after "submodule ... foreach".
> -	while test $# -ne 0
> -	do
> -		case "$1" in
> -		-q|--quiet)
> -			quiet=3D1
> -			;;
> -		--recursive)
> -			recursive=3D1
> -			;;
> -		-*)
> -			usage
> -			;;

i.e. here.=20

So this patch looks safe.

