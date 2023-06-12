Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D0AC7EE2F
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 21:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbjFLVEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 17:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238818AbjFLVEI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 17:04:08 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E7959EC
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 14:00:22 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b3b3f67ad6so20837805ad.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 14:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603622; x=1689195622;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RYQVCYlIAoPpVeghFs75oJwXCTvv4d18DmPWKo9YLoI=;
        b=QpLA91WuSoBvYlGu+WFeAIRAWhptVzRgizgGppfxYugbMoRcZWf/E9rMRpBWl0nWWz
         zXyX17RFCrS4yjgTisknV/xShGj8yiUWveFlJRpnOqQmc9oDqyhJr/holyOOaEcfvder
         6IOqFlXqdDfeKSyiTh5fS+gEgEETsIUBGCDG12WxWmB9mj/8+LoveyVBfHusNCYTkl29
         OZmJJeZwOQYaLbpKNVE2dGMw95/qJ8YDzmhn+cOntJC3kqodkr/lgQxE3fHVnodi3Sa3
         3vIYVrG5bI97TO7kCmLaHz/UzA8YwDVhSDH1bHBgky4/bsohkzeJzgmm/XmNvBPoA+W/
         mfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603622; x=1689195622;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RYQVCYlIAoPpVeghFs75oJwXCTvv4d18DmPWKo9YLoI=;
        b=Lx2r7a9lbwwDJE3kBIsIKqR8RPg0z5Vqxa6oPGBl8vfVb/ZDuqxyCGU2LMK0qJXvRt
         SZs3MjwrPmReQRvw00CXKSEl7gjqxYPLEbDzIGuSUvztmllG9u/gOY61vg5XBJJU7mZI
         P18bslyvzsYK7IJM0QMZrBrU6iWOa9TnA9lRaKCK7RcDFhs1j05hwpirzC4OaLIeKt2G
         YGkHMI+6E3q3RmmZrmImC0fmBN1Wo9/BmokgACGQPkIcLT2ahseSf9u884OgiWPTjpNf
         bzHR38bEVuVVV+YEOJi1ZnkLjGj9jBt4JYDJUImfw/7mz3TTgU6NVFmzgzFI0sqMin5i
         JzjQ==
X-Gm-Message-State: AC+VfDy1eKdnmk8xe+jWglMcODRbdorgp7dhwTaA2t+KDaeeQ9qH7NKn
        Ak0QK3GO+xZaxYarhnIbO0U=
X-Google-Smtp-Source: ACHHUZ7/V0e3uGrNGoymEkqUtFhJwU8s7JJwyJIW+4sZdjZU9TjPcuF7DMzQ87cdKSebynOTg8kAwA==
X-Received: by 2002:a17:902:e542:b0:1b3:dcf1:97 with SMTP id n2-20020a170902e54200b001b3dcf10097mr2420508plf.25.1686603621957;
        Mon, 12 Jun 2023 14:00:21 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id r23-20020a170902be1700b001a183ade911sm8632376pls.56.2023.06.12.14.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:00:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin/repack.c: only collect fully-formed packs
References: <20230607101617.ges6tnMry4E52lDGld43QgtNUsIS4YQq6w-t71hEfkQ@z>
Date:   Mon, 12 Jun 2023 14:00:21 -0700
In-Reply-To: <20230607101617.ges6tnMry4E52lDGld43QgtNUsIS4YQq6w-t71hEfkQ@z>
        (Taylor Blau's message of "Wed, 7 Jun 2023 06:16:17 -0400")
Message-ID: <xmqq4jnc9z16.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Fix the above by teaching `collect_pack_filenames()` to only collect
> packs with their corresponding `*.idx` files in place, indicating that
> those packs have been fully staged.

Hmph, after following the problem description (which by the way was
very well written), I expected to see "collect_pack_filenames() is
taught to use get_all_packs() and then enumerate the names from the
in-core packed_git structures---this way there is no possibility for
the two methods to produce inconsistent results".

But that is not what is going on.  Rather, it is "we still keep
using a separate readdir() loop, but made sure that the criteria to
include a packfile in the result is identical to the logic currently
used by the other function", whose implication is that they can
diverge again.  I am somewhat puzzled.

Will queue.  Thanks.
