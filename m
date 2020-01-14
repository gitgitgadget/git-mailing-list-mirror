Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0BFC33CB2
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 18:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D98524673
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 18:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1VqCkXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgANSn7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:43:59 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:42088 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgANSn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 13:43:58 -0500
Received: by mail-wr1-f45.google.com with SMTP id q6so13198863wro.9
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 10:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Q6kHVjqb6IwM4rsLItSjNPHvIVjXOb5FhwMqk+5KWpQ=;
        b=l1VqCkXyU3BuPvM6JvsKY60vubiXWeD2QagAa9rp/K3Z645YLi+ZDVDUzmOPxLCIFu
         3jiHRO0BXm0m88J+T25G3eM8NL0yWaFVSnvRx6n5MUD0uP6Ri7Xjm/0iTT5VgpT1pXJc
         /2BAnF/oZ2ZEE3nuZZH300nhfLuoaWLd7AObQyjkCZP4RyMpV7N7Ttk3h9lDq5OXpzwN
         p8T15eREpZ7tV5BQ8wqEsilD5xIpCy1Juv/tS7dzZSqyjrVfzNnCtCWoczVt8ny3sAaT
         WqSqGpYVsVj3z8KLVtHWuQ5rN0KqOrB/qiUF6YQbUzsvp0gpXxWFfEYwXAZ5/KgISOYx
         TkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Q6kHVjqb6IwM4rsLItSjNPHvIVjXOb5FhwMqk+5KWpQ=;
        b=YZlpvrgj6BjER07EnyYaMm3kItfUo0cpf6TQzx6BsxzkFZiR9wMpGhJk4i8evZ6oNH
         madbn1E1bNNrQpBwmwbOLv0fE+SE1kp18FNc3zhJHO2cy/NEancpxaAIW5rzX/Ebx7xu
         MOWXA8DA/3IH+LEEBQ0/PiOKR6GqFlbDvDFE1AZGSRN65w/yVp3uLHxeSnB9qb3NA3p2
         lRCeIieAxrIALU+3rUK/H0lf7tq7dwCjOYaYuvtHacPi9VJ/WN6HqEihPzrXoH5/6XEQ
         MZyqilLd0zrpzQJPKX0GgoAxeTxvMui/n/htFGrOhJIpWIXyl4Jh+6bdS3FvfqvbwQjX
         96jQ==
X-Gm-Message-State: APjAAAWXrRxkVipU6qk+wQpEx8oJzoEVs9glpPQwyTvXJAYSRKN6l5Py
        6T69FzCltyUln96+1H57SbyH0CD7
X-Google-Smtp-Source: APXvYqxxB2+Hcr8JS6XGZyUjY/LWA2biRwX3e3DSGvTMOTOgwnUpWeEzsIRVTGb29fvaGCF/Y+PIRQ==
X-Received: by 2002:a05:6000:160d:: with SMTP id u13mr27470928wrb.22.1579027436041;
        Tue, 14 Jan 2020 10:43:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15sm19712545wmh.21.2020.01.14.10.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 10:43:55 -0800 (PST)
Message-Id: <e12df77e8aa9f6105ab54b41c570df71fd43698d.1579027433.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v4.git.1579027433.gitgitgadget@gmail.com>
References: <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
        <pull.175.v4.git.1579027433.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jan 2020 18:43:44 +0000
Subject: [PATCH v4 01/10] t3701: adjust difffilter test
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 42f7d45428e (add--interactive: detect bogus diffFilter output,
2018-03-03), we added a test case that verifies that the diffFilter
feature complains appropriately when the output is too short.

In preparation for the upcoming change where the built-in `add -p` is
taught to respect that setting, let's adjust that test a little. The
problem is that `echo too-short` is configured as diffFilter, and it
does not read the `stdin`. When calling it through `pipe_command()`, it
is therefore possible that we try to feed the `diff` to it while it is
no longer listening, and we receive a `SIGPIPE`.

The Perl code apparently handles this in a way similar to an
end-of-file, but taking a step back, we realize that a diffFilter that
does not even _look_ at its standard input is very unrealistic. The
entire point of this feature is to transform the diff, not to ignore it
altogether.

So let's modify the test case to reflect that insight: instead of
printing some bogus text, let's use a diffFilter that deletes the first
line of the diff instead.

This still tests for the same thing, but it does not confuse the
built-in `add -p` with that `SIGPIPE`.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3701-add-interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 12ee321707..ac43f835a5 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -561,7 +561,7 @@ test_expect_success 'detect bogus diffFilter output' '
 	git reset --hard &&
 
 	echo content >test &&
-	test_config interactive.diffFilter "echo too-short" &&
+	test_config interactive.diffFilter "sed 1d" &&
 	printf y >y &&
 	test_must_fail force_color git add -p <y
 '
-- 
gitgitgadget

