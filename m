Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85089C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 01:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6521361205
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 01:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhKJBqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 20:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhKJBqm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 20:46:42 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4BCC061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 17:43:55 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id f8so4012104edy.4
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 17:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f5iSCgk+5Ok3GIkYsXPBSB/g/qy28rzlAPVs4UwyDco=;
        b=WbX0sdu8c+ljmOXK28GhSSIHTUyk0DS1voTFzxUlSsLX5MR1ThSuer4FdzeYyCqfuL
         PsHdC0SA7vi2aKqW1y0I6W3bYQQ6GnwCYAMMitqMZ8wnS/z8VNw0wlFlDNQeF9qr5vhM
         PCxGQCupcgNWja2bscJFYcZfT7pPlo44HfwZtDlSroJjHjM3oD2MXC32TThCT9nfmAHP
         zDdK61SKsqq9bttdlut/ibx6gntk9HdQ8lxSzbHdLMMNXzIXLotNJ9GJPPmOoh7eqcuZ
         AuQl4Nepkz4Hit/5DUVOb8XBBhRRBjqSvGSUBo+AeHDiaMPc1oYuD1fW9pWanLb24F2m
         qu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f5iSCgk+5Ok3GIkYsXPBSB/g/qy28rzlAPVs4UwyDco=;
        b=ub/szatSvB8R3kz6kWGMdtITI5O08R0LuXRNdncPluyXiXyFjLkIHUxticnzOzvNE+
         EFoeeyIV4Eb2CxHYSVErejwjT9LeKTb9Eyy+lXKNwqCfT05c5+Y955VHc4T+SnLqcivV
         8Zmp0tR0Yqc44IiIiuuZp1pUIYB3YJoiZvwBoCD9kq5B7sEiLvnNWggRowjBwmWFDCyA
         oyPjo+Cd2kAKPwHqnGWntpetKSliKN518lk+RFXv2ENefzLoA2el8s/6j+2RAZuGo3LU
         iiQJoeq9WsvC+/WxCZ/Q+NpN/M1+Jt2u268i+ljAj0aToEn6etCSouhnMOjazX3pu2Q0
         EZIg==
X-Gm-Message-State: AOAM532KMrmjNX3SKqHo/Iie/kEaGKwnxHmJEE258DZCFXg/cnybmjq7
        vUw/p0Y3zkiiXP+NVpKBCPVNzo5QsW2JNg==
X-Google-Smtp-Source: ABdhPJzYmK9uKgXKc67NGo8e5dhTsXFRHJXLDYv7H1fBHDCeAAwCjWG3ukCHjAwgTEIOtCy60/QqBw==
X-Received: by 2002:a05:6402:51d3:: with SMTP id r19mr16681929edd.13.1636508634052;
        Tue, 09 Nov 2021 17:43:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id qf8sm9369252ejc.8.2021.11.09.17.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 17:43:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/8] grep: simplify & delete code by changing obscure cfg variable behavior
Date:   Wed, 10 Nov 2021 02:43:42 +0100
Message-Id: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.791.gdbfcf909579
In-Reply-To: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series changes the behavior of an obscure interaction between
"grep.extendedRegexp=true" and "grep.patternType=default". See
7-8/8. Along the way we can delete a lot of code that was needed to
support the previous behavior.

For v1 and a more extensive summary see [1]. Thanks a lot Taylor for
the detailed review on v1!

Hopefully this v1 addresses all the feedback on one way or another,
it's still 8 patches, but much of the early part of v1 is squashed
together & re-done as suggested.

Then there's a mid-series de-duplication of the grep config
documentation. I ended up keeping the change to not needlessly pass
"cb" around in grep_cmd_config(), but that's now also in its own
patch.

1. https://lore.kernel.org/git/cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (8):
  grep.h: remove unused "regex_t regexp" from grep_opt
  built-ins: trust the "prefix" from run_builtin()
  log tests: check if grep_config() is called by "log"-like cmds
  grep docs: de-duplicate configuration sections
  grep.c: don't pass along NULL callback value
  grep API: call grep_config() after grep_init()
  grep: simplify config parsing, change grep.<rx config> interaction
  grep: make "extendedRegexp=true" the same as "patternType=extended"

 Documentation/config/grep.txt |  11 ++--
 Documentation/git-grep.txt    |  30 +--------
 builtin/grep.c                |  27 ++++----
 builtin/log.c                 |  13 +++-
 builtin/ls-tree.c             |   9 ++-
 git.c                         |   4 +-
 grep.c                        | 118 ++++------------------------------
 grep.h                        |  35 ++++++----
 revision.c                    |   4 +-
 t/t4202-log.sh                |  16 +++++
 t/t7810-grep.sh               |   4 +-
 11 files changed, 97 insertions(+), 174 deletions(-)

Range-diff against v1:
1:  412b8b65266 = 1:  1435db727ef grep.h: remove unused "regex_t regexp" from grep_opt
2:  244715e3497 < -:  ----------- git.c & grep.c: assert that "prefix" is NULL or non-zero string
3:  3338cc95b81 < -:  ----------- grep: remove unused "prefix_length" member
4:  78298657d69 < -:  ----------- grep.c: move "prefix" out of "struct grep_opt"
-:  ----------- > 2:  63cf2fe266d built-ins: trust the "prefix" from run_builtin()
5:  ba9be0b9283 = 3:  41e38ebb32c log tests: check if grep_config() is called by "log"-like cmds
-:  ----------- > 4:  efe95397d72 grep docs: de-duplicate configuration sections
-:  ----------- > 5:  d0f0ac6c7ae grep.c: don't pass along NULL callback value
6:  933ac853bca ! 6:  917944f79a5 grep API: call grep_config() after grep_init()
    @@ Commit message
         didn't do that, but now that it can't be a concern anymore let's
         remove those comments.
     
    +    This does not change the behavior of any of the configuration
    +    variables or options. That would have been the case if we didn't move
    +    around the grep_config() call in "builtin/log.c". But now that we call
    +    "grep_config" after "git_log_config" and "git_format_config" we'll
    +    need to pass in the already initialized "struct grep_opt *".
    +
         See 6ba9bb76e02 (grep: copy struct in one fell swoop, 2020-11-29) and
         7687a0541e0 (grep: move the configuration parsing logic to grep.[ch],
         2012-10-09) for the commits that added the comments.
     
    +    The memcpy() pattern here will be optimized away and follows the
    +    convention of other *_init() functions. See 5726a6b4012 (*.c *_init():
    +    define in terms of corresponding *_INIT macro, 2021-07-01).
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/grep.c ##
     @@ builtin/grep.c: static int wait_all(void)
    + 
      static int grep_cmd_config(const char *var, const char *value, void *cb)
      {
    - 	int st = grep_config(var, value, cb);
    --	if (git_color_default_config(var, value, cb) < 0)
    -+	if (git_color_default_config(var, value, NULL) < 0)
    +-	int st = grep_config(var, value, NULL);
    ++	int st = grep_config(var, value, cb);
    + 	if (git_color_default_config(var, value, NULL) < 0)
      		st = -1;
      
    - 	if (!strcmp(var, "grep.threads")) {
     @@ builtin/grep.c: int cmd_grep(int argc, const char **argv, const char *prefix)
    - 		OPT_END()
      	};
    + 	grep_prefix = prefix;
      
     -	git_config(grep_cmd_config, NULL);
      	grep_init(&opt, the_repository);
     +	git_config(grep_cmd_config, &opt);
    - 	opt.caller_priv = &opt_cmd;
      
      	/*
    + 	 * If there is no -- then the paths must exist in the working
     
      ## builtin/log.c ##
     @@ builtin/log.c: static int git_log_config(const char *var, const char *value, void *cb)
    @@ grep.c: int grep_config(const char *var, const char *value, void *cb)
     
      ## grep.h ##
     @@ grep.h: struct grep_opt {
    + 	int show_hunk_mark;
    + 	int file_break;
    + 	int heading;
    ++	void *caller_priv;
    + 	void *priv;
    + 
    + 	void (*output)(struct grep_opt *opt, const void *data, size_t size);
      	void *output_priv;
      };
      
7:  677a8f8520f ! 7:  140a7416223 grep: simplify config parsing, change grep.<rx config> interaction
    @@ Commit message
         but in a way that's consistent with how we parse other
         configuration.
     
    -    Pedantically speaking we're probably breaking past promises here, but
    -    I doubt that this will impact anyone in practice. The reduction in
    -    complexity and resulting consistency with other default config
    -    behavior is worth it.
    +    We are breaking past promises here, but I doubt that this will impact
    +    anyone in practice. The reduction in complexity and resulting
    +    consistency with other default config behavior is worth it.
     
         When "grep.patternType" was introduced in 84befcd0a4a (grep: add a
         grep.patternType configuration setting, 2012-08-03) we made two
    @@ Commit message
             # BRE grep
             git -c grep.extendedRegexp=true -c grep.patternType=basic grep <pattern>
     
    -    But probably not for this to ignore the new "grep.patternType" option
    -    entirely, say if /etc/gitconfig was still setting
    +    But probably not for this to ignore the favored "grep.patternType"
    +    option entirely, say if /etc/gitconfig was still setting
         "grep.extendedRegexp", but "~/.gitconfig" used the new
         "grep.patternType" (and wanted to use the "default" value):
     
    @@ Documentation/config/grep.txt: grep.patternType::
      	If set to true, enable `--extended-regexp` option by default. This
     -	option is ignored when the `grep.patternType` option is set to a value
     -	other than 'default'.
    -+	option is ignored when the `grep.patternType` option is set.
    - 
    - grep.threads::
    - 	Number of grep worker threads to use.
    -
    - ## Documentation/git-grep.txt ##
    -@@ Documentation/git-grep.txt: grep.patternType::
    - 
    - grep.extendedRegexp::
    - 	If set to true, enable `--extended-regexp` option by default. This
    --	option is ignored when the `grep.patternType` option is set to a value
    --	other than 'default'.
     +	option is ignored when the `grep.patternType` option is set.
      
      grep.threads::
8:  dadd5dff77a ! 8:  cc904d93b26 grep: make "extendedRegexp=true" the same as "patternType=extended"
    @@ Documentation/config/grep.txt: grep.patternType::
      grep.extendedRegexp::
     -	If set to true, enable `--extended-regexp` option by default. This
     -	option is ignored when the `grep.patternType` option is set.
    -+	Deprecated synonym for 'grep.patternType=extended`.
    - 
    - grep.threads::
    - 	Number of grep worker threads to use.
    -
    - ## Documentation/git-grep.txt ##
    -@@ Documentation/git-grep.txt: grep.patternType::
    - 	value 'default' will return to the default matching behavior.
    - 
    - grep.extendedRegexp::
    --	If set to true, enable `--extended-regexp` option by default. This
    --	option is ignored when the `grep.patternType` option is set.
     +	Deprecated synonym for 'grep.patternType=extended`.
      
      grep.threads::
    @@ grep.h: struct grep_opt {
      	.colors = { \
      		[GREP_COLOR_CONTEXT] = "", \
      		[GREP_COLOR_FILENAME] = "", \
    -@@ grep.h: struct grep_opt {
    - 		[GREP_COLOR_SELECTED] = "", \
    - 		[GREP_COLOR_SEP] = GIT_COLOR_CYAN, \
    - 	}, \
    --	.only_matching = 0, \
    - 	.color = -1, \
    - 	.output = std_output, \
    - }
     
      ## t/t7810-grep.sh ##
     @@ t/t7810-grep.sh: do
-- 
2.34.0.rc1.741.gab7bfd97031

