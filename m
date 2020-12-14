Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D9BC4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 23:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A8522510
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 23:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733105AbgLNXUu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 18:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732831AbgLNXUt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 18:20:49 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C1EC061793
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 15:20:09 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w5so13087798pgj.3
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 15:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s7TMuw4JA+124184dH25qfbXaNrXmjHUJ8g/8xUikSE=;
        b=txYLDiMYFtwoFuKxGgJzZvzsMRTMdQqGK37MIHeHUp8FlS9zP+N9YzXAl4tScN82xY
         ST/LWn8Y/y1KsmqJs0Ub0ZWgywlRddRHVff8ZmRYwFno/kmUPXArVBjqSgvziHa+E+zl
         +w+EPvIlD7l9XyB+0tVqoyJWoqdSlzWPzclIOykkOhQTrnyZmceWacyuDSOm0e8M58CS
         1RCe9dffyIHzmCgFc53wENjavlorEqTRCK+yNot6vUjjTdSti4cnS49tAprHfhAIZWCW
         KdV6x5NRV8k0ah5br27av62/naNvn9KA6+bpkrRRHzOK0wGGLWSNV93EMCqGS8C74I+I
         U4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s7TMuw4JA+124184dH25qfbXaNrXmjHUJ8g/8xUikSE=;
        b=HRlxKNMLHiMo+zte9QF2rqOdbga9hqpAEkiKdTA/+VB039L+nEWOlfFTRLh5VYvsk0
         MAwil1dfOOasij66HRjyTnYrR8OtqBnDTTVJSuaC7zu9/yGwRAenqIBOMvtRosnKoQLz
         liAme51t9R7qKIl/q0i37JpQlX8qpM50SpCXKWefKkpT4PqP9HjIGppe5G6JguIOxK0n
         ivoTHMVaYM4FeyOHSTIajBAc2c3QgfGoC5ZKYyPMYVZGQExbqXO8tFBZFCGX+R90/qzz
         tLbUY4pAy9RaOAJX2Gwyl+iqi0eXRRSWLGXmC+FAFOpNIheXfleHt1tJHDMWWAXVjX3h
         n6sw==
X-Gm-Message-State: AOAM5330NQoOGMBdRYGmzemFLII7go+nBu37PvHSpB9dVECrrf3DT1rk
        mbRLWr7vVdsvPbfLsR7mU7/SJ99oiBfUvA==
X-Google-Smtp-Source: ABdhPJxqR0P5Nkb0JWE62wY5/4CwHaMY5EPKlpv9gBi5N2Q+Y1DPr/8MgMXKEr6UNBpKyyr5ychMBg==
X-Received: by 2002:aa7:83c2:0:b029:1a5:daa9:f22f with SMTP id j2-20020aa783c20000b02901a5daa9f22fmr5421765pfn.48.1607988008736;
        Mon, 14 Dec 2020 15:20:08 -0800 (PST)
Received: from localhost.localdomain ([27.56.186.8])
        by smtp.gmail.com with ESMTPSA id z10sm21282983pfr.204.2020.12.14.15.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 15:20:07 -0800 (PST)
From:   Shourya Shukla <periperidip@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Shourya Shukla <periperidip@gmail.com>
Subject: [PATCH v3 0/3] submodule: port subcommand add from shell to C
Date:   Tue, 15 Dec 2020 04:49:36 +0530
Message-Id: <20201214231939.644175-1-periperidip@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings,

This is the v3 of the patch series with the same title. You may view
the v2 here:
https://lore.kernel.org/git/20201007074538.25891-1-shouryashukla.oo@gmail.com/

I have applied almost all of the changes asked before, except a few
which confused me a little. It would be great if I could get some help
about them:

    1. In this mail: https://lore.kernel.org/git/xmqqo8ldznjx.fsf@gitster.c.googlers.com/
       Junio asked me to accomodate for a merge in progress since
       'cache_pos < 0' does not necessarily mean that the path exists.
       I was wondering which function would be the most appropriate for
       the if-statements:
            if (!force) {
		        if (cache_pos >= 0 || dir_in_cache)
            }
       I was thinking of going with 'read_cache_unmerged()'. I thought
       of this by seeing what is triggered in case of a merge conflict
       and cam across this. What is your opinion on this?

    2. In this mail: https://lore.kernel.org/git/xmqqimbky6st.fsf@gitster.c.googlers.com/
       In this section:
            /* strip trailing '/' */
	        if (is_dir_sep(sm_path[strlen(sm_path) -1]))
		        sm_path[strlen(sm_path) - 1] = '\0';

       Junio makes a reasonable argument that we need to make sure that
       multiple trailing slashes are eliminated but my code only takes
       care of a single trailing slash. I was looking into the code of
       'normalize_path_copy()' and saw that the function it essentially
       calls: 'normalize_path_copy_len()' does not perform anything on
       the trailing slashes and this behaviour is mentioned as a
       NEEDSWORK.

       I was thinking of correcting the above function instead of
       putting in an extra loop. Is this feasible?

    3. In the following segment:
        /*
         * NEEDSWORK: In a multi-working-tree world, this needs to be
         * set in the per-worktree config.
         */
        if (!git_config_get_string("submodule.active", &var) && var) {

        There was a comment: "What if this were a valueless true
        ("[submodule] active\n" without "= true")?  Wouldn't get_string()
        fail?"

        I was under the impression that even if the above failed, it
        will not really affect the big picture since at the we will set
        'submodule.name.active" as true irrespective of the above value.
        Is this correct?

Feedback and reviews are appreciated.

Regards,
Shourya Shukla

Shourya Shukla (3):
  dir: change the scope of function 'directory_exists_in_index()'
  submodule: port submodule subcommand 'add' from shell to C
  t7400: add test to check 'submodule add' for tracked paths

 builtin/submodule--helper.c | 410 +++++++++++++++++++++++++++++++++++-
 dir.c                       |  30 ++-
 dir.h                       |   9 +
 git-submodule.sh            | 161 +-------------
 t/t7400-submodule-basic.sh  |  13 +-
 5 files changed, 443 insertions(+), 180 deletions(-)

-- 
2.25.1

