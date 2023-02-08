Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7E1C64EC4
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 19:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjBHTVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 14:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjBHTVi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 14:21:38 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0764751C60
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 11:21:35 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id u22so9073542ejj.10
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 11:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PUBfvuIzd7k7ptRnCsNfZ1jVrcGdlPfvuY+L6uhSyE=;
        b=Nz+Q1Fq3qs4082GGicIKkptD9Aw6TMbm+St8z7hXwUYbAxnZYC0ayHExfVGft+hfLr
         0cj1uUKXZ9Vj93rLNDwYd5xr2mOjn04kF/SFNo7W22cFh1Dza/5f5up5hnjMyyYjkrgB
         +bWqyAdhc9iXFz0ZClQ2GcoX68Yrn5qtL4LBvaF1ZBNZ0AQmMgpQRMuByH2XujQTyJos
         PuJcBE5laBsFvVTdt/71/ZggMQWyjnHW0vUTpkMp3qLYVsZ7TKqIZTGuaEeY0wqHmCrm
         YXTgRs3t9nSXaBx+c2Al7Xv23oyNK7s98vCZ+r+EVDuhuhtDZQYktAzJx8XxarXLN0zV
         lMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PUBfvuIzd7k7ptRnCsNfZ1jVrcGdlPfvuY+L6uhSyE=;
        b=LIWtbvfKus5bT7//WDYaPwQ5vG9ztf1lJLjkPGDH/JxwLFABCerXI8GTU+QY3JkZGe
         CjWebqP0tMyHmu3PGGirW7bhmRdMnOZuacUQ1UU9xSmYdP8W49dz993gxeq6Ubo3xYlI
         mahqw8Ciqw6oxy/hNLCtw6fqNoabQMrLn8+IKnSh8H7O/nl5lpvTP5G2EhNZ//0/sxYQ
         sEes2xTGZ0IFGr2lTvkbZsRo1swxraVWn2Q9f/knnzqbkuYQQaAPSngfC32UizCMOdSy
         XPTPicILuJNd8cWwpZWoEcfaI2ByQZOJcQR3kwq1rxL+hBraRP3MEMdWatV+5KI62Czi
         6N/A==
X-Gm-Message-State: AO0yUKXyHa6jsl+zfAf9kKSGudauYGRXDwM1fMhhD+ndZofGplpMttv6
        /tk9MuqSmv80AGqkKr3vC0bq6hd+aOmMHLXz
X-Google-Smtp-Source: AK7set98NfotZlH62FAoydt9eNW2WOgRoz6hltVWHM3tc5aWZNdU1uUmmKKUKvP+guInmNIDFvCD7w==
X-Received: by 2002:a17:906:a0c:b0:87b:db29:61af with SMTP id w12-20020a1709060a0c00b0087bdb2961afmr8888938ejf.24.1675884093089;
        Wed, 08 Feb 2023 11:21:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e15-20020a1709062c0f00b008964fdd5bbfsm6244227ejh.155.2023.02.08.11.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 11:21:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/5] hook API: support stdin, convert post-rewrite
Date:   Wed,  8 Feb 2023 20:21:10 +0100
Message-Id: <cover-v2-0.5-00000000000-20230208T191924Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1475.gc2542cdc5ef
In-Reply-To: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

BEGIN UPDATE

I sent this v2 in already as [0]; but didn't fill in the
In-Reply-Header, consequently it was disconnected from the v1 thread,
and per https://lore.kernel.org/git/xmqqr0v7o0pp.fsf@gitster.g/ (and
in "seen") hasn't been picked up. Sorry about that.

END UPDATE

As noted in the v1[1] this is the initial part of the greater
"config-based hooks" topic. I believe this iteration addresses all
comments on v1. Changes since then:

* Remove a couple of paragraphs in 1/4 that aren't relevant anymore,
  an already-landed topic addressed those.

* Don't needlessly change "cp->no_stdin = 1" and introduce an
  "else". This refactoring was there because that code eventually
  changes in the full "config-based hooks" topic, but going through
  those future changes I found that it wasn't for a good reason there
  either. We can just keep the "no_stdin = 1" by default, and have
  specific cases override that.

* Elaborate on why we're not converting the last "post-rewrite" hook
  here.

* Mention the future expected use for sendemail-validate in 5/5

The (passing) CI & topic branch for this is at[2].

0. https://lore.kernel.org/git/cover-v2-0.5-00000000000-20230203T104319Z-avarab@gmail.com/
1. https://lore.kernel.org/git/cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com/
2. https://github.com/avar/git/tree/es-avar/config-based-hooks-the-beginning-2

Emily Shaffer (4):
  run-command: allow stdin for run_processes_parallel
  hook API: support passing stdin to hooks, convert am's 'post-rewrite'
  sequencer: use the new hook API for the simpler "post-rewrite" call
  hook: support a --to-stdin=<path> option

Ævar Arnfjörð Bjarmason (1):
  run-command.c: remove dead assignment in while-loop

 Documentation/git-hook.txt |  7 ++++++-
 builtin/am.c               | 20 ++++----------------
 builtin/hook.c             |  4 +++-
 hook.c                     |  5 +++++
 hook.h                     |  5 +++++
 run-command.c              | 13 +++++++++----
 sequencer.c                | 18 ++++--------------
 t/t1800-hook.sh            | 18 ++++++++++++++++++
 8 files changed, 54 insertions(+), 36 deletions(-)

Range-diff against v1:
1:  351c6a55a41 ! 1:  488b24e1c98 run-command.c: remove dead assignment in while-loop
    @@ Commit message
     
         Remove code that's been unused since it was added in
         c553c72eed6 (run-command: add an asynchronous parallel child
    -    processor, 2015-12-15), the next use of "i" in this function is:
    -
    -            for (i = 0; ...
    -
    -    So we'll always clobber the "i" that's set here. Presumably the "i"
    -    assignment is an artifact of WIP code that made it into our tree.
    -
    -    A subsequent commit will need to adjust the type of the "i" variable
    -    in the otherwise unrelated for-loop, which is why this is being
    -    removed now.
    +    processor, 2015-12-15).
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
2:  81eef2f60a0 = 2:  9a178577dcc run-command: allow stdin for run_processes_parallel
3:  c6b9b69c516 ! 3:  3d3dd6b900a hook API: support passing stdin to hooks, convert am's 'post-rewrite'
    @@ builtin/am.c: static int run_applypatch_msg_hook(struct am_state *state)
     
      ## hook.c ##
     @@ hook.c: static int pick_next_hook(struct child_process *cp,
    - 	if (!hook_path)
    - 		return 0;
      
    --	cp->no_stdin = 1;
    + 	cp->no_stdin = 1;
      	strvec_pushv(&cp->env, hook_cb->options->env.v);
     +	/* reopen the file for stdin; run_command closes it. */
     +	if (hook_cb->options->path_to_stdin) {
     +		cp->no_stdin = 0;
     +		cp->in = xopen(hook_cb->options->path_to_stdin, O_RDONLY);
    -+	} else {
    -+		cp->no_stdin = 1;
     +	}
      	cp->stdout_to_stderr = 1;
      	cp->trace2_hook_name = hook_cb->hook_name;
4:  7a55c95f60f ! 4:  b96522d593f sequencer: use the new hook API for the simpler "post-rewrite" call
    @@ Commit message
     
         This leaves the more complex "post-rewrite" invocation added in
         a87a6f3c98e (commit: move post-rewrite code to libgit, 2017-11-17)
    -    here in sequencer.c unconverted. That'll be done in a subsequent
    -    commit.
    +    here in sequencer.c unconverted.
    +
    +    Here we can pass in a file's via the "in" file descriptor, in that
    +    case we don't have a file, but will need to write_in_full() to an "in"
    +    provide by the API. Support for that will be added to the hook API in
    +    the future, but we're not there yet.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
5:  cb9ef7a89c4 ! 5:  b4e02f41194 hook: support a --to-stdin=<path> option for testing
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
     
      ## Commit message ##
    -    hook: support a --to-stdin=<path> option for testing
    +    hook: support a --to-stdin=<path> option
     
         Expose the "path_to_stdin" API added in the preceding commit in the
    -    "git hook run" command. For now we won't be using this command
    -    interface outside of the tests, but exposing this functionality makes
    -    it easier to test the hook API.
    +    "git hook run" command.
    +
    +    For now we won't be using this command interface outside of the tests,
    +    but exposing this functionality makes it easier to test the hook
    +    API. The plan is to use this to extend the "sendemail-validate"
    +    hook[1][2].
    +
    +    1. https://lore.kernel.org/git/ad152e25-4061-9955-d3e6-a2c8b1bd24e7@amd.com
    +    2. https://lore.kernel.org/git/20230120012459.920932-1-michael.strawbridge@amd.com
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
-- 
2.39.1.1475.gc2542cdc5ef

