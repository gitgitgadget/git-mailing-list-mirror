Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2C2C433E6
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 18:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 971FB64FEC
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 18:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhCKSmt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 13:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhCKSmh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 13:42:37 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ED2C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 10:42:32 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 15so3469846ljj.0
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 10:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lMWRY38ntveTqYmrj/Xqp4HRgvs1JL8qlxvprhCTP0I=;
        b=CYVqcOzARl5MZo0KY7cw6cTrv1tihRwr3MNw1jjOisk61zq4SKwLOoXxcUp9RQdvVS
         AKJKahYtsBsZUqQtTgqukaRE/kVJmpn+gg0LhhlD/ApQxrPMGFbESpT9eZbIGpxKYDv3
         NuaEopVvo/N9uGQqKGp3WVuepUhOYKYTp2yqtfLg7DoqVCgnFg3TKsafuzD2jstRW4IS
         HL0Baxhi76f4HBreATemzrQtn29rw65CrI+94XTUbRwfOv5VCixA8C86cWjvRVBmUNPe
         GF28EgAtDkMPpAx5Xv5KHBq9pIDTOvbfYzfWfcMohcPhU/2wGMwVKFuFw827Sfc02sbO
         LmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lMWRY38ntveTqYmrj/Xqp4HRgvs1JL8qlxvprhCTP0I=;
        b=gVHywZGNSTAg8w1rcF1gbsQTGrHAe7A9+r9upcSY5xnWMrkf0NuWCB0iUlAQl+pOAa
         yWAViu4+6O7xD7hr5voKtkfMS53FtnXzwQRAeint0jgDhoKuODBe2KvRbWbdqnez/Avw
         LXLgzaYealv3iwubfEr01uhyOpVe1vE3DfJfGTeLSXOIXfYY18UX0KfBzUVEgvUqMBs3
         KxvoFfhlotu9svaQ91bsHXiuiEvSDqmstQqSxm+MueuCUc1mqKK2E9KWjH1M5Lg7ochT
         ZqpfuSp0+epVwfUWSfC/is+0t9TAAfSpezl/U+eTNivcvmUe9wiPoio/wEWZfbIOur6c
         3yLw==
X-Gm-Message-State: AOAM531jqxR9gxmaTkrRvaPrctl55mY24KzpxhXzfLERoa6OWVQx2NGU
        VCes18MQaF72cmb3VUos3Wfc27kvBD8MHQ9riBfMDgj3KhsHDw==
X-Google-Smtp-Source: ABdhPJztERGpdjPaf8Wn+eAegwouMtiGyYtSs/PYw0F13kYkTUC/64Ru4iVXkbzx6z/J4RCMy2Qi0nKXHNdXJKCO/zo=
X-Received: by 2002:a05:651c:103a:: with SMTP id w26mr137467ljm.273.1615488150929;
 Thu, 11 Mar 2021 10:42:30 -0800 (PST)
MIME-Version: 1.0
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Thu, 11 Mar 2021 10:42:19 -0800
Message-ID: <CAJoAoZk0fSyPSJZ51wNv4XujPA_-hPfh8eMRQPbyeTXFvKJ9+Q@mail.gmail.com>
Subject: What to do with fsmonitor-watchman hook and config-based hooks?
To:     Git List <git@vger.kernel.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks, I grabbed a bunch of CC from 'git blame fsmonitor.c' so
sorry if you don't care about fsmonitor-watchman anymore... :) Note
that this whole conversation has to do with the series proposed at
https://lore.kernel.org/git/20210311021037.3001235-1-emilyshaffer@google.com.

When I was looking through the remaining hooks in
Documentation/githooks.txt I noticed that the fsmonitor-watchman hook
is implemented somewhat differently than most other hooks. As I
understand it, to use that hook someone needs to:

1. Configure core.fsmonitor with a path to some fsmonitor-watchman
hook. The documentation in 'Documentation/githooks.txt' claims that it
needs to point to '.git/hooks/fsmonitor-watchman' or
'.git/hooks/fsmonitor-watchmanv2', but I don't see that constraint
enforced when the config is read (config.c:git_config_get_fsmonitor()
and fsmonitor.c:query_fsmonitor()), so it seems that core.fsmonitor
can point to wherever it wants. (Plus
'templates/blt/hooks/fsmonitor-watchman.sample' suggests setting
'core.fsmonitor' = '.git/hooks/query-watchman'...)
2. Configure core.fsmonitorhookversion to 1 or 2, to indicate the arg
structure for the executable specified in core.fsmonitor.

Because the executable doesn't necessarily live in .git/hooks/,
fsmonitor.c:query_fsmonitor() completely skips the "API" for running
hooks (run-command.h:run_hook_le()) and just uses
run-command.h:capture_command() directly.

Interestingly, this is really similar to the way config-based hooks
(https://lore.kernel.org/git/20210311021037.3001235-1-emilyshaffer@google.com)
work - but different enough that I think it may be awkward to
transition fsmonitor-watchman to work like everything else. So, some
questions, plus a proposal:

Q1: Does fsmonitor-watchman make sense to provide more than once
(since config-based hooks support multiple execs per hook)? (I get the
feeling the answer is no here - but what if, for example, I have an
NTFS partition with some repos and an ext4 partition with some other
repos, and only want to configure fsmonitor magic once at global
scope? I don't know anything about fsmonitor so maybe that is a very
stupid question ;) )
Q2: Does it make sense to specify anywhere other than per-repo scope?
(system/global scope, e.g., applying to all repos? One could imagine
providing it in a config which is inherited by submodules of a
superproject?) It looks like it operates on CWD + timestamp-ish, so it
seems to me like some user might want to only set it up once (e.g.
globally) and have it Just Work in all their repos afterwards. In
fact, I think you could configure core.fsmonitor in ~/.gitconfig today
and it would work for everything.

If we want to support checking vs multiple fsmonitor-watchman execs
(that is, if Q1's answer is "yes"), then I propose:
1. Check for values on 'hook.fsmonitor-watchman.command' and add them
to the execution list in config order.
  1a. Here we could either check for
'hookcmd.<command-value>.fsmonitor-watchman-version' or we could just
check separately for 'hook.fsmonitor-watchmanv2.command' as implied by
'githooks.txt' to determine the arg syntax for each hook.
2. Check for values on 'core.fsmonitor' and
'core.fsmonitorhookversion' to add a "legacy" hook at the end of the
execution list. (This is the same thing we do for hooks that live in
.git/hooks/<hookname>.)

If we don't want to support adding multiple fsmonitor-watchman execs,
then I propose:
1. Check hook.runHookDir's value to decide whether we believe in "legacy" hooks.
2. If we do, then check for core.fsmonitor and
core.fsmonitorhookversion, and run that one.
3. If we don't, or if core.fsmonitor was unset, then check for
(hook.fsmonitor-watchman +
hookcmd.<command-value>.fsmonitor-watchman-version) or
(hook.fsmonitor-watchman.command or
hook.fsmonitor-watchmanv2.command), error if we find more than one
candidate, and run the one candidate we do find. (Or I could see us
running only the most-local one, but that might be confusing for the
user.)

Thanks, all - I'm curious to learn more about this hook and the right
way to move forward :)

 - Emily
