Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25078C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0483D6145D
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhFOPAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 11:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhFOPAG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 11:00:06 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B94C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 07:58:01 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x73so13457275pfc.8
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 07:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bokvBJa2KOB9VT/r1QS3dhNQRJBpFqtAohjBNxfSVek=;
        b=H0PBjK0ML8y2pgc2Osyi+mQZRZYz//IiMgAaX8Qo5v12iY04Ou5ELd+Cs1Rufdjdyi
         KBLhsXR6r9V6fFC9VrZ/lLnzCPbHVI//oA3tgqcUExe0penPh/lDT48srGrwZbkPPIOG
         +upI7fWCJmAmhcKQtogcRk1eCUh/H1XL/r8cYJ6lxzpzeoYASra7Wy39UzS28ypA9/Gx
         PSjGwLty0tB+o5ELpNFIXJD7UcKkvMposMauzRkO+k7K37rEVCLwRX7ghvhE+hSL5B+Q
         BFCNVtZzrII9LOzZYoJlQwsDNeyGTvNp6oXdu50QHzkSJHd4xSMePX5us4n1m3uuNo3W
         XsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bokvBJa2KOB9VT/r1QS3dhNQRJBpFqtAohjBNxfSVek=;
        b=De2tqTLSxaVSxR6J0CioFxLam76Nv+xWXQyi0KGhCxzdqNr4MmElaiwouXoWYYs+Jt
         ulFmhJtQAiCSM77rIyCjeJf5dWE4pXq0McGWPHcjGEaPUILzvv3DePstDv2kiRQQRkyJ
         S5YNFIPn6CDlhkmJWoJqBWbMGrH6DBTvNPFT7EZ6ASurgpaGURM/chrFMS2wh5RamS1M
         EbwPyBxTCDzOEUbf2Oqry6PQWxvOkKl52+PO3Q0ojN2r6eH0kjH4YY7i/r4g/NwyCn0z
         Xj2d6lXO0EA22CmC9R/xx7QgY8qKEudyhANPMCM5ALzA+6/ua8kDniksZz/y5j9DYhMX
         cijQ==
X-Gm-Message-State: AOAM530r0kYj/rOi6uXUjYwALLJnTSuOb13tvUdka+Z2xvYgEl2Vzg7g
        hi2vdv6V1xoYtmxsugwIk6DRx/+RdJ1ynw+XjFY=
X-Google-Smtp-Source: ABdhPJxtLEloVcyZl6nYFKL6fCQI7rTaTzuj+qxFM6mwlvNFUh9tasmSTy0yFMI4FsRcpERNFZ4ncQ==
X-Received: by 2002:a05:6a00:844:b029:2f8:5436:dc39 with SMTP id q4-20020a056a000844b02902f85436dc39mr4807303pfk.10.1623769080926;
        Tue, 15 Jun 2021 07:58:00 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id u1sm16340120pgh.80.2021.06.15.07.57.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jun 2021 07:58:00 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [GSoC] [PATCH v6 0/3] submodule--helper: introduce subcommands for sh to C conversion
Date:   Tue, 15 Jun 2021 20:27:42 +0530
Message-Id: <20210615145745.33382-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210615093810.27930-1-raykar.ath@gmail.com>
References: <20210615093810.27930-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In [2/3]:
I noticed that my previous code fails to parse prefixes properly when it has not
been explicitly stated by the subcommand caller.

Atharva Raykar (3):
  submodule--helper: refactor module_clone()
  submodule--helper: introduce add-clone subcommand
  submodule--helper: introduce add-config subcommand

 builtin/submodule--helper.c | 543 ++++++++++++++++++++++++++++--------
 git-submodule.sh            |  66 +----
 2 files changed, 432 insertions(+), 177 deletions(-)

Range-diff against v5:
1:  068568f997 = 1:  068568f997 submodule--helper: refactor module_clone()
1:  10734cf91a ! 2:  06b2075580 submodule--helper: introduce add-clone subcommand
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
     +		OPT_STRING('b', "branch", &add_data.branch,
     +			   N_("branch"),
     +			   N_("branch of repository to checkout on cloning")),
    -+		OPT_STRING(0, "prefix", &add_data.prefix,
    ++		OPT_STRING(0, "prefix", &prefix,
     +			   N_("path"),
     +			   N_("alternative anchor for relative paths")),
     +		OPT_STRING(0, "path", &add_data.sm_path,
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
     +	if (argc != 0)
     +		usage_with_options(usage, options);
     +
    ++	add_data.prefix = prefix;
     +	add_data.progress = !!progress;
     +	add_data.dissociate = !!dissociate;
     +	add_data.force = !!force;
2:  383f0b6217 = 3:  3e827a3858 submodule--helper: introduce add-config subcommand

--
2.31.1

