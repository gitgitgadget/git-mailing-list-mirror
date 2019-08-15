Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7784D1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbfHOVlP (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:41:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45122 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731687AbfHOVlP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:41:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id w26so1959819pfq.12
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9oynMKxYc+KDhFjeeiMfiOH7/VysQCE2JPng5FpAn6Q=;
        b=pneNQpJ4zdqBIA/KMuYPKiPgVD7BVSItCBMcP0eG/MQTgLN39N9k8ebT9UmExS6f/p
         SqMtDlDoA6MTto8cWWeeVuZeJ8199bEOS1e52uH2pI7mWYXA07SzLzgesfvRT8P6S+v8
         c/hp+Jua0N73hy2kC8NxDAu+hSJQG1gsRpJKxbSvJe5TQOvBu4xllvwBshsgOGM/Gtjl
         CqtKdd+ESAId2tr2tOa4nMouXUuIALyazlcbjDsSQ/A097y+rQqhZymaX0k5lyWqY8RA
         xuHmmY2U4mBr3YJJC3KZLKcWgYHA/svrawFtUro2hvqNvpvfrZFaygwASOb5HKaxMNdX
         FN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9oynMKxYc+KDhFjeeiMfiOH7/VysQCE2JPng5FpAn6Q=;
        b=pHkO1XVMvFiurPNu2M+kZ7PJz5wtYLm6XWPluIKMyuuoZqXBV+nO5WYPKJYD+/Ycva
         qitBGoMJejq8y1o5IyhVym+LgB2ZiRG+NRcHWwgFMmIIiOtgxVgH+N49sm+8pU/xwFdH
         oKftjaAJKx+NzYeKewNRVFBWGk4p9Yv30hz4rgIftQIfdpb7N/huh6BCyDl86QuGo+YX
         jpPh1PRQSrJ6Gy5u/utPFJC4ba5uXqRXpO82nQiw9795VCQaqePzy+o7CC+pleIXL0DA
         tMH7X7094Ubwb7YrnrcKr3lgspZzgcw0ReKAnXM050egY0A7Pa0Q0EBSKjQHiQThImkh
         hTOQ==
X-Gm-Message-State: APjAAAVEBS1AAlcMVnsHrSNndFCjqMMKvXGgJwtR/2iOGEF9wrOtWbg2
        VZcTGZwdCloTpi0NdSqzl8JEXXRr
X-Google-Smtp-Source: APXvYqw5nnkaPU4+lTXkUvMNtl6PaCV1VisrJP+ISTlohH4sEAu22jBSAnRWaqcafZPWKCSoe9lXoQ==
X-Received: by 2002:a63:c118:: with SMTP id w24mr5103708pgf.347.1565905274424;
        Thu, 15 Aug 2019 14:41:14 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id i124sm4131966pfe.61.2019.08.15.14.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 14:41:13 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 01/24] merge-recursive: be consistent with assert
Date:   Thu, 15 Aug 2019 14:40:30 -0700
Message-Id: <20190815214053.16594-2-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.32.g2123e9e4e4
In-Reply-To: <20190815214053.16594-1-newren@gmail.com>
References: <20190726155258.28561-1-newren@gmail.com>
 <20190815214053.16594-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 8daec1df03de ("merge-recursive: switch from (oid,mode) pairs
to a diff_filespec", 2019-04-05), an assertion on a->path && b->path
was added for code readability to document that these both needed to be
non-NULL at this point in the code.  However, the subsequent lines also
read o->path, so it should be included in the assert.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 6b812d67e3..1d960fa64b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1043,7 +1043,7 @@ static int merge_3way(struct merge_options *opt,
 		}
 	}
 
-	assert(a->path && b->path);
+	assert(a->path && b->path && o->path);
 	if (strcmp(a->path, b->path) ||
 	    (opt->ancestor != NULL && strcmp(a->path, o->path) != 0)) {
 		base_name = opt->ancestor == NULL ? NULL :
-- 
2.23.0.rc2.32.g2123e9e4e4

