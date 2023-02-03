Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB95DC61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 12:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjBCMQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 07:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjBCMQY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 07:16:24 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E57E9AFDD
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 04:16:21 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id qw12so14856214ejc.2
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 04:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/M0k+hGvOODIT+DL0Raqb2o1I3oOGTKqP8TwNZ87RQ4=;
        b=KHXCbgmlHJ05Bt/SIQex88UUft/d2k3kE6X43qsgQ8Fk0qHE3zfPi3X83Ps1w+50MY
         dMEj2RDSMKyxKRybNR6INPlRL7BNHwis3ITf4Mnj7EPDpObvOg6mWeYe1hWy29yUjXWl
         fnPniStetV0Ak4K5ZEUl2n7z6RwoE6Ud9Q9/T8Uw5Ji3g68MieTbVefbWgyoC3a7OPsH
         LweojavVUAfvSCX7yyKTr0/nqHLvc5XzgugNIMTb6FYT1v9ElxHvz4ZYXsURfXZMF9lR
         Z3Ev/qnSHP3FWHBCs9oaVjixJtHkqH+g09PCPkf3ZEmwtu+8IQVBYC8JQ7HwH3LEBuqi
         lx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/M0k+hGvOODIT+DL0Raqb2o1I3oOGTKqP8TwNZ87RQ4=;
        b=Rg0ahf9dAGrQnhoLFr3VcANyhU1A5rPIJl91IloZmUhhlVonmetcbLkASJ6/ATAxA9
         QLvhcVCcUlDLeya2aCWzjOlJimsToiEMYOVQ8K+d42UdQwXS7bS7Ph+j7M1Jn8WbUppy
         esgHQF/H5V83zysm70g+qp86p/NyUu+uxibTJuQvKOyJ4xLnGJcy04YyJTndINnhKwdG
         kIzKxYe/4RF4uPTFjI1qbyB9aXQnt/ryny6yL3iFU9fG6HNEU73ofqFaMD6OIm1BxEkJ
         o674HT6qrtl6ZyWT5zxraAf7hBETCQY1sj4VSI0qNGtVYGBaA6/schUJ8udr8whXWQjh
         HGRQ==
X-Gm-Message-State: AO0yUKWB9XvIBi0CVhvvHlcDUIFYCqk4RpIw86sOAaeyRV+D17zq62hp
        fIwFKo1sPvoXa5NsWHbKab6ZOyHw8KXCYybm
X-Google-Smtp-Source: AK7set8LI1FeHpWPogBuJvvHtVL4Zlun5A1pfuuhy0GGMQfs7Q0ZYN3WEgraemIcyJX5AoA7KbNZEg==
X-Received: by 2002:a17:907:1b1f:b0:88f:8c13:52cf with SMTP id mp31-20020a1709071b1f00b0088f8c1352cfmr4278205ejc.43.1675426578952;
        Fri, 03 Feb 2023 04:16:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m24-20020a170906849800b0088b24b3aff8sm1286313ejx.183.2023.02.03.04.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 04:16:18 -0800 (PST)
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
Date:   Fri,  3 Feb 2023 13:15:30 +0100
Message-Id: <cover-v2-0.5-00000000000-20230203T104319Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1397.gbe42486b8a4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.39.1.1397.g8c8c074958d

