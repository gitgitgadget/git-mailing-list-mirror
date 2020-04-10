Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EB9C2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DFC2078E
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb6sGFFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgDJRfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:35:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43256 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgDJRfe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 13:35:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id x26so63659pgc.10
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 10:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YRVVbWJ7S4r9/XLvIOopZm4zqDsYNFlDD8GqbfSIyto=;
        b=nb6sGFFQApbj41W++72IbYeqS70eHc2RYPzFjHFJFlQCJMoSc70XCblU7E8rtj5kxr
         tAR80ntWpwWQyAaEWwHA11iMe2CH8MAzbaDLpS7D/Bo6JcBr1ET/sidcSxPy72hJiKlO
         c/8VsPoKma+8NBzIt3eNqRtFiTI0+S4oyXj7i40iWHy5OWI6G5I7pR54usKLxqUi7ifO
         Rrg0DUGnzKuSMGIr62vOqm888ebC59q+W/nLZBtSwzmmTHf2e1L8s0i8qq0Lxpqo8A+q
         b+2uIXtB+NpTaXiAKBHlyMAFAf1C1crClFTep8PdJj9xAoyPzQvwdtIVQiilfXsQYpBR
         Nwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YRVVbWJ7S4r9/XLvIOopZm4zqDsYNFlDD8GqbfSIyto=;
        b=PN+LzFrNUsTUMZ+OKIBgvEeRJvZMHZbhXQJ/A8LcndAWv+NTyYF60d3MatzgDKDBm7
         evEbV+tAZrSLDv8WZ9LmseeYHbLXEnjK+NtxH6FvFtUkqJFQawp8HNQYNtOnt8QDCX6V
         QWDgupzV04V6S+6JvamkOwVf4H3ScyTmydN4oegJvo1gs9mT6bq8BWgsfpUOMuHykRi+
         z+MBhaO96ZHUAbFgDM4c3W/klg5iR6luF7zdDL02svoS2gIuWsWcP68xjcGX3VsBNrdF
         Ln/5/ZwmcP1tuIlT2JPGUVcSpLY/4/tDw8GUc56VAIJvYYYWpnD8320LcsZ7HqEHVtuT
         /V8g==
X-Gm-Message-State: AGi0PuZGa4+rNvPiAlpgHmWt12XgOeqYqTOpRsTBOjSZK3I0wXMXVgY5
        g4Wic32QkKZg1FPTdh6RyDM=
X-Google-Smtp-Source: APiQypKlIGbQcqZf3v+x4EIsM05ns32UmSGWoRyeNSurdqVN9r+Ab/MGi+zx7HcZex9GNgzg2wipIQ==
X-Received: by 2002:a63:1711:: with SMTP id x17mr4783488pgl.210.1586540131898;
        Fri, 10 Apr 2020 10:35:31 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id c8sm2271987pfj.108.2020.04.10.10.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:35:31 -0700 (PDT)
Date:   Sat, 11 Apr 2020 00:35:29 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 00/12] ci: replace our Azure Pipeline by GitHub Actions
Message-ID: <20200410173529.GA27699@danh.dev>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <cover.1586309211.git.congdanhqx@gmail.com>
 <xmqqpncgmk5z.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2004101604210.46@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2004101636150.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2004101636150.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-10 16:37:27+0200, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi Junio,
> 
> me again, just quickly, because the `t0031-reftable.sh --valgrind` run
> just came back with this:
> 
> -- snip --
> [...]
> + git gc
> ==28394== error calling PR_SET_PTRACER, vgdb might block
> ==28399== error calling PR_SET_PTRACER, vgdb might block
> ==28399== error calling PR_SET_PTRACER, vgdb might block
> ==28404== error calling PR_SET_PTRACER, vgdb might block
> ==28404== Invalid read of size 1
> ==28404==    at 0x4C32CF2: strlen (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==28404==    by 0x551D9AD: strdup (strdup.c:41)
> ==28404==    by 0x39D15A: xstrdup (wrapper.c:29)
> ==28404==    by 0x3DA9CA: reftable_log_record_copy_from (record.c:605)
> ==28404==    by 0x3DB844: record_copy_from (record.c:968)
> ==28404==    by 0x3D64B3: merged_iter_next (merged.c:117)
> ==28404==    by 0x3D656B: merged_iter_next_void (merged.c:131)
> ==28404==    by 0x3D597D: iterator_next (iter.c:45)
> ==28404==    by 0x3D5AD2: reftable_iterator_next_log (iter.c:71)
> ==28404==    by 0x3DE037: stack_write_compact (stack.c:718)
> ==28404==    by 0x3DDBEA: stack_compact_locked (stack.c:632)
> ==28404==    by 0x3DE5AD: stack_compact_range (stack.c:847)
> ==28404==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
> ==28404==
> {
>    <insert_a_suppression_name_here>
>    Memcheck:Addr1
>    fun:strlen
>    fun:strdup
>    fun:xstrdup
>    fun:reftable_log_record_copy_from
>    fun:record_copy_from
>    fun:merged_iter_next
>    fun:merged_iter_next_void
>    fun:iterator_next
>    fun:reftable_iterator_next_log
>    fun:stack_write_compact
>    fun:stack_compact_locked
>    fun:stack_compact_range
> }
> ==28404==
> ==28404== Process terminating with default action of signal 11 (SIGSEGV)
> ==28404==  Access not within mapped region at address 0x0
> ==28404==    at 0x4C32CF2: strlen (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==28404==    by 0x551D9AD: strdup (strdup.c:41)
> ==28404==    by 0x39D15A: xstrdup (wrapper.c:29)
> ==28404==    by 0x3DA9CA: reftable_log_record_copy_from (record.c:605)
> ==28404==    by 0x3DB844: record_copy_from (record.c:968)
> ==28404==    by 0x3D64B3: merged_iter_next (merged.c:117)
> ==28404==    by 0x3D656B: merged_iter_next_void (merged.c:131)
> ==28404==    by 0x3D597D: iterator_next (iter.c:45)
> ==28404==    by 0x3D5AD2: reftable_iterator_next_log (iter.c:71)
> ==28404==    by 0x3DE037: stack_write_compact (stack.c:718)
> ==28404==    by 0x3DDBEA: stack_compact_locked (stack.c:632)
> ==28404==    by 0x3DE5AD: stack_compact_range (stack.c:847)
> ==28404==  If you believe this happened as a result of a stack
> ==28404==  overflow in your program's main thread (unlikely but
> ==28404==  possible), you can try to increase the size of the
> ==28404==  main thread stack using the --main-stacksize= flag.
> ==28404==  The main thread stack size used in this run was 8388608.
> error: reflog died of signal 11
> fatal: failed to run reflog
> error: last command exited with $?=128
> -- snap --

The second patch from Dscho (which is only test code in sh) trigger segfault
with and without the first patch on top of pu.

Git was built with DEVELOPER=1

I merely run "./t0031-reftable.sh -d -v -i"

-- 
Danh
