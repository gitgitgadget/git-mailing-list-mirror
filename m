Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82891C54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 15:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiIHPnD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 11:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiIHPnB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 11:43:01 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB9C98D15
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 08:42:59 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i129-20020a1c3b87000000b003b332a7acbcso1315157wma.1
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 08:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lsJ1m5UBtSoynWZy6678oecAPftmcPZ32yDqKsdHIEA=;
        b=L30I0glva4dfFJp3hWvlaIZ/Omfty0ZskveK+FfxywOMWVzLmEaxQ3RRxQ+SWT3z2c
         H0O2/GxZlRhTNSBtt5T1Hrsv5IybxvzMN6X42qNEgzMUJmYUoauyvO7qjAs3zi/I3m2G
         vQ92Bql3/qBRWWUcPtO8RgzNA4e0PrU3NlJokZ1GTcitrJ0shdwhTfQeihEJe8T+NYuh
         Ny/YcPFdTRJzxDgi5nZbzpYr1eVq7R4+RQ86z5eqw0Hk2As8UYxLwZN20fQHOJtEpiiE
         RtaAl91MuLAiuADuiFM266A0RKKiG7HNquaflyuz/ie5QWyK1/drW7uFSy415hkUjHeX
         F6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lsJ1m5UBtSoynWZy6678oecAPftmcPZ32yDqKsdHIEA=;
        b=p5OHDW3Yq5JDi7nTSFUyTlUGzwuMfOEyn0xsSiPDZUiWo3q2haoiHNuS1n1Vt4UpEg
         E1cxSW8iq/9AKMjBZrYGbRfvgjiUE1g59INV6AyUrEyb+bguNpu6AfLihR8WGT3r1AQa
         SoJzcEyDTlg3cki37kfJ3s3Kptbo8291A+n+Bb2RfSqybxxkCPCDRtwqYoRiQoZx4mor
         fo0QZnldAvQgryyXCQpwX4rE3EPQ+7WQqS6A3aXM5lwATJXOAH1ljR0nqxePW3rFkXSt
         Ang2j0dTkd88/Wi8DiTTDv5EcZFigb1ucJfxrCIIOYAq8/9gTMB5dwaJYAr4AqZ0Byxa
         kegA==
X-Gm-Message-State: ACgBeo1BcYtG6En2AFBP8nPSq47JHTzwfN6biAl+m1TnrMzotWBgArjx
        g8KA0Ly8MAtPXKrERHKIwCbyWDBMZGA=
X-Google-Smtp-Source: AA6agR4nYa44r4+qR2QhV8NWHrqgbIxUTEougu/cIzsm71pMzkaglPz+GLz+yyLhZW0A2epVTe/59A==
X-Received: by 2002:a1c:7214:0:b0:3a5:ea1c:c55b with SMTP id n20-20020a1c7214000000b003a5ea1cc55bmr2832105wmc.190.1662651777550;
        Thu, 08 Sep 2022 08:42:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b003a3561d4f3fsm3920920wms.43.2022.09.08.08.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 08:42:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] tests: opt "git --config-env" test out of SANITIZE=leak
Date:   Thu,  8 Sep 2022 17:42:54 +0200
Message-Id: <patch-1.1-fb2f0a660c0-20220908T153252Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1492.gbb5af15b83b
In-Reply-To: <Yxl91jfycCo7O7Pp@coredump.intra.peff.net>
References: <Yxl91jfycCo7O7Pp@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 676063016ad (leak tests: mark some config tests as passing with
SANITIZE=leak, 2021-10-31) t1300*.sh as a whole was marked as passing
with SANITIZE=leak, but as reported[1] certain compiler options and
optimization levels will re-arrange the generated code to have the
sanitizer fire.

This issue is reproducible with e.g. clang v12 with CFLAGS=-O2. The
issue is that -fsanitize=leak will combine with other optimization
options, and as we eliminate functions, variables etc. the
-fsanitize=leak criteria for considering something a leak might
effectively change.

This is arguably not a compiler issue or bug, as the very notion of a
variable being "in scope" as far as the leak checker is concerned is
fuzzy at best in the face of compiler optimizations.

A similar issue came up before related to the config.c code in
[2]. There the consensus seemed to be to avoid hacks in the C code to
work around these compiler edge cases. In this case however skipping
one test is easy enough. We can deal with these "!SANITIZE_LEAK"
issues later, when we have fewer overall leaks.

1. https://lore.kernel.org/git/Yxl91jfycCo7O7Pp@coredump.intra.peff.net/
2. https://lore.kernel.org/git/patch-v3-5.6-9a44204c4c9-20211022T175227Z-avarab@gmail.com/
---

On Thu, Sep 08 2022, Jeff King wrote:

> If I run:
>
>   make SANITIZE=leak GIT_TEST_PASSING_SANITIZE_LEAK=true CFLAGS=-O0
>
> locally, then all tests pass or are skipped. But if switch to -O2, then
> t1300 starts failing!
>
> The command that supposedly leaks is this:
>
>   git --config-env=foo.flag= config --bool foo.flag
>
> and the backtrace looks like:
>
>   Direct leak of 9 byte(s) in 1 object(s) allocated from:
>       #0 0x56195ae6dc62 in __interceptor_malloc (git+0x78c62) (BuildId: a5cfeb484fd14b6120fa26ff364fa2313fd23168)
>       #1 0x56195b0ad6b6 in do_xmalloc wrapper.c
>       #2 0x56195b0ad7bd in xmemdupz (git+0x2b87bd) (BuildId: a5cfeb484fd14b6120fa26ff364fa2313fd23168)
>       #3 0x56195af6f8d0 in git_config_push_env (git+0x17a8d0) (BuildId: a5cfeb484fd14b6120fa26ff364fa2313fd23168)
>       #4 0x56195ae71689 in handle_options git.c
>       #5 0x56195ae7060f in cmd_main (git+0x7b60f) (BuildId: a5cfeb484fd14b6120fa26ff364fa2313fd23168)
>       #6 0x56195af370c6 in main (git+0x1420c6) (BuildId: a5cfeb484fd14b6120fa26ff364fa2313fd23168)
>       #7 0x7f45b9029209 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>       #8 0x7f45b90292bb in __libc_start_main csu/../csu/libc-start.c:389:3
>       #9 0x56195ae420c0 in _start (git+0x4d0c0) (BuildId: a5cfeb484fd14b6120fa26ff364fa2313fd23168)
>
> But here's the weird part. The function looks like this:
>
>   void git_config_push_env(const char *spec)
>   {
>           char *key;
>           const char *env_name;
>           const char *env_value;
>   
>           env_name = strrchr(spec, '=');
>           if (!env_name)
>                   die(_("invalid config format: %s"), spec);
>           key = xmemdupz(spec, env_name - spec);
>           env_name++;
>           if (!*env_name)
>                   die(_("missing environment variable name for configuration '%.*s'"),
>                       (int)(env_name - spec - 1), spec);
>   
>           env_value = getenv(env_name);
>           if (!env_value)
>                   die(_("missing environment variable '%s' for configuration '%.*s'"),
>                       env_name, (int)(env_name - spec - 1), spec);
>   
>           git_config_push_split_parameter(key, env_value);
>           free(key);
>   }
>
> And it is complaining that we've leaked "key". But as you can see, we
> always free it. The problem is that for this particular invocation we
> die("missing environment variable name"), so of course we don't make it
> to the free(). Normally this is OK, though. The "key" variable is still
> on the stack, so the leak-checker should realize that it's still
> reachable.

[Re-arranged your E-Mail a bit for the purposes of the flow of this
reply]

> Maybe this is a known problem, but it was certainly surprising to me.

It is surprising, but it's a (at least to me) known "issue". See
e.g. https://lore.kernel.org/git/patch-v3-5.6-9a44204c4c9-20211022T175227Z-avarab@gmail.com/
for a previous discussion between us. I took the consensus there to be
that we shouldn't bend over backwards to worry about this.

I have been diligently ensuring that I don't mark tests as leak-free
if they "pass", but then "fail" on higher optimization levels.

But I see this one slipped through because I locally changed my
default compiler from "clang" to "gcc" (again) a while ago, and thus
missed testing clang at higher optimization levels. Usually it's GCC
that's unhappy about this sort of thing.

> But if you run this in a debugger, you'll find that under -O2 the "key"
> variable has been optimized out! So LSan is producing the wrong result
> due to the optimization. It doesn't know that "key" is conceptually
> still reachable.
> [...]

I don't know if we (or the compiler implementors) can call it the
"wrong" result. Just as some warnings only pop up depending on
optimization levels, this behavior also depends on it.

I've seen quite a few of these around die() codepaths. Presumably some
re-arranging/eliminaton of the code around that NORETURN codepath...

> [...]
> I'm not sure if we should do anything about it or not. It doesn't seem
> to trigger in CI, even though I don't see us taking any steps there to
> use -O0 or similar. So we can perhaps ignore it for now, and this
> message can serve as a warning. But if we think LSan isn't reliable
> under higher optimizations, we could perhaps teach the Makefile to
> prefer -O0 when it sees SANITIZE=leak.

I think it's good to not force -O0 with SANITIZE=leak, but this is
annoying, so let's do the below change. With it the tests pass for me
with clang under -O2/-O3.

FWIW if you play with the "check" mode you'll probably also find that
we have some tests that are "flaky" as far as the leak checking is
concerned ("t2012 t6415 t6435", I think, at least I skip those locally
when using it). IIRC some of that also depends on -On.

 t/t1300-config.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index c6661e61af5..a4953881db6 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1398,7 +1398,7 @@ test_expect_success 'git --config-env with missing value' '
 	grep "invalid config format: config" error
 '
 
-test_expect_success 'git --config-env fails with invalid parameters' '
+test_expect_success !SANITIZE_LEAK 'git --config-env fails with invalid parameters' '
 	test_must_fail git --config-env=foo.flag config --bool foo.flag 2>error &&
 	test_i18ngrep "invalid config format: foo.flag" error &&
 	test_must_fail git --config-env=foo.flag= config --bool foo.flag 2>error &&
-- 
2.37.3.1492.gbb5af15b83b

