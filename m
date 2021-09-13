Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3798CC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 17:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23A64603E7
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 17:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346248AbhIMRlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 13:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344413AbhIMRlI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 13:41:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBF9C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 10:39:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t18so15978175wrb.0
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zXz1lh2DtDXsCM+Tbw+Fhf1iH2pAoPCiBQ/bvMHgV4s=;
        b=RmjH5Mf4z3YVmJkpbLNRLP4Ljg7Ht1Ann9q+6CKeYBdcyFtR18qJMPU6KB5pVch51Z
         JVDoLrCLJAvAAb8a14k0vza4M+ur/BeML3TPEGNyysVZzCq/3tnc+ETfwu4V32eNEoWV
         SUlfbKXohNNRauxfvg7xwLY/QsDKbrCWmdht+GVZUvuRq7DSZBJKeKkHKoVAqItGPSY9
         4ZQfX4TJYwUCLzvKywdjsjDaC7Fm3a/HIClZzs6BZgN2N/vl2CGm/12RRr2bzPA6qcDI
         +oH7GPhAMZRGVlnoj9mOLXpIo0hPU0dTGqUYkCQhY84up09E9Lj9KeZLmOAah+O7//CM
         1FrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zXz1lh2DtDXsCM+Tbw+Fhf1iH2pAoPCiBQ/bvMHgV4s=;
        b=uZmnl77ROlr8QLNEjs97IwBgBfRJbUsI8nrDsj6OQPeM1U2jp+n/W2U4Kq84+jZIcP
         rSSeX7nUv28MKRMLGdVmIkw+iYTsUs7eo9i/ihkhrsRGysIfALau6+Y0iCgnRhON0W7j
         DVI4HoAdn1FfR1+a5CYlPKyn+TKasZztrlWZOoGqQM3ZhvofxZwY7xc4pcUsfUzzIjkp
         Ei8/AKEajzFeGetGm0xbvEiOPyWRtizCmXIpAoumESTHD5z6HXeplQpoh3JcmWXk0WOm
         I5vHATcGFFD++7wbl9AEI/LVWNBvZYubrEPKU64fJWthe/viNtfZo1r34ZTkng0vnKEd
         j8EQ==
X-Gm-Message-State: AOAM532WWma++/N/nuxilSgcEW8XKGR9VzQKquYN2fJ4cr2E5irrMIeQ
        84Tuk7MH+U0LzPtIoweuRemFZRM+C/0=
X-Google-Smtp-Source: ABdhPJzAIfjlGA23qgpKiGqHJCabboqrz/Lt2f9Z3wfboH967oGKT88eFqt0CrNdmFjIUgRkU2mAgg==
X-Received: by 2002:a5d:5003:: with SMTP id e3mr14230821wrt.118.1631554753121;
        Mon, 13 Sep 2021 10:39:13 -0700 (PDT)
Received: from localhost.localdomain ([81.0.34.57])
        by smtp.gmail.com with ESMTPSA id u25sm4428959wmm.5.2021.09.13.10.39.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Sep 2021 10:39:12 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v7 0/6] Finish converting git bisect to C part 4
Date:   Mon, 13 Sep 2021 19:38:58 +0200
Message-Id: <20210913173905.44438-1-mirucam@gmail.com>
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
https://gitlab.com/mirucam/git/commits/git-bisect-work-part4-v7.

I would like to thank Junio Hamano and Johannes Schindelin for reviewing
this patch series.

Specific changes
----------------

[1/6] t6030-bisect-porcelain: add tests to control bisect run exit cases
* Remove unnecessary redirections to /dev/null and my_bisect_log.txt
---

[2/6]t6030-bisect-porcelain: add test for bisect visualize
* Remove redirection and add double quotes to test's filename

---

[3/6]run-command: make `exists_in_PATH()` non-static
* Amend commit message.
* Change parameter name.
---

[4/6]bisect--helper: reimplement `bisect_visualize()` shell function in C
* Add brackets to an if expression.
---

[5/6] bisect--helper: reimplement `bisect_run` shell function in C
* Add two fflush(stdout) in dup2 dance.
* Rewrite if-else condition.


---


Miriam Rubio (3):
  t6030-bisect-porcelain: add tests to control bisect run exit cases
  t6030-bisect-porcelain: add test for bisect visualize
  bisect--helper: retire `--bisect-next-check` subcommand

Pranit Bauva (2):
  run-command: make `exists_in_PATH()` non-static
  bisect--helper: reimplement `bisect_visualize()` shell function in C

Tanushree Tumane (1):
  bisect--helper: reimplement `bisect_run` shell function in C

 builtin/bisect--helper.c    | 158 ++++++++++++++++++++++++++++++++++--
 git-bisect.sh               |  87 +-------------------
 run-command.c               |   4 +-
 run-command.h               |  12 +++
 t/t6030-bisect-porcelain.sh |  18 ++++
 5 files changed, 184 insertions(+), 95 deletions(-)

-- 
2.29.2

