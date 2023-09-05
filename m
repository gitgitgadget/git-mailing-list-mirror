Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CA1CA0FFF
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 19:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241622AbjIETID (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 15:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241620AbjIETIC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 15:08:02 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65E69F
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 12:07:32 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68bed2c786eso1922534b3a.0
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 12:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693940801; x=1694545601; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L9G4lJHNJRCMkqHJXhj+rP/1SboK06GBw+jpieoSgDU=;
        b=oirvodon23tcvPcWmDkPN08mRMoSTaoHpCUviJtzvHZ7WaCFQvIPrYmYaj7ddQJuWs
         6bIAx0cc6ZjcO/MFKFFg6yHwcaLlXADetRgNLZbcPCqec26jqvcti5QcNsPsn68wqwUn
         OvJqLi8LidksZ6//9GNjH6mNhffJPUTY+b8+XoL/bdaC9c+4cW76I29bCMgYmMq4Pjq/
         mbaOggeDvlfzbJYYr77689qzjdBCI1MGD2VTJURPo+3YB+GFh4j+H0ChpzMRnfcdkCBC
         IWREIt7R8pto1A0atcZ4rSy4gZsQP1xT/Ekdz9Tq8Zhs6knSs54vXJq0LwOMxC4WTdeR
         H4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693940801; x=1694545601;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L9G4lJHNJRCMkqHJXhj+rP/1SboK06GBw+jpieoSgDU=;
        b=SWNBio42drJhURqc4nEG9Dpx4CADWtlhi/a206e5tqrCgrjfDqPcgJls8BTcnbO9KP
         oyasAeq8xV21Vw2N9o0/C5tLffquEkXk1mlkKvdvRyfgiOrSwhNO5LAa/f2uPRB/J45c
         dRoH06xYcYVoT6ZOwKmJ2Rt9LZWeINBg+mTJZqjY867WidcnfUZ46JuvQGjFVXwFQzgK
         h7/RKYoQ8/v5rTiDiFBx+R7b5gCFCjWqDKzmp7z6md3Ns7twuu9g1r8y6Iv/4KbFugbA
         w+3EXzbjXe6VW+QMt59Ew4C9uwuEbWw86tyVSRhC5UqCenaGlsD8ZBHmoJimrcWYRh/r
         gU3Q==
X-Gm-Message-State: AOJu0YxLAZPrrvyk3TuZ5jCpeuPxuvq2u0sdxJUVqNwciut0SRGRpxET
        rsFQTP4L2wWEO2VfUMLNfppucJjL+L6qjLqKeuM7od+0l8g=
X-Google-Smtp-Source: AGHT+IE0U9NqpT87aNa8t3vY+SCqmtAsXAP2m0V0Juy4R3BOTF2XbHq3CC5J+j9HutsiXwrz6gWdh4kWKEPytbdPekA=
X-Received: by 2002:a05:6a20:142:b0:14b:dd4e:bd7f with SMTP id
 2-20020a056a20014200b0014bdd4ebd7fmr11302228pzs.4.1693940801163; Tue, 05 Sep
 2023 12:06:41 -0700 (PDT)
MIME-Version: 1.0
From:   Max Amelchenko <maxamel2002@gmail.com>
Date:   Tue, 5 Sep 2023 22:06:27 +0300
Message-ID: <CAN47KsVqamQgFT6sNS=C3Mz=aHEeaRYCYDrkFp3YgZUkSNYzqw@mail.gmail.com>
Subject: git clone command leaves orphaned ssh process on system
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

Run the command:
ps aux
Observe no ssh processes running on system.

Run git clone against a non-existent hostname:
git clone -v --depth=1 -b 3.23.66
ssh://*****@*****lab-prod.server.sim.cloud/terraform/modules/aws-eks
/tmp/dest
Observe the command fails with:

Could not resolve hostname *****lab-prod.server.sim.cloud: Name or
service not known

Run:
ps aux

Observe a defunct ssh process is left behind.


What did you expect to happen? (Expected behavior)
I expected the command to quit without leaving any processes behind.

What happened instead? (Actual behavior)
The command quit and left a defunct ssh process on the system.

What's different between what you expected and what actually happened?
I don't want zombie processes left after any git command (either failed or not).

Anything else you want to add:
These processes are zombie orphaned, meaning we're stuck with them
until system reboot (which is bad).

Please review the rest of the bug report below.

You can delete any lines you don't wish to share.



[System Info]

git version:

git version 2.40.1

cpu: aarch64

no commit associated with this build

sizeof-long: 8

sizeof-size_t: 8

shell-path: /bin/sh

compiler info: gnuc: 7.3

libc info: glibc: 2.26

$SHELL (typically, interactive shell): <unset>



[Enabled Hooks]

not run from a git repository - no hooks to show
