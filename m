Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF0DC433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 19:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A2D20897
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 19:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4h7pXHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIITrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgIITrp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 15:47:45 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481D9C061573
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 12:47:44 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id m6so4258261wrn.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 12:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=US1F8ADxmKkEf83XRqjzO0cbYFexDKssZ/triYelF9w=;
        b=o4h7pXHbxLDoj6WRg6f/blG0TDEkCoJuQY/cnYzUw/oQ7pEOJfahcOGPUNhmyM2xOp
         bsZdz/tMgzd/CZZBDq4Okp6mYwpi3rLAW9WAKG6pJlBDybOTBnRCa3dO/uXjm5vYacu4
         SaO9dBjdNrFJqO7J8FMADTJfJOcMPRe7abgGvogrpI34RoXZTwE1ltmHHqRvwI5d4wLw
         5Tr85QRRnJPRDeTgbwdQplg4mWkcvzIp5dcnejRWxXZAZP6Rg+MciuqFPgvhaWkAfI+h
         Ewnmtjlv9yWDsAdpe35dU3YPWtQosC0aeFWsUz8hPNCh8R8cY6rRD57zafV5aqydtu8N
         OSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=US1F8ADxmKkEf83XRqjzO0cbYFexDKssZ/triYelF9w=;
        b=MXvV1jz279YVVOijQLhgZO3KmAzf7YSJxo2EraF4Y+0Q4jAQvD/+Z6LWK5DKJKfaxw
         lSwFrBXpkkHO9muusl+64MMuC3sBJPwdhSucWc8wiN3Eh/fPHNrgTFbrcbq3Jvoqs4Uy
         Tme6t/BSGRJHITpNiTIvSBTMArLfj3MYDpTEvAj6wS9kHr+34+0g77zXzUrdY2aU/CSI
         M94XqlFLWliJq5tBOGCcMDLuFEZZPsHjIbyL75w6K3wweAQnYnc7Y8ltUZJG2wt9lU99
         nIdiSX72tg5CKfufv2ACGdfLn92Go5njIoKOB72BAqr9k524o4yrH+lWmdFTZ0OMnaUX
         jxvg==
X-Gm-Message-State: AOAM532YcK6SppVwJv2ohhwJQ/xbDHdPo6P+wSiCrgvTDMjjVtbRE786
        aeJwcwDRorK8rrpjCncfPO3a22Bd/nk=
X-Google-Smtp-Source: ABdhPJw4XIB1XLbL4aihV5YpaC8KoQXZvNWEKt35G7FqdzGTmo/67wlh2If2bLWOyp3p68zNJjLU3g==
X-Received: by 2002:adf:e7ce:: with SMTP id e14mr5247572wrn.43.1599680862583;
        Wed, 09 Sep 2020 12:47:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k4sm5526491wrx.51.2020.09.09.12.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 12:47:42 -0700 (PDT)
Message-Id: <pull.694.v2.git.1599680861.gitgitgadget@gmail.com>
In-Reply-To: <pull.694.git.1596675905.gitgitgadget@gmail.com>
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
From:   "KADOTA, Kyohei via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Sep 2020 19:47:39 +0000
Subject: [PATCH v2 0/2] Fit the building tools to Plan 9 environment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "KADOTA, Kyohei" <lufia@lufia.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've posted some commits for porting git to Plan 9.

This pull request is thing that cut off building scripts from #305 and is
re-constructed that.

I expect this don't change any artifacts.

differ from v1
==============

 * drop some adapters, printf, cut, expr or tar
 * drop using SHELL_PATH instead of sh
 * use real name at Signed-off-by signature

Kyohei Kadota (2):
  Fit to Plan 9's ANSI/POSIX compatibility layer
  Use $(LD) instead of $(CC) for linking the object files

 .github/workflows/main.yml |  1 +
 Makefile                   | 15 +++++----
 ci/lib.sh                  |  8 ++++-
 config.mak.in              |  1 +
 config.mak.uname           |  6 ++++
 generate-cmdlist.sh        |  4 +--
 t/chainlint.sed            | 66 +++++++++++++++++++-------------------
 7 files changed, 58 insertions(+), 43 deletions(-)


base-commit: 3a238e539bcdfe3f9eb5010fd218640c1b499f7a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-694%2Flufia%2Fcompat-p9-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-694/lufia/compat-p9-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/694

Range-diff vs v1:

 1:  1f63b4fc7c < -:  ---------- Use $(SHELL_PATH) instead of sh in Makefile.
 2:  22f8f3e37a < -:  ---------- Define TAR_CF and TAR_XF variables in Makefile
 3:  d15ed626de ! 1:  c850888c25 Fit to Plan 9's ANSI/POSIX compatibility layer
     @@
       ## Metadata ##
     -Author: lufia <lufia@lufia.org>
     +Author: Kyohei Kadota <lufia@lufia.org>
      
       ## Commit message ##
          Fit to Plan 9's ANSI/POSIX compatibility layer
      
     -    That haven't any commands: cut, expr and printf.
     +    tr(1) of ANSI/POSIX environment, aka APE, don't support \n literal.
     +    It's handles only octal(\ooo) or hexadecimal(\xhhhh) numbers.
      
          And its sed(1)'s label is limited to maximum seven characters.
          Therefore I replaced some labels to drop a character.
     @@ Commit message
          * shell -> sh
          * string -> str
      
     -    Signed-off-by: lufia <lufia@lufia.org>
     -
     - ## GIT-VERSION-GEN ##
     -@@ GIT-VERSION-GEN: else
     - 	VN="$DEF_VER"
     - fi
     - 
     --VN=$(expr "$VN" : v*'\(.*\)')
     -+VN=${VN#v}
     - 
     - if test -r $GVF
     - then
     +    Signed-off-by: Kyohei Kadota <lufia@lufia.org>
      
       ## generate-cmdlist.sh ##
     -@@ generate-cmdlist.sh: die () {
     - }
     - 
     - command_list () {
     --	eval "grep -ve '^#' $exclude_programs" <"$1"
     -+	eval "grep -v -e '^#' $exclude_programs" <"$1"
     +@@ generate-cmdlist.sh: command_list () {
       }
       
       get_categories () {
     @@ generate-cmdlist.sh: die () {
       	grep -v '^$' |
       	sort |
       	uniq
     -@@ generate-cmdlist.sh: get_categories () {
     - 
     - category_list () {
     - 	command_list "$1" |
     --	cut -c 40- |
     -+	awk '{ print substr($0, 40) }' |
     - 	get_categories
     - }
     +@@ generate-cmdlist.sh: category_list () {
       
       get_synopsis () {
       	sed -n '
     @@ generate-cmdlist.sh: get_categories () {
       		${
       			x
       			s/.*'"$1"' - \(.*\)/N_("\1")/
     -@@ generate-cmdlist.sh: define_category_names () {
     - 	echo "};"
     - }
     - 
     -+if test -z "$(echo -n)"
     -+then
     -+	alias print='echo -n'
     -+else
     -+	alias print='printf %s'
     -+fi
     -+
     - print_command_list () {
     - 	echo "static struct cmdname_help command_list[] = {"
     - 
     - 	command_list "$1" |
     - 	while read cmd rest
     - 	do
     --		printf "	{ \"$cmd\", $(get_synopsis $cmd), 0"
     -+		print "	{ \"$cmd\", $(get_synopsis $cmd), 0"
     - 		for cat in $(echo "$rest" | get_categories)
     - 		do
     --			printf " | CAT_$cat"
     -+			print " | CAT_$cat"
     - 		done
     - 		echo " },"
     - 	done
      
       ## t/chainlint.sed ##
      @@
 4:  4ebd56a3c5 ! 2:  6f35562965 Use $(LD) instead of $(CC) for linking the object files
     @@
       ## Metadata ##
     -Author: lufia <lufia@lufia.org>
     +Author: Kyohei Kadota <lufia@lufia.org>
      
       ## Commit message ##
          Use $(LD) instead of $(CC) for linking the object files
     @@ Commit message
          The compilers are called 8c, 6c... for each machine architectures;
          corresponded loaders are called 8l, 6l...
      
     -    Signed-off-by: lufia <lufia@lufia.org>
     +    Signed-off-by: Kyohei Kadota <lufia@lufia.org>
      
       ## .github/workflows/main.yml ##
      @@ .github/workflows/main.yml: jobs:
     @@ Makefile: compat/nedmalloc/nedmalloc.sp: SP_EXTRA_FLAGS += -Wno-non-pointer-null
      -	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
      +	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
       
     - git-bugreport$X: bugreport.o GIT-LDFLAGS $(GITLIBS)
     --	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
     -+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
     - 		$(LIBS)
     - 
       git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
      -	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
      +	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
     @@ Makefile: compat/nedmalloc/nedmalloc.sp: SP_EXTRA_FLAGS += -Wno-non-pointer-null
      +	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
       		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
       
     - git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITLIBS) $(VCSSVN_LIB)
     --	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS) \
     -+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS) \
     - 	$(VCSSVN_LIB)
     - 
       $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
      @@ Makefile: $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
       	cp $< $@
     @@ Makefile: $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
       		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
       
       $(LIB_FILE): $(LIB_OBJS)
     -@@ Makefile: t/helper/test-svn-fe$X: $(VCSSVN_LIB)
     +@@ Makefile: perf: all
       t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
       
       t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)

-- 
gitgitgadget
