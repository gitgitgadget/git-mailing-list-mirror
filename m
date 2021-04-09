Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6743C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91189611AE
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhDIICE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbhDIICC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 04:02:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D91C061760
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 01:01:49 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n2so7212476ejy.7
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 01:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AwcX8qOWDX1hPfRZW3601oGVhmK6CMseLGzG8hPFSgY=;
        b=s19rHf2xc81XDj/+TCi6hdEDcoTfKBNLwCPopgzh42NTM/ev/zW4A1WOXNT7Zhn263
         4U/x3twhasLnmWRAonbNT1jW9A3bkuYZCqQTYfBi+/lTmdSDygMtmwHTTjIuklJfkWme
         tlOYOfsTVlKYf7NmUin6N/6uQbIbAltfeAjGikYmvyXhuDkG4Z26/NSIYuLS3rK+cjEi
         5iJOa6pRkvTl6Jha1PaYbCUHWjvAnNOd0kNg1EG9I+ic5GMi6GG13E9npBxcJ5vvMSFK
         pnJ0oESMm7I6eeht9Gzkef9r2H9miss/5WV4TSK3xCwkAygh7VidnjvC1QoJgENG1T1m
         Th/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AwcX8qOWDX1hPfRZW3601oGVhmK6CMseLGzG8hPFSgY=;
        b=qNwQsZ/CRZMBtI8KuQKuolOV9TEZCswD13+eDbFrjytyijg4HIdrd6wH/EW8ay9SJl
         hqrr9ivtbcCvJT0o0Wa7CbCnnB8gkQeQvIKwai6S0tOkO4wCg3BZgH8Ch6dDcXG8BZrk
         27XhO44TWqgqXvfu2eMH4Y5jMPkEq4nYpfmUQozZPHKjjp2qnQDuLa39MscVpwGW4vAy
         tfV62eSpPSsbOO33Z10cURJVef0ixbNNbqSbNw8A3PIt3/jxR2yYpEMVQUBpF/kTX8IQ
         DMvzry816NHpgnU6XIyOjCOIDnMVbpMbMoZ+qhddyWlTAxuR+7z5zngkwqK3CF74+1h9
         03Cg==
X-Gm-Message-State: AOAM533ILRWogz+qcEwf9EBi0XzQZu3TCAseQWOLjWL5H7hkc4twC+58
        2qbQVqhqPibtBB91rCIaQAJDjtGbf7Y3mA==
X-Google-Smtp-Source: ABdhPJyHoEL5jBIwCRoddHBOeMW7DBx6ayMZb9B8AcEaTjACeCGKt5qtHTJwPRE72YsuggwB47FDbQ==
X-Received: by 2002:a17:907:75d9:: with SMTP id jl25mr14736192ejc.452.1617955307637;
        Fri, 09 Apr 2021 01:01:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k8sm955177edr.75.2021.04.09.01.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:01:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] rebase: don't override --no-reschedule-failed-exec with config
Date:   Fri,  9 Apr 2021 10:01:36 +0200
Message-Id: <cover-0.3-0000000000-20210409T075713Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.584.gf4baedee75
In-Reply-To: <cover.1616411973.git.avarab@gmail.com>
References: <cover.1616411973.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a bug where we read config & options when "git rebase -i -x
make" starts, and will understand the "--no-reschedule-failed-exec"
option, but once a command fails we'll lose track of having had a
"--no-reschedule-failed-exec" and will happily re-read the
"rebase.rescheduleFailedExec=true" config the user might have.

Thus we'll have config winning over explicit command-line
options. This series fixes that bug.

Changes since v1:

 * I forgot how test_config works, and was doing a test_when_finished
   "test_unconfig", which isn't needed, duh! Thanks to Phillip Wood
   for that & other reviews on this series.

 * There was a discussion about how to add yet another rebase
   machinery state file. I think the consensus is "let's just do it
   like this", i.e. we could write some tri-state content to the file,
   but we'd get into back-compat issues with other git versions.

There was a discussiob about how to manage this whole state (a DB,
JSON?) in another thread, let's kick the can of how exactly we store
state down the line, and just fix the bug using the existing state
saving convention for now.

Ævar Arnfjörð Bjarmason (2):
  rebase tests: camel-case rebase.rescheduleFailedExec consistently
  rebase: don't override --no-reschedule-failed-exec with config

 Documentation/git-rebase.txt |  8 ++++++++
 sequencer.c                  |  5 +++++
 t/t3418-rebase-continue.sh   | 27 +++++++++++++++++++++++++--
 3 files changed, 38 insertions(+), 2 deletions(-)

Range-diff against v1:
1:  002dc72ee7 = 1:  e0dd2cb82a rebase tests: camel-case rebase.rescheduleFailedExec consistently
2:  330b33e7a8 < -:  ---------- rebase tests: use test_unconfig after test_config
3:  e00300d58d ! 2:  7991160de3 rebase: don't override --no-reschedule-failed-exec with config
    @@ Commit message
         However the --reschedule-failed-exec option doesn't take effect when
         the rebase starts (we'd just create a
         ".git/rebase-merge/reschedule-failed-exec" file if it was true). It
    -    only takes effect when the exec command fails, and the user wants to
    -    run "rebase --continue".
    +    only takes effect when the exec command fails, at which point we'll
    +    reschedule the failed "exec" command.
     
    -    At that point we'll have forgotten that we asked for
    -    --no-reschedule-failed-exec at the start, and will happily re-read the
    -    config.
    +    Since we only wrote out the positive
    +    ".git/rebase-merge/reschedule-failed-exec" under
    +    --reschedule-failed-exec, but nothing with --no-reschedule-failed-exec
    +    we'll forget that we asked not to reschedule failed "exec", and would
    +    happily re-read the config and see that
    +    rebase.rescheduleFailedExec=true is set.
     
    -    We'll then see that rebase.rescheduleFailedExec=true is set. At that
    -    point we have no record of having set --no-reschedule-failed-exec
    -    earlier. So the config will effectively override the user having
    -    explicitly disabled the option on the command-line.
    +    So the config will effectively override the user having explicitly
    +    disabled the option on the command-line.
     
         Even more confusingly: Since rebase accepts different options based on
         its state there wasn't even a way to get around this with "rebase
    @@ t/t3418-rebase-continue.sh: test_expect_success 'rebase.rescheduleFailedExec onl
      
     +test_expect_success 'rebase.rescheduleFailedExec=true & --no-reschedule-failed-exec' '
     +	test_when_finished "git rebase --abort" &&
    -+	test_when_finished "test_unconfig rebase.rescheduleFailedExec" &&
     +	test_config rebase.rescheduleFailedExec true &&
     +	test_must_fail git rebase -x false --no-reschedule-failed-exec HEAD~2 &&
     +	test_must_fail git rebase --continue 2>err &&
    @@ t/t3418-rebase-continue.sh: test_expect_success 'rebase.rescheduleFailedExec onl
     +test_expect_success 'new rebase.rescheduleFailedExec=true setting in an ongoing rebase is ignored' '
     +	test_when_finished "git rebase --abort" &&
     +	test_must_fail git rebase -x false HEAD~2 &&
    -+	test_when_finished "test_unconfig rebase.rescheduleFailedExec" &&
     +	test_config rebase.rescheduleFailedExec true &&
     +	test_must_fail git rebase --continue 2>err &&
     +	! grep "has been rescheduled" err
-- 
2.31.1.584.gf4baedee75

