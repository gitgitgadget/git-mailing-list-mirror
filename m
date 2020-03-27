Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6460C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 16:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79960206E6
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 16:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj9S8FV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgC0QhX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:37:23 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:36582 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgC0QhX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 12:37:23 -0400
Received: by mail-io1-f53.google.com with SMTP id d15so10481037iog.3
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 09:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qsMcuEcXWwnpBMe2YkIZ37tYF7L6wJ8CWhns86+H2To=;
        b=jj9S8FV7NL7dfLo+QBCqwqpFZ1ir9I5t/InJtS/UB7LA2CCuKmScVIQ/SP5yT6ggFj
         79GpIrmMZ//Rxi87KeJzYpt9UzbRXRxwuO1JL8Moqyup8fwEPejYybusolBvuyouWnsJ
         6EiH/4cZOzPY0LpHjQsqyxyPj0Di9IKHOBuLTOEhSGxeK4HfYrLrdLgjQFaAAPk9AclB
         A6wWwgsiUAaBpfLMSMpGy+BUboFrzhlabqe7lXgrKVdLQr9mlvqE0L+ahiqdoifQKKar
         p+8aoIfAqW7lnAeFssT8DttJd2pPpJr+FdPFM7Shy+p3yyeoKH33MjTtCX3xmam94k6a
         t1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qsMcuEcXWwnpBMe2YkIZ37tYF7L6wJ8CWhns86+H2To=;
        b=dFR0NzNrW0hlQ0/nxqBeNJDXZEFDBTixa108k2jPBhmfU4nlX1kdRCItCia1JCkI+C
         nxTwmDh7qhoeC3KsDiempzN91/HSEhFWvXfLtkHVDjl9+6pTcDmsRrrjivUteT70kyTI
         ZpjPRFtGLGlIhW/6YfcXonP27vRiRw5XhycRhWL7uGohVGSPnVJKy22rFc55hhJgnlFc
         IzgY4AWQdMveFDI3C/231G4Wb81xEDPj15tiaSI3+AW3AIwoPUHr5qn8/TwCm/2AbA33
         KbzWdmbUAUVWGHVJ7oOMFCl63Yfd3LzBxVC2LRu3VMdS2lpFryVFcFuaaYZY8tC0r+aX
         MpZQ==
X-Gm-Message-State: ANhLgQ0mb8II+7ayg2DtCP1C40hfyMaywkfGrhYsPEJR+S0Lh84THjEX
        AJFI2+3x0Ycih3oZVX+e8aR2hsOGI753l9NPGGiuAdPA
X-Google-Smtp-Source: ADFU+vsymP7z4HJK9HQ9qhTT+WOfznb+jIkjSiqbUd4r6z3sJOGlRsz8Otb7KqaOPZf8kFh2p7rX8dzXjPIFBZqUZ3U=
X-Received: by 2002:a02:94cf:: with SMTP id x73mr505771jah.92.1585327041948;
 Fri, 27 Mar 2020 09:37:21 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?U3rFkXRzIMOBa29z?= <szotsaki@gmail.com>
Date:   Fri, 27 Mar 2020 17:36:56 +0100
Message-ID: <CAAr69zbzX=ihOQLZRELWHaC42vs=XtNGkuJ+WhzeWaokPNcfAA@mail.gmail.com>
Subject: git svn 2.26.0 segfault on fetch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear list,

When I use a "git svn fetch" on my git-SVN repository it dies with
"error: git-svn died of signal 11".

I tried to get a coredump or attach GDB to it but as I see in strace
there are signal handlers attached to INT, HUP, TERM, QUIT, and PIPE
and possibly because of them no coredumps are generated even with
unlimited "-c" and also possibly because of this GDB doesn't stop on
SIGSEGV.

What I could do still with turned off ASLR is to run Valgrind with
children tracking. It gave the following results:

Warning: invalid file descriptor -1 in syscall close()
Invalid read of size 4
   at 0x9B1A82C: UnknownInlinedFun (atomic_base.h:419)
   by 0x9B1A82C: UnknownInlinedFun (qatomic_cxx11.h:239)
   by 0x9B1A82C: UnknownInlinedFun (qbasicatomic.h:107)
   by 0x9B1A82C: UnknownInlinedFun (qrefcount.h:66)
   by 0x9B1A82C: UnknownInlinedFun (qstring.h:1263)
   by 0x9B1A82C: UnknownInlinedFun (kaboutdata.cpp:460)
   by 0x9B1A82C: KAboutData::~KAboutData() (kaboutdata.cpp:583)
   by 0x9B1AADC: (anonymous
namespace)::Q_QGS_s_registry::innerFunction()::Holder::~Holder()
(kaboutdata.cpp:1041)
   by 0x4A63706: __run_exit_handlers (exit.c:108)
   by 0x4A638BB: exit (exit.c:139)
   by 0x154465: main (perlmain.c:171)
 Address 0x80cf1c0 is not stack'd, malloc'd or (recently) free'd


Process terminating with default action of signal 11 (SIGSEGV): dumping cor=
e
 Access not within mapped region at address 0x80CF1C0
   at 0x9B1A82C: UnknownInlinedFun (atomic_base.h:419)
   by 0x9B1A82C: UnknownInlinedFun (qatomic_cxx11.h:239)
   by 0x9B1A82C: UnknownInlinedFun (qbasicatomic.h:107)
   by 0x9B1A82C: UnknownInlinedFun (qrefcount.h:66)
   by 0x9B1A82C: UnknownInlinedFun (qstring.h:1263)
   by 0x9B1A82C: UnknownInlinedFun (kaboutdata.cpp:460)
   by 0x9B1A82C: KAboutData::~KAboutData() (kaboutdata.cpp:583)
   by 0x9B1AADC: (anonymous
namespace)::Q_QGS_s_registry::innerFunction()::Holder::~Holder()
(kaboutdata.cpp:1041)
   by 0x4A63706: __run_exit_handlers (exit.c:108)
   by 0x4A638BB: exit (exit.c:139)
   by 0x154465: main (perlmain.c:171)
 If you believe this happened as a result of a stack
 overflow in your program's main thread (unlikely but
 possible), you can try to increase the size of the
 main thread stack using the --main-stacksize=3D flag.
 The main thread stack size used in this run was 8388608.

During stracing I found this line around the SIGSEGV:
close(-1)                   =3D -1 EBADF

If you could tell me how it's possible to attach GDB onto it, I'd be
glad to provide you some backtraces as well.

Version: 2.26.0.

All the best,

=C3=81kos
