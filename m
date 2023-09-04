Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72358C83F33
	for <git@archiver.kernel.org>; Mon,  4 Sep 2023 12:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345383AbjIDM44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Sep 2023 08:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbjIDM4z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2023 08:56:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723D8CD0
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 05:56:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-402d0eda361so6126935e9.0
        for <git@vger.kernel.org>; Mon, 04 Sep 2023 05:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693832209; x=1694437009; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4IVmY4W5yEu817EGhCKojaNhFNxGujGKNp3UWxi0CyU=;
        b=bVC5qtvb998DI2aVcO58lHPnhIC+CpA5m4yFSeMiyzxa60g0GfsIp9xUMYP2cE0Kv0
         YUvD/M0c+klNgEgRQXHA8PhlmKq+zP9+Hc79wfArIZd6XllUVox7SzqlHYD7dR0B+w33
         I3FYTjlnoGHpouq7hCxJPvsrS2FYFaTIK9Q/NZOHf3qNZFyST9m8a3bqpCascMUZNxfZ
         dbQajedoJB13uoSovODhyvuTWH8zxs9e488hLae3Ps4pCzOSq+W3NxgrcX0W/hVnvgS6
         tq2VQx/RGCMpCYUM03UUW/YH7Ascxao1b7LsNrqYNfVyg/B0mxWAOb0Xx2LGz8ZDZ+O5
         66hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693832209; x=1694437009;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4IVmY4W5yEu817EGhCKojaNhFNxGujGKNp3UWxi0CyU=;
        b=BsOdpQn6hJoGDQl5Cgoirc4e4S5VAjFPpTA5dTB+/UgrzyHWjbdbPK6u3yT6Ckb80j
         pxXCwxJQ4GuzRhUblTi3vLEV90f2TZrXuudYM5HA6/A5ECa7MC3G7wJVb7hbhfkcrlhS
         piPjsKcyjpt6uM9a6dCw6CeoD0xmkrbbRDSXPqVsp++CzOT6/dRz9DHh0/UCuhSkTckm
         BQ6lK0dY7e1GyQdVUfC98QNAQLOiWcR1nNyq/H7LyhmpqMv+BthKh/0hRn+AlG8rzPxv
         IdlsDmqW5O6KEs9QsVr/LwE6UQWGxAf1EQ5/g0h/m9alvdfqWN8A9wxTp5LlsJNPiQ11
         1jQQ==
X-Gm-Message-State: AOJu0YxeFv0rqLzGvy5QxVd8J8pTC88QQ+f1utsU0oD77fTxUuweXPNO
        if7t2JeE96YZ1RW/9QfEoWZtiMSuuUFrCA==
X-Google-Smtp-Source: AGHT+IGwYrIapcxUJis0wHEsVuw43pC1ERXiXmfiAKyBRGYHHT4W7BHdF/7ba5ppfNf13UG3bWbJ8g==
X-Received: by 2002:a7b:cbd1:0:b0:3fe:18a3:b3c with SMTP id n17-20020a7bcbd1000000b003fe18a30b3cmr7915458wmi.12.1693832209434;
        Mon, 04 Sep 2023 05:56:49 -0700 (PDT)
Received: from smtpclient.apple ([88.212.39.71])
        by smtp.gmail.com with ESMTPSA id y23-20020a7bcd97000000b003fbc9d178a8sm17368954wmj.4.2023.09.04.05.56.48
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Sep 2023 05:56:49 -0700 (PDT)
From:   =?utf-8?Q?Radovan_Halu=C5=A1ka?= <radovan.haluska1@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Potential bug in `git checkout --quiet`
Message-Id: <9419E14B-5933-4773-B1BA-899A7DA75D96@gmail.com>
Date:   Mon, 4 Sep 2023 14:56:37 +0200
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3731.600.7)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I believe I have found a bug in the `git checkout =E2=80=94quiet` =
command. Below, you can find the output of `git bugreport`. Thank you

Best,
Radovan Haluska

=E2=80=94=E2=80=94

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

```
git clone --quiet --branch master --depth 1 --no-checkout --filter =
blob:none \
    git@github.com:acatai/Strategy-Card-Game-AI-Competition.git =
locm-agents
cd locm-agents
git sparse-checkout set --no-cone
git sparse-checkout add 'contest-2022-08-COG/ByteRL'
git checkout --quiet
```

What did you expect to happen? (Expected behavior)

I expected to receive no output from any of the commands above.

What happened instead? (Actual behavior)

I received an output from the last command even though the `--quiet` =
switch was specified

What's different between what you expected and what actually happened?

This shouldn't have been printed on the screen:

'''
remote: Enumerating objects: 28, done.
remote: Counting objects: 100% (28/28), done.
remote: Compressing objects: 100% (27/27), done.
remote: Total 28 (delta 0), reused 25 (delta 0), pack-reused 0
Receiving objects: 100% (28/28), 31.40 MiB | 4.94 MiB/s, done.
'''

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.42.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.5.0 Darwin Kernel Version 22.5.0: Mon Apr 24 20:51:50 =
PDT 2023; root:xnu-8796.121.2~5/RELEASE_X86_64 x86_64
compiler info: clang: 14.0.3 (clang-1403.0.22.14.1)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
not run from a git repository - no hooks to show

