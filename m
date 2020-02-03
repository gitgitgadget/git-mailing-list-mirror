Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69451C33CAC
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 10:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9B420661
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 10:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaqeSRZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgBCKsM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:48:12 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:45709 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgBCKsM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 05:48:12 -0500
Received: by mail-io1-f54.google.com with SMTP id i11so16107321ioi.12
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 02:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=eDbOGRo6Zr/6cZNe5HP0oT/aPLDUyEDmSYYT5wnjklI=;
        b=aaqeSRZlCvDvltK0VrdGXTMu/4l9c5hohsFKgByzdGnKpcoGUwrnHL0IeJF/gXcrfK
         Yo37zYoaUkoyWA1JmWYAB7KHg8XvopoZF4+g9fufX6OTienbV7arb3RhWFJQ9JJhgiyO
         KfJtiwNddrBYXdyHEdhZLA8qJXHlrf0ZOk+O3DmIJI/5bJwqqkDUM2GKZCED/FgfVjd8
         CrQzGM5qWbkuzSA+OjudR3RzHEcqceQ5rBefguVOW47SxmFX35/XWGy6zkg53aHqhKxm
         caV/LiRi+c8Nm5kkvVlXd/l+wQnbDMLhazBErqFCP7kEvflXNlgtol6AmBj24mVPdBdO
         827w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=eDbOGRo6Zr/6cZNe5HP0oT/aPLDUyEDmSYYT5wnjklI=;
        b=CgFANzgyHS1cjKq3sql0mhyoQviGEIGLze4yERn5XoSHlkOaATBmlGJju0DCfKVD/Y
         snx96OD2w3M9VTOMjMVkCQWp0bWLWrl7NXdfYtTkF0750RLoNy+Mj0J3T+t/7GbRKQeN
         wu1HyZ0fZa7tOgA3tebqq7DV9OdLVXDQdwgD4/OcTLRon/aAWg9/7d6kQpFC+bYKfA2X
         oKDxzXiEUqD8xS2v1A31VTVwsDD5syGT+fVepmVbDhAwohnyO2Y7LUEB/OVvb8DRTaZK
         ZScNXG1c31q3yGRMSTs7LFXEEuVFNWhOtRvAhTURIUmXB5tfb6YlSPOHMnIxMtOR0Flv
         Bpog==
X-Gm-Message-State: APjAAAWIyGhTLkzn626rZ2ccOuHFvRRz/IqzyDTNed/uYN/Q0KIcxsYx
        VN3Kq32CJvYMQuuJ7yCxItyJQIvI1IXpSnoRmBstBQy9
X-Google-Smtp-Source: APXvYqwh7F3M+fKsEEr9Hlh6ZDahiK4vGk+EgzMgzRfD/hhyYa+GZdqfFbGMgSQ1hSxyR0SBzSOf1mu5wkmyYhWklxw=
X-Received: by 2002:a5d:9c4e:: with SMTP id 14mr18829257iof.166.1580726890262;
 Mon, 03 Feb 2020 02:48:10 -0800 (PST)
MIME-Version: 1.0
References: <CAH8yC8m3JFvEcfFF3z1rrRnEPK-adHGObmkOhNZiph7QJKUWqA@mail.gmail.com>
 <CAH8yC8mh0gysNz3Dbrph0f8KZ8DEWaH-6rWg6fSOD-_aGh3=3A@mail.gmail.com> <20200203085405.GC2164@coredump.intra.peff.net>
In-Reply-To: <20200203085405.GC2164@coredump.intra.peff.net>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 3 Feb 2020 05:46:53 -0500
Message-ID: <CAH8yC8mmNXGw13zkrmxxJFQKEsmGqkKHFp13+U7==umHM2WR_Q@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IGdpdC1jb21wYXQtdXRpbC5oOjc5ODoxMzogZXJyb3I6IGNvbmZsaWN0aW5nIHR5cA==?=
        =?UTF-8?B?ZXMgZm9yIOKAmGluZXRfbnRvcOKAmQ==?=
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

...
> But having those variables unset is already the default. The root of the
> problem is likely that the autoconf test seems to get the wrong result
> on Solaris (another workaround would be to remove them from
> config.mak.autogen, but that will get obliterated next time you run
> ./configure).

Thanks Jeff.

Below is from configure.ac around line 720
(https://github.com/git/git/blob/master/configure.ac#L722).

I think the test program needs to include <arpa/inet.h>. Then, if the
current -lresolv test fails, configure should use the same program and
check -lsocket -lnls.

How would you like to craft the test? Or how should I craft the test?

# The next few tests will define NEEDS_RESOLV if linking with
# libresolv provides some of the functions we would normally get
# from libc.
NEEDS_RESOLV=
#
# Define NO_INET_NTOP if linking with -lresolv is not enough.
# Solaris 2.7 in particular hos inet_ntop in -lresolv.
NO_INET_NTOP=
AC_CHECK_FUNC([inet_ntop],
[],
[AC_CHECK_LIB([resolv], [inet_ntop],
[NEEDS_RESOLV=YesPlease],
[NO_INET_NTOP=YesPlease])
])
GIT_CONF_SUBST([NO_INET_NTOP])
