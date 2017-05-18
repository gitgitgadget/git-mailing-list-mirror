Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4B36201CF
	for <e@80x24.org>; Thu, 18 May 2017 19:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932218AbdERTip (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 15:38:45 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33702 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757702AbdERTiP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 15:38:15 -0400
Received: by mail-pg0-f54.google.com with SMTP id u187so27330257pgb.0
        for <git@vger.kernel.org>; Thu, 18 May 2017 12:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eD6zfl8CWQm+qDllBBXWyNNLLMN2ievChmljdzvTIm0=;
        b=E3ZjKSz/7issXiRJz5uL4N9Aj7tHbhFA/pM42d0YwHAEPC+7244OszsW8hu2FUyo7Z
         DZXPY7gGxM24C/UVODtpwzAZRdgzd2sZE9DgiRvuTDjGXTkV4DqTgs63bogKwTAHLho1
         brg/iLdve4Ux5MBqhNU/fT93kVdNEA9dkyoB/VkywVgURRIKng+GxKAeCpEZs1lBovta
         +p78m8UWlyGik6FsGhRWhpRI5KUUParJTk9lZqSm1Xw+qIdwO6uJgljZ3hAlXuSKeEYv
         BzUsAFkNxto7tFrOW8g81FEicxWDVEJrG7NUoXXScgUu5p2jrQLg0JXrXefeWgfthO7S
         6Ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eD6zfl8CWQm+qDllBBXWyNNLLMN2ievChmljdzvTIm0=;
        b=Dq91qNmcQIPpoycCvL8HQd3RNd02i+u6CcsKXbT3H/fGTBkk6NgP6os4svrepnWvUM
         pfOiCtCXWHEDk8M24uSqXfijuWAKZVdS5lupHFEjxUTCqZyqcHqn/gA96OyqFQozvm+k
         snQ2Axbucv0eK4Ly6VTyLnhPd7mcw61mylbreOR3IK9WCYSFda3CDZfWw2wxAX4YMI1U
         FK3OvlbQQbmR41n/SmrIATj1oM7EAeTLa+jmxdJ6uKvQEW1L417xScRn6nMan7xFcbzU
         EJI/CdJteTOgohdv0sZv9/7sSRlAnwRTOdKid1drryJajPjNyB3VqqYhLNAoCCph9NWu
         mTSA==
X-Gm-Message-State: AODbwcCT4MHGBMgKEoTARXvO41ALCz/tBmMF4/AknuKfc76oKju2YsKL
        uj6MPT2Ceb7vA89c
X-Received: by 10.84.140.164 with SMTP id 33mr6845047plt.142.1495136293919;
        Thu, 18 May 2017 12:38:13 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7013:588c:5765:703d])
        by smtp.gmail.com with ESMTPSA id k192sm11760261pgc.31.2017.05.18.12.38.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 12:38:13 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net
Subject: [PATCHv3 16/20] diff.c: convert diff_flush to use emit_line_*
Date:   Thu, 18 May 2017 12:37:42 -0700
Message-Id: <20170518193746.486-17-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170518193746.486-1-sbeller@google.com>
References: <20170517025857.32320-1-sbeller@google.com>
 <20170518193746.486-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch, I want to propose an option to detect&color
moved lines in a diff, which cannot be done in a one-pass over
the diff. Instead we need to go over the whole diff twice,
because we cannot detect the first line of the two corresponding
lines (+ and -) that got moved.

So to prepare the diff machinery for two pass algorithms
(i.e. buffer it all up and then operate on the result),
move all emissions to places, such that the only emitting
function is emit_line_0.

This covers diff_flush.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 383c8c4b52..774f1acdd3 100644
--- a/diff.c
+++ b/diff.c
@@ -4872,7 +4872,9 @@ void diff_flush(struct diff_options *options)
 			emit_line(options, NULL, NULL, 1, 0, term, !!term[0]);
 			if (options->stat_sep) {
 				/* attach patch instead of inline */
-				fputs(options->stat_sep, options->file);
+				emit_line(options, NULL, NULL, 0, 0,
+					  options->stat_sep,
+					  strlen(options->stat_sep));
 			}
 		}
 
-- 
2.13.0.18.g7d86cc8ba0

