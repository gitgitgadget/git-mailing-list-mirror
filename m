Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABE591FADE
	for <e@80x24.org>; Mon, 11 Sep 2017 07:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbdIKHLt (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 03:11:49 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:38022 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdIKHLr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 03:11:47 -0400
Received: by mail-io0-f178.google.com with SMTP id n69so19156478ioi.5
        for <git@vger.kernel.org>; Mon, 11 Sep 2017 00:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ORfgPqgWTv2mTxVbxLDD8EMP2VZ3xLpBQCB0iD8ozeY=;
        b=ht7WeY8jQWr5hXTTWZHaPee0Tfb7WDKUV/rhWLO3UUDaZ33/bgRopPT9yVTK4gmhgn
         9owrI2NCTeAZaLXxkzM/7ekOaif7qdwyxHguSkc1D06GQnwtRbc16GQ79LnOR/cujImn
         mz4sJ6K9ByHE3UeaLCk5U8WL1zlC+JHwbUSiTmSRXCD1JdXEvh83qR2XojGsNtJKt3dz
         Oiz1kunLjHGqVgUHspT3QlSSxCF9rHgpy/Vd3zPZgW9s2dXmWCKWDi9tO6idRnOeot1b
         UB0UCa8lnwaBTNfVPeGrwnz8azIzNh6L5rBUTbWQpN8+v103+l8PWgiLGG9+t+OY4vdT
         kyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ORfgPqgWTv2mTxVbxLDD8EMP2VZ3xLpBQCB0iD8ozeY=;
        b=T2bYO6lgHecC+nFED0ZxDoc8ULOovjWyZ3mIWzpFjInDzq763/u9bQfi3PACVPnxR2
         j5IMmqlI6WeFWf8LWOTOuhhpv/XL+2uMnc1MEqONUhLNGjNwe0kPIJ39DE8eUpjCcZpR
         3XeOPlm6SEVjp6yya+PEnZLVQ2pnqbqZKLW9pmXutNwrytTt8oh6r2XbdmzplR8UZ1JR
         aAcuG0u1DaEDaGUp7RSmak7TR248opW3hlKVkoIM0roT/UHzHthdACFAhvbrubXzkvGe
         Vs4tHentFK54iM1ZmQCOXf+1gVWQdDY+ca9prYy63jK2OPkryrIfdkZ3lqk2My1/s0n+
         zJeQ==
X-Gm-Message-State: AHPjjUgknh0CU7rmDBd1ST4YR8IOCAaDfGtUZoNqTKK7kb0+e2uvfFMB
        2R+SVPO9seLSKZlM1qgVX4YRjGExDGOp
X-Google-Smtp-Source: AOwi7QBrlLb8j9QHv/mtIV0RYBkoe5iDuovU4QJKLj5qWZQ4e1hHDQobb9mUwi9wu4ez6vVd8eavHWudYjoOwv1RSAI=
X-Received: by 10.202.73.76 with SMTP id w73mr10688677oia.263.1505113906909;
 Mon, 11 Sep 2017 00:11:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.61.3 with HTTP; Mon, 11 Sep 2017 00:11:31 -0700 (PDT)
From:   Pavel Kretov <firegurafiku@gmail.com>
Date:   Mon, 11 Sep 2017 10:11:31 +0300
Message-ID: <CAOZF3=Ouvk8ccME+fXr_T=GL1j4Gx3Hgj3ao_-GQng-noeOubg@mail.gmail.com>
Subject: [idea] File history tracking hints
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Excuse me if the topic I'm going to raise here has been already discussed
on the mailing list, forums, or IRC, but I couldn't find anything related.


The problem:

Git, being "a stupid content tracker", doesn't try to keep an eye on
operations which happens to individual files; things like file renames
aren't recorded during commit, but heuristically detected later.

Unfortunately, the heuristic can only deal with simple file renames with
no substantial content changes; it's helpless when you:

 - rename file and change it's content significantly;
 - split single file into several files;
 - merge several files into another;
 - copy entire file from another commit, and do other things like these.

However, if we're able to preserve this information, it's possible
not only to do more accurate 'git blame', but also merge revisions with
fewer conflicts.


The proposal:

The idea is to let user give hints about what was changed during
the commit. For example, if user did a rename which wasn't automatically
detected, he would append something like the following to his commit
message:

    Tracking-hints: rename dev-vcs/git/git-1.0.ebuild ->
dev-vcs/git/git-2.0.ebuild

or (if full paths of affected files can be unambiguously omitted):

    Tracking-hints: rename git-1.0.ebuild -> git-2.0.ebuild

There may be other hint types:

    Tracking-hint: recreate LICENSE.txt
    Tracking-hint: split main.c -> main.c cmdline.c
    Tracking-hint: merge linalg.py <- vector.py matrix.py

or even something like this:

    Tracking-hint: copy json.py <-
libs/json.py@4db88291251151d8c5c8e4f20430fa4def2cb2ed

If file transformation cannot be described by a single tracking hint, it shall
be possible to specify a sequence of hints at once:

    Tracking-hint:
        split Utils.java -> AppHelpers.java StringHelpers.java
        recreate Utils.java

Note that in the above example the order of operations really matters, so
both lines have to reside in one 'Tracking-hint' block.

* * *

How do you think, is this idea worth implementing?
Any other thoughts on this?

-- Pavel Kretov.
