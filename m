Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A53C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 12:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206D8221EB
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 12:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQh8BoZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgIXMd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 08:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgIXMd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 08:33:59 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0B4C0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 05:33:58 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a17so3629036wrn.6
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 05:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dv8isxB9SULNW0E4TPfxmq2KQf87KXdtO8fYfPwuTKs=;
        b=HQh8BoZnnDqluVCpAqD/8SfrxJVoZfw8XklRISPxu2dSo+uvAen2QrTIuberqnwP1p
         /6UwwnOo7xktv7q4o3OpNK9F4+8qMaJmWy3uejSxT/dSwWBcuceNlbo+P7VgmDp6kBUJ
         CJ4EtkN5TLQQbeM/NbTykzpoQRAZmUZuEKsKioOAsAyGfzprebQ2sU/VVa+o22icemu9
         6KHOZ0cR6ZJiYxA9GsCI4khGF4/cR4Ri1YRMwkH1TemJ4PAC4VLaQ2KCCD2iHeLbgCsT
         NlbsdlOvBUESbfp1uLxXWK7+86cdUQHG5j+D3uTDpB8dbKNqz5pOHWrqegw2ldNLGMPx
         MicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dv8isxB9SULNW0E4TPfxmq2KQf87KXdtO8fYfPwuTKs=;
        b=nTSB3qjvQ2gZsKOvuBO9YjpMgcsGRmlhHOObgCv9e61UAFexBAnI6afSkZd9xdWjp8
         nzHwYhFVto3Rr9ygkf8/JLvQ4EwBMDpKKQedu4H27081KN3GHGORTpEmO/k2dGEWGaJL
         zqK/ZHOxGGzU2fDm68x1rb945RIq06D0hVH6MaAqJvgt+PiD5G6gUYM83dSL/jSichcU
         RttDLMjm6DFWDGgv7eAqkQTxVnXQmStEYSubFJW6Beziv5v5YZqpG772x2iSmBm6CrsQ
         pL2TOguyO/M48SICjqtjKRbE7UK6bHcaIVeefcID0/bl3F/rQWgwk2HjU59tZ1iYtFoa
         GR6w==
X-Gm-Message-State: AOAM531asLIp3AHgePRPjrfDUqudhV3ShvbbO2cMXnfOpGn/N99XQHXw
        RbYgIwFU+OTvirFA4GappWzQ1zFAkfk=
X-Google-Smtp-Source: ABdhPJwbFBZqg07wFPieTwLErlIeR2QY3XGLGiqD+ELjotM8MirK2zOkDbnu8kImFw9ySlAafaYINA==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr5178743wrp.217.1600950837189;
        Thu, 24 Sep 2020 05:33:57 -0700 (PDT)
Received: from localhost.localdomain ([178.237.235.60])
        by smtp.gmail.com with ESMTPSA id i83sm3485457wma.22.2020.09.24.05.33.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 05:33:55 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v9 0/6]Finish converting git bisect to C part 2 subset 1
Date:   Thu, 24 Sep 2020 14:33:34 +0200
Message-Id: <20200924123340.52632-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches correspond to a second part of patch series 
of Outreachy project "Finish converting `git bisect` from shell to C" 
started by Pranit Bauva and Tanushree Tumane
(https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
continued by me.

This patch series version is composed by the first six patches of the
previous version due to a bug discovered during the test stage, that 
affects the rest of the patches and that needs to be fixed before 
sending them.

These patch series emails were generated from:
https://gitlab.com/mirucam/git/commits/git-bisect-work-part2-v9-subset1.

I would like to thank Johannes Schindelin for reviewing this patch series
and to Christian Couder for his advice and help.

General information
-------------------

* Rebased on 385c171a01, (Fifteenth batch, 2020-09-18).

Specific changes
----------------

[4/6] bisect--helper: reimplement `bisect_autostart` shell function in C

* Add `|| exit` to bisect-autostart call in shell script.

---

Miriam Rubio (4):
  bisect--helper: BUG() in cmd_*() on invalid subcommand
  bisect--helper: use '-res' in 'cmd_bisect__helper' return
  bisect--helper: introduce new `write_in_file()` function
  bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'

Pranit Bauva (2):
  bisect--helper: reimplement `bisect_autostart` shell function in C
  bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell
    functions in C

 bisect.c                 |  13 +-
 builtin/bisect--helper.c | 269 +++++++++++++++++++++++++++++++++++++--
 git-bisect.sh            |  70 +---------
 3 files changed, 274 insertions(+), 78 deletions(-)

-- 
2.25.0

