Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AD7C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B0520663
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BC7Ed9mu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgEDRjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 13:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730173AbgEDRjo (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 13:39:44 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8B8C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 10:39:43 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a32so185673pje.5
        for <git@vger.kernel.org>; Mon, 04 May 2020 10:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nVeBRFXbCKAc8sAyuHM+SNpiM4xxQc3Id4iUzwXAjQU=;
        b=BC7Ed9mukPJHyM1VagAx9cPqnTf7LHnYm/onNWD0GDrRLrTiUWx11nFLQ/agLgm4QR
         NV5TRBiQ0h/8KakLRIsxLh3ghg5UAmpiHlm8h/U39QRlbOGu5c97E0kACaYznJvO6Ac9
         qiojpGPngNs2CWemKZVaDPvFg2FtQfNQyRq20l5hXwyzW6AaM0u1qIdYup48UwKB90Is
         zughZE5w28oiMiT6vgY2f4kbcOO2A7EKqLcbb/EYBwOJydk7BJjlSFptZJRy6VfLGV7p
         NKo33Pm/40VueZ4JIgR1o6PPzzmtptrqCpuiv320Ml8G8PReiviIIx2d4bE3Ze/Euvfz
         v37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nVeBRFXbCKAc8sAyuHM+SNpiM4xxQc3Id4iUzwXAjQU=;
        b=ujmHjAe5qQTcg20z5ndpHZpmDf/mHEoe6wWoTms91EUzUXSYwoalq0htcMcHAKdQ+m
         bqrI+HXXT1F58Ov8Ml5xIN4JiJr+W9jykkRSEwPlXjlLIVfQ7gTtWB5PguvNhCdgPoGl
         bymVSBcUDQeB2XqlIDRi7TAMVKVkd+IeTM9gCdsGKdDAGTNn/FKc/xuh09wHHO4C66yn
         XuucgSPKRBHZAcNFNdxBaEU9iCbibcL03V0RRbxm2MZkbY3E0I1halfLSVh0zvvFc/bu
         3inU37tH8ce/2jSEwjlfdHuZWae/gcQaK9K/oYR1zOZ6Guj1LGFSry9tLgS+GmVeURgc
         HNEw==
X-Gm-Message-State: AGi0PuZNPqLgPW5GMZZwttmq1oxw2NOf9NZg2N6arrdVplohBNPB3mqh
        MGkHg+3xZ89sQI713yA9tMY=
X-Google-Smtp-Source: APiQypK4zJvIRzC+PTiHvunwD6Ys1J3Inq3ay/sil3b4DeWF/l8HQYqyqEw7ljW11lJOeaVgKavDcQ==
X-Received: by 2002:a17:90a:9f8a:: with SMTP id o10mr122136pjp.118.1588613983336;
        Mon, 04 May 2020 10:39:43 -0700 (PDT)
Received: from konoha ([103.37.201.177])
        by smtp.gmail.com with ESMTPSA id z23sm9285272pfr.136.2020.05.04.10.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 10:39:42 -0700 (PDT)
Date:   Mon, 4 May 2020 23:09:36 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        liu.denton@gmail.com
Subject: Re: [PATCH v3] submodule: port subcommand 'set-url' from shell to C
Message-ID: <20200504173936.GA8919@konoha>
References: <20200504072705.15261-1-shouryashukla.oo@gmail.com>
 <xmqqd07jitjz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd07jitjz.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/05 08:55, Junio C Hamano wrote: 
> > +	argc = parse_options(argc, argv, prefix, set_url_options,
> > +			     usage, 0);
> > +
> > +	if (quiet)
> > +		quiet |= OPT_QUIET;
> 
> This is bogus.  "command --quiet --quiet" would count-up quiet twice
> and would make it 2, and you or OPT_QUIET==1 in to make it 3, but
> your intention is quite clear that you want to pass 1 to
> sync_submodule() in such a case.

This is a grave mistake from my side. Though I do not understand how
will `quiet` be counted twice. Let's say we pass `--quiet` option in the
command, then `quiet` is set to 1. And now if we do `quiet|= OPT_QUIET`,
this will make `quiet` 1 again right? Could you please tell me what am I
missing out here?

The fix you suggested (quiet ? OPT_QUIET : 0), we use this because we
want to ensure `quiet` goes into sync as either 1/0 right? Not any other
non-zero positive integer right?
