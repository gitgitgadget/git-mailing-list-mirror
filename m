Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352B7C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08F7360EFE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhJULgk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 07:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhJULgj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 07:36:39 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1797C06161C
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 04:34:23 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ec8so60893edb.6
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 04:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=HdtGd8DzaXflEvOGcgC6J10VWewEmnbb0hLbXg1V6V4=;
        b=OKoCfXhyYdxEySkADhA66mtDMns6XuwVyaWYVRNS47bbzL5Uuxhbh1HVe9gIXid7QD
         8oIDH0G+uiJZy4dqUgrKw3dRBgDC7Iyhtn50rgaGJ2CDuWUYGPMfkF6l8nde4j83fseq
         NKFVqCXhREUXxR3fORBcdnoxdUvv8g8CDLtfkfH6Z1xL1vtQZGExY5Trpm9jPlPuhZQP
         7xqX72Pd/eZYBips/wnOYXnO26vE/4MTg5obj2xvZIsN63ywqEG/SR39hVYtO4QNG8+E
         RYu6DZQRp9JWROM7nYPY2NsztbgQ0P2hCtCniGjCfLilbwb06at0nxyeLYmfqDXG8bnw
         pvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=HdtGd8DzaXflEvOGcgC6J10VWewEmnbb0hLbXg1V6V4=;
        b=6a8PIlIX3UnVrhy2B5pMiCc6HXFJ7AH2csZgEAC10KFhGS8w7sIY87/gCKFUzfY9Lu
         RNWkVSrDenND1rYBVw/bKRzTb8FXCkovIRB8jOtG3oO03ddT5yZNkhZ4Mf1ficp6S2Eg
         HbeILnSlFDnHzOABtkLPdw77y66GjXmicrkDgNHf2EG6u/ZwIVXH4qudTAw09ThEEd5h
         /bW8xJU5xn2QC3v5HEi2DaDnRz+w6aKXNYKUCm134a9P+j4y52cJu4IZgvgXDUCiyCig
         zk1wy+mOJ+AJHr0ERCIbTiV0GTxhGqd3NAzBtVUqHfoQGOGtuijTDg9SBp2O/H6ntgWR
         Yj8g==
X-Gm-Message-State: AOAM533oqQwxHXE26HnPn0VJXIkYFj5TFGoPzyTmDM8Kzhn8tJOt3utw
        iarkZTDJFNCmbrKl/xHGyqj93fhKBVmsHg==
X-Google-Smtp-Source: ABdhPJy/4t6lr9p01aRlq8CeHJAmNjwuaASbmMRzbVHbR9ETyIqLgkz0e6nUxQs754cMc1tPdKhAIA==
X-Received: by 2002:a05:6402:11d4:: with SMTP id j20mr6986372edw.267.1634816062098;
        Thu, 21 Oct 2021 04:34:22 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x13sm2386410ejv.64.2021.10.21.04.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 04:34:21 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdWKz-000yuL-0U;
        Thu, 21 Oct 2021 13:34:21 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: ab/only-single-progress-at-once (was: What's cooking in git.git
 (Oct 2021, #05; Mon, 18))
Date:   Thu, 21 Oct 2021 13:32:16 +0200
References: <xmqq1r4hv7bv.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqq1r4hv7bv.fsf@gitster.g>
Message-ID: <211021.86a6j2mx1f.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 18 2021, Junio C Hamano wrote:

> * ab/only-single-progress-at-once (2021-10-13) 10 commits
>  - progress.c: add & assert a "global_progress" variable
>  - various *.c: use isatty(1|2), not isatty(STDIN_FILENO|STDERR_FILENO)
>  - pack-bitmap-write.c: don't return without stop_progress()
>  - progress.c: add temporary variable from progress struct
>  - progress.c: call progress_interval() from progress_test_force_update()
>  - progress.c: move signal handler functions lower
>  - progress.c tests: test some invalid usage
>  - progress.c tests: make start/stop verbs on stdin
>  - progress.c test helper: add missing braces
>  - leak tests: fix a memory leaks in "test-progress" helper
>
>  Further tweaks on progress API.
>
>  Will merge to 'next'?

I think it should be ready & has reviewed quite a bit of review so far.

Taylor lifted one of the patches for his just-submitted topic:
https://lore.kernel.org/git/cover.1634787555.git.me@ttaylorr.com/; just
an FYI in terms of graduation/merging etc.
