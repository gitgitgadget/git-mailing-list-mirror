Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADACC433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 16:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EE512310E
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 16:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbhALQlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 11:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbhALQlU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 11:41:20 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DA1C061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 08:40:39 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id t16so4375039ejf.13
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 08:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=00+CMfJaAdA+xpy94iDoNns3L9wQV/OGhqJTF9gAdU8=;
        b=UD44LDdkLRvW5crzWOvob6Dunk9+PFDUphgpA03KaLJ6owvhXYgrSporrTsm5+o4SJ
         We6hU/+Xbd9r0wLvaNh1V5oblArVMSdOAmgtz51LvdPtGP4b45Ix2TsW8EtL+3w7WziY
         ktOOHhY1jpC7njFFgQVT1K/fCtXtZAAQjowftR+ybeA1dt+bKNBBsLfVhRGtMgnToNeN
         JhW3zKb9l2u10L85EA9/4gFkxWekPO3l5iC3PiH+vVpnpLDRHZkuyMsLeXWCOjOv4/nG
         1tzIPWEbnE+KvEPmVNQOApcRHdjF5mpQwdY3wYA0y9hrBXAOVlRnWnz9Cu/nMIB12+8m
         5DHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=00+CMfJaAdA+xpy94iDoNns3L9wQV/OGhqJTF9gAdU8=;
        b=CctlJOUEl8d2ECdAaj2+9JOMQY0r6SwD/FdQbNeRF5rdIyNWR4+XkSeUziENLPwr2P
         9IvuRD/nN0MRoo+U99SKFBvsDCFtUJyVxeL0V7rz089Uqbd1278PQ/WqY/O0cRRSlygS
         CRInGiWtTXi0Bt8FTkHRXAkVar2asgNMJatydM1Ua68/a30+AtFSFrCQQtObF/E8sWab
         udcY/Zqih6Q4pnSHqjyfWCBvB23AUHn3nU8al4xsPTWQ8VniaecGxN3Mz6oQZcwU2Db9
         2lozLEpSOjFqYKX5lgVHmfdR4o/PFLimhUVcgyycy56DyT7qn1mcj9wZ3L1CvyDD7b/b
         NMtw==
X-Gm-Message-State: AOAM533hfe6j3tARLJoYZeHzgAfu0OkSHLIATAjwRBFiRz1KsEs0YBKp
        2fVY6YItwbrE7l8Hpl3xcyEfanvuMck=
X-Google-Smtp-Source: ABdhPJwm1Fnles5Ugp+bn0pOZDd3dFWqnWfYRQOEF3xx6Gej9hiOeI35g6Im4e8TuWZEPWstoKfAcg==
X-Received: by 2002:a17:906:4a14:: with SMTP id w20mr1477287eju.192.1610469638353;
        Tue, 12 Jan 2021 08:40:38 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id hr31sm364517ejc.125.2021.01.12.08.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 08:40:37 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 05/10] simple-ipc: design documentation for new IPC
 mechanism
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <7064c5e9ffa0e3e666ea6d146b0839680952757d.1610465493.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <7064c5e9ffa0e3e666ea6d146b0839680952757d.1610465493.git.gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 17:40:36 +0100
Message-ID: <87eeiq5csb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 12 2021, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Brief design documentation for new IPC mechanism allowing
> foreground Git client to talk with an existing daemon process
> at a known location using a named pipe or unix domain socket.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  Documentation/technical/api-simple-ipc.txt | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/technical/api-simple-ipc.txt
>
> diff --git a/Documentation/technical/api-simple-ipc.txt b/Documentation/technical/api-simple-ipc.txt
> new file mode 100644
> index 00000000000..920994a69d3
> --- /dev/null
> +++ b/Documentation/technical/api-simple-ipc.txt
> @@ -0,0 +1,31 @@
> +simple-ipc API
> +==============
> +
> +The simple-ipc API is used to send an IPC message and response between
> +a (presumably) foreground Git client process to a background server or
> +daemon process.  The server process must already be running.  Multiple
> +client processes can simultaneously communicate with the server
> +process.
> +
> +Communication occurs over a named pipe on Windows and a Unix domain
> +socket on other platforms.  Clients and the server rendezvous at a
> +previously agreed-to application-specific pathname (which is outside
> +the scope of this design).
> +
> +This IPC mechanism differs from the existing `sub-process.c` model
> +(Documentation/technical/long-running-process-protocol.txt) and used
> +by applications like Git-LFS because the server is assumed to be very

s/to be very long running/to be a long running/, or at least "s/to be
very/to be a very/.

> +long running system service.  In contrast, a "sub-process model process"
> +is started with the foreground process and exits when the foreground
> +process terminates.  How the server is started is also outside the
> +scope of the IPC mechanism.
> +
> +The IPC protocol consists of a single request message from the client and
> +an optional request message from the server.  For simplicity, pkt-line
> +routines are used to hide chunking and buffering concerns.  Each side
> +terminates their message with a flush packet.
> +(Documentation/technical/protocol-common.txt)
> +
> +The actual format of the client and server messages is application
> +specific.  The IPC layer transmits and receives an opaque buffer without
> +any concern for the content within.

