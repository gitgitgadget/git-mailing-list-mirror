Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A16C6FD1D
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 14:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbjDGOaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 10:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjDGOaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 10:30:16 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C536EAC
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 07:30:15 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so43449091pjz.1
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 07:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680877814; x=1683469814;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3Z7H7H/1jc0i0htq35qwpSrkoqb0582w6UayIS829w=;
        b=WyD9nAZItwum71ZAHHDri8y9bhe4m3QxrHguH2prEmYSAVHy1zSnaEBb//uP4ABKGE
         5omACd4OBkdKVjmBSD2yIT8+Fzgx7L1CZdW6Xkv+roa+w5vIKcKM51YX3fHTQsqdy94V
         nQtQIP8axsH9jRig9qtFpOMEpPvPJMFsrjXqv/7GYq1R3x2PWcz1TH166O5AxANyt7b4
         iwnoD0RiPK83BEJ9tW6BZW6hwbn8vfG364KXTh+FgfqlOhCUNE4P70nMC/kX6iMl1DbP
         WK9BngIhPPQMqtVWuP6rR7Yagip60AwQsHhIaUL/DlOprsrNZVjAq/V+a813UwkriLLI
         C/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680877814; x=1683469814;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E3Z7H7H/1jc0i0htq35qwpSrkoqb0582w6UayIS829w=;
        b=JjUNcfcUzJ5+kWQd0ULzs5FzH1TzEFFEixMUYFjk8VOE2vvVnz5Muwxc1Kz+j+w2LP
         21ojxdHbNFOlU26xEHNNrEVGuO4UCwi3b+HdngpDGdOkN/plYBD6yi/EBTCkUXA8CYSZ
         /w9FE/V0mnja/R5ww7hjY3JLeG1TFc5d8X7kGHZr0CmFejbFKYPi7kWlRZ5eXTGOjYbZ
         6J4jm8ewIGJEIqjh9yHWldl+SgDDCSQ1movXu4qKJOyg+y0KD1V4uRAuRzkj5szPceTS
         T1n82bUTHFvPTvqv2mjVDv7kIUoR8cnPA50lFh3hzzzuuwvpfId0iEpuirxHvPSUUirG
         4xEQ==
X-Gm-Message-State: AAQBX9cYDJx5mMfDO59+0j+93hvbCHilXzqmTv0YQcDCXqos1sAz0LUV
        sIpmTuoAOvqe6f+eb0RsYGI=
X-Google-Smtp-Source: AKy350aCY+zQQ2H2z6CNyMmMk1f4XOvhYlle72HWGokuvOkNnHAra9sX8zZ766S7So6ijy8C9VPypw==
X-Received: by 2002:a05:6a20:47c8:b0:e1:3bde:3a98 with SMTP id ey8-20020a056a2047c800b000e13bde3a98mr3234138pzb.52.1680877814253;
        Fri, 07 Apr 2023 07:30:14 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id w8-20020a63c108000000b005141e2c733dsm2723822pgf.11.2023.04.07.07.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 07:30:12 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH] doc: asciidoc: remove custom header macro
References: <20230323221523.52472-1-felipe.contreras@gmail.com>
        <20230406035729.GA2092667@coredump.intra.peff.net>
        <CAMP44s2u4tj7hUZHZ9H4qsJGp1a=Y=YUTBAxmSzftdfHX_HqwQ@mail.gmail.com>
        <20230406071914.GA2143526@coredump.intra.peff.net>
Date:   Fri, 07 Apr 2023 07:30:11 -0700
In-Reply-To: <20230406071914.GA2143526@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 6 Apr 2023 03:19:14 -0400")
Message-ID: <xmqqwn2nlq8c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> At any rate, I don't think any of that needs to hold up this patch,
> which is not touching the asciidoctor side at all (I only wondered while
> reviewing it what the implications might be).

Yeah, sounds good.  Wondering about and discussing possible
implications is also a good thing, when done in a productive way.

Queued.  Trickling in modernization a bit by bit to avoid hogging
too much list bandwidth may also be a good thing to do.

Thanks.
