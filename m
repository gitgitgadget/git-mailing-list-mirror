Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B83C4321E
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 01:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiK0B1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 20:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiK0B1d (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 20:27:33 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E047010CA
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 17:27:31 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id l7so4829088pfl.7
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 17:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJieE31RzqJL9IKFoBDjV6BHUFfTVQNV94gtN/G5B5M=;
        b=EckwakjOd3XNrJw0E2UcFdT34UPuZg9PEr96SVtqk2Fxo/u5nTYoRpTa+0tsWPbVbe
         CLSwSb8eYFZ1LgTyUSMrQn27Q8HIczA1dCCkM520D+LLItajiSWYsp6tOdcaS1Wj2nLr
         lA5fE8WwMqiM2mMXCPGoEtsMeYbf/wjNNPnuphctLRc68dCYMDv/zSij4TpoV7AK2j02
         kgAHYn0QZ5SB9G4r0uDVJkcsW1moRZMbpUwFExewIZSANsiSJcQ6JaukjBN+z6g4cD7L
         K5oOMKBhcKws52tERQW/fKsF1JsZghgYl0CVlIQBIy1M+OwxJHOEQgE70jEmsoAyiYVT
         4Eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DJieE31RzqJL9IKFoBDjV6BHUFfTVQNV94gtN/G5B5M=;
        b=En9tgvF03QklytePzW+VexJ296okvyRzuO8w2pQHogKzjdkcUQ0xz4x6NYNBScR3Ji
         qB5tBfYs2rcURGpjAQ1jAhtYe+yZiq4fX0LHU7ZFBbdkgKEzG0vjeTsPA0lTVMHGVKCp
         w/DZb1pYjvSueO8BuVY99wRkTQjEU8StvaHeISJ85DHrLrvqvfuYgTDW+6X3G2PdAkjp
         kPI9JJsmvqNeHtB+Ir1qZiKDWIGDELklN9P03d3YQR3/aCjJhlI6BTjVYzyXHbuwndiR
         kTzzI/uQISXNZEBPGtPFc3MZtuvVs0M6e0GVTP1QlFdB+P32bHwXompYDxVsxLa3FuEd
         E0tQ==
X-Gm-Message-State: ANoB5pn5u47uDX+o0fwdDqPLKShgMT6m+wZDGs/ahtrSoHIO9rmRPju1
        zHjiocQrHtkhDz+uKxaRTJw=
X-Google-Smtp-Source: AA0mqf7qPbTKM3BBLS2V7zNk3GrJJeysjYI7SINL6JKALW2XZ4K8GoOU6r9H0dmoFNliqnNB5xBrkg==
X-Received: by 2002:a63:f214:0:b0:477:f449:3644 with SMTP id v20-20020a63f214000000b00477f4493644mr5582210pgh.484.1669512451323;
        Sat, 26 Nov 2022 17:27:31 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id iw14-20020a170903044e00b001869f2120a4sm5980381plb.94.2022.11.26.17.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 17:27:30 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] am: Allow passing --no-verify flag
References: <20221119005031.3170699-1-thierry.reding@gmail.com>
        <xmqqilj8yir1.fsf@gitster.g> <Y4D+UU6l3YN9r9Xn@orome>
Date:   Sun, 27 Nov 2022 10:27:30 +0900
In-Reply-To: <Y4D+UU6l3YN9r9Xn@orome> (Thierry Reding's message of "Fri, 25
        Nov 2022 18:41:37 +0100")
Message-ID: <xmqqv8n19ofx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thierry Reding <thierry.reding@gmail.com> writes:

> Thinking a bit more about this, if we let applypatch-msg run but ignore
> failures and continue on to commit the result, wouldn't that potentially
> allow committing garbage? I'm thinking about cases where applypatch-msg
> may attempt to normalize the message and fails badly, leaving a partial
> commit message or none at all.

That is a very reasonable way to think about this.  So I am sold on
your approach of not running the hook at all.

Thanks.
