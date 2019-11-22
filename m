Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF81CC432C3
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 18:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7509E2071B
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 18:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvA1Agz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfKVS7q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:59:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44035 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfKVS7p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 13:59:45 -0500
Received: by mail-pf1-f193.google.com with SMTP id q26so3882280pfn.11
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 10:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XUUpV0tA5oAfQhNm9mLYnF6tkK+QStOR2NJ+B4L8S0s=;
        b=QvA1Agz4EKEYNEtOAnI7xn6S3IK06Q19MA5bnpLzU0oP3p0gDr9FCN6FAxdc+y3M+o
         lTZy4LWfHn8QLr8lVwatgV1BhUi9TZUOjE8C1Ynful8xV43qTZzVHjdAhT9wRr0qjySd
         zHiYr+GJervM/NgDJha4c+T/1Hwo8oalhVo/VsPedoH3RJAOVwfEdAHxWALUh/NJ16Ip
         4JmdeSDLm/4ZhRnZHRnEZeht2VeTZM0MX7llQEmtGCrp7hJpgXAa+F8gKyX5k8yIrFCW
         GhtzvrePpAeclnLgHGzyfQKhuG8E6Hn5NwxQKnGe7TF2FBhXjjt/LQ/72X3Gy6LPokfT
         iuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XUUpV0tA5oAfQhNm9mLYnF6tkK+QStOR2NJ+B4L8S0s=;
        b=GOe/iAizbty2kwtWL3VYXww0jFaGHv3JICT+VWS+ijKkAKFyUWXuev/3z6gAUYj7rj
         N2uH4qS+GCwGDavidsbzyD2zRy0uiiBvv1lbz5cb5cairLzaci783h8JjLF8VWA91jto
         YRJgUOhbqidLLITjyEdAt3Ae6iOhd0sfYsbGxV5ebPdUH/xQ7qKX41DOgWPK9kXZC67Y
         3h7xXk3daNQAR0ECoMMAg4I6KAfpVgT/DGT1jaGvMhE9b4CJFEBGOnJy6rbctpXcuE+S
         KgrWzZCc7AlSPx6L370LkZn3ZNphks6PYRorOBeneKTbK3ArhtypJJn8Kx7uzz51h+/L
         snGg==
X-Gm-Message-State: APjAAAUQB4RoVRpIP0aYzexQN1LjOWcZGDEz9lGqrdDe1zQll8aYSoj9
        8IU72iewHBvvwSqQumUT4g6teHnq
X-Google-Smtp-Source: APXvYqxsXafu4xgLzilVJM+ZHCRXSKwoMKlO1q4GP1TBhyCI26lww7okEmMa0g4mOWNSA+zQVVfwHw==
X-Received: by 2002:a63:4553:: with SMTP id u19mr17359231pgk.436.1574449184562;
        Fri, 22 Nov 2019 10:59:44 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id a28sm8445151pfg.51.2019.11.22.10.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 10:59:43 -0800 (PST)
Date:   Fri, 22 Nov 2019 10:59:42 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 00/22] t: test cleanup stemming from experimentally
 enabling pipefail
Message-ID: <cover.1574449072.git.liu.denton@gmail.com>
References: <cover.1574296987.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574296987.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches perform some general test cleanup to modernise the style.
They should be relatively uncontroversial. The reason these tests were
identified for cleanup was because they failed under `set -o pipefail`.

I've gotten rid of the RFC part that actually enables `set -o pipefail`
on supported platforms. As Peff pointed out, there are a lot of
opportunities for racy SIGPIPE failures so that part still needs a lot
of work to be ironed out.

Those changes shouldn't hold back the first part of the series, however.
Let's try to get this test cleanup merged in sooner than later so that
any new test cases done by copy-paste will have their changes
represented.

Changes since v1:

* Removed the `set -o pipefail` changes

* Addressed Junio and Eric's comments on the first part of the series

Denton Liu (22):
  lib-bash.sh: move `then` onto its own line
  apply-one-time-sed.sh: modernize style
  t0014: remove git command upstream of pipe
  t0090: stop losing return codes of git commands
  t3301: stop losing return codes of git commands
  t3600: use test_line_count() where possible
  t3600: stop losing return codes of git commands
  t3600: comment on inducing SIGPIPE in `git rm`
  t4015: stop losing return codes of git commands
  t4015: use test_write_lines()
  t4138: stop losing return codes of git commands
  t5317: stop losing return codes of git commands
  t5317: use ! grep to check for no matching lines
  t5703: simplify one-time-sed generation logic
  t5703: stop losing return codes of git commands
  t7501: remove spaces after redirect operators
  t7501: stop losing return codes of git commands
  t7700: drop redirections to /dev/null
  t7700: remove spaces after redirect operators
  t7700: move keywords onto their own line
  t7700: s/test -f/test_path_is_file/
  t7700: stop losing return codes of git commands

 t/lib-bash.sh                          |   6 +-
 t/lib-httpd/apply-one-time-sed.sh      |   8 +-
 t/t0014-alias.sh                       |   4 +-
 t/t0090-cache-tree.sh                  |   5 +-
 t/t3301-notes.sh                       | 230 ++++++++++++++++++-------
 t/t3600-rm.sh                          |  14 +-
 t/t4015-diff-whitespace.sh             | 123 +++++++------
 t/t4138-apply-ws-expansion.sh          |  16 +-
 t/t5317-pack-objects-filter-objects.sh |  34 ++--
 t/t5703-upload-pack-ref-in-want.sh     |  53 +++---
 t/t7501-commit-basic-functionality.sh  |  83 +++++----
 t/t7700-repack.sh                      | 125 ++++++++------
 12 files changed, 433 insertions(+), 268 deletions(-)

Range-diff against v2:
 1:  9085cc00af =  1:  9085cc00af lib-bash.sh: move `then` onto its own line
 -:  ---------- >  2:  1fddaab701 apply-one-time-sed.sh: modernize style
 2:  9ec5244905 =  3:  f69e5345ba t0014: remove git command upstream of pipe
 3:  613a58491a =  4:  28ddc6c79d t0090: stop losing return codes of git commands
 4:  ee40bc972f =  5:  4d5f868e50 t3301: stop losing return codes of git commands
 5:  702a25f328 =  6:  658db8866e t3600: use test_line_count() where possible
 6:  6ebfed9234 =  7:  a7d76f9cb9 t3600: stop losing return codes of git commands
 7:  7ca9099fa7 =  8:  d35c054344 t3600: comment on inducing SIGPIPE in `git rm`
 8:  64ecf82b94 =  9:  bd6f6487b9 t4015: stop losing return codes of git commands
 9:  8d1f457d19 = 10:  6993316839 t4015: use test_write_lines()
10:  0a843a25c8 = 11:  5e88c755ed t4138: stop losing return codes of git commands
11:  4ace91a8b9 = 12:  56eebcc249 t5317: stop losing return codes of git commands
12:  7a15dd95f8 ! 13:  85c2f8ca27 t5317: use ! grep to check for no matching lines
    @@ Commit message
         return code! Use `! grep` in the cases where we are ensuring that there
         are no matching lines.
     
    -    It turns out that these tests were simply born this way[1], doing all
    -    this unnecessary work for no reason, probably due to copy/paste
    -    programming, and it seems no reviewer caught it. Likewise, the
    -    unnecessary work wasn't noticed even when the code was later touched
    -    for various cleanups[2,3].
    +    While at it, drop unnecessary invocations of 'awk' and 'sort' in each
    +    affected test since those commands do not influence the outcome. It's
    +    not clear why that extra work was being done in the first place, and the
    +    code's history doesn't shed any light on the matter since these tests
    +    were simply born this way[1], doing all the unnecessary work for no
    +    reason, probably due to copy/paste programming...
     
         [1]: 9535ce7337 (pack-objects: add list-objects filtering, 2017-11-21)
    -    [2]: bdbc17e86a (tests: standardize pipe placement, 2018-10-05)
    -    [3]: 61de0ff695 (tests: don't swallow Git errors upstream of pipes, 2018-10-05)
     
         Helped-by: Eric Sunshine <sunshine@sunshineco.com>
     
13:  439994027d ! 14:  f7e8ae79fa t5703: simplify one-time-sed generation logic
    @@ Commit message
         Pull the command substitutions out into variable assignments so that
         their return codes are not lost.
     
    -    Drop the pipe into tr because command substitutions should already strip
    -    leading and trailing whitespace, including newlines.
    +    Drop the pipe into `tr` because the $(...) substitution already takes
    +    care of stripping out newlines, so the `tr` invocations in the code are
    +    superfluous.
     
    -    Finally, convert the printf into an echo because it isn't necessary
    -    anymore.
    +    Finally, given the way the tests actually employ "one-time-sed" via
    +    $(cat one-time-sed) in t/lib-httpd/apply-one-time-sed.sh, convert the
    +    `printf` into an `echo`. This makes it consistent with the final "server
    +    loses a ref - ref in want" test, which does use `echo` rather than
    +    `printf`.
    +
    +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
     
      ## t/t5703-upload-pack-ref-in-want.sh ##
     @@ t/t5703-upload-pack-ref-in-want.sh: inconsistency () {
14:  859328b168 = 15:  28ef8f3a59 t5703: stop losing return codes of git commands
15:  d5e5be76c2 = 16:  0824965707 t7501: remove spaces after redirect operators
16:  d4154e621d = 17:  5058d21880 t7501: stop losing return codes of git commands
17:  2045c6e30e = 18:  297f383897 t7700: drop redirections to /dev/null
18:  20563779ee = 19:  2521ade74d t7700: remove spaces after redirect operators
19:  37a6d826bc = 20:  560f618334 t7700: move keywords onto their own line
20:  ea4338a43a = 21:  bd27805e4b t7700: s/test -f/test_path_is_file/
21:  98aec252fc = 22:  e9835b8542 t7700: stop losing return codes of git commands
-- 
2.24.0.497.g17aadd8971

