Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E814C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4125C613FC
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhGAQFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhGAQFl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 12:05:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8379BC061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 09:03:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t15so5551155wry.11
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Rz3Nl94Fws7HWmWfL7K7U6r8JIT869z9kJbOi+3IPTQ=;
        b=N3MH/I0ANozP9F/PIpuah16e/7Y1Prb2Ngv+I2CoAkjorY++TaVfhcnGp/YpOwv+Ja
         AcN4wpBz+khh3Iqiom6QCefUTW3FpBaJyt07CLEfk5ECZdlUCaQLM3OgU6GNuySux3Ls
         pmv5V8wugc8T34fFgMuNfaIz2uOv7HveTi/ol69fF5Trhz275YQAiQPwgoiH/Tz+GH94
         wsqTGgb4SitYQ6fNCaML5dgATwWHg94sUAE0O61JsyYcgqLxkf82kumyAjfp6Ov4S9j4
         Wq43OThe9fIk6Ruu5eUCssEx0JE/sDZL1mwfSoib/5eW7esDlL43dlIzaNtyIbp6BMpx
         U7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Rz3Nl94Fws7HWmWfL7K7U6r8JIT869z9kJbOi+3IPTQ=;
        b=tPdkUvWivtBRuNUmFLshAtL6+3tjOrD5H45mHwMhzrWls19cbCE/PFbCi/gZdJ+Tho
         tHDqNSqB83OsNuFt0tlwwMHaPp1j0FWIQiJgFpuH4Fa6LYJXpussDYC3eFywv8ayMhUs
         jqeZsDHhDFH3sTwJHG3JIYYE1MNVh6K9AI2WKodUCBSbu7PHfjEppnpKI9camNSpKi8f
         7NQbb2BUZPjpsVeLbqFkmKYgfb1n1fHutdltWFlLAzw5sbDiVrPMJfM2hOJarwj6j9xN
         uroyJitLOx+kDHOQKOp56sVptHhY+/O0TdoVPt6wh2UPwxPx/4me9Lgd6AcHyBI9TfkP
         QqOw==
X-Gm-Message-State: AOAM532pConTD0RJjyFRAdHxtnL6heaMgNQjyPiE/eGB2Xp6zdqGbISr
        m5s065wFV5+HxH6MaN3mqQwHFgUtaco=
X-Google-Smtp-Source: ABdhPJyLfdVEna77dN/qufIvWSS4FqDlNXEnYzZ/3z4x4BpK4zgtr0e/VeulXWUKvznQfeh3KBGcVw==
X-Received: by 2002:a5d:4d8c:: with SMTP id b12mr469555wru.332.1625155389082;
        Thu, 01 Jul 2021 09:03:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t83sm9519736wmf.36.2021.07.01.09.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 09:03:08 -0700 (PDT)
Message-Id: <pull.66.v2.git.1625155388.gitgitgadget@gmail.com>
In-Reply-To: <pull.66.git.gitgitgadget@gmail.com>
References: <pull.66.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 16:03:05 +0000
Subject: [PATCH v2 0/2] mingw: handle absolute paths in expand_user_path()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Git for Windows, we ran with a patch "in production" for quite a while
where paths starting with a slash (i.e. looking like Unix paths, not like
Windows paths) were interpreted as being relative to the runtime prefix,
when expanded via expand_user_path().

This was sent to the Git mailing list as a discussion starter, and it was
pointed out that this is neither portable nor unambiguous.

After the dust settled, I thought about the presented ideas for a while
(quite a while...), and ended up with the following: any path starting with
<RUNTIME-PREFIX>/ is expanded. This is ambiguous because it could be a valid
path. But then, it is unlikely, and if someone really wants to specify such
a path, it is easy to slap a ./ in front and they're done.

Changes since v1:

 * Included a test for the RUNTIME_PREFIX that I had meant to send for ages
   already, and based on which...
 * A test case was added to verify that this actually works as intended
 * It is no longer Windows-specific
 * I added some documentation

Johannes Schindelin (2):
  tests: exercise the RUNTIME_PREFIX feature
  expand_user_path(): support specifying paths relative to the runtime
    prefix

 Documentation/config.txt | 10 ++++++++++
 Makefile                 |  5 +++++
 path.c                   |  5 +++++
 t/t0060-path-utils.sh    | 26 ++++++++++++++++++++++++++
 4 files changed, 46 insertions(+)


base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-66%2Fdscho%2Fmingw-expand-absolute-user-path-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-66/dscho/mingw-expand-absolute-user-path-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/66

Range-diff vs v1:

 -:  ----------- > 1:  cc8f09baba9 tests: exercise the RUNTIME_PREFIX feature
 1:  2287dd96cf0 ! 2:  66df56f5db0 mingw: handle absolute paths in expand_user_path()
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    mingw: handle absolute paths in expand_user_path()
     +    expand_user_path(): support specifying paths relative to the runtime prefix
      
     -    On Windows, an absolute POSIX path needs to be turned into a Windows
     -    one.
     +    Ever since Git learned to detect its install location at runtime, there
     +    was the slightly awkward problem that it was impossible to specify paths
     +    relative to said location.
     +
     +    For example, if a version of Git was shipped with custom SSL
     +    certificates to use, there was no portable way to specify
     +    `http.sslCAInfo`.
     +
     +    In Git for Windows, the problem was "solved" for years by interpreting
     +    paths starting with a slash as relative to the runtime prefix.
     +
     +    However, this is not correct: such paths _are_ legal on Windows, and
     +    they are interpreted as absolute paths in the same drive as the current
     +    directory.
     +
     +    After a lengthy discussion, and a way lengthier time to mull over the
     +    problem and its best solution, we decided to introduce support for the
     +    magic sequence `<RUNTIME-PREFIX>/`. If a path starts with this, the
     +    remainder is interpreted as relative to the detected runtime prefix.
     +
     +    This solves the problem, but what new problems does it stir up? Here are
     +    the two most obvious ones:
     +
     +    - What if Git was not compiled with support for a runtime prefix?
     +
     +      In that case, we will simply use the compiled-in hard-coded prefix.
     +
     +    - What if a user _wants_ to specify a path starting with the magic
     +      sequence?
     +
     +      In that case, the user will simply need to prefix the magic sequence
     +      with `./` and voilà, the path won't be expanded.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     + ## Documentation/config.txt ##
     +@@ Documentation/config.txt: pathname::
     + 	tilde expansion happens to such a string: `~/`
     + 	is expanded to the value of `$HOME`, and `~user/` to the
     + 	specified user's home directory.
     +++
     ++If a path starts with `<RUNTIME-PREFIX>/`, the remainder is
     ++interpreted as a path relative to Git's "runtime prefix", i.e. relative
     ++to the location where Git itself was installed. For example,
     ++`<RUNTIME-PREFIX>/bin/` refers to the directory in which the Git
     ++executable itself lives. If Git was compiled without runtime prefix
     ++support, the compiled-in prefix will be subsituted instead. In the
     ++unlikely event that a literal path needs to be specified that should
     ++_not_ be expanded, it needs to be prefixed by `./`, like so:
     ++`./<RUNTIME-PREFIX>/bin`.
     + 
     + 
     + Variables
     +
       ## path.c ##
      @@
     - #include "path.h"
       #include "packfile.h"
       #include "object-store.h"
     + #include "lockfile.h"
      +#include "exec-cmd.h"
       
       static int get_st_mode_bits(const char *path, int *mode)
     @@ path.c: char *expand_user_path(const char *path, int real_home)
       
       	if (path == NULL)
       		goto return_null;
     -+#ifdef __MINGW32__
     -+	if (path[0] == '/')
     -+		return system_path(path + 1);
     -+#endif
     ++
     ++	if (skip_prefix(path, "<RUNTIME-PREFIX>/", &path))
     ++		return system_path(path);
     ++
       	if (path[0] == '~') {
       		const char *first_slash = strchrnul(path, '/');
       		const char *username = path + 1;
     +
     + ## t/t0060-path-utils.sh ##
     +@@ t/t0060-path-utils.sh: test_expect_success RUNTIME_PREFIX,CAN_EXEC_IN_PWD 'RUNTIME_PREFIX works' '
     + 	cp "$GIT_EXEC_PATH"/git$X pretend/bin/ &&
     + 	GIT_EXEC_PATH= ./pretend/bin/git here >actual &&
     + 	echo HERE >expect &&
     ++	test_cmp expect actual'
     ++
     ++test_expect_success RUNTIME_PREFIX,CAN_EXEC_IN_PWD '<RUNTIME-PREFIX>/ works' '
     ++	mkdir -p pretend/bin &&
     ++	cp "$GIT_EXEC_PATH"/git$X pretend/bin/ &&
     ++	git config yes.path "<RUNTIME-PREFIX>/yes" &&
     ++	GIT_EXEC_PATH= ./pretend/bin/git config --path yes.path >actual &&
     ++	echo "$(pwd)/pretend/yes" >expect &&
     + 	test_cmp expect actual
     + '
     + 

-- 
gitgitgadget
