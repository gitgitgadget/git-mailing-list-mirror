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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6722C12002
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 00:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84A7F613CA
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 00:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhGOAsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 20:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhGOAsU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 20:48:20 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD855C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 17:45:26 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l6so2679560wmq.0
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 17:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G2URAEAztj05QIv/KheEm7CWGPiZzepyOG9L4d02Pf4=;
        b=uKCVo9JCnjGUpX3w2zBWktMvZ/1K19y4SBdgQNC4E2q+gcHSHf02vonqXSHvTYRthT
         VdXkB/ViM7/ZDKecUTtYn/9g/J4OTLhswbtuqDTtWDAgYFIZHpxB3qlN7IRi4HzuHO+C
         IvTNjrT0gH2lJCqSzsVsKoNWOLo/JFUWPo+E4+PfS7e0XhBN6Jzf/sb+EpuO3ZhUJv8t
         bBW1/Qa3fhehNSy+rgrlgXR5xYAIjlD9Gixf4jHcZh0TzVunb/Q6rAgDv8FeUrSL1SVV
         QsDHi/gWOeudaDNxD1nsYXnJLT2DapbyjDPNfnR2UrX21kxY2IZZfqwMbyztQSX769TB
         8Ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G2URAEAztj05QIv/KheEm7CWGPiZzepyOG9L4d02Pf4=;
        b=gBOhuVOznmPYt2AFw6tcg5z9WipqplEsKdQYVSMhmoUcgfAe3bJzZbOgFIYyapNeg9
         1QtYk983bM6r+EAI5tujNoorZ7Ekk4LlJOb9uzC1Lu6r94Pk9KtuK6smonMkfiBAfNbw
         wrSGPrlGKjj5HDOTDFonH686Sw2PRZrb9rirY8fY18ZrXW2OTUwUjNMOX+lkTEuXYrqb
         RO/QLE7fDES8fhF7tur6Oq0tD4sGQjc+LVoNdX+UX+BHJ5NyD8YkwOcj+neWfysiRQxf
         swRb/ZRE1J2cHrh/pN2SrdWwz2LIhKo9N5CYEvr8JMdrSpuLgQ/HpG/Qn7fE5iaFBdls
         KKiw==
X-Gm-Message-State: AOAM530vmypHq7mqzAAE0yzcAMe/THWS1j93i4Y0ym1bslfyOcu/kdSq
        /MrVEXRD/54s+jOuk3oSL7CCdC9B0m0=
X-Google-Smtp-Source: ABdhPJzt1NCfCLqaxLuH6DX2KwoTtuHo9ijKUCFSM/j5jAfweYlqyvk64ox9yOrr+M5slCGYZMzfbw==
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr6638056wmc.6.1626309925405;
        Wed, 14 Jul 2021 17:45:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm4298462wru.11.2021.07.14.17.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 17:45:25 -0700 (PDT)
Message-Id: <pull.1044.v3.git.git.1626309924.gitgitgadget@gmail.com>
In-Reply-To: <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com>
References: <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 00:45:20 +0000
Subject: [PATCH v3 0/4] Rename/copy limits -- docs, warnings, and new defaults
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

Changes since v2:

 * Change the meaning of "0" to actually mean unlimited, and modify the
   documentation to mention that.
 * Added 'currently' to descriptions to make it clear the defaults are
   likely to change (again).
 * Added a brief explanation of the exhaustive portion of rename detection,
   as requested by Ævar (though, honestly, I think the thing that actually
   helps people pick values for the limit is the warning that tells people
   that rename detection was skipped and how high they need to set the limit
   if they want to redo the operation and get renames).

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
  diffcore-rename: treat a rename_limit of 0 as unlimited
  Bump rename limit defaults (yet again)

 Documentation/config/diff.txt  |  7 ++++---
 Documentation/config/merge.txt | 10 ++++++----
 Documentation/diff-options.txt | 16 +++++++++++-----
 diff.c                         |  4 ++--
 diffcore-rename.c              |  2 +-
 merge-ort.c                    |  2 +-
 merge-recursive.c              |  2 +-
 7 files changed, 26 insertions(+), 17 deletions(-)


base-commit: d486ca60a51c9cb1fe068803c3f540724e95e83a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1044%2Fnewren%2Frename-limit-documentation-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1044/newren/rename-limit-documentation-v3
Pull-Request: https://github.com/git/git/pull/1044

Range-diff vs v2:

 1:  0d1d0f180a3 = 1:  0d1d0f180a3 diff: correct warning message when renameLimit exceeded
 2:  4046993a9a2 ! 2:  193385d7ca1 doc: clarify documentation for rename/copy limits
     @@ Documentation/config/diff.txt: diff.orderFile::
      -	has no effect if rename detection is turned off.
      +	The number of files to consider in the exhaustive portion of
      +	copy/rename detection; equivalent to the 'git diff' option
     -+	`-l`.  If not set, the default value is 400.  This setting has
     -+	no effect if rename detection is turned off.
     ++	`-l`.  If not set, the default value is currently 400.  This
     ++	setting has no effect if rename detection is turned off.
       
       diff.renames::
       	Whether and how Git detects renames.  If set to "false",
     @@ Documentation/config/merge.txt: merge.verifySignatures::
      +	The number of files to consider in the exhaustive portion of
      +	rename detection during a merge.  If not specified, defaults
      +	to the value of diff.renameLimit.  If neither
     -+	merge.renameLimit nor diff.renameLimit are specified, defaults
     -+	to 1000.  This setting has no effect if rename detection is
     -+	turned off.
     ++	merge.renameLimit nor diff.renameLimit are specified,
     ++	currently defaults to 1000.  This setting has no effect if
     ++	rename detection is turned off.
       
       merge.renames::
       	Whether Git detects renames.  If set to "false", rename detection
     @@ Documentation/diff-options.txt: When used together with `-B`, omit also the prei
      -	The `-M` and `-C` options require O(n^2) processing time where n
      -	is the number of potential rename/copy targets.  This
      -	option prevents rename/copy detection from running if
     -+	The `-M` and `-C` options have an exhaustive portion that
     -+	requires O(n^2) processing time where n is the number of
     -+	potential rename/copy targets.  This option prevents the
     -+	exhaustive portion of rename/copy detection from running if
     - 	the number of rename/copy targets exceeds the specified
     +-	the number of rename/copy targets exceeds the specified
      -	number.
     -+	number.  Defaults to diff.renameLimit.
     ++	The `-M` and `-C` options involve some preliminary steps that
     ++	can detect subsets of renames/copies cheaply, followed by an
     ++	exhaustive fallback portion that compares all remaining
     ++	unpaired destinations to all relevant sources.  (For renames,
     ++	only remaining unpaired sources are relevant; for copies, all
     ++	original sources are relevant.)  For N sources and
     ++	destinations, this exhaustive check is O(N^2).  This option
     ++	prevents the exhaustive portion of rename/copy detection from
     ++	running if the number of source/destination files involved
     ++	exceeds the specified number.  Defaults to diff.renameLimit.
       
       ifndef::git-format-patch[]
       --diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]::
 3:  6f5767607cd ! 3:  00a2072baea doc: document the special handling of -l0
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    doc: document the special handling of -l0
     +    diffcore-rename: treat a rename_limit of 0 as unlimited
      
     -    As noted in commit 89973554b52c (diffcore-rename: make diff-tree -l0
     -    mean -l<large>, 2017-11-29), -l0 has had a magical special "large"
     -    historical value associated with it.  Document this value, particularly
     -    since it is not large enough for some uses -- see commit 9f7e4bfa3b6d
     -    (diff: remove silent clamp of renameLimit, 2017-11-13).
     +    In commit 89973554b52c (diffcore-rename: make diff-tree -l0 mean
     +    -l<large>, 2017-11-29), -l0 was given a special magical "large" value,
     +    but one which was not large enough for some uses (as can be seen from
     +    commit 9f7e4bfa3b6d (diff: remove silent clamp of renameLimit,
     +    2017-11-13).  Make 0 (or a negative value) be treated as unlimited
     +    instead and update the documentation to mention this.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/diff-options.txt ##
      @@ Documentation/diff-options.txt: of a delete/create pair.
     - 	exhaustive portion of rename/copy detection from running if
     - 	the number of rename/copy targets exceeds the specified
     - 	number.  Defaults to diff.renameLimit.
     -++
     -+Note that for backward compatibility reasons, a value of 0 is treated
     -+the same as if a large value was passed (currently, 32767).
     + 	prevents the exhaustive portion of rename/copy detection from
     + 	running if the number of source/destination files involved
     + 	exceeds the specified number.  Defaults to diff.renameLimit.
     ++	Note that a value of 0 is treated as unlimited.
       
       ifndef::git-format-patch[]
       --diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]::
     +
     + ## diffcore-rename.c ##
     +@@ diffcore-rename.c: static int too_many_rename_candidates(int num_destinations, int num_sources,
     + 	 * memory for the matrix anyway.
     + 	 */
     + 	if (rename_limit <= 0)
     +-		rename_limit = 32767;
     ++		return 0; /* treat as unlimited */
     + 	if (st_mult(num_destinations, num_sources)
     + 	    <= st_mult(rename_limit, rename_limit))
     + 		return 0;
 4:  8f1deb6dd16 ! 4:  b41278b6680 Bump rename limit defaults (yet again)
     @@ Documentation/config/diff.txt: diff.orderFile::
       diff.renameLimit::
       	The number of files to consider in the exhaustive portion of
       	copy/rename detection; equivalent to the 'git diff' option
     --	`-l`.  If not set, the default value is 400.  This setting has
     -+	`-l`.  If not set, the default value is 1000.  This setting has
     - 	no effect if rename detection is turned off.
     +-	`-l`.  If not set, the default value is currently 400.  This
     ++	`-l`.  If not set, the default value is currently 1000.  This
     + 	setting has no effect if rename detection is turned off.
       
       diff.renames::
      
     @@ Documentation/config/merge.txt
      @@ Documentation/config/merge.txt: merge.renameLimit::
       	rename detection during a merge.  If not specified, defaults
       	to the value of diff.renameLimit.  If neither
     - 	merge.renameLimit nor diff.renameLimit are specified, defaults
     --	to 1000.  This setting has no effect if rename detection is
     -+	to 7000.  This setting has no effect if rename detection is
     - 	turned off.
     + 	merge.renameLimit nor diff.renameLimit are specified,
     +-	currently defaults to 1000.  This setting has no effect if
     ++	currently defaults to 7000.  This setting has no effect if
     + 	rename detection is turned off.
       
       merge.renames::
      

-- 
gitgitgadget
