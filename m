Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4885C4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 00:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiLMAzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 19:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiLMAzt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 19:55:49 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7DCF4F
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 16:55:48 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 62so9384788pgb.13
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 16:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1riru2YaTAUEvujMP3c+/CqFZdfGZVP7VEoDiY9MgE=;
        b=BVhbbl7IfzDxo4LJIRhwl8q4HohMNLTG4V6bhfcZe3HSo68FQx+HeqXJBLMSkJczJs
         C1CQxPMLLeb4RUjeY/SMF063VvEYcCbOecVq/oEf9kGsZDzpLlJSrgcLTuLeyO4PMxeU
         ZJu+C1ntz76zuigBdFf+f7RLQKUREoJ9ayzgOuBpb0UWDPMbg5npNO1cizACUJ/TQ3ji
         gnPSqkT6nA+Fig9wfkH+prsTJ1x/BNvl93r7tlxWPqrc/PUxKiyK1fUGtFHuR/LnqYpj
         ywRygf7HtU16ASBZV58mLuQz6s8o/0rHDq3ALeaR02JTtbJBlsiaLflG+ZY7mLbQ9uTp
         AB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1riru2YaTAUEvujMP3c+/CqFZdfGZVP7VEoDiY9MgE=;
        b=hmQqMloJRP4I83Bl3RH8T5KKM78aYppZ/fvToMlducEBOL75ZmwCgZFPOFyJP3yVRn
         XfXUlzE3dWcCFrzlU+HJseZTCJHnV0Gy6X5Ss109QrfkgLUdtwPko+FU7OcXOJXa2VF/
         Nd/wAn8VMXoQRs4ilnUYKdhNNiiNpSPTW8oFRJCHpYhdPneSGmUFhXBL5oplwOo6e+Rl
         ELEeMXMe/W68JPb0rT5McKke+QlVV7FG/v7LiCuuTrwUJrVsnGDZEUz1TQrQd9nR+SI4
         JtTygvqzcXCl/s00G/2+zKUWa1DsK0wFRVhSWnrFCsU4jVsPUNmo/pyM3Kq2Iqw+ZOcE
         6M1w==
X-Gm-Message-State: ANoB5pnLOcZffadkPtwdZY1h46R3u/do75aonVhJ0se3sLLLsAyrnK79
        xor1LJNMFHzGdwvMUHS8DxRAwAcXwH0qgQ==
X-Google-Smtp-Source: AA0mqf6mRxKOHV/E+AfZAZrQFtjekjQb+63scbZQdbmrNirqql9kNbPTiIRE1Nppxw9EbPdZmYqpXg==
X-Received: by 2002:aa7:9486:0:b0:576:755a:4831 with SMTP id z6-20020aa79486000000b00576755a4831mr17118011pfk.9.1670892948056;
        Mon, 12 Dec 2022 16:55:48 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x12-20020aa79acc000000b0057725613627sm6583035pfp.142.2022.12.12.16.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 16:55:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com, avarab@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 3/4] test-lib-functions: add helper for trailing hash
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
        <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>
        <813e81a058227bd373cec802e443fcd677042fb4.1670862677.git.gitgitgadget@gmail.com>
        <20221212181438.GA3411@szeder.dev>
Date:   Tue, 13 Dec 2022 09:55:47 +0900
In-Reply-To: <20221212181438.GA3411@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Mon, 12 Dec 2022 19:14:38 +0100")
Message-ID: <xmqqh6y0qfzg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> +	test_trailing_hash .git/index >hash &&
>> +	echo $(test_oid zero) >expect &&
>
> Nit: test_oid zero >expect
>
>> +	test_cmp expect hash &&

Unfortunately they are not equivalent.

Usually we write these helpers to terminate their output with LF,
relying on the fact that terminating LF will be dropped when used in
a command substition, e.g. VAR=$(HELPER), but test_oid deviates from
the pattern and does not give the terminating LF to its output.


