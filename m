Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D3FC433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3735610A8
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhETIUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 04:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhETIUg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 04:20:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D7DC061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:19:14 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id h3-20020a05600c3503b0290176f13c7715so4649953wmq.5
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pk5EuVFTEGbEnhVGewvxnJv4NNEVUP75M5SjrAa9Rqc=;
        b=EagDg2I6tQSOGhjVAQQtNxUSTttdpOTk2FUUd5mpPlQWXxZ1JikZfYLsdOyZT3d6Wt
         ZevLqgceXe3F+gs5Pp7uoh4ckwHh/tqJj2v1iJd1OCe7TxuktYdlE6vrXYm4D+tRYZzQ
         XPihSLqg+PnREdINy0S85EtjUTxc0QPF3JdJ18a0v9HrLRLN1Qlkv3CIQLY7EZvyCOVe
         RbG93PHkeiYw2aRk5CF5Qp66vIou1+x0/hHswOYX+vSMUl4aUHKw5MGdwhGt65QLD0MI
         pKWcbH3z3a1sH5RqnBclWcIBk5PkAdmRE3vYqdCTGonu3whDnEDh6Bh69aD61Fj/NK35
         V4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pk5EuVFTEGbEnhVGewvxnJv4NNEVUP75M5SjrAa9Rqc=;
        b=t228i+mJ0N2pNZp7ETO3zt6OfnEKFJ7BF/HJ1asdiolzzjiYthWFrKVZVr/YjoWNjN
         MedQp0pfrBWMueoPBavguGMMSrKKBbOadiakDZTMtoYK4t7Nvcr2IQLFYXJz7O0JUgRP
         BarAgIRpgM//rbmElzqdbmSWuD5LeNIrJZGYXZNA+IJUL3u8fn41XE9bCW63koD28tp8
         0RKKhXNDQXx+pYJHdllEKSky+Un0V4pM0JcpH3tjBuGqhmoteZ1x94cptYZ3z+zam2rI
         kHo9Dw+VINgzUfYfsorib/v0rlnoOKEKDm0CY+87CDO811Voges+EqQcQgj7sfOPCE2q
         U2pQ==
X-Gm-Message-State: AOAM533CroxKDmSgkNY9vomn3KT4lRF3uOxwt5/BXxtx5RrgRp5HgUUM
        95TtIlkkGggVYmzt6CabWuS8TZuz99sVfw==
X-Google-Smtp-Source: ABdhPJx39oQxGVMVY5XxL4RarlQ9gtSuZduYOeGY05nQmAmBQfmMoufKzkt4/IbVvpP8sFBSFhLagA==
X-Received: by 2002:a1c:1f90:: with SMTP id f138mr2770250wmf.123.1621498752957;
        Thu, 20 May 2021 01:19:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y20sm8900004wmi.0.2021.05.20.01.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 01:19:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/10] send-email: various optimizations to speed up by >2x
Date:   Thu, 20 May 2021 10:18:57 +0200
Message-Id: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.405.g5d387561bb3
In-Reply-To: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of [1], the work I based v1 on top of has landed in master,
so this has been rebased on master.

The changes here are minor, just a typo fix / commit message
clarification, moving "require" closer to where it's used, and finally
a new 10/10 patch to s/cwd/getcwd/g.

As noted in the commit message I don't think that'll make any
difference in practice. The "time" Eric posted was for loading Cwd.pm
and then doing cwd() or getcwd(), but when we run it we've already
paid the cost of loading Cwd.pm. But it was an easy change to make, so
let's make it anyway.

1. https://lore.kernel.org/git/cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (10):
  send-email: remove non-working support for "sendemail.smtpssl"
  send-email: refactor sendemail.smtpencryption config parsing
  send-email: lazily load config for a big speedup
  send-email: lazily shell out to "git var"
  send-email: use function syntax instead of barewords
  send-email: get rid of indirect object syntax
  send-email: lazily load modules for a big speedup
  perl: lazily load some common Git.pm setup code
  send-email: move trivial config handling to Perl
  perl: nano-optimize by replacing Cwd::cwd() with Cwd::getcwd()

 Documentation/config/sendemail.txt |   3 -
 git-send-email.perl                | 146 +++++++++++++++++------------
 perl/Git.pm                        |  49 +++++-----
 3 files changed, 111 insertions(+), 87 deletions(-)

Range-diff against v1:
 1:  92571a8cf7f <  -:  ----------- Makefile: make PERL_DEFINES recursively expanded
 2:  85b706d43fc !  1:  8474acae689 send-email: remove non-working support for "sendemail.smtpssl"
    @@ Metadata
      ## Commit message ##
         send-email: remove non-working support for "sendemail.smtpssl"
     
    -    Remove the already dead code to support "sendemail.smtssl" by finally
    +    Remove the already dead code to support "sendemail.smtpssl" by finally
         removing the dead code supporting the configuration option.
     
         In f6bebd121ac (git-send-email: add support for TLS via
 3:  c22af817f10 =  2:  b87f53adbed send-email: refactor sendemail.smtpencryption config parsing
 4:  1e14d322535 =  3:  1b27a393ae3 send-email: lazily load config for a big speedup
 5:  e1df469d5fe =  4:  acee22b77d2 send-email: lazily shell out to "git var"
 6:  8846d40fc02 =  5:  f317cd1c01e send-email: use function syntax instead of barewords
 7:  0dde0e14ef6 =  6:  fc27024f838 send-email: get rid of indirect object syntax
 8:  55a0b07062f !  7:  f86f5453d7a send-email: lazily load modules for a big speedup
    @@ git-send-email.perl: sub do_edit {
      
      # Handle Uncouth Termination
      sub signal_handler {
    -+	require Term::ANSIColor;
    - 
    +-
      	# Make text normal
     -	print color("reset"), "\n";
    ++	require Term::ANSIColor;
     +	print Term::ANSIColor::color("reset"), "\n";
      
      	# SMTP password masked
 9:  2312346f71e =  8:  86641377c0d perl: lazily load some common Git.pm setup code
10:  0d87c9a5a37 !  9:  895c9e29a96 send-email: move trivial config handling to Perl
    @@ Commit message
     
         Optimize the startup time of git-send-email by using an amended
         config_regexp() function to retrieve the list of config keys and
    -    values we're interested in.
    +    values we're interested in. See the earlier "send-email: lazily load
    +    config for a big speedup" commit for why changing its interface is OK.
     
         For boolean keys we can handle the [true|false] case ourselves, and
         the "--get" case didn't need any parsing. Let's leave "--path" and
    @@ Commit message
         "git send-email".
     
         This brings the runtime of "git send-email" from ~60-~70ms to a very
    -    steady ~40ms on my test box. We no run just one "git config"
    +    steady ~40ms on my test box. We now run just one "git config"
         invocation on startup instead of 8, the exact number will differ based
         on the local sendemail.* config. I happen to have 8 of those set.
     
 -:  ----------- > 10:  97455f993d5 perl: nano-optimize by replacing Cwd::cwd() with Cwd::getcwd()
-- 
2.32.0.rc0.405.g5d387561bb3

