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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5A8C07E96
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0CA6613AC
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbhGNBP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 21:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237198AbhGNBP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 21:15:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61857C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 18:12:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v5so1025451wrt.3
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 18:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CvvaOBVE3CM28dLmUzqY3kkViuNk/kPx5rHlbFYgEC4=;
        b=FIPfTA1skKZ9j20TPJ6zlo/AMJmDLnCeUisKF9Gjf1l5WjraT2UgDjfA5tU13gN7RF
         t8eFvWvRC0p29GDCbRYm64Df4B3njjglbS/thiy7efleBEj6PQ1b6FgJiFQvPCLzKUEO
         lzeIlLigal4nBqbPkM9XN3rg1Ki7Xa6qJ1JTxfI1vNwDlbSU3N35PIhK2IsNXW57BPRZ
         48WZvphLIaiWaw2Alg555ioLsZnvSmdAWKq36Z9diOCi1r2fu8P7LPE7d3cadt5wZZmu
         fBPFDqCbUtNAxQUABul6VEb38AfHLTtSlpJ9p+eQ1F2kOZAPBMcmR70Cw5XgBQEjdJSJ
         c2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CvvaOBVE3CM28dLmUzqY3kkViuNk/kPx5rHlbFYgEC4=;
        b=ujtySg/XKEjAAE9omVOU1TdLHGcSGXkjgtFWDp/Ry0GQgzgL5swWenZIYDA6wbbICF
         RFcAFYb6XTdr6oMTvPcMDxD57XxDgnqo64FzkCZJLvVcp/J9YdNfiIzVDY7AxRkHNy1k
         DuzMff8MOSMS0Sagy5smWDvogLTwoDapl3e+ED11wAqRE/TxnWJdTH+Xocv3gUUqmnSH
         AlNmMiJ2N286nR0UlHFOKrIbeNmDqoiB3Grl9luaVsHmNcRLXyOr7RWGH/vUpQHar9qi
         dXqHpH11Xr6gIBhEGnyhtS8hLmEn0bRW3zRXs19i5OI7Htb50ltQdZyHS8k2GWJObt1V
         v8Gw==
X-Gm-Message-State: AOAM531Ab1sGAQsRoX7xig4xQVhO8/8NoVP0omQrU0wUNGwl7/aumtRd
        p+2aL9Zn+A+y5hM9DKM2ieTdtyMi7cI=
X-Google-Smtp-Source: ABdhPJxbAqePo8seKRAUcgFlPV+PXhnMZQrxiLfL0ByLQ03O7+LX88OWe1ZNK0bNyfLbEo4z8ZrfUw==
X-Received: by 2002:adf:f2c6:: with SMTP id d6mr9455650wrp.286.1626225154959;
        Tue, 13 Jul 2021 18:12:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w3sm511146wrt.55.2021.07.13.18.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 18:12:34 -0700 (PDT)
Message-Id: <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com>
In-Reply-To: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 01:12:29 +0000
Subject: [PATCH v2 0/4] Rename/copy limits -- docs, warnings, and new defaults
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a few small issues with documentation and warnings around the limits for
the quadratic portion of rename (&copy) detection, and bump the default
limits.

Discussion on bumping the limits can be found at [1]. Although it appears we
generally agree we could switch to an unlimited setting for
merge.renameLimit, that would require some changes to progress bars to
notify users how to take action once things start taking a while. So, for
now, just bump the limits.

[1]
https://lore.kernel.org/git/CABPp-BFzp3TCWiF1QAVSfywDLYrz=GOQszVM-sw5p0rSB8RWvw@mail.gmail.com/T/#u

Changes since v1:

 * Shuffled patch order since the explanation of why "inexact rename
   detection" is incorrect was in the third patch
 * Use the term "exhaustive rename detection" for the quadratic portion
 * Simplify -l description by just stating that it defaults to
   diff.renameLimit (since it in turn has the right default value)
 * Fix asciidoc formating
 * Include bump of the limits in a new patch

Elijah Newren (4):
  diff: correct warning message when renameLimit exceeded
  doc: clarify documentation for rename/copy limits
  doc: document the special handling of -l0
  Bump rename limit defaults (yet again)

 Documentation/config/diff.txt  |  7 ++++---
 Documentation/config/merge.txt | 10 ++++++----
 Documentation/diff-options.txt | 12 ++++++++----
 diff.c                         |  4 ++--
 merge-ort.c                    |  2 +-
 merge-recursive.c              |  2 +-
 6 files changed, 22 insertions(+), 15 deletions(-)


base-commit: d486ca60a51c9cb1fe068803c3f540724e95e83a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1044%2Fnewren%2Frename-limit-documentation-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1044/newren/rename-limit-documentation-v2
Pull-Request: https://github.com/git/git/pull/1044

Range-diff vs v1:

 3:  44a5d5efaa6 ! 1:  0d1d0f180a3 diff: correct warning message when renameLimit exceeded
     @@ Commit message
          detection" was an accurate way to refer to the quadratic portion of
          rename detection.  However, that changed with commit bd24aa2f97a0
          (diffcore-rename: guide inexact rename detection based on basenames,
     -    2021-02-14), so now the correct way to refer to quadratic rename
     -    detection is "quadratic rename detection".  Fix the warning accordingly.
     +    2021-02-14).  Let's instead use the term "exhaustive rename detection"
     +    to refer to the quadratic portion.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ diff.c: static int is_summary_empty(const struct diff_queue_struct *q)
       
       static const char rename_limit_warning[] =
      -N_("inexact rename detection was skipped due to too many files.");
     -+N_("quadratic rename detection was skipped due to too many files.");
     ++N_("exhaustive rename detection was skipped due to too many files.");
       
       static const char degrade_cc_to_c_warning[] =
       N_("only found copies from modified paths due to too many files.");
 1:  7dc448df6ec ! 2:  4046993a9a2 doc: clarify documentation for rename/copy limits
     @@ Documentation/config/diff.txt: diff.orderFile::
      -	The number of files to consider when performing the copy/rename
      -	detection; equivalent to the 'git diff' option `-l`. This setting
      -	has no effect if rename detection is turned off.
     -+	The number of files to consider in the quadratic portion of
     ++	The number of files to consider in the exhaustive portion of
      +	copy/rename detection; equivalent to the 'git diff' option
      +	`-l`.  If not set, the default value is 400.  This setting has
      +	no effect if rename detection is turned off.
     @@ Documentation/config/merge.txt: merge.verifySignatures::
      -	during a merge; if not specified, defaults to the value of
      -	diff.renameLimit. This setting has no effect if rename detection
      -	is turned off.
     -+	The number of files to consider in the quadratic portion of
     ++	The number of files to consider in the exhaustive portion of
      +	rename detection during a merge.  If not specified, defaults
      +	to the value of diff.renameLimit.  If neither
      +	merge.renameLimit nor diff.renameLimit are specified, defaults
     @@ Documentation/diff-options.txt: When used together with `-B`, omit also the prei
      -	The `-M` and `-C` options require O(n^2) processing time where n
      -	is the number of potential rename/copy targets.  This
      -	option prevents rename/copy detection from running if
     --	the number of rename/copy targets exceeds the specified
     ++	The `-M` and `-C` options have an exhaustive portion that
     ++	requires O(n^2) processing time where n is the number of
     ++	potential rename/copy targets.  This option prevents the
     ++	exhaustive portion of rename/copy detection from running if
     + 	the number of rename/copy targets exceeds the specified
      -	number.
     -+	The `-M` and `-C` options can require O(n^2) processing time
     -+	where n is the number of potential rename/copy targets.  This
     -+	option prevents the quadratic portion of rename/copy detection
     -+	from running if the number of rename/copy targets exceeds the
     -+	specified number.  Defaults to diff.renameLimit, or if that is
     -+	also unspecified, to 400.
     ++	number.  Defaults to diff.renameLimit.
       
       ifndef::git-format-patch[]
       --diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]::
 2:  ee0969429cb ! 3:  6f5767607cd doc: document the special handling of -l0
     @@ Commit message
      
       ## Documentation/diff-options.txt ##
      @@ Documentation/diff-options.txt: of a delete/create pair.
     - 	specified number.  Defaults to diff.renameLimit, or if that is
     - 	also unspecified, to 400.
     + 	exhaustive portion of rename/copy detection from running if
     + 	the number of rename/copy targets exceeds the specified
     + 	number.  Defaults to diff.renameLimit.
     +++
     ++Note that for backward compatibility reasons, a value of 0 is treated
     ++the same as if a large value was passed (currently, 32767).
       
     -+	Note that for backward compatibility reasons, a value of 0 is treated
     -+	the same as if 32767 was passed.
     -+
       ifndef::git-format-patch[]
       --diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]::
     - 	Select only files that are Added (`A`), Copied (`C`),
 -:  ----------- > 4:  8f1deb6dd16 Bump rename limit defaults (yet again)

-- 
gitgitgadget
