Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 358C1207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 22:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbcIZWON (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 18:14:13 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:35595 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753022AbcIZWOM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 18:14:12 -0400
Received: by mail-oi0-f48.google.com with SMTP id w11so224254047oia.2
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 15:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=/PyUVj3JkJ4MC92z4WRHyDh6sedzHgHjDK4aqLq8F3k=;
        b=Y0fbELZEIeuIxbkqB6mb6Ip8tS5fGoj5P2sOKaHeXF4xo1D5a9QVit/6LjCmmec19T
         U0HSM5hyZIme+nkzUuq/s8h5zsWtXmdTCsZbvKGLQhHIKVtddDDbfj+KhUpyLqLq9mHx
         mXsbCI6FlGnK6B6sh7c69M6JeZ5oWU8doqI6emyc/JwfqWjEK14XxQHCSH1gzHzlVmxX
         e89bK+wa1co+5E1KT1by/96QmJzaz/lkjQWDIeJVAee1UHX59ZLyq8FvfL6ojccJvELI
         Qe0T+Z4kPIgzYj3Xbn4z2opW26Tsm6XxAuIYs7VjoHj2QZGbWUPzCUQk8aoIPeiCfUDY
         Amwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/PyUVj3JkJ4MC92z4WRHyDh6sedzHgHjDK4aqLq8F3k=;
        b=m7lHKoYSAz7SJIpbYbkzWo2t3in9sKS1yZfmmLoRf4aortetLe3ktXWTlsvNq99vuh
         VXGdpOiS7zn0hmj8efl875ovSXLp9phPVhA/BNRf9kc6Jw2eXu8D0C98DqVMoXaMYYgY
         cLdQNFl4SQ4JOlwL7GakWi75atYdjE2tviAVRdUd7928myYHpDdrx+cqES/I9bWAnHs8
         MRQ7pINrNtI/TfWUJEnuue8G+7JnWJaXWRfrigHrPZRdBnsTtJ0W4wPNEndDvXB/9+Pk
         D4FVC4u8jNA6TpaY0uqG112ghaPrR+nuqpwfn30TuBLSwzi8WiMpXUCUPk1CJd4tuFiw
         TZ0A==
X-Gm-Message-State: AE9vXwNEFRtzFPFWS93uCgNmuCjGgrts5TQXpjCgh4yB8r4RLBELQzUxl1W/anNlgDp5xSuPYSwzM4xFI20awA==
X-Received: by 10.202.240.11 with SMTP id o11mr29969922oih.23.1474928051300;
 Mon, 26 Sep 2016 15:14:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.66.14 with HTTP; Mon, 26 Sep 2016 15:13:50 -0700 (PDT)
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 27 Sep 2016 00:13:50 +0200
Message-ID: <CACBZZX5wdnA-96e11edE7xRnAHo19RFTrZmqFQj-0ogLOJTncQ@mail.gmail.com>
Subject: A couple of bugs / things TODO I encountered
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have these on my TODO list to look at at some point, but who knows
when, meanwhile I thought I'd send them to the list if anyone's
interested or wants to comment on them.

= Inconsistent regexp usage:

If you supply --perl-regexp to git-log it only applies to --grep. The
documentation says "Consider the limiting patterns to be
Perl-compatible regular expressions". Which might lead you to think
that e.g. -G uses it too. It doesn't, only grep.c does PCRE, but -G is
handled by diffcore-pickaxe.c.

Looking at "git grep -l regexec -- '*.c'" this whole thing is a mess.
Ideally you should be able to say you want to use PCRE for everything,
except maybe things that end up in your .gitconfig or e.g. the diff
driver. But we could really use a more generic regexp interface.

In general Git's regexp use is a huge mess, e.g. there's
--regexp-ignore-case but no way to supply various other regexp options
like REG_NEWLINE or PCRE options consistently.

= "git describe" really needs some overhaul

$ git describe  6ebdac1
v2.10.0
$ git describe  --contains 6ebdac1
v2.10.0^0

As far as I can tell for the former there's no options that'll give me
v2.10.0-g6ebdac1, or v2.10.0-g6ebdac1 for the latter.

The reason I want that is that I like using "git describe" to give me
approximately when a commit happened in a repo, but the tags may get
deleted. In that case the *g<commit> syntax makes sure we can still
look up the commit, but omitting the commit if it exactly corresponds
to a tag, or the entire otherwise useful --contains option breaks
that.
