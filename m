Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D383C4320A
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71E896109E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244818AbhIBJGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbhIBJGR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 05:06:17 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA970C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 02:05:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g18so1708833wrc.11
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 02:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7CU2Ztz68587TSuRefUDulzhzN3HY2j1Ll4XHjUCA8Q=;
        b=BVoraVohzHxHFHFdpYRSsCegEmzHEiP2HnWxPTAC2l6KM6j8oHPZCF87PD1Hwfwhm3
         EgFM1GXs8O1Vg56cSeHNAnfS0/adGZ/dzFP29K96l+iGYxqB9YQ9dk1nyHS/F3IQgdyB
         tMOvQd+dWYWbGxxLPhdUvToRXhuHGBab/DfWmesovdbhQggVqdVXZ3lRhDXXsRvs6p0M
         KaBJxkBECV+b78b3oEIgIDTGqn2wCj7MkrresiUgrcdqwAqcpK4IoMgXLlVYwnUMLLZU
         a4kScEXce1HcD/9FO8hF48PCeBJR0W4tDi9zYknaGCJLJQTTzJH5pa9ai+Je6YejoFUk
         EO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7CU2Ztz68587TSuRefUDulzhzN3HY2j1Ll4XHjUCA8Q=;
        b=RFg7lFhexOO+BEBpUMAgU90RjsAZcEE6u3oPww3Yt+hUH8mYBkaI7GUjRM+ASzqUQz
         U+TO0iEmXDRqOC2zNBrBt6eHin+xAqW7XHsdq/5TpxACAMFZmXDKV5N4ErxOpJxcDbOY
         Qn6yCX2yPOLckBYNzJEr60jPothRd1SeiCWPriOib8tR0DsMPf/bLgUDW2tbKc/2S5l1
         C9suNY0PcQO5ZknDLc9jRjDOdEdHXKj+8pd2xEvfOe1MLMoDD6pKUF1LES5JydxEjmYB
         HbHX4aKvnwArS0GkUtTzwPwvSSVT2W0JuSvMjnNvIlJIVUR9fVFjm9YbOxWre30SLnqw
         PB3g==
X-Gm-Message-State: AOAM5312Kci04qngCajDOHysZkUugS7K1i2ia2DqBJ6qCb2zOjnYLt1R
        xYEfemU3qAcpJaU3CS/g82dG+wazO+s=
X-Google-Smtp-Source: ABdhPJwGnhoMaXVLad/b8MFYg/Qtu5NoOcE4ofbBn61Dj69vZLfQGMKRZYrBY9gtied3EthIuBSYhA==
X-Received: by 2002:adf:d1ab:: with SMTP id w11mr2421635wrc.372.1630573517187;
        Thu, 02 Sep 2021 02:05:17 -0700 (PDT)
Received: from localhost.localdomain ([178.237.237.111])
        by smtp.gmail.com with ESMTPSA id l17sm1262516wrz.35.2021.09.02.02.05.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 02:05:16 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v6 0/6] Finish converting git bisect to C part 4
Date:   Thu,  2 Sep 2021 11:04:15 +0200
Message-Id: <20210902090421.93113-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches correspond to a fourth part of patch series 
of Outreachy project "Finish converting `git bisect` from shell to C" 
started by Pranit Bauva and Tanushree Tumane
(https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
continued by me.

This fourth part is formed by reimplementations of some `git bisect` 
subcommands, addition of tests and removal of some temporary subcommands.

These patch series emails were generated from:
https://gitlab.com/mirucam/git/commits/git-bisect-work-part4-v6.

I would like to thank Johannes Schindelin for reviewing this patch 
series.

Specific changes
----------------

[5/6] bisect--helper: reimplement `bisect_run` shell function in C
* Format line.
* Use copy_fd() in print_file_to_stdout().
---

Miriam Rubio (3):
  t6030-bisect-porcelain: add tests to control bisect run exit cases
  t6030-bisect-porcelain: add test for bisect visualize
  bisect--helper: retire `--bisect-next-check` subcommand

Pranit Bauva (2):
  run-command: make `exists_in_PATH()` non-static
  bisect--helper: reimplement `bisect_visualize()`shell function in C

Tanushree Tumane (1):
  bisect--helper: reimplement `bisect_run` shell function in C

 builtin/bisect--helper.c    | 152 ++++++++++++++++++++++++++++++++++--
 git-bisect.sh               |  87 +--------------------
 run-command.c               |   2 +-
 run-command.h               |  12 +++
 t/t6030-bisect-porcelain.sh |  18 +++++
 5 files changed, 177 insertions(+), 94 deletions(-)

-- 
2.29.2

