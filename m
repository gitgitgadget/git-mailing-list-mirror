Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16ABC38142
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 15:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbjAXPiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 10:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjAXPiF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 10:38:05 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B867AA1
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 07:38:02 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id a184so11440540pfa.9
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 07:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=paTRMOdoAio5JHCS8+Er5ESSjzn1C9cVMUWH6KjoNO4=;
        b=AtYjlehDWxZAmaFUoyWbkQjlqArrNhJtFsCkFfmuHg4dLDsOoD1ND+IQKtqasZOCP8
         OZo4dBX18i0gA6Tnun6vSykFq21FTw188ZghubI0L4yNfEjSZPLSpyFaINgn9dHa5u0t
         XY+HomQcPiID9EYdHdDp4LsV8lAbiAsXi9cRzSpL82dDIFAmBoT6Ibc5pGT0NU5snfQv
         hWf8n1dMXH/vEIBVB/5zQSEB60X3i++0q4022DgfbzIbltP098cV8NJkJhTE5Vj8fq9c
         TJBBTYTGgTP/TKfGtUTJJHCRcfD9yVhwrI5hxf37BlFp0kqkRDFR27GuS9S9HKRPpepk
         yEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=paTRMOdoAio5JHCS8+Er5ESSjzn1C9cVMUWH6KjoNO4=;
        b=ZgYR7QHQi611j5hyJ+ygv+foihRLqMjzYRFqn94lp17DJs2ykASY3AM8mWCgxvDXyf
         z7Dh8ywr6s+mwrcsrrx+o8433Qs25pl7qkXp0g1esBxCch7TkyNz8QR398DAUBDd30o0
         MAQgMHnmnBLqZLuwR14DOnQ8O/iG+8Bh3R7t+Q+nhDKlRhYKpJEkdIXe9K55xm6q1LHS
         FVOcv27iuyMybt2brdvj4tvMVOoANmeKXf8UeV0oYrZACe3O+zJ+4M19Gx1nD1GXvd39
         bzxkqiY64ewyAHOJHOefHTeUJrzbaIx0w4cdSthXUuaLwIRl7684DPUT+pZhgy7M9v+Y
         RGLw==
X-Gm-Message-State: AFqh2kqgYZaFZpfqrm6+hpfxoa+sXTKwxuFOYwpfyZs3Vhovw30Ysz3p
        K1aqLEwFCem4EYS5jgQqHvo=
X-Google-Smtp-Source: AMrXdXsY1D0a1mOEI9CoFoa0Ej9Gi0Ta6xKnsbFVmD1NRmmMHKQ+n3Xt16UzUvQgNOUgwEYk0+o10g==
X-Received: by 2002:a05:6a00:7c4:b0:58a:f300:42c9 with SMTP id n4-20020a056a0007c400b0058af30042c9mr26754879pfu.22.1674574681612;
        Tue, 24 Jan 2023 07:38:01 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w1-20020aa79541000000b00580fb018e4bsm1711255pfq.211.2023.01.24.07.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 07:38:01 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] gitk: prevent overly long command lines
References: <pull.1469.git.1674559397.gitgitgadget@gmail.com>
        <89fe0380cd3a373e7e23d663b506466fd6cb5fb6.1674559397.git.gitgitgadget@gmail.com>
Date:   Tue, 24 Jan 2023 07:38:01 -0800
In-Reply-To: <89fe0380cd3a373e7e23d663b506466fd6cb5fb6.1674559397.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 24 Jan 2023
        11:23:16 +0000")
Message-ID: <xmqqv8kwhrja.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> To avoid running into command line limitations, some of Git's commands
> support the `--stdin` option.
>
> Let's use exactly this option in the three rev-list/log invocations in
> gitk that would otherwise possibly run the danger of trying to invoke a
> too-long command line.

Makes perfect sense.  I do not know the point of saying exactly
here, though.

> While it is easy to redirect either stdin or stdout in Tcl/Tk scripts,
> what we need here is both. We need to capture the output, yet we also
> need to pipe in the revs/files arguments via stdin (because stdin does
> not have any limit, unlike the command line). To help this, we use the
> neat Tcl feature where you can capture stdout and at the same time feed
> a fixed string as stdin to the spawned process.

Nice, so this is not about "we may have too many args to fit in
our memory", but about "we may have too many args for system to
spawn the subprocess with".

> One non-obvious aspect about this change is that the `--stdin` option
> allows to specify revs, the double-dash, and files, but *no* other
> options such as `--not`.

It sounds like a design mistake, which may want to be fixed, but of
course gitk cannot depend on Git it runs with having such a fix, and
use of "^" prefix is a good alternative (after all, "--not" was
invented to save us writing ^ in front of many revs).

Good.

