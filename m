Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF08EC433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7611D22525
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgLVADF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgLVADF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:03:05 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F68C0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:25 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id k17so5823552pfu.21
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=jw9XRA0ihdsb0kkoV+3I05rCVEETrxXCurgFE4jZ2wU=;
        b=Z4Dll/82iaFFUdRXyCfxKCGz/ud2/AChGrI4BvZRn76+xRgAJhavOwL9gf91gXUuN9
         CyYIA5N9kJXhEkFRno5MllSZzfDcutCPHJlysBUyrejIRfNoEiDv413n0S9ihKajaadi
         JANDC+sfYaXoX9+IIH9Ie9nRPb9iCBQiIBezlYdwc+g4Er28tmDYS7KyHg703mVwGZzH
         htTDNGig9x3/jiGvzgic7MlRn5ON+kCIfmvI7s4/BH7vc+pNMEHQpeteih5nWLCDhlKB
         U9UwzPWAhHGHiweLKiiwLS+hMhkqhQ6Ky4RdDbSjfrngu8YdTkqxtK7RJ3vgTH+8Y0US
         3LiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :subject:from:to:cc;
        bh=jw9XRA0ihdsb0kkoV+3I05rCVEETrxXCurgFE4jZ2wU=;
        b=Hk1CmuJ+KqlGIzER7dhTS1FFlGC7LmXfwFYIKoZQgupZkAC81h9Vp5z5CcIg0ic3tO
         p8Wjyhw747gecMm+/EMgf9RA2PiDhPI1sPpPh4Wf8zX0wdyWuVlEQJ6sTbLT6BUoQC8+
         +HU4gohP/vEkMuTIKEdVu+J/J5aCZEwBuvirpIbfXW7XhvEy3xU6O2+YxhrliQgItrbh
         6l+AlnoYdwKbH0OmOPTDAm/YvEKPPm9OR6paKKtlaCb1bbECU3F5AOZa5TlpjeZPR+EB
         PPJYR+adM05sez4fX4AdzPz2uWr1fTzp3etwnOE6EdSo/m1B04UDbLzsX2mlg6KEsoex
         z9uw==
X-Gm-Message-State: AOAM530G5EAKAEnB/lvmQr+ayRrvndIZZW6tnOfOBFVIsgfNVVVkVSSo
        zjOL2MTvb4J5hUfeA4ZNB+lMFU/uWeFsZEzZCujuvGrIMf4g7v8XfejImtG0bu6HR9A7oIgoDWF
        BlqnBQhlxkDZRMoVTE32n26dXsOxNoPn+WZQYhk2eIWZJOk+1bZi18jx3xjLDC+r6kXQxJROaAQ
        ==
X-Google-Smtp-Source: ABdhPJwKz/3YnNys4axAatnxm66ba4k5e61u6ruU9a5A6Qz4eB+QdwSH34fK2cKBETDPRDFEczuXvK+FRQ7cYbcMWbk=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a17:902:5985:b029:da:c737:5842 with
 SMTP id p5-20020a1709025985b02900dac7375842mr18049948pli.21.1608595344343;
 Mon, 21 Dec 2020 16:02:24 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:02:03 -0800
In-Reply-To: <20201205014607.1464119-1-emilyshaffer@google.com>
Message-Id: <20201222000220.1491091-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v7 00/17] propose config-based hooks (part I)
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since v6:

 - Converted 'enum hookdir_opt' to UPPER_SNAKE
 - Coccinelle fix in the hook destructor
 - Fixed a bug where builtin/hook.c wasn't running the default git config setup
   and therefore missed hooks in core.hooksPath when it was set. (These hooks
   would still run except when invoked by 'git hook run' as the config was
   called by the processes which invoked the hook library.)

CI run: https://github.com/nasamuffin/git/actions/runs/436864964

Thanks!
 - Emily

Emily Shaffer (17):
  doc: propose hooks managed by the config
  hook: scaffolding for git-hook subcommand
  hook: add list command
  hook: include hookdir hook in list
  hook: respect hook.runHookDir
  hook: implement hookcmd.<name>.skip
  parse-options: parse into strvec
  hook: add 'run' subcommand
  hook: replace find_hook() with hook_exists()
  hook: support passing stdin to hooks
  run-command: allow stdin for run_processes_parallel
  hook: allow parallel hook execution
  hook: allow specifying working directory for hooks
  run-command: add stdin callback for parallelization
  hook: provide stdin by string_list or callback
  run-command: allow capturing of collated output
  hooks: allow callers to capture output

 .gitignore                                    |   1 +
 Documentation/Makefile                        |   1 +
 Documentation/config/hook.txt                 |  19 +
 Documentation/git-hook.txt                    | 117 +++++
 Documentation/technical/api-parse-options.txt |   5 +
 .../technical/config-based-hooks.txt          | 355 +++++++++++++++
 Makefile                                      |   2 +
 builtin.h                                     |   1 +
 builtin/bugreport.c                           |   4 +-
 builtin/fetch.c                               |   1 +
 builtin/hook.c                                | 176 ++++++++
 builtin/submodule--helper.c                   |   2 +-
 command-list.txt                              |   1 +
 git.c                                         |   1 +
 hook.c                                        | 416 ++++++++++++++++++
 hook.h                                        | 154 +++++++
 parse-options-cb.c                            |  16 +
 parse-options.h                               |   4 +
 run-command.c                                 |  85 +++-
 run-command.h                                 |  31 ++
 submodule.c                                   |   1 +
 t/helper/test-run-command.c                   |  46 +-
 t/t0061-run-command.sh                        |  37 ++
 t/t1360-config-based-hooks.sh                 | 256 +++++++++++
 24 files changed, 1717 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/config/hook.txt
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 Documentation/technical/config-based-hooks.txt
 create mode 100644 builtin/hook.c
 create mode 100644 hook.c
 create mode 100644 hook.h
 create mode 100755 t/t1360-config-based-hooks.sh

-- 
2.28.0.rc0.142.g3c755180ce-goog

