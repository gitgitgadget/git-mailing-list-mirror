Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A24BC77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 16:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbjDYQ6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 12:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbjDYQ6T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 12:58:19 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF272D70
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 09:57:58 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b73203e0aso36892428b3a.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 09:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682441878; x=1685033878;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LyKKlZiC0XtqjwIiWjp/0ok1AgLP92+NIDFo/Bdg/0c=;
        b=bkD6YCeZqPECS2jHDJ3BvG3BMoVwAbYxs6ewkWyLe/ZrAe2MSX39YoZ7TkaCyXWAgM
         1llJKYOComIaUzXF7tcnYdvppd4HmfyAZMP35gWuqXYUTuB3FJEQ6F05eZwDKI6Kk/YP
         6rF4VbkPKhqNVqhNn1U4Ttfd1Zh5t3PyU84IBEqS9IzLjZFD+2SbQI1vC616ufSN/sR7
         YjId1M6lAKp9ZlIHTBh+qTcsBvdqZqIzAFS/JqvpOdBdwAJlXzyqToHtRnH8ZGrzfN7b
         Ao4CzMfX1ALSe/ISGtuQSLgiydG4TXR2EWB9BllQ/Jjuv9sqaJ47ys71JSUaJdV0ckkT
         6RcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682441878; x=1685033878;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LyKKlZiC0XtqjwIiWjp/0ok1AgLP92+NIDFo/Bdg/0c=;
        b=Lfzxx/K7sBNXFdtM9/hVX4mDD87A1241LpYtSGNzySoR3rdOUtzHWq9eTKh0MTGbyz
         Ab1GUBZwmQEOpsRLD5bsEGyePp3vcgKJiWI8S3XMo24YjN0NCcm7Pb131bPrBGl2MLjy
         b/MDFEWYzkdnsyIRFchGILbfUILZ1vdUPfy2sSFeVCE+DExfvXwDWnrCAmEzP32xXHHD
         9tCKiTxZ7Co262Tj/QHx6r7hqxmkDKrstPFZ9k2H9JNd9MraD8I68X29ZSogOuU377Dx
         ohjCuborlvyUQT9QN9VSWRJdmZ07V8gyrk1EBDG67GsZ2z9fQgw8sNVEoEnSkNE3wvi+
         BpzQ==
X-Gm-Message-State: AAQBX9efrdtFnY1uJcjCK7gLraFctayqYigWAkDUAGIGewSU/rVBQkgj
        dxQ3eJXk+sA90CzKmZoYxhUVJ0izF5M=
X-Google-Smtp-Source: AKy350YygL0PT2JDN5MlQUT96KqR9QlGli14oO46fJBQPMmiHbCbSUf7evJKRP+fRprhHXh0z95/cg==
X-Received: by 2002:a05:6a00:238b:b0:63f:32ed:92b1 with SMTP id f11-20020a056a00238b00b0063f32ed92b1mr14305663pfc.7.1682441878232;
        Tue, 25 Apr 2023 09:57:58 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id 30-20020a63145e000000b00524cfd635cesm6786870pgu.69.2023.04.25.09.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 09:57:57 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com
Subject: Re: [PATCH v8 0/2] diff-files: integrate with sparse index
References: <20230322161820.3609-1-cheskaqiqi@gmail.com>
        <20230423010721.1402736-1-cheskaqiqi@gmail.com>
Date:   Tue, 25 Apr 2023 09:57:57 -0700
Message-ID: <xmqqo7nb3nmy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> Changes since v7:
>
> * Refactor the ensure_expanded and ensure_not_expanded functions by 
> introducing a helper function, ensure_index_state.
>
> * Delete the test 'diff-files pathspec expands index when necessary'.
>
> * Delete 'the pathspec_needs_expanded_index' function.
>
> * Add double quotes to "deep/*"
>
> * Change "**a" to "*a"
>
> * Updata commit message.

These patches seem to have some whitespace errors.
