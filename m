Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145AA23776
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 21:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA96D6D
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 14:50:54 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-41cc7b67419so15083941cf.2
        for <git@vger.kernel.org>; Fri, 03 Nov 2023 14:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699048254; x=1699653054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pj9vMHJy63RTG2LHadOp9SXvf7A9D8PAeylDfbwDzs=;
        b=iCY4gN7njJDjRsULH+agDp88fIHyPZxb16/9viw21OMYUhac6udp4odrEukxrLKlW6
         x6ejfWIxuDXWqxXAKx5FdKjsHnFOwg7SY8FVAbolpzsePvkCashjyJUxGG9mUDiPcNEO
         eTyTqiJ0DaDyQi9+B9V4AJADa9zJrFIkK7K42QlW1yEMt2ncIhaMTlk6oONTs7c4cSep
         42LyM0yZqED+UudqqfeAaASSvqesFe7oKiUmfjjn1Jh8ycqSYboO246hWtsqBTQwGGT0
         45i63hYcFNY0vhLmP4jfqZdOp234xKh7vzy036vyJOJTcVixD3KT3vmAB5Hou1bu+w6D
         DGjA==
X-Gm-Message-State: AOJu0YwpdlYUr5Bgg/SUbgX2OxHhzjijSUFdInMcPzzcfl5GOZ8kMuKt
	q0sXsg5XM9CJnTCYqBqrWgJ8ejzWVuU8m308eWZKGK1obME=
X-Google-Smtp-Source: AGHT+IF3WG+No9wxKAm1t0v+ywtmstKtzJsIM/sQ2ly2sZtJTYgbri28l09T++zA/AtiKqgBk9k5dUfZDzGk/vvxhMA=
X-Received: by 2002:a05:6214:1d09:b0:649:8f20:5528 with SMTP id
 e9-20020a0562141d0900b006498f205528mr27985064qvd.60.1699048253825; Fri, 03
 Nov 2023 14:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00a101da0e88$778cd3b0$66a67b10$@nexbridge.com>
 <CAPig+cTzWCpmksJm-0M1MfUSeYpWbgMaFNHRSOtAhCsNQigV-g@mail.gmail.com> <00c301da0e9d$0d2cb8e0$27862aa0$@nexbridge.com>
In-Reply-To: <00c301da0e9d$0d2cb8e0$27862aa0$@nexbridge.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 3 Nov 2023 17:50:42 -0400
Message-ID: <CAPig+cRG3VWgnwOPWvbW9boUooa6sD9d667wbSUe4_RkcR60vg@mail.gmail.com>
Subject: Re: Request for Help - Too many perl arguments as of 2.43.0-rc0
To: rsbecker@nexbridge.com
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 5:31=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> On November 3, 2023 4:52 PM, Eric Sunshine wrote:
> >On Fri, Nov 3, 2023 at 3:03=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> >> I can no longer test git as the number of arguments (and size) sent to
> >> perl from the make infrastructure is too big for my platform. Is it
> >> possible to use xargs instead?
> >
> >Presumably you're talking about the invocation of chainlint.pl?
> >Considering that that's quite an unimportant part of `make test` for tho=
se just
> >running the test suite (as opposed to those authoring new tests), the si=
mplest
> >workaround is to disable chainlint when you run the tests by setting env=
ironment
> >variable GIT_TEST_EXT_CHAIN_LINT to 0.
>
> I tried both ways to specify this variable with no success:
>
> /usr/coreutils/bin/bash: /usr/bin/perl: Argument list too long
> Makefile:125: recipe for target 'test-lint-shell-syntax' failed

This is a separate issue from chainlint (though, it too will likely
suffer the same problem). In this case, it's trying to run the
check-non-portable-shell.pl script and the command-line is too long.
Unfortunately, unlike chainlint for which there is a knob to disble
it, there is no direct knob to disable `test-lint-shell-syntax`. You
may be able to skip all the shell-script linting by setting TEST_LINT
to an empty value.
