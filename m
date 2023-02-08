Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57022C636CC
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 17:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBHRAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 12:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjBHRAV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 12:00:21 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4BA4DE2A
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 09:00:18 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id u9so379506plr.9
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 09:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DawJSqswu/0VRCmOWQLVoJlw1lM81SOFMS2B7ELBxiE=;
        b=UrFc+wQtPvOxWf4Q6kvrVRYbcuLibj2rOa9ETsIwhVkagpoqQX3VYp8StBYPHf2M3q
         QZE2ESMj6lmHBcHX6ycfQowYMXIEuSBEuE2++7qYP2+Tb0tRFMs8i4qNtddA0JUPcNBK
         0rk5MfA8ZK6Sh6dxlsYZH6XXCMyK4Q8I55hiNcYVcmwIifRwGUz6JiD2qcNSajFU5ANm
         vLE0+7eTXEfFVH80fjAFYVSKVrRgb+yhi+aHfOkQCmKn3nLb6Q9KjgdAKX6G146rbUtz
         vPDqtmlOns0Fp0ipRnz94MtEJ4CxHatumdxeaH3ZNOh7cTggx+49Z+cR5vrROb3P8Oha
         Pkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DawJSqswu/0VRCmOWQLVoJlw1lM81SOFMS2B7ELBxiE=;
        b=i6lPVg2q55F3EyNgvfYV3mS2ICs4dChSiTGZCMcQZYBIb/SCIfPzdbuGxTXT8Qsidm
         iJ8tYY7TsJj1ysMKN6G7Dhg97XuImRGg1aGU1MLCq34iajCuaSUVka4y3+E3JoTzBVeR
         CZ8cfdtJ2kQMaZ+dzVpD2TK3HN2JiGyzglB4ELTcW8+RYPOF9MsucvB8Qm8RSqZm75lc
         BwlSLMlYKElsqwf5OzmJLFmqyUAVQtkK+3Hw4KjQpxyA6FQJc8XvTe04O4/EdeRiABk7
         NTK2RW9BPfKln+HamV004pc7TbkEAob10TQVcwuHSD3hZE0bC8/wvhmlKMl/1Na6VDUr
         iEMw==
X-Gm-Message-State: AO0yUKVbHZAA7zE+paDpSeucBB1hh29W3VUWpjHugH1C5RIB89k7luiN
        pVGbeeafGQWhNd85QoEi4Ns=
X-Google-Smtp-Source: AK7set84N9BV/QLc61kcMHZ8w/jsv15fLMfX+zm/2Xoq9EsPMn9+guyDbD9XKp3XztqY6bR8JbULIQ==
X-Received: by 2002:a17:90b:4c47:b0:230:d37a:3e93 with SMTP id np7-20020a17090b4c4700b00230d37a3e93mr9691770pjb.5.1675875617971;
        Wed, 08 Feb 2023 09:00:17 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id o10-20020a17090a4b4a00b002308f09460fsm1789939pjl.26.2023.02.08.09.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 09:00:16 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Gautier <max.gautier@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: git rev-list fails to verify ssh-signed commits (but git log
 works)
References: <Y+PGRaiTTaZ/DtlJ@work-laptop-max>
Date:   Wed, 08 Feb 2023 09:00:16 -0800
In-Reply-To: <Y+PGRaiTTaZ/DtlJ@work-laptop-max> (Max Gautier's message of
        "Wed, 8 Feb 2023 16:56:53 +0100")
Message-ID: <xmqqfsbgt7mn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Gautier <max.gautier@redhat.com> writes:

> $ git rev-list @{u}..HEAD --format='%G? %H'
> commit 9497d347b048dbea7f527624f815f7926594c4bc
> error: gpg.ssh.allowedSignersFile needs to be configured and exist for ssh signature verification

"git rev-list" as a plumbing does not want to read in or be affected
by unnecessary configuration variables, so it uses
git_default_config() to read the barebones, unlike "git log" that
uses git_log_config() that calls, among other things,
git_gpg_config().

Untill "git rev-list" learns to inspect the --format string and
checks necessary configuration on-demand (e.g. presence of "%G"
signals the need to call git_gpg_config()), this is sort of
expected, unfortunately.

