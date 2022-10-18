Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45870C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 18:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJRShu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 14:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJRShs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 14:37:48 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F012895FD
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 11:37:47 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id e15so12534436iof.2
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 11:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5zns8lvLizHkGBb10H1MOzCL0UEqWkTx4yhKCRdKzU=;
        b=OEXsj4hm+xeBtrdsaBmnIPNGpIlGgt21Har/GMGSw0GARDxhf5SolYY390XsHslk7t
         SgJcGd14mcq4nbi+Y93PKDPXes8VQgOBZS1v4B8BFJl3VYTIhO89k65J8kbjxucSiZRk
         V3E9uA5QyPtU8ECALg4A1+3ucfQzM3b03q2Zu7gtVnfFSRkZq4Xu21MDWZybTxxJWcv+
         0afiW1qCMZGGDBGN+4zP86TArfNEyGaYQJB3zOmMcBsbUn5xmaJSmRwU50KMHmT6gUOV
         ai16qBvD3ZAzMVky2S36tFWGExVXYJHTNV3wJ8H0Qx8RBYs9vv+FU1BpKfpeEQ++x9qB
         bnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5zns8lvLizHkGBb10H1MOzCL0UEqWkTx4yhKCRdKzU=;
        b=Q6l48Ef9a6nPtB1Zs9KCXEm1/xilEFS9rCwkjsayEzug79s2ViWawm7p5hixPQhQPt
         Ldkgv3oLn+sDCN8kYMcEL2THCEZzZ7Ge5nTQSOWrwGk7rXECjseGFqqOHU5ZqzwkIKm0
         FpgRJh1v6JLPcNmVG7Y/Ne8RE4cNHF4BxUpzGFFW8hMQtGB6lUVOs6LYKTcRVXxwzxas
         6roAR3k2+rP7H6cuBctrWYD47bxDxipNmQJqaRV0HZUytNYKtmr5zmtvIoklHIrokvpC
         Crss6HfVCHnA/G/GpE3vWz8EWiPhkBDnGwYI4CADlL1WM5PohB9N7S5CJosvNJuJubHz
         tbww==
X-Gm-Message-State: ACrzQf211BQJwt37Dd/aoyQO6SBi5f6cjoNypI1xnu1+EDU15jheT+89
        hqq7t4m1DUEUcAs588+ByhMt8nQgR0mz4vXD
X-Google-Smtp-Source: AMsMyM5dXqle274qaUXfEsItBeE3J+ueuXfIqkEyf5CoT+xTmhoIiPtSCtqA/SbJg2H0aqAkZQ50iQ==
X-Received: by 2002:a05:6638:d51:b0:363:e124:aa6 with SMTP id d17-20020a0566380d5100b00363e1240aa6mr2701556jak.7.1666118266431;
        Tue, 18 Oct 2022 11:37:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y4-20020a92d804000000b002f66aacb98asm1216207ilm.70.2022.10.18.11.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:37:45 -0700 (PDT)
Date:   Tue, 18 Oct 2022 14:37:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: linux-leaks CI failure on master
Message-ID: <Y07yeEQu+C7AH7oN@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After Junio pushed out the tags for v2.38.1 and friends, I noticed that
our linux-leaks CI job is failing t1300.104 and t1300.109, claiming that
there is a leak here:

    Direct leak of 7 byte(s) in 1 object(s) allocated from:
    #0 0x7fc4a5b319c1 in __interceptor_malloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:54
    #1 0x7fc4a598638e in __GI___strdup /build/glibc-SzIz7B/glibc-2.31/string/strdup.c:42
    #2 0x55ba23538f7c in xstrdup wrapper.c:39
    #3 0x55ba233e258c in git_config_string config.c:1445
    #4 0x55ba233e6b06 in git_config_include config.c:439
    #5 0x55ba233e063f in get_value config.c:910
    #6 0x55ba233e063f in git_parse_source config.c:1092
    #7 0x55ba233e063f in do_config_from config.c:1937
    #8 0x55ba233e3d2d in do_config_from_file config.c:1965
    #9 0x55ba233e3d2d in git_config_from_file_with_options config.c:1987
    #10 0x55ba233e4793 in git_config_from_file config.c:1996
    #11 0x55ba233e4793 in do_git_config_sequence config.c:2143
    #12 0x55ba233e4793 in config_with_options config.c:2198
    #13 0x55ba233e4a50 in read_early_config config.c:2255
    #14 0x55ba233acb36 in alias_lookup alias.c:35
    #15 0x55ba232d0748 in handle_alias git.c:346
    #16 0x55ba232d0748 in run_argv git.c:851
    #17 0x55ba232d0748 in cmd_main git.c:921
    #18 0x55ba232cee03 in main common-main.c:57
    #19 0x7fc4a590b082 in __libc_start_main ../csu/libc-start.c:308
    #20 0x55ba232cee8d in _start (git+0x1fe8d)

I can't reproduce the failure locally with gcc (Debian 10.3.0-15)
10.3.0, but Victoria (CC'd) can reproduce the failure with 9.4.0.
Interestingly, the failure only appears when compiling with `-O2`, but
not `-O0` or `-O1`.

This is reminiscent to me of the discussion in:

  https://lore.kernel.org/git/Yy4eo6500C0ijhk+@coredump.intra.peff.net/

I'm not sure if I'm content to treat the 9.4.0 behavior as a compiler
bug, but definitely running the linux-leaks build with `-O2` is
suspicious.

I suppose we could temporarily mark t1300 as not passing with
SANITIZE=leak turned on, but I tend to agree with Peff that that feels
like a hack working around compiler behavior, that will ultimately
result in us playing whack-a-mole.

So my preference would be to run the linux-leaks build with `-O0` in its
CFLAGS, optionally with a newer compiler if one is available for Focal.

Thoughts?

Thanks,
Taylor
