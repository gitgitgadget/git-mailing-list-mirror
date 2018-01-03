Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DE141F428
	for <e@80x24.org>; Wed,  3 Jan 2018 01:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751029AbeACBMk (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 20:12:40 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:40447 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbeACBMj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 20:12:39 -0500
Received: by mail-io0-f178.google.com with SMTP id v30so559659iov.7
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 17:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iWX9tKx3+c8soSvj4NzQFKjRR0skHvVWcNO9WnxbSOI=;
        b=XcO5wo7k8NZYbPU/UmQiISwp6CGzvBKivYfpFKBQMEIaBY0hgNPLpfy/xi8nY21+3X
         BzoQO2gY0Uteu4dwndLodeTdp8MIXv57p/AuCmCQI1427v+Ag3w5LlTcN9ddnaZN99dA
         mbxGjCEZx208RF+KoJ83LRJY16s7opnPjf23tZ8CWQVB63MEIotK1OljFsmaE8tSu4oT
         oRw9W6LmSqsbTP+pHph+lOrslUipLVPbOL0kUL6vq1WddUzHK/npQdFFFQDNn82Tl+bD
         b0PBlHyQWUK6/VYkVhxGs3WJAh3ox0Ew8RqKYf1vJWZtNwT37ldwqnXpZTJvdWCY4per
         qDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iWX9tKx3+c8soSvj4NzQFKjRR0skHvVWcNO9WnxbSOI=;
        b=M+DwE1upmZCuLxeyz+InXeBpRQWECojCZ1iCa3Yi0FVrQX4/rdsnm0YXuwwvU8u19H
         /4qC7YQnGtDsqboMW6fHKeXJQut86FauU3h1WPLjTkjmnkgEeIovw7S7BQOkWorj8MM4
         hueQ6vbu8mrzcAvWT3uA4sqMlEes8QoAs+uDShsCZgSkkuI9YLBLnVAozTNuxmCXJ0fd
         dVhIWKq/xQNF3xoP4uG9ByTZPt3NF/VFyDw+woRTe4yoPIV9YNfCMHEkuSj5cikxdXHW
         lWfJAYAS88NpKIHta7BrUYopDMXYJwKWsyjUseHcNbfpMBHwgHKEgQnRBHzAaQXHN7Fa
         A8Gg==
X-Gm-Message-State: AKGB3mKgB9yyEx2Rp5zIKf/6p1+Df/UFKXQ0QaUzHNKVeG2ZQjUVtFmu
        Tzsz9q5jz8vC4c+TQxKBhcrkCH+Oa7s=
X-Google-Smtp-Source: ACJfBovZNgFKnQJRnPPDkcnm7QsJWaXDZYwT0NPuafbTvAAwVmRWcLjFJxOvXANIYfq1r57aB7nMWQ==
X-Received: by 10.107.89.19 with SMTP id n19mr22292404iob.53.1514941958374;
        Tue, 02 Jan 2018 17:12:38 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id j81sm14860789ioi.9.2018.01.02.17.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 17:12:37 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sbeller@google.com
Subject: [PATCH 3/5] t/lib-submodule-update.sh: Fix test ignoring ignored files in submodules
Date:   Tue,  2 Jan 2018 17:12:24 -0800
Message-Id: <20180103011226.160185-4-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103011226.160185-1-sbeller@google.com>
References: <xmqqbmichws2.fsf@gitster.mtv.corp.google.com>
 <20180103011226.160185-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It turns out that the test replacing a submodule with a file with
the submodule containing an ignored file is incorrectly titled,
because the test put the file in place, but never ignored that file.
When having an untracked file Instead of an ignored file in the
submodule, git should refuse to remove the submodule, but that is
a bug in the implementation of recursing into submodules, such that
the test just passed, removing the untracked file.

Fix the test first; in a later patch we'll fix gits behavior,
that will make sure untracked files are not deleted.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/lib-submodule-update.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index d7699046f6..fb0173ea87 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -885,6 +885,7 @@ test_submodule_switch_recursing_with_args () {
 		(
 			cd submodule_update &&
 			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			echo ignored >.git/modules/sub1/info/exclude &&
 			: >sub1/ignored &&
 			$command replace_sub1_with_file &&
 			test_superproject_content origin/replace_sub1_with_file &&
-- 
2.15.1.620.gb9897f4670-goog

