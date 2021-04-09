Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97143C43460
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2A1610FC
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbhDISrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhDISru (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:47:50 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870C9C061763
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:47:35 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id 12so6583842wrz.7
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kutQRoSXgTrZRMN4WNErTxjFZhfNJD6RaZXLDMDVf5Y=;
        b=KS1/KQEmVHqKBPT/tA3+RPsoqZ6Isju1Ylha8I7HFtqr1GerjuHT9O3CQXDrD6uOSJ
         ENXcfmMZ42THyJL3EoKsMHRVDbJQ5aIBRw6D8XMn/gUyw5rQGcYKJWkHgl7PejKMyHwg
         NCHifrY9LgmwHZnevkpAypRNSfmRLBcgev5qqSzYP7xkoIJbX4p213TEfPJ0RtLE4My0
         Trc4PyyCg0DoouQ1shyGOBIZ7jnhEXs+CHfk7GZ+1epXxfbHOt627/FMi0TjiwnxLyhX
         UCExN4X+p8u0V+jfk0k5Z0JFTGXmMDOUxcJtftWhrCdoDnP2P/CTm3l0PL8plniHDjsk
         n3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kutQRoSXgTrZRMN4WNErTxjFZhfNJD6RaZXLDMDVf5Y=;
        b=G/2cAdUFU+E+FpEnEB7n8BpiqrB2jxNPM+CCHltXp5CrPD/vhvVkXUNXo0rbxelmFx
         cjesdRV94GkY0pUJKP60oH0pWHCrkyZLaCz+qXnmXIGeUCEstRLCZrG5NQJJguEOuuqJ
         2L+LvAix1+vonjpZSCWu6RyET2BZiKfxFkUE2JHNMH2DVntN7DFXhBOvrAyZ7oab0wdx
         lrI4GDDz/FlT3MYPascFd9QMOQHVV6coWwUKCuk6HlitrY+bJ/MgG/N1RXd+QErrVvcx
         PQI/tEdPigeWgXpTnAFO7e+Y52IfSsxZravi2Ek/8VFSFoxW+t299u2yvUXYD9ui5PG7
         yDqQ==
X-Gm-Message-State: AOAM532rQKBQWjarO4+RxmFNT0Nh+rGH8pqU9dPvKbNXNKjEr3r/ER51
        kyarXX0bGL7IzgpVTMyC0PIYzWLXXkE=
X-Google-Smtp-Source: ABdhPJwQBWfiuExhd4ujKXUnQSKtqDzDTJCo6mz0FOiEusRTIdeDzVDLncut9ZL29uvKkrD0YUTSUA==
X-Received: by 2002:a5d:4ece:: with SMTP id s14mr19453422wrv.97.1617994054300;
        Fri, 09 Apr 2021 11:47:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h13sm5029605wmq.29.2021.04.09.11.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:47:34 -0700 (PDT)
Message-Id: <12f0dcaef109e7577eabcc6f94f8ee72695b79aa.1617994052.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.git.1617994052.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Apr 2021 18:47:20 +0000
Subject: [PATCH 01/12] revision: free remainder of old commit list in
 limit_list
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>, Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

limit_list() iterates over the original revs->commits list, and consumes
many of its entries via pop_commit. However we might stop iterating over
the list early (e.g. if we realise that the rest of the list is
uninteresting). If we do stop iterating early, list will be pointing to
the unconsumed portion of revs->commits - and we need to free this list
to avoid a leak. (revs->commits itself will be an invalid pointer: it
will have been free'd during the first pop_commit.)

This leak was found while running t0090. It's not likely to be very
impactful, but it can happen quite early during some checkout
invocations, and hence seems to be worth fixing:

Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x49a85d in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0x9ac084 in do_xmalloc wrapper.c:41:8
    #2 0x9ac05a in xmalloc wrapper.c:62:9
    #3 0x7175d6 in commit_list_insert commit.c:540:33
    #4 0x71800f in commit_list_insert_by_date commit.c:604:9
    #5 0x8f8d2e in process_parents revision.c:1128:5
    #6 0x8f2f2c in limit_list revision.c:1418:7
    #7 0x8f210e in prepare_revision_walk revision.c:3577:7
    #8 0x514170 in orphaned_commit_warning builtin/checkout.c:1185:6
    #9 0x512f05 in switch_branches builtin/checkout.c:1250:3
    #10 0x50f8de in checkout_branch builtin/checkout.c:1646:9
    #11 0x50ba12 in checkout_main builtin/checkout.c:2003:9
    #12 0x5086c0 in cmd_checkout builtin/checkout.c:2055:8
    #13 0x4cd91d in run_builtin git.c:467:11
    #14 0x4cb5f3 in handle_builtin git.c:719:3
    #15 0x4ccf47 in run_argv git.c:808:4
    #16 0x4caf49 in cmd_main git.c:939:19
    #17 0x69dc0e in main common-main.c:52:11
    #18 0x7faaabd0e349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Indirect leak of 48 byte(s) in 3 object(s) allocated from:
    #0 0x49a85d in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0x9ac084 in do_xmalloc wrapper.c:41:8
    #2 0x9ac05a in xmalloc wrapper.c:62:9
    #3 0x717de6 in commit_list_append commit.c:1609:35
    #4 0x8f1f9b in prepare_revision_walk revision.c:3554:12
    #5 0x514170 in orphaned_commit_warning builtin/checkout.c:1185:6
    #6 0x512f05 in switch_branches builtin/checkout.c:1250:3
    #7 0x50f8de in checkout_branch builtin/checkout.c:1646:9
    #8 0x50ba12 in checkout_main builtin/checkout.c:2003:9
    #9 0x5086c0 in cmd_checkout builtin/checkout.c:2055:8
    #10 0x4cd91d in run_builtin git.c:467:11
    #11 0x4cb5f3 in handle_builtin git.c:719:3
    #12 0x4ccf47 in run_argv git.c:808:4
    #13 0x4caf49 in cmd_main git.c:939:19
    #14 0x69dc0e in main common-main.c:52:11
    #15 0x7faaabd0e349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 revision.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.c b/revision.c
index 553c0faa9b38..7b509aab0c87 100644
--- a/revision.c
+++ b/revision.c
@@ -1460,6 +1460,7 @@ static int limit_list(struct rev_info *revs)
 			update_treesame(revs, c);
 		}
 
+	free_commit_list(list);
 	revs->commits = newlist;
 	return 0;
 }
-- 
gitgitgadget

