Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED1B1DDE4
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--delmerico.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dEkJjkkU"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso1500537276.1
        for <git@vger.kernel.org>; Wed, 03 Jan 2024 14:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704321666; x=1704926466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Z9rIdcj+A8n0sHkoGwGU1B8PLWYIS97hx7LaMZiVxc=;
        b=dEkJjkkUUT8kKYI06v6VJ19W5KQqqpeRcxHRE0HBcixCLMID7PBMHGbSTOnHLU5rlt
         tYpz4OKyeeaxQ4xF2ovp45janVremYzMXk0cqOBFFPy0FJoficAI1agsGjBsn/AbFAYR
         Ij+FOixEw0bhGppsrHyZP0ZCuvbxiKW0YZnf1J25gtBTq+r5iBE/A6cEGhwcLpMIksaZ
         1wS3MPYiP+q8o2NOlXaQWJDmG9CGM8H5iBfn3cGXuV4fDL59EOV4GOYBXT7/AEIm73+f
         AYqQoVijq/2u92d5mDXVlpZLC2UG/7sI/VNL9NFd4igNP6jOFKf7gngJ4WEbIPiTnDhE
         cceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704321666; x=1704926466;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Z9rIdcj+A8n0sHkoGwGU1B8PLWYIS97hx7LaMZiVxc=;
        b=AarAmkxbCRsUx2pDt+2ZIUyQbGZTEObRG9YiiHTBI74SXJsApp/k+FsDIl95sAs7bB
         3YzGMnYtdkw3QZ7zODJV/1r3gpE3y/li0+PHJ5aXVbaFNjiRZNlN5QaSvCjYbt1JPlM+
         PjIv2XmnRLHsS+0VMtlb/U9PdfJgNgyC03qXtUIw/jLepN0cZ5oAfGD630peWmQFLNPI
         8ilP0fTuH/6jzfk30iRLcTY0hJU9dAW6Cqpt7F7SNU+90r+RFYmbY/3w/HneRCpFegWn
         ulB4+vjjVwPyBxsLVqfBRam2as0EB2GOClobhJaRGP0rtxBL21TymmYFcOJOl5K50Ppu
         Tvlw==
X-Gm-Message-State: AOJu0YxV0q6fJ0WqVi0cLJhhQyOoesdKsFUJNOaoB5RkEC9RsvJCVFNv
	S8x8iAZS/fezcmEfCu0lQOY86J24uon7p3itgqPKSXOFeuJ0UqxS6Jw5ETSXwxcMhJBTrvnNauR
	8wTkDkP3h7Y6jwn3Uwrbe85ZzCl8q8ZYPA4SFGkz0K1hf9nW+OiYdNWY9l44+ZDVAIXvOoHTO
X-Google-Smtp-Source: AGHT+IH9QCL9ZbPbDbKsDbsNqHP0Axz+xTqD/AtMFiSpdEDDVaWj3xzawT/N6QetLvFo1H+gFBza5Ae1UYHalf8=
X-Received: from h2o.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2868])
 (user=delmerico job=sendgmr) by 2002:a05:6902:56b:b0:dbd:b756:983a with SMTP
 id a11-20020a056902056b00b00dbdb756983amr7289532ybt.9.1704321666449; Wed, 03
 Jan 2024 14:41:06 -0800 (PST)
Date: Wed,  3 Jan 2024 14:40:54 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240103224054.1940209-1-delmerico@google.com>
Subject: [PATCH] push: region_leave trace for negotiate_using_fetch
From: Sam Delmerico <delmerico@google.com>
To: git@vger.kernel.org
Cc: steadmon@google.com, Sam Delmerico <delmerico@google.com>
Content-Type: text/plain; charset="UTF-8"

There were two region_enter events for negotiate_using_fetch instead of
one enter and one leave. This commit replaces the second region_enter
event with a region_leave.

Signed-off-by: Sam Delmerico <delmerico@google.com>
---
 fetch-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 31a72d43de..dba6d79944 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -2218,7 +2218,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 					   the_repository, "%d",
 					   negotiation_round);
 	}
-	trace2_region_enter("fetch-pack", "negotiate_using_fetch", the_repository);
+	trace2_region_leave("fetch-pack", "negotiate_using_fetch", the_repository);
 	trace2_data_intmax("negotiate_using_fetch", the_repository,
 			   "total_rounds", negotiation_round);
 	clear_common_flag(acked_commits);

base-commit: a26002b62827b89a19b1084bd75d9371d565d03c
-- 
2.43.0.472.g3155946c3a-goog

