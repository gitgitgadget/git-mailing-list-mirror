Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D694E1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 20:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbeGLUTA (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 16:19:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33978 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbeGLUTA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 16:19:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id c13-v6so22859853wrt.1
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 13:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=po4JDaOLfiwUmLObG7ar8ls5VJPkgqoIH+Sh5t4B+8E=;
        b=mArpAf80+27eL0P7cXuAM7V+glSPFcbcdFi91nQ5sIUAE6bDTEnNpL8nhaWKG8dMrd
         KvLQez1orLfVZqlm6gg10vVv7MCg5Dj6TWmtjGVcCO3ht9t9xnAQ9Pki1ko4XSzgHQuI
         sqcwSmS2OXixdXMd73HkKygkHk+3mM3/Lc3n2S+wuXwxLsOmhDcJ/NCZV0CkWVpGEeQ4
         mLACqdVH5v7QliplWBeumuFD72oLNMA71FBSD2x7JETBiQFPjnQk20Bw2b1NkMjTBv1A
         wmvr6V9oW5PuPhMvTOEEkD/yQJN1cWAuyuYu/iRkHtUHFT2HEROEGFXOJg0klxsqg2Pk
         EmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=po4JDaOLfiwUmLObG7ar8ls5VJPkgqoIH+Sh5t4B+8E=;
        b=ZwToeEz+/xNprBogjaMKgooqDWTipNr5tUEid3BU7bu01ZI2OJXPreuwq13sBENnEk
         WQDGgDyX+65u+BjBlVmFvwm0onUcuVnbq9F1XowF/i4/uPNxWi8pFx7kF5SGqfWnkaXB
         KHxo3xD4jGsJ0GfGKuSBQwafm5/QsYxVEIcLhmoX8kC3jpjYfCOfYA8u+GDyXNYaSWQX
         aiGI2Az3xrmqFww5IcUOegXpRhQQbvJu4UAroSYA0DnlC6gCDJiknFfyQ4RSahfsqwNv
         ZBQBufHtmM2koVTDVJ7sxgWqfVxYSYLH1UxxdYeOnU1dhrF9dLI2+znDnB+JSNhOcMuB
         qtNQ==
X-Gm-Message-State: AOUpUlHnyjcrCoJ1RKbXP/KTdRL/X1fC4Fj0qLp/ocvaNjpxw4zZv48R
        kT74N7NYVMbSV+ggJzWlAEWSMSgo
X-Google-Smtp-Source: AAOMgpfhEKnqPIHpqUzTovLwhvwyYWLCMgq3xOfBSwLbqhmVYig5DllrAGaRf21jXsh58kBwaIhUWw==
X-Received: by 2002:adf:e9c1:: with SMTP id l1-v6mr2679726wrn.14.1531426072617;
        Thu, 12 Jul 2018 13:07:52 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w204-v6sm6575802wmw.17.2018.07.12.13.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 13:07:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] t3404: fix use of "VAR=VAL cmd" with a shell function
Date:   Thu, 12 Jul 2018 13:07:51 -0700
Message-ID: <xmqqefg8w73c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bash may take it happily but running test with dash reveals a breakage.

This was not discovered for a long time as no tests after this test
depended on GIT_AUTHOR_NAME to be reverted correctly back to the
original value after this step is done.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * We could enclose the setting and exporting inside a subshell and
   do without the oGIT_AUTHOR_NAME temporary variable, but that
   would interfere with the timestamp increments done by
   test_commit, so I think doing it this way may be preferrable.

 t/t3404-rebase-interactive.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 7e9f375a24..fd43443ff5 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -280,8 +280,11 @@ test_expect_success 'retain authorship w/ conflicts' '
 	git reset --hard twerp &&
 	test_commit a conflict a conflict-a &&
 	git reset --hard twerp &&
-	GIT_AUTHOR_NAME=AttributeMe \
+	oGIT_AUTHOR_NAME=$GIT_AUTHOR_NAME &&
+	GIT_AUTHOR_NAME=AttributeMe &&
+	export GIT_AUTHOR_NAME &&
 	test_commit b conflict b conflict-b &&
+	GIT_AUTHOR_NAME=$oGIT_AUTHOR_NAME &&
 	set_fake_editor &&
 	test_must_fail git rebase -i conflict-a &&
 	echo resolved >conflict &&
