Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68190C64EC4
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 00:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCAAiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 19:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCAAiV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 19:38:21 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAA9AD1A
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 16:38:20 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so6918997wmq.2
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 16:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RlA0c6hwHxPnMzLMjgMUGLnWJ1Uw6XGw3mLp14fTALw=;
        b=C2zavx84RT595Gqsox5VHgw/iSrEC5QsYS0XbgnYkN8lF71NWmZeXJz+eRrtpQDB+O
         I8MLw/K+sv2RB2/+mo4Fc7dK57Suymu9OJZNtkCAZTk5bGY1YSbQIYgltt9smNDRvkeH
         rYDFCE0LjxPfGw9x1cQfdFAd4qSYL4zAmBd8eXinB8LuMIa787YR3BhZYyBbRYZvBvpP
         MmpDTy7DhN+22LXhZgChGcUnNQf4j8FYc5F1MfdwaclMit1b2WP4k6592SnBnxGU+qSJ
         K07vEaUIV5bFk6FmYxBJBO1YvU/YdQZfpo5pv9Pwa3PWepCe+fIWZpOkwlIqHzscvnIH
         X1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlA0c6hwHxPnMzLMjgMUGLnWJ1Uw6XGw3mLp14fTALw=;
        b=wFVDry2g3yHP5oZ8H1tAsKBDyVWFnJi0pEpH+yJa7gf+CCULeEyYkAuk9Hpl/3w5+Q
         i7hNYkV9PuL6VkJcTX3n4wX6wGZBpbm0LZQRPeRNekc5hpGLIfgqed8go7iv/1DGYYMm
         JuunOvm8CYMjoX8lXSdIc5gKEKc4wGYwVhk8CorVjc2em9xsuVMFtRdTfwiQyabsnDW7
         lO4CiIi20B07/W25KToLhX1/l2FgVBOEKQCJ1b2CSmXHuFk5eG7VlqjvjWYQr5+WFHbd
         AHrbrwrOasYvBeVAro0YEk4jKp1lKMYhJI0Vro5NR4+pFatUJz+xZCo5OmVWvg9l1ctH
         j/2Q==
X-Gm-Message-State: AO0yUKUbynKT0tzXxzmCOG3E1N5lvRgxEzJAvpsiPulqXUiyxyq+rATo
        BNqxmj8stYIR/hlOJzJLiokJdqZ1ZlM=
X-Google-Smtp-Source: AK7set/LWBBLvSn1fw8DlMANqyw7ssOpOckGUW3lHvE5zMCfgdPoytcZUWUiuZHgvzkkQI90EbkAaw==
X-Received: by 2002:a05:600c:319a:b0:3e2:a9e:4eaa with SMTP id s26-20020a05600c319a00b003e20a9e4eaamr3304281wmp.35.1677631098429;
        Tue, 28 Feb 2023 16:38:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u26-20020a05600c441a00b003e21638c0edsm14439530wmn.45.2023.02.28.16.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 16:38:17 -0800 (PST)
Message-Id: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Mar 2023 00:38:11 +0000
Subject: [PATCH 0/6] [RFC] config.c: use struct for config reading state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This RFC is preparation for config.[ch] to be libified as as part of the
libification effort that Emily described in [1]. One of the first goals is
to read config from a file, but the trouble with how config.c is written
today is that all reading operations rely on global state, so before turning
that into a library, we'd want to make that state non-global.

This series gets us about halfway there; it does enough plumbing for a
workable-but-kinda-ugly library interface, but with a little bit more work,
I think we can get rid of global state in-tree as well. That requires a fair
amount of work though, so I'd like to get thoughts on that before starting
work.

= Description

This series extracts the global config reading state into "struct
config_reader" and plumbs it through the config reading machinery. It's very
similar to how we've plumbed "struct repository" and other 'context objects'
in the past, except:

 * The global state (named "the_reader") for the git process lives in a
   config.c static variable, and not on "the_repository". See 3/6 for the
   rationale.

 * I've stopped short of adding "struct config_reader" to config.h public
   functions, since that would affect non-config.c callers.

If we stop right here, it's quite easy to extend it to a future config-lib.h
without having to adjust the config.h interface:

 * Move the core config reading functionality from config.c to config-lib.c.

 * Have config-lib.h accept "struct config_reader" as an arg.

 * Have config.h call config-lib.h while passing "the_reader".

and I have some WIP patches that do just that [3], but I think they can be
significantly improved if we go a bit further...

= Leftover bits and RFC

With a bit more work on the config machinery, we could make it so that
config reading stops being global even without adjusting non-config.c
callers. The idea is pretty simple: have the config machinery initialize an
internal "struct config_reader" every time we read config and expose that
state to the config callbacks (instead of, in this series, asking the caller
to initialize "struct config_reader" themselves). I believe that only config
callbacks are accessing this state, e.g. because they use the low-level
information (like builtin/config.c printing the filename and scope of the
value) or for error reporting (like git_parse_int() reporting the filename
and line number of the value it failed to parse), and only config callbacks
should be accessing this state anyway.

The catch (aka the reason I stopped halfway through) is that I couldn't find
a way to expose "struct config_reader" state without some fairly big
changes, complexity-wise or LoC-wise, e.g.

 * We could add "struct config_reader" to "config_fn_t", i.e.
   
   -typedef int (*config_fn_t)(const char *var, const char *val, void
   *data); +typedef int (*config_fn_t)(const struct config_reader *reader,
   const char *var, const char *val, void *data);
   
   which isn't complex at all, except that there are ~100 config_fn_t
   implementations [3] and a good number of them may never reference
   "reader". If the churn is tolerable, I think this a good way forward.

 * We could create a new kind of "config_fn_t" that accepts "struct
   config_reader", e.g.
   
   typedef int (*config_fn_t)(const char *var, const char *val, void *data);
   +typedef int (*config_state_fn_t)(const struct config_reader *reader,
   const char *var, const char *val, void *data);
   
   and only adjust the callers that would actually reference "reader". This
   is less churn, but I couldn't find a great way to do this kind of
   'switching between config callback types' elegantly.

 * We could smuggle "struct config_reader" to callback functions in a way
   that interested callers could see it, but uninterested callers could
   ignore. One trick that Jonathan Tan came up with (though not necessarily
   endorsed) would be to allocate a struct for the config value + "struct
   config_reader", then, interested callers could use "offset_of" to recover
   the "struct config_reader". It's a little hacky, but it's low-churn.

= Questions

 * Is this worth merging without the extra work? There are some cleanups in
   this series that could make it valuable, but there are also some hacks
   (see 4/6) that aren't so great.
 * Is the extra work even worth it?
 * Do any of the ideas seem more promising than the others? Are there other
   ideas I'm missing?

[1]
https://lore.kernel.org/git/CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com
[2]
https://github.com/chooglen/git/compare/config/structify-reading...chooglen:git:config/read-without-globals
[3] This is a rough estimate based on "git grep"-ing callers of the config.h
functions. I vaguely recall callbacks being called "old-style", with the
suggestion that we should replace them with the "new-style" constant time
git_config_get_*() family of functions. That would decrease the number of
config callbacks significantly.

Glen Choo (6):
  config.c: plumb config_source through static fns
  config.c: don't assign to "cf" directly
  config.c: create config_reader and the_reader
  config.c: plumb the_reader through callbacks
  config.c: remove current_config_kvi
  config.c: remove current_parsing_scope

 config.c | 489 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 287 insertions(+), 202 deletions(-)


base-commit: dadc8e6dacb629f46aee39bde90b6f09b73722eb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1463%2Fchooglen%2Fconfig%2Fstructify-reading-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1463/chooglen/config/structify-reading-v1
Pull-Request: https://github.com/git/git/pull/1463
-- 
gitgitgadget
