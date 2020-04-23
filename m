Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC68C2BA19
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98F7C21569
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muOlJr3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgDWHJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgDWHJg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 03:09:36 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2196BC03C1AB
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:36 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u127so5348425wmg.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gKgDkfXv348qjUUT9eNPivXEfvRu4ys6PkGwqDYOZr4=;
        b=muOlJr3CzVdMlPc0C3MQMjzbL5V9naxaokVdcNKV/G0AhkX1r/AS4r74kmtACsJZc3
         MEnD7/AqppXYcpzOAmXiMXKikCzstdx+AwCT4SIdVBs4ITGkuEAzNjtGNQ3qDrfMACb6
         OhiRDmEK6D3WUZd7PtPXbgqO9DZ5EtLGuqydc1/5wbLJbuAfvwo7SKiUI+8NvWBSbkjS
         0RljwGmb8V/Jb8/gxzAXSb2jqwHsRpIwM1SRT3vY2R9RCLlODv+IGcJeYXlMBNYcexBw
         NPI8WmulmFmhafebbPYddtcq8SwtbzjIkHB1GIz3e0C19rFcpJWvnHYa/oD9IvEyv4CU
         +Exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gKgDkfXv348qjUUT9eNPivXEfvRu4ys6PkGwqDYOZr4=;
        b=MltFl+rvUafSjOWwUaOXOvAAxnQdWp+crMo3v04WYdYIVmttgZBT6ei07q9dHoWfqp
         cfL38IATltLfqJfwR/BAP7qdNhoMtVUuAZ/5k53U0GTBwD/NP2WJC8eopPgd4ZmWptrW
         aod+6PC2VSFWgleH9yjsdlUX1CW5r/x4myfXwOtgQD7CDoKkIqoV7CbgDWjmR1CiX/Io
         DSIykyRf0jONhWvOaocAwRGQPGsD1NVD7h+WY6MrOqF1b6SlBykRyH3pCASEQbPCmbyD
         FYMQgjYzf//BLGin2vkmOGN9S4TGBWhyIN5ojIdBhDOe/FjZBtb7QpMamznSEhcg2jzh
         mp9Q==
X-Gm-Message-State: AGi0Pub923AfpdJp4iM2lrMCCrg5+AvKdJsFCtfsZdhBfpXCARnyf2IE
        NM/VU5f/LVlDvb9u+2zK/TG+WGYDFwA=
X-Google-Smtp-Source: APiQypIox5omzFBtoQZrLmb1xNJU4vRxXO9xFsYGSyGgoFooNq+nv/aHpiI6HzpYy/nByx7Ig7oNqg==
X-Received: by 2002:a1c:a4c2:: with SMTP id n185mr2630541wme.104.1587625774303;
        Thu, 23 Apr 2020 00:09:34 -0700 (PDT)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u17sm2518585wra.63.2020.04.23.00.09.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 00:09:33 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 00/12] Finish converting git bisect to C part 2
Date:   Thu, 23 Apr 2020 09:06:52 +0200
Message-Id: <20200423070704.39872-1-mirucam@gmail.com>
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

These patch series emails were generated from:
https://gitlab.com/mirucam/git/commits/git-bisect-work-part2-v3.

I would like to thank Junio Hamano for reviewing this patch series and
Christian Couder for his help.

--- Changes since v2 Finish converting git bisect to C part 2 patch series ---

General changes
---------------

* Rebase on master branch: efe3874640 (Sync with v2.26.1, 2020-04-13)

Specific changes
----------------

[1/12] bisect--helper: fix `cmd_*()` function switch default return

* Use `BUG()` instead of `return error()` in default switch.

--

[2/12] bisect--helper: use '-res' in 'cmd_bisect__helper' return

* New patch: use '-res' instead of 'abs(res)'.

--

[3/12] bisect--helper: introduce new `write_in_file()` function

* Rename input parameter `filepath` to `path`.
* Change `error_errno()` to `error()` in mode checking.
* Change error message when file cannot be opened.
* Add `fclose()` before error return.

--

[4/12] bisect--helper: reimplement `bisect_autostart` shell function in C

* Reorder patch before `reimplement `bisect_next` and `bisect_auto_next`
shell functions in C` to use `bisect_autostart()` function in 
`bisect_append_log_quoted()`.

--
`
[5/12] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell
functions in C

* Amend commit message.
* Add `clear_commit_marks()` at the end of bisect_next_all() and remove it from 
`bisect_rev_setup()`.
* Fix if condition.
* Add `bisect_autostart()` in `bisect_append_log_quoted()`.
* Check `git_path_bisect_head()` with `file_exist()` instead of 
`is_empty_or_missing_file()`.
* Fix return with BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND.
* Add conversion in `cmd_*()` to BISECT_OK when return is 
BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND.

* Note to previous reviewer: suggestion to change `bisect_auto_next()` function
to return void cannot be done because errors from `bisect_next()` are not 
ignored.

--

[5/12] bisect--helper: reimplement `bisect_state` & `bisect_head` shell
functions in C

* Check `git_path_bisect_head()` with `file_exist()` instead of 
`is_empty_or_missing_file()`.

--

Miriam Rubio (3):
  bisect--helper: fix `cmd_*()` function switch default return
  bisect--helper: use '-res' in 'cmd_bisect__helper' return
  bisect--helper: introduce new `write_in_file()` function

Pranit Bauva (9):
  bisect--helper: reimplement `bisect_autostart` shell function in C
  bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell
    functions in C
  bisect--helper: finish porting `bisect_start()` to C
  bisect--helper: retire `--bisect-clean-state` subcommand
  bisect--helper: retire `--next-all` subcommand
  bisect--helper: reimplement `bisect_state` & `bisect_head` shell
    functions in C
  bisect--helper: retire `--check-expected-revs` subcommand
  bisect--helper: retire `--write-terms` subcommand
  bisect--helper: retire `--bisect-autostart` subcommand

 bisect.c                 |   8 +
 builtin/bisect--helper.c | 383 +++++++++++++++++++++++++++++++++------
 git-bisect.sh            | 145 +--------------
 3 files changed, 347 insertions(+), 189 deletions(-)

-- 
2.25.0

