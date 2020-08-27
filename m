Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4C8C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 17:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33FE52177B
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 17:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZZdGDU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgH0RpL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgH0RpL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 13:45:11 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C90CC061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 10:45:10 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k15so4061410pfc.12
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 10:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ublb+jlhECrXtd+sGPPc1mTp9Bcx4iCUMkLTbASPHOo=;
        b=IZZdGDU4etjOKlkfV/SKvgRtVEaOC6HowDXa2lA1y810uE1Kkhe7XovujH//8zA2fJ
         stT3LqhyNcN4fKkazpclDEwp1k0w/EGGD/yAtpDT3zl1qeXwLqUd4T+39KVBw2yiDT1t
         /roypFJYb6+Z6L4GXgqtAGkHOy6E4r7srcHkmftoQGqSsIaZ8UijWH80tM2xvfNroPYh
         QMvX0UZCZTg7x7fNRHSLG+DIWpICmzYx9rR19EzI/ciL3xymRY3HyH95fVXDVR/ZVYq5
         gLL/3PdrIMKPH7/sNAYay7UK4/Nwa/j+O29NmP9dc9iKjaIfSaH+PKhAyoXa21Z/GxDG
         yRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ublb+jlhECrXtd+sGPPc1mTp9Bcx4iCUMkLTbASPHOo=;
        b=enZys/aWM1DT5O46o8P1A0BtCIwSamken5EY1ZYvGM9Cdt6V3gLQMnSw/RirL7sijE
         TYKyP2iMH+mpvVpXW71iCvsH1GWXOfbs9TxP3EhS3qH2UsHheX00eO1aiNprRVXq3SFb
         QXnhf9kANk2B5iHgve0OWnfTJKerBYiceHMQsTU2NcPbmiKqovPD/EZcvoOEvj/ql7EA
         YPCcrfefpNZtDWEYhA8bK9u4u/PQRro0Z0eUzgYX7Mp/bnvebk/FAaE/mdQWUOEDkZGN
         3R1+XzcjdRyKlInNlyU5g6+bneQGbOTU0rk3ID69j0OKorfXPHIzNDeMs0VC32DiBhyn
         +hXQ==
X-Gm-Message-State: AOAM531cuyMUpQr+WpQoEdbzPorLOyFrRWsrY4OP2R+0PWE+6SanSnCH
        tPi25RK3vTNBOOca7yJBg0nuDViyGuYpXA==
X-Google-Smtp-Source: ABdhPJznt8SmZjg8qg2iJe0e/2anQeYprVqwLphzcLBp1iKLobnwWyHCHtm38p/v8AwmMLcijMb+YA==
X-Received: by 2002:aa7:92d7:: with SMTP id k23mr17155265pfa.295.1598550308850;
        Thu, 27 Aug 2020 10:45:08 -0700 (PDT)
Received: from konoha.iballbatonwifi.com ([103.84.62.195])
        by smtp.gmail.com with ESMTPSA id i20sm940847pfq.204.2020.08.27.10.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 10:45:08 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     kaartic.sivaraam@gmail.com, christian.couder@gmail.com,
        gitster@pobox.com, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com, peff@peff.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [GSoC][PATCH v2 0/3] submodule: fixup to summary-v3
Date:   Thu, 27 Aug 2020 23:14:58 +0530
Message-Id: <20200827174501.7103-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings,

This is the v2 of the previous patch series with the same title. The v1
received some comments from Junio and Kaartic. The following changes
were made:

    PATCH[3/3] received the comment that it had an unnecessary
    'char *dst_abbrev = NULL' which had to be reverted to 'char
    *dst_abbrev' since the assignment was pretty much useless.
    The commit message also needed some changes in the sense that it
    stated that the change of guarding the
    'verify_submodule_committish()' call was made for dst_abbrev as well
    which wasn't the case. Junio also suggested to clarify the reason
    for not having the guard in case of 'dst_abbrev'.

Another thing which came up was the cleanup of 'submodule--helper.c'. IT
started with Junio commenting on PATCH[2/3] 'submodule: fix style in
function definition'. He asked me to verify if there are any other
similar faults regarding function or variable defintions which had a
faulty asterisk placement. I did some digging and found a fault here in
submodule--helper.c:

    static char *compute_rev_name(const char *sub_path, const char* object_id)

As yiou may notice, the correction should be 's/static char */static
char* /. I also did some further digging and found that there we some
other minor faults in the option descriptions of various subcommands.
For instance in module_foreach:

	struct option module_foreach_options[] = {
		OPT__QUIET(&info.quiet, N_("Suppress output of entering each submodule command")),
		OPT_BOOL(0, "recursive", &info.recursive,
			 N_("Recurse into nested submodules")),
		OPT_END()
	};

The option descriptions should start in lowercase but they start with a
capital letter. This convention is mentioned in L267-270 of
'api-parse-options.txt'. There are other such small violations such as
die() messages starting with a captial letter.

I will do this cleanup after some time when I am a bit free since I have
some personal engagements right now. Or something even better could be
to add this as a 'good first issue' on gitgitgadget/git so that a
newcomer can be something relatively easy and get familiar with the way
work is done at Git. Please do tell what seems more fitting to you.
Also, to be clear, I am not suggesting the latter out of laziness.

I am attaching a range-diff b/w v1 and v2 below for ease of review.
Feedback and reviews are appreciated.

Regards,
Shourya Shukla

-----
range-diff:

1:  a22ffa950f = 1:  768f24de95 submodule: eliminate unused parameters from print_submodule_summary()
2:  32934998ee = 2:  35664360ac submodule: fix style in function definition
3:  82e0956cd2 ! 3:  f5ce59db84 t7421: eliminate 'grep' check in t7421.4 for mingw compatibility
    @@ Commit message

             fatal: exec 'rev-parse': cd to 'my-subm' failed: No such file or directory

    -    Tighten up the check to compute '{src,dst}_abbrev' by guarding the
    +    Tighten up the check to compute 'src_abbrev' by guarding the
         'verify_submodule_committish()' call using `p->status !='D'`, so that
         the former isn't called in case of non-existent submodule directory,
         consequently, there is no such error message on any execution
    -    environment.
    +    environment. The same need not be implemented for 'dst_abbrev' and is
    +    rather redundant since the conditional `if (S_ISGITLINK(p->mod_dst))`
    +    already guards the `verify_submodule_committish` when we have a status
    +    of 'D'.

         Therefore, eliminate the 'grep' check in t7421. Instead, verify the
1:  a22ffa950f = 1:  768f24de95 submodule: eliminate unused parameters from print_submo
dule_summary()
2:  32934998ee = 2:  35664360ac submodule: fix style in function definition
3:  82e0956cd2 ! 3:  f5ce59db84 t7421: eliminate 'grep' check in t7421.4 for mingw comp
atibility
    @@ Commit message

             fatal: exec 'rev-parse': cd to 'my-subm' failed: No such file or directory

    -    Tighten up the check to compute '{src,dst}_abbrev' by guarding the
:...skipping...
1:  a22ffa950f = 1:  768f24de95 submodule: eliminate unused parameters from print_submodule_summary()
2:  32934998ee = 2:  35664360ac submodule: fix style in function definition
3:  82e0956cd2 ! 3:  f5ce59db84 t7421: eliminate 'grep' check in t7421.4 for mingw compatibility
    @@ Commit message

             fatal: exec 'rev-parse': cd to 'my-subm' failed: No such file or directory

    -    Tighten up the check to compute '{src,dst}_abbrev' by guarding the
    +    Tighten up the check to compute 'src_abbrev' by guarding the
1:  a22ffa950f = 1:  768f24de95 submodule: eliminate unused parameters from print_submodule_summary()
2:  32934998ee = 2:  35664360ac submodule: fix style in function definition
3:  82e0956cd2 ! 3:  f5ce59db84 t7421: eliminate 'grep' check in t7421.4 for mingw compatibility
    @@ Commit message
     
             fatal: exec 'rev-parse': cd to 'my-subm' failed: No such file or directory
     
    -    Tighten up the check to compute '{src,dst}_abbrev' by guarding the
    +    Tighten up the check to compute 'src_abbrev' by guarding the
         'verify_submodule_committish()' call using `p->status !='D'`, so that
         the former isn't called in case of non-existent submodule directory,
         consequently, there is no such error message on any execution
    -    environment.
    +    environment. The same need not be implemented for 'dst_abbrev' and is
    +    rather redundant since the conditional `if (S_ISGITLINK(p->mod_dst))`
    +    already guards the `verify_submodule_committish` when we have a status
    +    of 'D'.
     
         Therefore, eliminate the 'grep' check in t7421. Instead, verify the
1:  a22ffa950f = 1:  768f24de95 submodule: eliminate unused parameters from print_submo
dule_summary()
2:  32934998ee = 2:  35664360ac submodule: fix style in function definition
3:  82e0956cd2 ! 3:  f5ce59db84 t7421: eliminate 'grep' check in t7421.4 for mingw comp
atibility
    @@ Commit message
     
             fatal: exec 'rev-parse': cd to 'my-subm' failed: No such file or directory
     
    -    Tighten up the check to compute '{src,dst}_abbrev' by guarding the
:...skipping...
1:  a22ffa950f = 1:  768f24de95 submodule: eliminate unused parameters from print_submodule_summary()
2:  32934998ee = 2:  35664360ac submodule: fix style in function definition
3:  82e0956cd2 ! 3:  f5ce59db84 t7421: eliminate 'grep' check in t7421.4 for mingw compatibility
    @@ Commit message
     
             fatal: exec 'rev-parse': cd to 'my-subm' failed: No such file or directory
     
    -    Tighten up the check to compute '{src,dst}_abbrev' by guarding the
    +    Tighten up the check to compute 'src_abbrev' by guarding the
         'verify_submodule_committish()' call using `p->status !='D'`, so that
         the former isn't called in case of non-existent submodule directory,
         consequently, there is no such error message on any execution
    -    environment.
    +    environment. The same need not be implemented for 'dst_abbrev' and is
    +    rather redundant since the conditional `if (S_ISGITLINK(p->mod_dst))`
    +    already guards the `verify_submodule_committish` when we have a status
    +    of 'D'.
     
         Therefore, eliminate the 'grep' check in t7421. Instead, verify the
         absence of an error message by doing a 'test_must_be_empty' on the
    @@ builtin/submodule--helper.c: static void print_submodule_summary(struct summary_
                                       struct module_cb *p)
      {
     -  char *displaypath, *src_abbrev, *dst_abbrev;
    -+  char *displaypath, *src_abbrev = NULL, *dst_abbrev = NULL;
    ++  char *displaypath, *src_abbrev = NULL, *dst_abbrev;
        int missing_src = 0, missing_dst = 0;
        char *errmsg = NULL;
        int total_commits = -1;
~
~
~
~
~
~
~
~
~         'verify_submodule_committish()' call using `p->status !='D'`, so that
         the former isn't called in case of non-existent submodule directory,
         consequently, there is no such error message on any execution
    -    environment.
    +    environment. The same need not be implemented for 'dst_abbrev' and is
    +    rather redundant since the conditional `if (S_ISGITLINK(p->mod_dst))`
    +    already guards the `verify_submodule_committish` when we have a status
    +    of 'D'.

         Therefore, eliminate the 'grep' check in t7421. Instead, verify the
         absence of an error message by doing a 'test_must_be_empty' on the
    @@ builtin/submodule--helper.c: static void print_submodule_summary(struct summary_
                                       struct module_cb *p)
      {
     -  char *displaypath, *src_abbrev, *dst_abbrev;
    -+  char *displaypath, *src_abbrev = NULL, *dst_abbrev = NULL;
    ++  char *displaypath, *src_abbrev = NULL, *dst_abbrev;
        int missing_src = 0, missing_dst = 0;
        char *errmsg = NULL;
        int total_commits = -1;
~
~
~
~
~
~
~
~
~
-----

Shourya Shukla (3):
  submodule: eliminate unused parameters from print_submodule_summary()
  submodule: fix style in function definition
  t7421: eliminate 'grep' check in t7421.4 for mingw compatibility

 builtin/submodule--helper.c      | 17 ++++++++---------
 t/t7421-submodule-summary-add.sh |  2 +-
 2 files changed, 9 insertions(+), 10 deletions(-)

-- 
2.28.0

