Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50362ECAAD2
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 21:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiIAVQC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 17:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiIAVQA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 17:16:00 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2A56BCCE
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 14:15:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id q7so553233lfu.5
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 14:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingy-net.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=/HvMiKtHY2gp50MuTzHDVKTstReXHgzullK7rsaRhcs=;
        b=xz6iNayMWk1SHpGGR1Cku7phXtMfCDWef3V9ogKK7nzdEZv1zq8X/VjbbVyGYJmyn3
         vnb0fQGnMaIGvUTsnFNUaVHPxiMWkqhpOrXL8+qXQfc8N2kqA0L4MWYpYiHK6SZXSpU8
         2fUGZC98p1GwaBEkZ1r9PJ3En+KrY20ietvyMZbZG1k5FAZpzJBPD4mybna6X1xMOhLh
         HlWyv7T5abkbtjAeaNS3b+Mkc31Vye99S53Q+cXq5+aXK8MhTgsHKym52LkZuf/Bazmf
         EIeFfCxmdsR1MrV3st5LBIOlV6uYyfTreigEiXTfMUpVScIA5BjkwhdYkSNJPln7qg0S
         zZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=/HvMiKtHY2gp50MuTzHDVKTstReXHgzullK7rsaRhcs=;
        b=4AO1q5qz1JyrOAviwXCl39n30l439rhbSTQ8QG7zwPQngaAEC9Wv7SnngohBWvFpeZ
         7qtT1FK+6kMfuErPeg4qPqhmGsq2p6ex/BIvl7/+Wad+FHB+633KXCVO4DWQukQm43q9
         Q3UB8bh6K29cWTOSMJitf+Q6gsFPsGkL+Pj7LFHieVrOXU6rglJfpxIzY2S4Efc59FLm
         2NtmxcVvkLPNXo+rgqwMcOJRxR7/km40iFHp/dZFaatz7r67qmf/s9PfIjGxlRXWx+kL
         +JSNdfW+HPjNVC/3scdYIf8rxxpF8t9Trl6WCM8gNQFlF93VhaeHA/1Zd3kdwWaY/Gcb
         hadA==
X-Gm-Message-State: ACgBeo3bjJPVcCAMGRsTKtDosJjKkHHB7QSzJzAh++3TpW4coQrwjqx+
        gjuLBJnonz7tUDfpEO4dbdWYk1s7600I8HfPb3+7eHtYTcNjkQ==
X-Google-Smtp-Source: AA6agR5bWD8vLvkuZhPa+UMhjt6wD0LUu8ACxsbulyyUnW5heaMSfbiG5wlbcudkVMPtPAeOg8mcK7wvX2jTx+Nwo1Q=
X-Received: by 2002:a05:6512:b24:b0:491:10ba:3283 with SMTP id
 w36-20020a0565120b2400b0049110ba3283mr10509192lfu.566.1662066957638; Thu, 01
 Sep 2022 14:15:57 -0700 (PDT)
MIME-Version: 1.0
From:   Ingy dot Net <ingy@ingy.net>
Date:   Thu, 1 Sep 2022 14:15:46 -0700
Message-ID: <CAHJtQJ4uJc2_upHvc-SWVpA3OX2Lpu-XspswGTTDLgXWjG-Gew@mail.gmail.com>
Subject: [BUG] git crashes on simple rev-parse incantation
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ git --version
git version 2.34.1
$ uname -a
Linux zed 5.15.0-48-generic #54-Ubuntu SMP Fri Aug 26 13:26:29 UTC
2022 x86_64 x86_64 x86_64 GNU/Linux

I get:

$ git rev-parse --parseopt -- <<<$'x\n--\n=, x\n'
fatal: Out of memory, malloc failed (tried to allocate
18446744073709551615 bytes)

----
Here's a less cryptic that fails the same way:

OPTS_SPEC="\
some-command [<options>] <args>...

some-command does foo and bar!
--
h,help    show the help
=,equal   nooooooooooooo!
"

echo "$OPTS_SPEC" |
  git rev-parse --parseopt --

----
'=' as a short form in the opts spec seems to be the culprit.

I was trying to see what short options could be parsed like '-9',
'-_', '-+', etc.

In addition to '=', '!' and '*' also cause crashes.
I tested all the other ascii punctuation and didn't see crashes.
