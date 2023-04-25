Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1EBC77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 17:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbjDYRtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 13:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjDYRte (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 13:49:34 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C7FAD0F
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 10:49:34 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b35789313so4457204b3a.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682444973; x=1685036973;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CRj/cIRR58T/XeQxgVo4a67SeFzQyIMFEh9+M5jVWbo=;
        b=Dy+jo7ew176Liqi1ItkGm9KYNtGbr48b2ybW9SuGRb0J2Y/cDaEkxB/5vGxyz4ee2i
         TKTfw7epqwbEtfXT6GIMg+1MkY7/zA0WhkN5ACEb0Nx+UKLfIUjJfL+wOrB9pqGaECHd
         bV3jVX1If3uVixt8e60tlv1InPDXMFp9095rDmnPNgWSEpjugsgcNOpWU9GRVkM6l4lL
         +fQdXIoaoEgGFyLGdfuzv4MluvhKjCcKKnomWSgNMiOav7Ugjlb5lDQErN+9Poey0sXX
         8Sz4QC161wJPJ3wgYEiVSSQR0N0ZbEuPMFT+j2LX7peKfo55ffro3/PBCgFx/hnx6ysY
         I+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682444973; x=1685036973;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CRj/cIRR58T/XeQxgVo4a67SeFzQyIMFEh9+M5jVWbo=;
        b=D22BCD/IKL2LytXd1nXxi60iLkjQfsbIjAblTMr8HjzJa72qaOHs4XYXCPfcCDFEVF
         P4IzX4+9zitVYAScKCsctIusqkSTWaac/ymat4N9bdHdOT1g+3qDkSl50NYLTd1ZbgRD
         DjYxh18KxsYiaIjQMlkKtZz0YLgRkr55JQ5M9S1bap/OCqCWqM6O94fmWFhUX9ySBahm
         tsApd9PmwHTqyYJvtkORiHdr+0ftH7B3iMtO4uZUMniVsYe4b2hfkMHJgAPvjY++9gq7
         EfGyRW1gZ2pGwuawxsnn3t++SbGn09aVTTd/HEG1BGUB8xMeC72gDF2v/pPjTG7ufR3L
         dmlw==
X-Gm-Message-State: AAQBX9d/EPLpakBDBb2WEE3bKy1eLFciPWad2Czyc83RqiB6Z6uT1jMz
        QxgeIBnm1Ec3NWB31DjLZn0=
X-Google-Smtp-Source: AKy350b9XFpmts7N6Sg9N/PCP7CM6ErNKtlDIU6K/KRQZURo7v29l6oFGbnPNCJJJ+poSYyIP54QpQ==
X-Received: by 2002:a05:6a20:a10d:b0:f0:b6e3:90c9 with SMTP id q13-20020a056a20a10d00b000f0b6e390c9mr23136310pzk.4.1682444973325;
        Tue, 25 Apr 2023 10:49:33 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id x137-20020a62868f000000b0062ddcad2cbesm9807677pfd.145.2023.04.25.10.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 10:49:32 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v8 6/6] notes.c: introduce "--[no-]stripspace" option
References: <cover.1682429602.git.dyroneteng@gmail.com>
        <f60f743203d78a489b90df81472e71391b45367d.1682429602.git.dyroneteng@gmail.com>
Date:   Tue, 25 Apr 2023 10:49:32 -0700
In-Reply-To: <f60f743203d78a489b90df81472e71391b45367d.1682429602.git.dyroneteng@gmail.com>
        (Teng Long's message of "Tue, 25 Apr 2023 21:34:41 +0800")
Message-ID: <xmqq4jp326oj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> From: Teng Long <dyroneteng@gmail.com>
>
> This commit introduces a new option "--[no-]stripspace" to git notes
> append, git notes edit, and git notes add. This option allows users to
> control whether the note message need to stripped out.

Makes sense.

>     ... One more thing need to note is "the order of
>     the options matter", that is, if you specify "-C" before "-m" or
>     "-F", the reused message by "-C" will be stripped out together,
>     because everytime concat "-m" or "-F" message, the concated message
>     will be stripped together. Oppositely, if you specify "-m" or "-F"
>     before "-C", the reused message by "-C" will not be stripped out.

This sounds more like a design/implementation mistake that we may
want to fix.

