Return-Path: <SRS0=24Vd=34=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05076C35250
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0D1217BA
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmMYs4Ah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgBHJI0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 04:08:26 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:51449 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgBHJI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 04:08:26 -0500
Received: by mail-wm1-f43.google.com with SMTP id t23so4868420wmi.1
        for <git@vger.kernel.org>; Sat, 08 Feb 2020 01:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BEf5Et9siW0jrcTQ6HLROSKXamHHZiSaNVE0MDkrOaY=;
        b=cmMYs4AhiiLYtd5H8vreEjYr8C0YVOuJRmz4N2rNVvVrIgbvYLP1UcYywYS9x+2w3y
         poQ0InTNTG4UwGhLwoAspS0IprUiUPhjA9aOBQ6Db200kLlf4m09Hh/KCpzDM74EiQkv
         4V4zzNJSWA2nloSTPNOQELMT/ykmE8p3YQ8I8sZ/6+5amZYWGdUM0mGatPfOZW4LaEB6
         ipFgAnTflMTPHUtL7anT7SYeRh8cLsNe0qfN5mlTRpJ8YekiX6fN6ZGR5q+tkUQ7Ys8n
         8FgvRvUa9GkzOlsOEThD47ZfxPuskDUSTyBeNo/zAbidIceiUMwPYFjADM4pNYycZd2q
         +Yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BEf5Et9siW0jrcTQ6HLROSKXamHHZiSaNVE0MDkrOaY=;
        b=eO5N2cMHd+6h/rswsYo3HLyVsABX5Dhc3jbZP4cHjWdudJiZYSH84aj4L2g3X7vxAB
         svAEn9VabdR2rdwpzJ51AGCLNen29ojZO4gsqr6n18QPndbRilk0No+CgVg9UPwPVSwa
         5KbpEDGVa1wy+z+qROhndXS0d2s8iJeqPQXoqoDL+72ELIv3rCJYYqjidnatuU0bM/Fn
         5STqro1vP644zo/TxcSn1jHFqalJhRD2mYXdYG1Y+0YlrNj+86d2hGtMtpW1PrlfrPKw
         rKn8Al38Q8GZR0gGS2BhZCIrkM5UjD+e8LWAnXKfJTu0XLqzxU0iUPZp9ZyUPpQr3/QK
         QIdw==
X-Gm-Message-State: APjAAAUVmGOq/POiVqTb3tRuo8fAQB3cVgeAaLvq7VN1m7DW5cXLE6sg
        f1dRoV57ViiS3GWDjfDHrBfsDN6t
X-Google-Smtp-Source: APXvYqwxgUV/1xsCAJzDofi5qXhafRwxEqop6W4dv63iCdAxGfZxmUg05MzLivTLuNry7YThG/TOow==
X-Received: by 2002:a05:600c:d5:: with SMTP id u21mr3566190wmm.98.1581152903727;
        Sat, 08 Feb 2020 01:08:23 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id e1sm6999346wrt.84.2020.02.08.01.08.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 01:08:23 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [Outreachy] [PATCH v3 00/13] Finish converting git bisect to C part 1
Date:   Sat,  8 Feb 2020 10:06:51 +0100
Message-Id: <20200208090704.26506-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches correspond to a first part of patch series 
of Outreachy project "Finish converting `git bisect` from shell to C" 
started by Pranit Bauva and Tanushree Tumane
(https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
continued by me.

This first part is formed of preparatory/clean-up patches and all 
`bisect.c` libification work. 

I would like to thank Johannes Schindelin and Junio Hamano for reviewing
the patch series.

These patch series emails were generated from:
https://gitlab.com/mirucam/git/commits/git-bisect-work-part1-v3

--- Changes since v2 Finish converting git bisect to C part 1 patch series ---

General changes
---------------

* Rebase on master branch: de93cc14ab (The third batch for 2.26, 2020-02-05).
* Amend commit messages.
* Add an enum to represent bisecting error codes.

Specific changes
----------------

[5/13] bisect--helper: introduce new `decide_next()` function

* Change const char* types to char* and fix `free()` calls.

--

[6/13] bisect: add enum to represent bisect returning codes

* New patch that adds an enum to represent bisecting error codes.

--

[7/13] bisect--helper: return error codes from `cmd_bisect__helper()`

* New patch split from `libify `check_good_are_ancestors_of_bad` and its 
dependents`.
* Change code in return for readability.

--

[8/13] bisect: libify `exit_if_skipped_commits` to `error_if_skipped*` 
and its dependents

* Remove comments.

--

[9/13] bisect: libify `bisect_checkout`

* Fix declaration block.
* Change code in return for readability.
* Add comments.

--

[11/13] bisect: libify `check_good_are_ancestors_of_bad` and its 
dependents

* Fix brace location.

--

Miriam Rubio (3):
  bisect--helper: convert `vocab_*` char pointers to char arrays
  bisect: use the standard 'if (!var)' way to check for 0
  bisect: add enum to represent bisect returning codes

Pranit Bauva (8):
  run-command: make `exists_in_PATH()` non-static
  bisect--helper: return error codes from `cmd_bisect__helper()`
  bisect: libify `exit_if_skipped_commits` to `error_if_skipped*` and
    its dependents
  bisect: libify `bisect_checkout`
  bisect: libify `check_merge_bases` and its dependents
  bisect: libify `check_good_are_ancestors_of_bad` and its dependents
  bisect: libify `handle_bad_merge_base` and its dependents
  bisect: libify `bisect_next_all`

Tanushree Tumane (2):
  bisect--helper: change `retval` to `res`
  bisect--helper: introduce new `decide_next()` function

 bisect.c                 | 135 +++++++++++++++++++++++++++------------
 bisect.h                 |  29 ++++++++-
 builtin/bisect--helper.c | 123 +++++++++++++++++++----------------
 run-command.c            |   2 +-
 run-command.h            |  11 ++++
 5 files changed, 201 insertions(+), 99 deletions(-)

-- 
2.25.0

