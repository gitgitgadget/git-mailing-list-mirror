Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AFCC761A1
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5A521D56
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ouX9SNpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgBTB7J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:59:09 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:36533 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbgBTB7I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 20:59:08 -0500
Received: by mail-pg1-f201.google.com with SMTP id i8so1315290pgs.3
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 17:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=ncZXRgloFmXoxSyUko7QnB3M33zhbvDy3kyUPwKpvEE=;
        b=ouX9SNpb2+YtGl/w0Fr8Ucp8e9vrTHhL3qqW0LPEu2ioEyHGJalDA7o2f82oBgq6ij
         xQGlWlNbwloYY8F0+tWY4D81nBSB1uD0/wwr76kXxBpakNzS0AP7BF2r2/Z3eOJBnZnd
         Ekvfy+Bpz+E6YovU1UFJjuUVOAwtzJ11+4XnVbH+LdGA4P/+oaukix3/JCNZm5SdtMMo
         u4BnSN12Vu0d7w5uzYzIvpQJHmaB7yZdNNQMZwbMM/+NKFnIDvomZXDtF8OSYGQ+ykGO
         udkACRRsfnfjgJafata0vIZtcDeZGyiBeeWqESTOCjbN7A28QVX79p4zZa3SM3djOiQT
         VUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=ncZXRgloFmXoxSyUko7QnB3M33zhbvDy3kyUPwKpvEE=;
        b=q+OBnQ4ZXP37w3nlHbJ2oNAf+TpjH9eesGpPrLNY/9Ep07+mno71uAjp88wJSsvrNU
         x3oU/IdCjdq4UlHvgK8+tcHUUqN2E74lyan8OM6uIyYW24wot77Mn1lzgdafapt2a1OO
         u+/XVMfC2iwm5IGdv9EnvLYOotiXEZDvRfqP54U+M9HYXNbqIWsmEPqkJpOEYGeSSeI/
         89OykKpN9vCB2PitIjKTi69Sd3h4KlkuQR++hJ8y4qUOS9pDuyiru4+hKAdMZzkBT/Kx
         r4Sqs6SNu9ZOOgjqdSaNWoevRJ1dRbvjjJhC8RYQ6kb0/rKhSDSvUGSEuFrup1PM1wCq
         TcqQ==
X-Gm-Message-State: APjAAAXA3PBVPy3WBAR7yxNw5BJKd4ErNGzRuVjuqCBt4GliRBWUVCvN
        tcaXey1QheMyOYRmNW8Hvyngcfn/CWGY6Kob/Kh//4XCakLPQmKRrEnJ1IZ1QG7adh4ZD4wqv50
        /DYZW5gZwQ7Vcsd13NB/qxmVoxDfuOOQjUYMM/1zrtxBK62WD4GFNGKcCSZKXtlZxn1MpdYzafQ
        ==
X-Google-Smtp-Source: APXvYqyLoXpAYA7E+MsQcIN3ZTYaXrbQVGAIvzl7mqmR3yexjaExgNTKSOFwuvS8cyFwOuGuSasVxR3WrH+ZSnHn+7s=
X-Received: by 2002:a63:aa09:: with SMTP id e9mr30860847pgf.354.1582163946114;
 Wed, 19 Feb 2020 17:59:06 -0800 (PST)
Date:   Wed, 19 Feb 2020 17:58:43 -0800
In-Reply-To: <20200214015343.201946-1-emilyshaffer@google.com>
Message-Id: <20200220015858.181086-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v8 00/15] add git-bugreport tool
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Martin=20=C3=85gren?=" <martin.agren@gmail.com>,
        Aaron Schrab <aaron@schrab.com>,
        Danh Doan <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "=?UTF-8?q?SZEDER=20G=C3=A1bor?=" <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No longer relies on any topic branches, since mr/show-config-scope is
merged. Range-diff at the bottom of the cover letter.

Since v7:
 - Dropped some POSIX regex magic in
   generate-bugreport-config-safelist.sh.
 - Added some advice in doc for scenarios when git-bugreport may not run
   nicely
 - Quit using unusual "return -foo(bar)" and start using "return
   !!foo(bar)"
 - Add a test to ensure path creation works outside of a git dir
 - Add some GNUC and GNUC_MINOR reporting
 - Use git_cmd instead of hardcoding "git" as the first arg when
   invoking another process
 - Fix some pesky whitespace

Thanks.
 - Emily

Emily Shaffer (15):
  help: move list_config_help to builtin/help
  help: add shell-path to --build-options
  bugreport: add tool to generate debugging info
  bugreport: gather git version and build info
  bugreport: add uname info
  bugreport: add compiler info
  bugreport: add git-remote-https version
  bugreport: include user interactive shell
  bugreport: generate config safelist based on docs
  bugreport: add config values from safelist
  bugreport: collect list of populated hooks
  bugreport: count loose objects
  bugreport: add packed object summary
  bugreport: list contents of $OBJDIR/info
  bugreport: summarize contents of alternates file

 .gitignore                              |   3 +
 Documentation/asciidoc.conf             |   9 +
 Documentation/asciidoctor-extensions.rb |   7 +
 Documentation/config/sendemail.txt      |  56 ++--
 Documentation/git-bugreport.txt         |  60 ++++
 Makefile                                |  27 +-
 bugreport.c                             | 418 ++++++++++++++++++++++++
 builtin/help.c                          |  86 +++++
 command-list.txt                        |   1 +
 compat/compiler.h                       |  27 ++
 generate-bugreport-config-safelist.sh   |  18 +
 generate-cmdlist.sh                     |  19 --
 generate-configlist.sh                  |  21 ++
 help.c                                  | 132 ++------
 help.h                                  |   2 +-
 object-store.h                          |   6 +
 packfile.c                              |   3 +-
 remote-curl.c                           |   8 +
 t/t0091-bugreport.sh                    |  61 ++++
 19 files changed, 808 insertions(+), 156 deletions(-)
 create mode 100644 Documentation/git-bugreport.txt
 create mode 100644 bugreport.c
 create mode 100644 compat/compiler.h
 create mode 100755 generate-bugreport-config-safelist.sh
 create mode 100755 generate-configlist.sh
 create mode 100755 t/t0091-bugreport.sh


 1:  429c7e093b =  1:  69f54afc6b help: move list_config_help to builtin/help
 2:  0cfb24f878 =  2:  9ea1c3ab34 help: add shell-path to --build-options
 3:  02bb151176 !  3:  8a290b5445 bugreport: add tool to generate debugging info
    @@ Documentation/git-bugreport.txt (new)
     + - Expected behavior
     + - Actual behavior
     +
    ++This tool is invoked via the typical Git setup process, which means that in some
    ++cases, it might not be able to launch - for example, if a relevant config file
    ++is unreadable. In this kind of scenario, it may be helpful to manually gather
    ++the kind of information listed above when manually asking for help.
    ++
     +OPTIONS
     +-------
     +-o <path>::
    @@ bugreport.c (new)
     +
     +	UNLEAK(buffer);
     +	UNLEAK(report_path);
    -+	return -launch_editor(report_path.buf, NULL, NULL);
    ++	return !!launch_editor(report_path.buf, NULL, NULL);
     +}
     
      ## command-list.txt ##
    @@ t/t0091-bugreport.sh (new)
     +	test_when_finished rm non-repo/git-bugreport-*
     +'
     +
    ++test_expect_success 'can create leading directories outside of a git dir' '
    ++	nongit git bugreport -o foo/bar/baz &&
    ++	test_when_finished rm -fr foo/bar/baz
    ++'
    ++
    ++
     +test_done
 4:  463612e409 !  4:  4eb4a7aef3 bugreport: gather git version and build info
    @@ Documentation/git-bugreport.txt: The following information is requested from the
     +
     + - 'git version --build-options'
     +
    - OPTIONS
    - -------
    - -o <path>::
    + This tool is invoked via the typical Git setup process, which means that in some
    + cases, it might not be able to launch - for example, if a relevant config file
    + is unreadable. In this kind of scenario, it may be helpful to manually gather
     
      ## bugreport.c ##
     @@
 5:  85e11ea125 !  5:  4e18b4678e bugreport: add uname info
    @@ Documentation/git-bugreport.txt: The following information is requested from the
       - 'git version --build-options'
     + - uname sysname, release, version, and machine strings
      
    - OPTIONS
    - -------
    + This tool is invoked via the typical Git setup process, which means that in some
    + cases, it might not be able to launch - for example, if a relevant config file
     
      ## bugreport.c ##
     @@
 6:  d9eafbaa48 !  6:  c18d17443d bugreport: add compiler info
    @@ Documentation/git-bugreport.txt: The following information is captured automatic
       - uname sysname, release, version, and machine strings
     + - Compiler-specific info string
      
    - OPTIONS
    - -------
    + This tool is invoked via the typical Git setup process, which means that in some
    + cases, it might not be able to launch - for example, if a relevant config file
     
      ## bugreport.c ##
     @@
    @@ compat/compiler.h (new)
     +
     +static inline void get_compiler_info(struct strbuf *info)
     +{
    -+	strbuf_addf(info, "glibc: %s", gnu_get_libc_version());
    ++	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
    ++#ifdef __GNUC__
    ++	strbuf_addf(info, "gnuc: %d.%d\n", __GNUC__, __GNUC_MINOR__);
    ++#endif
     +}
     +
     +#else
 7:  f5b6dd4174 !  7:  6d807cf857 bugreport: add git-remote-https version
    @@ Documentation/git-bugreport.txt: The following information is captured automatic
       - Compiler-specific info string
     + - 'git remote-https --build-info'
      
    - OPTIONS
    - -------
    + This tool is invoked via the typical Git setup process, which means that in some
    + cases, it might not be able to launch - for example, if a relevant config file
     
      ## bugreport.c ##
     @@
    @@ bugreport.c
     +{
     +	struct child_process cp = CHILD_PROCESS_INIT;
     +
    -+	argv_array_push(&cp.args, "git");
    ++	cp.git_cmd = 1;
     +	argv_array_push(&cp.args, "remote-https");
     +	argv_array_push(&cp.args, "--build-info");
     +	if (capture_command(&cp, version_info, 0))
 8:  3119c9c1e3 !  8:  f85e1b69d0 bugreport: include user interactive shell
    @@ Documentation/git-bugreport.txt: The following information is captured automatic
       - 'git remote-https --build-info'
     + - $SHELL
      
    - OPTIONS
    - -------
    + This tool is invoked via the typical Git setup process, which means that in some
    + cases, it might not be able to launch - for example, if a relevant config file
     
      ## bugreport.c ##
     @@ bugreport.c: static void get_git_remote_https_version_info(struct strbuf *version_info)
 9:  c35bab2735 !  9:  9980728360 bugreport: generate config safelist based on docs
    @@ generate-bugreport-config-safelist.sh (new)
     +# cat all regular files in Documentation/config
     +find Documentation/config -type f -exec cat {} \; |
     +# print the command name which matches the annotate-bugreport macro
    -+sed -n 's/^\([^[:blank:]]*\)[[:blank:]]\{1,\}annotate:bugreport\[include\].* ::$/  "\1",/p' \
    ++sed -n 's/^\([^ ]*\)  *annotate:bugreport\[include\].* ::$/  "\1",/p' \
     +	| sort
     +
     +cat <<EOF
10:  8a54ebdbbb ! 10:  e9cd8ffec9 bugreport: add config values from safelist
    @@ Documentation/git-bugreport.txt: The following information is captured automatic
       - $SHELL
     + - Selected config values
      
    - OPTIONS
    - -------
    + This tool is invoked via the typical Git setup process, which means that in some
    + cases, it might not be able to launch - for example, if a relevant config file
     
      ## Makefile ##
     @@ Makefile: git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
11:  8bb5bcd8b8 ! 11:  881b62369d bugreport: collect list of populated hooks
    @@ Documentation/git-bugreport.txt: The following information is captured automatic
       - Selected config values
     + - A list of enabled hooks
      
    - OPTIONS
    - -------
    + This tool is invoked via the typical Git setup process, which means that in some
    + cases, it might not be able to launch - for example, if a relevant config file
     
      ## bugreport.c ##
     @@
12:  744dd6aeee ! 12:  715e48e9a7 bugreport: count loose objects
    @@ Documentation/git-bugreport.txt: The following information is captured automatic
       - A list of enabled hooks
     + - The number of loose objects in the repository
      
    - OPTIONS
    - -------
    + This tool is invoked via the typical Git setup process, which means that in some
    + cases, it might not be able to launch - for example, if a relevant config file
     
      ## bugreport.c ##
     @@
13:  2f23e272bf ! 13:  c9e2f1f1d8 bugreport: add packed object summary
    @@ Documentation/git-bugreport.txt: The following information is captured automatic
       - The number of loose objects in the repository
     + - The number of packs and packed objects in the repository
      
    - OPTIONS
    - -------
    + This tool is invoked via the typical Git setup process, which means that in some
    + cases, it might not be able to launch - for example, if a relevant config file
     
      ## bugreport.c ##
     @@ bugreport.c: static void get_loose_object_summary(struct strbuf *obj_info, int nongit) {
    @@ bugreport.c: int cmd_main(int argc, const char **argv)
     
      ## object-store.h ##
     @@
    - #include "list.h"
      #include "sha1-array.h"
      #include "strbuf.h"
    + #include "thread-utils.h"
     +#include "packfile.h"
      
      struct object_directory {
14:  7b5ae1aca1 ! 14:  89762a0de1 bugreport: list contents of $OBJDIR/info
    @@ Documentation/git-bugreport.txt: The following information is captured automatic
       - The number of packs and packed objects in the repository
     + - A list of the contents of .git/objects/info (or equivalent)
      
    - OPTIONS
    - -------
    + This tool is invoked via the typical Git setup process, which means that in some
    + cases, it might not be able to launch - for example, if a relevant config file
     
      ## bugreport.c ##
     @@ bugreport.c: static void get_packed_object_summary(struct strbuf *obj_info, int nongit)
    @@ bugreport.c: static void get_packed_object_summary(struct strbuf *obj_info, int
      }
      
     +static void list_contents_of_dir_recursively(struct strbuf *contents,
    -+				      	     struct strbuf *dirpath)
    ++					     struct strbuf *dirpath)
     +{
     +	struct dirent *d;
     +	DIR *dir;
15:  315b00ed54 ! 15:  aa81e197aa bugreport: summarize contents of alternates file
    @@ Documentation/git-bugreport.txt: The following information is captured automatic
       - A list of the contents of .git/objects/info (or equivalent)
     + - The number of valid and invalid alternates
      
    - OPTIONS
    - -------
    + This tool is invoked via the typical Git setup process, which means that in some
    + cases, it might not be able to launch - for example, if a relevant config file
     
      ## bugreport.c ##
     @@ bugreport.c: static void get_object_info_summary(struct strbuf *obj_info, int nongit)

-- 
2.25.0.265.gbab2e86ba0-goog

