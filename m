Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDC42566
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 06:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF50119D
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 23:37:00 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-66d2f3bb312so16228236d6.0
        for <git@vger.kernel.org>; Fri, 03 Nov 2023 23:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699079820; x=1699684620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBOENJybTIEirilAwZ3paYVhKnPg/wQCqsrme1EncoQ=;
        b=KmPd+BjlV8FDRhFEeheyQrUtzGs0FX2E5rk5DYtJKEJzs5Itt2US4XbPHViUo9Q4qf
         xcz1ZYaW6QCaxyDT6Osr+xD6mQNtnI3n2brG7b3uCWFhesgdx/h1ihV9MsnN3CDAt8ob
         NcmMwDMhEtx9D5JQeuSgni4XZQyWp1arfTedtbO5asq36+G83jvQ4aw3r1kxV/s2upz+
         BNRfp8MdSGndGX9u8OOLbopjdUsXb169Q3tBM9V+9a3LS/0/NDbHGEh9bW3CIGfZRkfT
         h+zYZ47jmajJfrGFLVxX+Al6FduxM+qBtQWFgzZpl6QMvCG2BybH9+FxXZe+9S4Yiq5y
         aXzA==
X-Gm-Message-State: AOJu0Yxnn1dtj0BFfkjbm+e3shd3pNvFN4EQAJgYIH/8l0ja7yuEIcn6
	vwAflq7l4vfP++OOKMQHLpF8EzRtbQUPPpCzcBsaTbsP
X-Google-Smtp-Source: AGHT+IEQ3CXldOGBmupNOF4K4ji1i9kil+oqlTtppa3CLvnShK5aMUbnU3IQMOBFFqXsBwOykdFSDYn6faQxWQXECWU=
X-Received: by 2002:ad4:5f8e:0:b0:675:47ad:3be with SMTP id
 jp14-20020ad45f8e000000b0067547ad03bemr13507935qvb.45.1699079819875; Fri, 03
 Nov 2023 23:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00a101da0e88$778cd3b0$66a67b10$@nexbridge.com>
 <CAPig+cTzWCpmksJm-0M1MfUSeYpWbgMaFNHRSOtAhCsNQigV-g@mail.gmail.com>
 <00c301da0e9d$0d2cb8e0$27862aa0$@nexbridge.com> <CAPig+cRG3VWgnwOPWvbW9boUooa6sD9d667wbSUe4_RkcR60vg@mail.gmail.com>
 <00c401da0ea1$b61899c0$2249cd40$@nexbridge.com>
In-Reply-To: <00c401da0ea1$b61899c0$2249cd40$@nexbridge.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 4 Nov 2023 02:36:48 -0400
Message-ID: <CAPig+cQpxRQnhffR8EWWRhqJPmOeOuCE3qsuMcnDyuMLLbTH8Q@mail.gmail.com>
Subject: Re: Request for Help - Too many perl arguments as of 2.43.0-rc0
To: rsbecker@nexbridge.com
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 6:04=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> On November 3, 2023 5:51 PM, Eric Sunshine wrote:
> >On Fri, Nov 3, 2023 at 5:31=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> >> /usr/coreutils/bin/bash: /usr/bin/perl: Argument list too long
> >> Makefile:125: recipe for target 'test-lint-shell-syntax' failed
> >
> >This is a separate issue from chainlint (though, it too will likely suff=
er the same
> >problem). In this case, it's trying to run the check-non-portable-shell.=
pl script and
> >the command-line is too long.
> >Unfortunately, unlike chainlint for which there is a knob to disble it, =
there is no direct
> >knob to disable `test-lint-shell-syntax`. You may be able to skip all th=
e shell-script
> >linting by setting TEST_LINT to an empty value.
>
> That worked. I wonder whether it might be useful to set up a knob for thi=
s.

I don't see an urgent need for it. Unlike the actual tests themselves
run by `make test` which may catch platform-specific problems in Git
itself, the purpose of the "linting" checks is not to catch
platform-specific problems, but rather to help test authors by
identifying mistakes in the tests which might make them fragile. So,
disabling linting on a particular platform isn't going to cause `make
test` to miss some important Git problem specific to that platform.

Also, in the longer term, as you suggested, `xargs` is likely a more
fruitful solution.
