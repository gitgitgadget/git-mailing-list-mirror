Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A5BC54FCA
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 16:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF96E20757
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 16:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yo14o7E4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgCUQNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 12:13:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34562 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbgCUQNw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 12:13:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id z15so11215346wrl.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J0CtIqLgqj6ald+vRhmm3KC41JqOKs5reoFzFFEU8R8=;
        b=Yo14o7E4mXcvmi3+NT2y3/0fg3kVL6e/ZqL0mF2t+eOsEwSlWWE05zdTmRjn3pzM47
         P3/+5RzplmSxpaN51ikGDqWMi7CJnQFDqIEZaKuhhmAkm7fIpcEyJtjQf1i3ibfYG2fw
         I5CZVsTs1nXGZWDecQ+aMyEZa6/hP6pzceeJWr9a7TD+NU5yqkkdGN/Cqspzo+cn95zS
         sirSo+KYBk4LKF8iEnJ9Oh32lBbRafSkTl2W5bIwbe1ubQBF/xF2y3Sqy10qJqGmEOML
         CF/8NKv/R0yWgvttK9GjSLV1T5LVmKflgOq7i8cTj+tcoFO99iG6KFXbDLB2K3F0R+dn
         8New==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J0CtIqLgqj6ald+vRhmm3KC41JqOKs5reoFzFFEU8R8=;
        b=YP3x0IUpcIrgjEkNCA3fYHa5boE+GzQWI5BTnvcNJfFVFUOXqpukfnxYmysl6RvTJK
         rEeyBlPWZ58ygHfot8ZA37BiceCc6repw6hQ1mdVFGYS/89yenRdxtBs6XdJE8rM3bER
         1s90ikZUKsz8JmMrXKP2b+N7K9NZtXCi7m/BNKzk6kPvgeu5RR9K4XFXTm/xybBnxn2J
         XFc4+VkqlPG9q6LMJBwFbiCXFxHnHRo8Zk2mcZGhOBsEDsGM2OviC9lJLWQ+68Y8/vz8
         ya94eJgdb1VpfjAJiutOuQGi2YPchfyYdsTosK/7DchHgvjePOkdO2EP7XxCj70PnDtK
         glTA==
X-Gm-Message-State: ANhLgQ1bfop9gD8hDotf29Wcyj6XGh/N3494A5bkH8pTInHQt0G6uMK1
        mf14ElU2Op/TvJ281SvaIB8X6hqo
X-Google-Smtp-Source: ADFU+vvEu3GTI6D3zL6Rkek+FBNu0BiAQ58aLAea4NH5XK68nTkarDM1HzpHhSByBmbN7viTzbCuYw==
X-Received: by 2002:adf:b307:: with SMTP id j7mr19046489wrd.128.1584807228495;
        Sat, 21 Mar 2020 09:13:48 -0700 (PDT)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id f22sm13992285wmf.2.2020.03.21.09.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 09:13:47 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 00/11] Finish converting git bisect to C part 2
Date:   Sat, 21 Mar 2020 17:10:09 +0100
Message-Id: <20200321161020.22817-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches correspond to a second part of patch series 
of Outreachy project "Finish converting `git bisect` from shell to C" 
started by Pranit Bauva and Tanushree Tumane
(https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
continued by me.

This second part is formed by reimplementations of some `git bisect`
subcommands and removal of other temporary subcommands.

These patch series emails were generated from:
https://gitlab.com/mirucam/git/commits/git-bisect-part2-v2.

I would like to thank Junio Hamano and Johannes Schindelin for their
reviews and suggestions.

--- Changes since v1 Finish converting git bisect to C part 2 patch series ---

General changes
---------------

* Rebase on master branch: 98cedd0233 (Merge https://github.com/prati0100/git-gui, 2020-03-19)

Specific changes
----------------

[1/11] bisect--helper: fix `cmd_*()` function switch default return

* New patch that fixes a return `error()` in a `cmd_*()` function.

[2/11] bisect--helper: introduce new `write_in_file()` function

* Improve commit message.
* Change `write_in_file()` function to avoid extra allocation.
* Adapt new `write_in_file()` call in `write_terms()`.

--

[3/11] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C

* Adapt new `write_in_file()` call in `bisect_successful()`.
* Rewrite `register_good_ref()`
* Adapt `prepare_rev_argv()` to new `register_good_ref()`.
* Use `reset_revision_walk()` to reset flags in `process_skipped_commits()`.
* Add code comment.

--
[7/11] bisect--helper: reimplement `bisect_autostart` shell function in C

* Handle exit first in `bisect_autostart()`.
* Add spaces around a curly brackets.
* Pass NULL instead of argv to `bisect_start()`.

Note to previous reviewers:`bisect_autostart` cannot move to forward-declaration 
location, it would imply many functions relocations.

--

[8/11] bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C

* Change `bisect_state()` logic to accept `struct object_id *` as input.
* Rewrite `bisect_state()` function following reviewer suggestions.
* Remove subshell use in `git-bisect.sh`.

Note to previous reviewers: Refactor of check_expected_revs() function 
will be in a separate patch in the next patch series (part 3).


Miriam Rubio (2):
  bisect--helper: fix `cmd_*()` function switch default return
  bisect--helper: introduce new `write_in_file()` function

Pranit Bauva (9):
  bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell
    functions in C
  bisect--helper: finish porting `bisect_start()` to C
  bisect--helper: retire `--bisect-clean-state` subcommand
  bisect--helper: retire `--next-all` subcommand
  bisect--helper: reimplement `bisect_autostart` shell function in C
  bisect--helper: reimplement `bisect_state` & `bisect_head` shell
    functions in C
  bisect--helper: retire `--check-expected-revs` subcommand
  bisect--helper: retire `--write-terms` subcommand
  bisect--helper: retire `--bisect-autostart` subcommand

 bisect.c                 |  11 ++
 builtin/bisect--helper.c | 377 +++++++++++++++++++++++++++++++++------
 git-bisect.sh            | 145 +--------------
 3 files changed, 346 insertions(+), 187 deletions(-)

-- 
2.25.0

