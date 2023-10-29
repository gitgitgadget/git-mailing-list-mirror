Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C1938B
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 01:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42261CE
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 18:34:12 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5842a7fdc61so1915317eaf.3
        for <git@vger.kernel.org>; Sat, 28 Oct 2023 18:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698543250; x=1699148050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rx0C04yZsmAkLX+1/ZPT39gm8AnYwowHn5yK4MvP6gU=;
        b=KJ1/IIFfC1uPbi1VgBp91AHGQj2iYbZCUuSjUT1XKOG/hlaECwqaswVOhFgutYXQTw
         Tdqgewc2qeSiEjGpBuMctHSUYp+uBxzSNM5mZ0sS5kOn4Y/y7CnlUFf5XK70Gx/uTLKx
         B8702eV6Y049xN9ZYPAQkX2Z3MMi22XU7INQgLnFkvfi57Zu1M/VxN7d1tKndT/a2HcV
         BXsTNazoPGJXX+sOmltxDnsSnZBROBw804UEJvT7xEa8QzL02Il+JBt8OwmYfrrVZY6R
         wgOmAdHJvfg5o3SileMq/VLpluWKjsQx/MhmFsqdMjulFtpAz62CTYmjshRvlQBMOXCF
         Yysw==
X-Gm-Message-State: AOJu0Yxyl5uxab4GRDAO/l7dlebflN/ykcHi4L+WNhBU6yALAa5cEW5B
	kGdfqkEqBgSIk5dXPwLWlggz8Mqnc4Sx5DqKSVI=
X-Google-Smtp-Source: AGHT+IEz5l06PKnnBju9t32nM3Sf3NjN31mtfmhhIwx8EcG6KDOaECyTCTxCG9HN5zYdCWrlZr+ZGkPLNzgrAXk4KHY=
X-Received: by 2002:a05:6358:7e47:b0:168:eb8a:7da with SMTP id
 p7-20020a0563587e4700b00168eb8a07damr8206894rwm.23.1698543250193; Sat, 28 Oct
 2023 18:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PSBPR01MB3544370EEA032FA47778135DBDA3A@PSBPR01MB3544.apcprd01.prod.exchangelabs.com>
In-Reply-To: <PSBPR01MB3544370EEA032FA47778135DBDA3A@PSBPR01MB3544.apcprd01.prod.exchangelabs.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 28 Oct 2023 21:33:58 -0400
Message-ID: <CAPig+cScxS=NYBpeoyWe8JQA6HBO+PNCKJpzL=57-9mu3Dxwbg@mail.gmail.com>
Subject: Re: [Bugs] Hello,I can't build git by ./configure
To: h hm <haoming9245@outlook.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 28, 2023 at 11:39=E2=80=AFAM h hm <haoming9245@outlook.com> wro=
te:
> I want to build commit 2e8e77c in the master

This is a merge commit bringing together multiple topics, so it's
difficult to say which topic may have caused a regression. Perhaps try
git-bisect to narrow the problem down to a single commit.

> configure: Setting lib to 'lib' (the default)
> configure: Will try -pthread then -lpthread to enable POSIX Threads.
> configure: CHECKS for site configuration
> checking for gcc... gcc
> checking whether the C compiler works... no
> configure: error: in `/home/haomi/git':
> configure: error: C compiler cannot create executables

Your config.log shows that it is trying to test-compile this tiny program:

    /* confdefs.h */
    #define PACKAGE_NAME "git"
    #define PACKAGE_TARNAME "git"
    #define PACKAGE_VERSION "2.42.GIT"
    #define PACKAGE_STRING "git 2.42.GIT"
    #define PACKAGE_BUGREPORT "git@vger.kernel.org"
    #define PACKAGE_URL ""
    /* end confdefs.h.  */
    int
    main (void)
    {
      ;
      return 0;
    }

with the simplest command `gcc conftest.c`, but it's failing. Perhaps
try compiling that program manually in your `/home/haomi/git'
directory and see what the result is (also check $?).
