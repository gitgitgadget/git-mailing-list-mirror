Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91075C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 05:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDRFau (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 01:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjDRFas (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 01:30:48 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCB15BA6
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 22:30:21 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-38bed577755so87861b6e.0
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 22:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681795820; x=1684387820;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkgRQe9pOF9CnJzzIFaL+/0Hk4tLZp6Nj0ToiMhWb7A=;
        b=Oo6MCZhJIOQa47ooppLxkTVkG/MyfCNZS0f33LKwsT1MgvCELNRJ0cBfgWXzXpjDOL
         mmwp6QzAIeA/M1XEHLVhbutt3CuEbTxK8q+C11ukeocQRN2NFERO0jhLPdMqBOX5G4KF
         S8iW6T/+WYUOItjisqfib17l8o+qCIAR55z7yBZ9FwwGM5xHePtxNf3Xf9GAtqczMTGp
         8hTQROPOe6fuJYHUj4OAUp63NwA6Z4O1O3tuZ5moBZFjAzz1g8iCwOZ2F3Dpp/iOTK81
         ppw5vkQBk0PXPH4TdwcwWyQUNxIP6F7KznpnWA/5PEGlvosG9isUPDL650SP1sOUUtyv
         XjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681795820; x=1684387820;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TkgRQe9pOF9CnJzzIFaL+/0Hk4tLZp6Nj0ToiMhWb7A=;
        b=U7EpB7ImgMAveZObwTJYYa4R/mlv6YZgXBLoR30fapVcvS4MdD3VpBCQe3sZRbE3OM
         9Kxx2+34BqOmg6g4+M3Q2fjYpiZLTJSLNHPysavgcvkrpEo7i6pMzeDlc0Aw1B+O6LQL
         5LqexzbxauUBXZnEvzo82zmuefiXK52pmizxz+xx+gyN7MokP+A/pjtgaKNnckyxxtcH
         SiSoIJc6htE48pgp7TTH5XeCGH135lyFzLZl/b6+fOdKdzNkboh7oTTN+Roto/imbOJ3
         Ql6ybyAbNqfl2nvEP0I+CuLQ83JiPd+EVxb1rrXCKrN043HdF2NN5lUdyH9y+aRjTb8g
         cY9Q==
X-Gm-Message-State: AAQBX9doTFeVBHaQxr0OBSqs7eknqs/2ICylb7kt6ftg4FXubvtL67HV
        ohUBoV6IU7iRKPPOp2O05+g=
X-Google-Smtp-Source: AKy350bSxn46nG8frpScbu4RM3bGUdarSAd7eBxi79vxpy2pm70154YIWhAse+S6PrPMitxVhh3AGQ==
X-Received: by 2002:a05:6808:8c:b0:37f:a346:bfad with SMTP id s12-20020a056808008c00b0037fa346bfadmr391382oic.47.1681795820242;
        Mon, 17 Apr 2023 22:30:20 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id p9-20020acabf09000000b00383cc29d6b2sm5452222oif.51.2023.04.17.22.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 22:30:19 -0700 (PDT)
Date:   Mon, 17 Apr 2023 23:30:18 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>
Message-ID: <643e2aeae0515_217cdb29473@chronos.notmuch>
In-Reply-To: <20230418040034.GC60552@coredump.intra.peff.net>
References: <20230418011828.47851-1-felipe.contreras@gmail.com>
 <20230418040034.GC60552@coredump.intra.peff.net>
Subject: Re: [PATCH] doc: remove custom callouts format
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Apr 17, 2023 at 07:18:28PM -0600, Felipe Contreras wrote:
> 
> > What's worse: the format of the upstream callouts is much nicer than our
> > hacked version.
> > 
> > Compare this:
> > 
> >      $ git diff            (1)
> >      $ git diff --cached   (2)
> >      $ git diff HEAD       (3)
> > 
> >   1. Changes in the working tree not yet staged for the next
> >      commit.
> >   2. Changes between the index and your last commit; what you
> >      would be committing if you run git commit without -a
> >      option.
> >   3. Changes in the working tree since your last commit; what
> >      you would be committing if you run git commit -a
> > 
> > To this:
> > 
> >      $ git diff            (1)
> >      $ git diff --cached   (2)
> >      $ git diff HEAD       (3)
> > 
> >  1. Changes in the working tree not yet staged for the next commit.
> >  2. Changes between the index and your last commit; what you would
> >  be committing if you run git commit without -a option.
> >  3. Changes in the working tree since your last commit; what you
> >  would be committing if you run git commit -a
> 
> You don't say which is which, so I'm hoping that the top one is the new
> output. :) And running doc-diff shows that it is. Good.
> 
> It does look like at least one spot is made worse, though. In
> git-checkout, we have now:
> 
>           1. The following sequence checks out the master branch,
>              reverts the Makefile to two revisions back, deletes hello.c
>              by mistake, and gets it back from the index.
>   
>                  $ git checkout master             (1)
>                  $ git checkout master~2 Makefile  (2)
>                  $ rm -f hello.c
>                  $ git checkout hello.c            (3)
>   
>              1. switch branch
>              2. take a file out of another commit
>              3. restore hello.c from the index
>   
>              If you want to check out all C source files out of the
>              index, you can say
>   
>                  $ git checkout -- '*.c'
>   
>              Note the quotes around *.c. The file hello.c will also be
>              checked out, even though it is no longer in the working
>              tree, because the file globbing is used to match entries in
>              the index (not in the working tree by the shell).
> 
> which is achieved through plus-continuation of each paragraph, to make
> it all part of the block under item "1." in the numbered list.
> 
> But after your patch, it's:
> 
>           1. The following sequence checks out the master branch,
>              reverts the Makefile to two revisions back, deletes hello.c
>              by mistake, and gets it back from the index.
>   
>                  $ git checkout master             (1)
>                  $ git checkout master~2 Makefile  (2)
>                  $ rm -f hello.c
>                  $ git checkout hello.c            (3)
>   
>               1. switch branch
>               2. take a file out of another commit
>               3. restore hello.c from the index
>   
>                  If you want to check out all C source files out of
>                  the index, you can say
>   
>                                 $ git checkout -- '*.c'
>   
>                             Note the quotes around *.c. The file
>                             hello.c will also be checked out, even
>                             though it is no longer in the working
>                             tree, because the file globbing is used
>                             to match entries in the index (not in the
>                             working tree by the shell).

That's because git's usage of asciidoc leaves much to be desired.

The `+` character is used as a list continuation, how is the doc parser
supposed to know that we want to continue the 1. list item, or the 3. callout?

That's why instead of:

  1. foo
  +
  bar
  +
  roo

It's better (and easier) to use an open block.

  1. foo
  +
  --
  bar

  roo
  --

This is what the documentation of asciidoctor recommends, and it even has an
example to attack a block to a grandparent list item.

If we do this then the parser has no trouble understanding what we are trying
to do:

  --- a/Documentation/git-checkout.txt
  +++ b/Documentation/git-checkout.txt
  @@ -523,36 +523,37 @@ EXAMPLES
     the `Makefile` to two revisions back, deletes `hello.c` by
     mistake, and gets it back from the index.
   +
  +--
   ------------
   $ git checkout master             <1>
   $ git checkout master~2 Makefile  <2>
   $ rm -f hello.c
   $ git checkout hello.c            <3>
   ------------
  -+
   <1> switch branch
   <2> take a file out of another commit
   <3> restore `hello.c` from the index
  -+
  +
   If you want to check out _all_ C source files out of the index,
   you can say
  -+
  +
   ------------
   $ git checkout -- '*.c'
   ------------
  -+
  +
   Note the quotes around `*.c`.  The file `hello.c` will also be
   checked out, even though it is no longer in the working tree,
   because the file globbing is used to match entries in the index
   (not in the working tree by the shell).
  -+
  +
   If you have an unfortunate branch that is named `hello.c`, this
   step would be confused as an instruction to switch to that branch.
   You should instead write:
  -+
  +
   ------------
   $ git checkout -- hello.c
   ------------
  +--
   
   . After working in the wrong branch, switching to the correct
     branch would be done using:


> This is perhaps a bug in asciidoc itself.

In my opinion it's a bug in our usage of asciidoc. It happened to look OK by
accident.

> Building with USE_ASCIIDOCTOR is mostly good, though it seems to drop the
> newline between the callout list and the next paragraph, which our custom one
> has:

That's a DocBook Stylesheets problem, if you apply the patch above to use an
open block, then you get the same output with both asciidoc and asciidoctor.

I don't see why we insist on creating such complex list items though.

Creating a subsection is much clearer for everyone: the reader, the writer, and
the parser:

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 6bb32ab460..2d16651d1f 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -519,84 +519,89 @@ to checkout these paths out of the index.
 EXAMPLES
 --------
 
-. The following sequence checks out the `master` branch, reverts
-  the `Makefile` to two revisions back, deletes `hello.c` by
-  mistake, and gets it back from the index.
-+
+=== 1
+
+The following sequence checks out the `master` branch, reverts
+the `Makefile` to two revisions back, deletes `hello.c` by
+mistake, and gets it back from the index.
+
 ------------
 $ git checkout master             <1>
 $ git checkout master~2 Makefile  <2>
 $ rm -f hello.c
 $ git checkout hello.c            <3>
 ------------
-+
 <1> switch branch
 <2> take a file out of another commit
 <3> restore `hello.c` from the index
-+
+
 If you want to check out _all_ C source files out of the index,
 you can say
-+
+
 ------------
 $ git checkout -- '*.c'
 ------------
-+
+
 Note the quotes around `*.c`.  The file `hello.c` will also be
 checked out, even though it is no longer in the working tree,
 because the file globbing is used to match entries in the index
 (not in the working tree by the shell).
-+
+
 If you have an unfortunate branch that is named `hello.c`, this
 step would be confused as an instruction to switch to that branch.
 You should instead write:
-+
+
 ------------
 $ git checkout -- hello.c
 ------------
 
> It's probably still worth moving forward with your patch, as I think it
> takes us in the direction we want long-term (and which builds with
> asciidoctor are already using). But we may want to pair it with a patch
> to work around the issue with git-checkout.1 using asciidoc to avoid
> regressing that section. It may require re-wording or re-organizing to
> work around the bug.

I can add that patch depending what we want:

Open block:

  1. foo
  +
  --
  bar

  roo
  --

Or subsection:

  === 1

  foo

  bar

  roo

Cheers.

-- 
Felipe Contreras
