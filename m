Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1135CC47253
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E77A020731
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ipqxad+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgD3Ts6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgD3Ts5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 15:48:57 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F46C035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 12:48:56 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id hi11so1289526pjb.3
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 12:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vUlf3e6mvxAzSgqqtvRMqp8acREE/pg/p00IHkpXqEo=;
        b=ipqxad+EKNRJIhsrC3A28FpNdrqE+Gw1Z3tPu1u+F9p7vyo8lBb2q1+cVySwTb5JlT
         K+/+cMb1kf9+UGMcH0/PhmfOCbpQLPcqGKGO2W/+AquZa2GuaqhuX/ogU/gjm1SohYcT
         lI/G8IQCHY/y/Hv6yDb9YOmsnuqMmNJHOmRxRWlFUNsNSpkmjuz8H/NjajaYKK/Mc/Uq
         70r1ZtobpcMUUm7e4CTMs0yO1oJSTq/8Fo5+QCiIDWxajbdDRQ99MHCHoRAF2XkSDF0k
         hqjD/WOlmkxXcnTiHYS62Q2XgcYr72Z2/SK5LhSK3A7u0/tw+DOygXGcvLFKAMpcFn+C
         hd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vUlf3e6mvxAzSgqqtvRMqp8acREE/pg/p00IHkpXqEo=;
        b=iRLwcOjPXzRuRmzXaaNnUePBXv6fffeDnlTWgo2H8wQpBqfXjqkRyOV8xpUkpzEaLI
         CliKFH7Lz0xd9eLedW3Zj3Sr5of+AaplLMO3Nrt5S0+XSEX2NOJnB/YqJuK2vMdO6jHy
         +KwElICUPqX4ZnwUt1vFccjRpfEUDu4yMvKO0NzPXyarT/atSYQwTeAkURsML4sv87xj
         pzSo6hBeZBCgx3c1AqgJOa193VxPYQ+GxtCYcD6hvsHmdCG8vAo30+uBLP1lpekMnY81
         HnXl3ue285G4vFdO8mkEllxPS6pY5kn5NfkIo7+HvxptGS8eFSly8WohXBkNanrXi3Lx
         VAKw==
X-Gm-Message-State: AGi0PubVGdtS2gLlsXdbk2qwv5WW/tw6/6LUFS3eQcQrTKALYb7+tFG7
        ZZY90ljJt6BBs3zDK+2ELUuv5z/lhrX6sQ==
X-Google-Smtp-Source: APiQypLH7ttflqskQ/gxKB7YY2ghg5lIftbsYkjJJPhxZHMwH9fB7mILnMBd5bbdP/m52rcZOj5K+A==
X-Received: by 2002:a17:902:598f:: with SMTP id p15mr626050pli.264.1588276135887;
        Thu, 30 Apr 2020 12:48:55 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id s123sm485611pfs.170.2020.04.30.12.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:48:55 -0700 (PDT)
Date:   Thu, 30 Apr 2020 13:48:54 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com, jrnieder@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v2 3/4] shallow.h: document '{commit,rollback}_shallow_file'
Message-ID: <c251cf3ef9fe34e78db30c3170b56a496bc45345.1588275891.git.me@ttaylorr.com>
References: <cover.1588275891.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588275891.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 'commit_shallow_file()' and 'rollback_shallow_file()' were
introduced, they did not have a documenting comment, when they could
have benefited from one.

Add a brief note about what these functions do, and make a special note
that they reset stat-validity checks.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 shallow.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/shallow.h b/shallow.h
index b50a85ed7e..b3bf200bf9 100644
--- a/shallow.h
+++ b/shallow.h
@@ -10,7 +10,9 @@ void set_alternate_shallow_file(struct repository *r, const char *path, int over
 int register_shallow(struct repository *r, const struct object_id *oid);
 int unregister_shallow(const struct object_id *oid);
 int is_repository_shallow(struct repository *r);
+/* commit $GIT_DIR/shallow and reset stat-validity checks */
 int commit_shallow_file(struct repository *r, struct lock_file *lk);
+/* rollback $GIT_DIR/shallow and reset stat-validity checks */
 void rollback_shallow_file(struct repository *r, struct lock_file *lk);
 
 struct commit_list *get_shallow_commits(struct object_array *heads,
-- 
2.26.0.113.ge9739cdccc

