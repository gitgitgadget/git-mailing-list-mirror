Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50219C4332F
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 17:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241850AbhLFRHk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 12:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbhLFQ70 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 11:59:26 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3847C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 08:55:57 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a18so23830286wrn.6
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 08:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wYFlVHr0fWz6eadJWJ4z1VO6MjidyFdIxCZv8yxJnsY=;
        b=Geub8S/yKcX80mdUGEPZKAf2HU89o1zu6MnM2s51x1mUg+qATLY/hkAdtOVsgUCEYM
         AozQUos9HdBYUu635LqnMhRtPsnz8JM9U+EVjnlYtdEwliyf0eGef5d92ykG3/088N2G
         p95pNLHPO1kJq25NQV6rasDe9iXfuRCbpByRvymnLLYFQvSs0ynDt2NTWUsDfims5tUu
         HFbtt7gy4aAzGyU0dK67xTl4oq09+oP0czt+9njIQJxrxdXtkWyoQdfmL8Y4wLpqayeW
         o8LDbRXT1iGJ4r2bdYqzas5f5fR3G9mIXpWrzqJLyt6XKCG7DCE1ON6o9J37GV7jwu6W
         +Fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wYFlVHr0fWz6eadJWJ4z1VO6MjidyFdIxCZv8yxJnsY=;
        b=efKgsvryux4LtDwpgXwvnWK4IDMkqUwzMUcln9nI7AhDEJ+6XY+OfCdzOgWbzPjxLE
         7HiZXCrI0SvQs2IzmbzpwmU4zybVsFvU7FLEQcnNb7LvwTnmJXjeJpLOyy+1DJUViDRw
         MR5j5D+dLar3vKL39QRr8bHi4fl+QGXfgD/eC+3RTFpAn8LZlK8YbnBxtdlp07haC3lO
         9WYoFUyEZh4lc3JVyUtUc+8BWSDLXYnv10hsF1WrJU1eHh0HymSKqZpKRILAoWONjzWJ
         cf5k75hxnVRXfd3XjJes4XBK9egHwoc9wYip6RaqlDDWHlLlsu3kNKdzagDel94iNKuo
         ZG8w==
X-Gm-Message-State: AOAM531b3wwQ0CbgWczf9o5wPd3ALpDrmqt/LSB+rQjBIkquUsJ89ZdP
        JrdvgoYpKslq6e3e5mBUDvvqxMZnbSAMhg==
X-Google-Smtp-Source: ABdhPJx4hWMnHXI7Bmn+LRvnsHo4VQVfl3B1f5fIfbZ44mdeqYPRENy6cpRwaJOidHnGFR1JqLzdVg==
X-Received: by 2002:adf:f90a:: with SMTP id b10mr43038072wrr.255.1638809756019;
        Mon, 06 Dec 2021 08:55:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j40sm11775419wms.16.2021.12.06.08.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 08:55:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/4] usage API: Add and use die_message()
Date:   Mon,  6 Dec 2021 17:55:49 +0100
Message-Id: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.898.g5a552c2e5f0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A small series to add both die_message() and die_message_errno()
functions. By using these we can make vreportf() in usage.c static.

Doing so opens the door to later feature work on vreportf() that I
submitted an RFC series for[1], but wanted to peel off this more
trivial (and more easy to review) part.

The range-diff below shows changes since the RFC version. There was a
stupid bug of the die_message_errno() helper returning -1 instead of
128 as its die_message() sibling, I also f ixed up the commit messages
a bit, and had builtin/gc.c call "return" instead of "exit()" while I
was at it.

1. https://lore.kernel.org/git/RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (4):
  usage.c: add a die_message() routine
  usage.c API users: use die_message() where appropriate
  usage.c + gc: add and use a die_message_errno()
  config API: don't use vreportf(), make it static in usage.c

 builtin/fast-import.c | 19 +++++++++++--------
 builtin/gc.c          | 21 ++++++++++++---------
 builtin/notes.c       | 15 +++++++++------
 config.c              | 22 +++++++++-------------
 config.h              | 10 ++++++----
 git-compat-util.h     |  4 +++-
 http-backend.c        |  3 ++-
 imap-send.c           |  3 ++-
 parse-options.c       |  2 +-
 run-command.c         | 16 +++++-----------
 usage.c               | 42 ++++++++++++++++++++++++++++++++++++++----
 11 files changed, 98 insertions(+), 59 deletions(-)

Range-diff:
1:  ae05d2398fb ! 1:  5a9ab85fa56 usage.c: add a die_message() routine
    @@ Commit message
         helper routine to bridge this gap in the API.
     
         Functionally this behaves just like the error() routine, except it'll
    -    print a "fatal: " prefix, and it will exit with 128 instead of -1,
    -    this is so that caller can pas the return value to exit(128), instead
    -    of having to hardcode "128".
    +    print a "fatal: " prefix, and it will return with 128 instead of -1,
    +    this is so that caller can pass the return value to "exit()", instead
    +    of having to hardcode "exit(128)".
     
         A subsequent commit will migrate various callers that benefit from
    -    this function over to it, for now we're just adding the routine and
    +    this function over to it. For now we're just adding the routine and
         making die_builtin() in usage.c itself use it.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
2:  b4ff6ddf986 = 2:  36c050c90c2 usage.c API users: use die_message() where appropriate
3:  f93d95ab288 ! 3:  8747afecdcd usage.c + gc: add and use a die_message_errno()
    @@ Commit message
         errors to use a "fatal: " prefix instead. This adds a sibling function
         to the die_errno() added in a preceding commit.
     
    -    Since it returns 128 instead of -1 we'll need to adjust
    -    report_last_gc_error(). Let's adjust it while we're at it to not
    -    conflate the "should skip" and "exit with this non-zero code"
    -    conditions, as the caller is no longer hardcoding "128", but relying
    -    on die_errno() to return a nen-zero exit() status.
    +    Since it returns 128 instead of -1 (like die_message()) we'll need to
    +    adjust report_last_gc_error().
    +
    +    Let's adjust it while we're at it to not conflate the "should skip"
    +    and "exit with this non-zero code" conditions, as the caller is no
    +    longer hardcoding "128", but relying on die_errno() to return a
    +    nen-zero exit() status.
    +
    +    Since we're touching this code let's also use "return ret" in place of
    +    an "exit(ret)". This is kinder to any cleanup our our "cmd_main()" in
    +    "git.c" might want to do.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
      				/* Last gc --auto failed. Skip this one. */
      				return 0;
     +			if (ret)
    -+				/* an error occurred, already reported */
    -+				exit(ret);
    ++				/* an I/O error occurred, already reported */
    ++				return ret;
      
      			if (lock_repo_for_gc(force, &pid))
      				return 0;
    @@ usage.c: int die_message(const char *err, ...)
     +	va_start(params, fmt);
     +	die_message_routine(fmt_with_err(buf, sizeof(buf), fmt), params);
     +	va_end(params);
    -+	return -1;
    ++	return 128;
     +}
     +
      #undef error_errno
4:  40fe7cf81a8 = 4:  e0e6427cbd3 config API: don't use vreportf(), make it static in usage.c
-- 
2.34.1.898.g5a552c2e5f0

