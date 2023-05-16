Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88C3C77B7F
	for <git@archiver.kernel.org>; Tue, 16 May 2023 21:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjEPVeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 17:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjEPVeE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 17:34:04 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C889EF4
        for <git@vger.kernel.org>; Tue, 16 May 2023 14:33:46 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b9daef8681fso12749525276.1
        for <git@vger.kernel.org>; Tue, 16 May 2023 14:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684272825; x=1686864825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=twj0fz32cWvcGv199Hpjb8ee42tECpERiSvyjgXoP8Q=;
        b=hob5h6d5+pjqUeKMFXDdqOm27zq7ED0bia8CSgiZOBivTBH4k2MVARtmfdBCEZ3Jq8
         1P6MYQU2i7gO0gJjl1oq4mMIzzjzhbILEbqxstgjWVi64Mwd9e9U/Wq3YcKAtmaDBsD0
         loq76dn2l9iiVhXaf8wNavK9X1GlNJ72XTX0+VNbK0dbH2cPLtaf9HIbF1QTvt7niteX
         SPLzqCYyn0I8XLa87kRp03Lt0Q8yQ6BscQeokhnoGqb4QdfCnrZvM7+2jF19qphq7htM
         PotgjXnMoipe8Y3ktErrAMs+agtZ9Rs/ukDapy88+qX9QZLH6UNpTdwingjNJWxS2RQ5
         O8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684272825; x=1686864825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=twj0fz32cWvcGv199Hpjb8ee42tECpERiSvyjgXoP8Q=;
        b=CIj7KIw3n+rr/q2vI70iFrTnQRyAx9Rwcfv3XHv5kbP5OebF9EqUfEhBi6dwoC8f0F
         wdhmHr/sbWvi55oLaZRUONGLCn/zx0QCsjZIk5tOlYVY/Ekxtgt0HhO6rpVXvIiMAnTR
         +EnOLqGUyCd8cDIlE9Qr0cff+q+RnCFnuAUapD1Yr6ub1BkyL0cp/DvlHTvcFaN1sT4U
         N3iGxNwb6kMNgYTIFLDHl97dSUS7URgJJdJrJV0jfRTP/p2jFdavRvXF8DvDM+V1t7mq
         x+xkhavbcZSqu5fVcmvArHv5Z0G9SMU7ObQcDrwG8GvWyHwkzUqbgU6TPFIC78nctbqe
         EU3Q==
X-Gm-Message-State: AC+VfDw6fBRc+HZjuoTI4xZBZoY4GM3LuctSiEiO3X1xoF+7OWsz2oPs
        XLK9i4sMMPraul23OSXL6arm8rgfo7uTiNbQW6Z1BQ==
X-Google-Smtp-Source: ACHHUZ7iqZdGHzX2KW8awCF40J7GfE5oqVTmrrcYooNQTOG0hGYJuzrEkAp5MLCSE/uoYIDXeCpjxw==
X-Received: by 2002:a25:ce85:0:b0:ba7:4334:1849 with SMTP id x127-20020a25ce85000000b00ba743341849mr12011976ybe.25.1684272825036;
        Tue, 16 May 2023 14:33:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t7-20020a81c247000000b00545b02d4af5sm171483ywg.48.2023.05.16.14.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 14:33:44 -0700 (PDT)
Date:   Tue, 16 May 2023 17:33:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "Randall S. Becker" <randall.becker@nexbridge.ca>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] run-command.c: fix missing include under `NO_PTHREADS`
Message-ID: <ZGP2tw0USsj9oecZ@nand.local>
References: <ZGO4LesPe4A2ftdm@nand.local>
 <db403de74da839084165f11dab05d71484457c6f.1684259780.git.me@ttaylorr.com>
 <xmqqh6sct7jx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqh6sct7jx.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2023 at 12:12:02PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > When building git with `NO_PTHREADS=YesPlease`, we fail to build
> > run-command.o since we don't have a definition for ALLOC_GROW:
> >
> >     $ make NO_PTHREADS=1 DEVELOPER=1 run-command.o
> >     GIT_VERSION = 2.41.0.rc0.1.g787eb3beae.dirty
> >         CC run-command.o
> >     run-command.c: In function ‘git_atexit’:
> >     run-command.c:1103:9: error: implicit declaration of function ‘ALLOC_GROW’ [-Werror=implicit-function-declaration]
> >      1103 |         ALLOC_GROW(git_atexit_hdlrs.handlers, git_atexit_hdlrs.nr + 1, git_atexit_hdlrs.alloc);
> >           |         ^~~~~~~~~~
> >     cc1: all warnings being treated as errors
> >     make: *** [Makefile:2715: run-command.o] Error 1
>
> I am OK to give a reproduction recipe, i.e. the "$ make" command
> line, to make it easy for people, who cannot remember how to define
> make variables from the command line, to try out themselves, but I
> hate the "build transcript" in the log message, when a few lines of
> prose suffices.

Much appreciated. Here's a version with your changes include that is
suitable for queueing:

--- 8< ---

Subject: [PATCH] run-command.c: fix missing include under `NO_PTHREADS`

Git 2.41-rc0 fails to compile run-command.c with `NO_PTHREADS` defined,
i.e.

  $ make NO_PTHREADS=1 run-command.o

as `ALLOC_GROW()` macro is used in the `atexit()` emulation but the
macro definition is not available.

This bisects to 36bf195890 (alloc.h: move ALLOC_GROW() functions from
cache.h, 2023-02-24), which replaced includes of <cache.h> with
<alloc.h>, which is the new home of `ALLOC_GROW()` (and
`ALLOC_GROW_BY()`).

We can see that run-command.c is the only one that try to use these
macros without including <alloc.h>.

  $ git grep -l -e '[^_]ALLOC_GROW(' -e 'ALLOC_GROW_BY(' \*.c | sort >/tmp/1
  $ git grep -l 'alloc\.h' \*.c | sort >/tmp/2
  $ comm -23 /tmp/[12]
  compat/simple-ipc/ipc-unix-socket.c
  run-command.c

The "compat/" file only talks about the macro in the comment,
and is not broken.

We could fix this by conditionally including "alloc.h" when
`NO_PTHREADS` is defined.  But we have relatively few examples of
conditional includes throughout the tree[^1].

Instead, include "alloc.h" unconditionally in run-command.c to allow it
to successfully compile even when NO_PTHREADS is defined.

[^1]: With `git grep -E -A1 '#if(n)?def' -- **/*.c | grep '#include' -B1`.

Reported-by: Randall S. Becker <randall.becker@nexbridge.ca>
Co-authored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 run-command.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/run-command.c b/run-command.c
index d4247d5fcc..60c9419866 100644
--- a/run-command.c
+++ b/run-command.c
@@ -16,6 +16,7 @@
 #include "packfile.h"
 #include "hook.h"
 #include "compat/nonblock.h"
+#include "alloc.h"

 void child_process_init(struct child_process *child)
 {
--
2.41.0.rc0.dirty

