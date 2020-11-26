Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E3CC63777
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 20:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B077221E9
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 20:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLxgOxmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732101AbgKZUo5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 15:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731220AbgKZUo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 15:44:57 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19102C0613D4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 12:44:57 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id oq3so4621473ejb.7
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 12:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7CtRk1pJYwL+pKyexfoOBbhRdSC4LnsGVdJB1tm8QfE=;
        b=jLxgOxmT72QBVYIjhC2L1bnQRePF0RHKqSrxXiKomCKkKoa0izyUpG4orWLZTFBxAH
         UIlVOVveEVs9K7b/OTIiinWR46Ive04CsvMj+QmwAw4y8kAZl3l9ax3L4byR7RODADWx
         8DHLIT+w25ru45KkrLvP/ZwDmrQTHj9swPXfEtVG3VlfShCZRf79aG2aNv/WZsm1Fw4N
         Yh/yHuNcN4spiDZS67wxuXTmlJanQFyhxIZnvqIQoc9TXgnSXAsfUggHZ3wG5O8yZJXR
         z3oIyi2jLfEgjV28nIdSr3QcJd0mYCwGFRBoscy/l8I0rC3c9v1kMPjjBttwWHJ00yWF
         2XCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7CtRk1pJYwL+pKyexfoOBbhRdSC4LnsGVdJB1tm8QfE=;
        b=tiZcWCwJqXK4D15TPQ+VYz/Sygw5jhcdsB3f6VLwOaZy0+Y/9S5j2jPavK0hDfzODv
         8jz1Nck9crSnH3DCg+hKeyTneKD3p2AQ08l//lbCNh9SYDoBfnNJaGPuybEdzfATWlaI
         z6KnrpxIHZ77J08a99Zl9VKV5ogq2NOGfwq7DaQFACyKfiDYAa0OACBk3yWtb1ANQeeq
         jBKkXOZTyc9wRH+Mk61iKfDQdo2ivl3CX9XkAEVLMZiBRP9YMxEMrWBmWJ8mRNvzh2Gk
         52yhYbyffmTOhcxonNhlZPkVAZXgkkH3+v4N74k2vJmEBGRO1MPOiKbISFnnKebvpHp5
         P1KA==
X-Gm-Message-State: AOAM531xB+/EhQj9yRzbuocPn0H8vjHLTgbM3YU/zcxBOe19eJqbadrw
        XT0OkZEhGYM3a/R8aSJfPMD6AHskr2kwqU2h
X-Google-Smtp-Source: ABdhPJxcMOGNho8NV/ADs8+jSbm6vEoOzs3NWULXGI7tvUqRTqYhxJmccj97cXtqGtOBuxy+6gaSwA==
X-Received: by 2002:a17:906:174f:: with SMTP id d15mr4335807eje.15.1606423495397;
        Thu, 26 Nov 2020 12:44:55 -0800 (PST)
Received: from contrib-buster.auto1.local ([79.140.115.35])
        by smtp.gmail.com with ESMTPSA id d1sm3648689eje.82.2020.11.26.12.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 12:44:54 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v2 0/1] maintenance: Fix SEGFAULT when running outside of a repository 
Date:   Thu, 26 Nov 2020 20:41:40 +0000
Message-Id: <20201126204141.1438-1-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.29.2.367.g37477fb670
In-Reply-To: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com>
References: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In d7514f6ed5 (maintenance: take a lock on the objects directory, 2020-09-17) [1],
and 2fec604f8d (maintenance: add start/stop subcommands, 2020-09-11) [2] The
"git maintenance run" and "git maintenance start" was taught to hold a file-based
lock at the .git/maintenance.lock and .git/schedule.lock respectively because these
operations involves writing data into the .git/repository. 

The lock file path string is built using the the_repository->objects->odb->path,
in case the_repository->objects->odb is NULL when there is not repository available,
resulting in a SEGFAULT.

In order to reproduce the error, one can execute maintenance "run" and/or
"start" subcommand with a non valid repository: 

    $ git -C /tmp maintenance start
    Segmentation fault

    $ git -C /tmp maintenance run
    Segmentation fault

The above test was executed from a git built from commit: faefdd61ec (Sixth batch, 2020-11-18):

For reference here's the output from GDB when debugging the "start" command

	Program received signal SIGSEGV, Segmentation fault.
	0x00005555555b9b4c in maintenance_run_tasks (opts=0x7fffffffded4) at builtin/gc.c:1268
	1268		char *lock_path = xstrfmt("%s/maintenance", r->objects->odb->path);


Updates in v2
=============

  * Instead of implementing the check on the subcommands, a more robust approach
    is taken by replacing the "maintenance" command option to use RUN_SETUP
    instead of RUN_SETUP_GENTLY as suggested by Derrick Stolee in [3] as part of
    review cycle from v1.

    This provides protection for all maintenance subcommands given that
    currently all the commands are required to be executed inside a repository.

  * As the RUN_SETUP will enable protection to all commands, the checks in
    maintenance_register() and maintenance_unregister() are removed as they
    are not required anymore.

  * Use the "nongit" helper function for testing it instead of relying on the
    `/tmp` directory for a non valid git repository as suggested by
    SZEDER Gábor and Eric Sunshine in [4].

  * All "git maintenance" subcommands are included on the test to ensure the
   behaviour is consistent for all subcommands. In particular the "register"
   command that current exists without a message and code 0 which will be
   changed by this patch to fail when running outside of a repository. 

   It also worth noting that "register" command does not exists in a released
   version of Git as mentioned in [5] which make it easier for changing the
   current behaviour of the command

[1] https://lore.kernel.org/git/1a0a3eebb825ac3eabfdd86f82ed7ef6abb454c5.1600366313.git.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/5194f6b1facbd14cc17eea0337c0cc397a2a51fc.1602782524.git.gitgitgadget@gmail.com/
[3] https://lore.kernel.org/git/1bfd84da-5b74-be10-fc2c-dee80111ee2d@gmail.com/
[4] https://lore.kernel.org/git/20201124191407.GC8396@szeder.dev/
[5] https://lore.kernel.org/git/54fa678c-7150-8c48-50e5-b33923a69249@gmail.com/

Thanks everyone for the insightful and helpful feedback.

Rafael Silva (1):
  maintenance: fix SEGFAULT when no repository

 builtin/gc.c           | 7 -------
 git.c                  | 2 +-
 t/t7900-maintenance.sh | 8 ++++++++
 3 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.29.2.367.g37477fb670

