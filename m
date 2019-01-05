Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFA1F1F6A9
	for <e@80x24.org>; Sat,  5 Jan 2019 05:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfAEFwc (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Jan 2019 00:52:32 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33528 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfAEFwc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jan 2019 00:52:32 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so18377996pgu.0
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 21:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3XJww+mjn2ekowxHM8wGMtE76Q7IY3qj021KCmxoEqM=;
        b=F6LlxWAk6MajN0CdpIu2VNgQCQChNp/6/BGeSLv8d4iDyOVoY4HoDQs3eWxSYVnEYE
         Gt0Z41el/6xW4nYpYX8gqoYQyttdfG+1qtj/QvaLrL9hq9CLjdv9Ly471CYhw75aHdfk
         HPe7CaGI9k7zKN07loCSH9j8XHsd8iYv9w28Ssb4yCXezCyg5AU5IFtEzjoXaE70KT0J
         m1N61Ki5e6lZvhre1sSvOWCwo05AcYYKYmNe2fByx7yJajjsBNMyAGjOyVCgRGErHnSp
         nzXm8IgfiAjDxeM/p8XnFpJLcwLg5Gz7OPCeT/RJ+l/IXFqweLxJWG1olBFmiZ64N7ha
         0xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3XJww+mjn2ekowxHM8wGMtE76Q7IY3qj021KCmxoEqM=;
        b=mmGQ5lNnRYe/bwBfLThH1PO8PqozEaofW7npfCc+wXm4gIgT260EQ4mc+eFTk7cKj/
         0T7v6BTG/0JP2ra1bSBGU7dobspsM3OCQgLQUK00lVGoqBabp/r/dLpIBjhIoV58JEGE
         GImGt3UgjiU0aEndvhC4XwfXYdXi1P0gWKEQuMIq8xVweE5N/xfzdfzKJUl+8yjBMY/G
         lXmEjPbl+CL+QpdF7/TsPzdlpR6hQDEwFy/i4GSy/rcFIDaZPjNHMLNPbjA3k5yF2QK4
         j2eyr6R8JPOxhjVKjVzl1cokRHzSEDedSztc3Ce8lWYilvhB0O2h/3orXGGnF41/U1jm
         AWzA==
X-Gm-Message-State: AJcUukf7pzNAJcUSH6dtjh8G67OkXP16G1gImDfteaZG1sSa7a4fqt8g
        9mx+t3IOqAs1neM6G+vjJHCehDE+Y8U=
X-Google-Smtp-Source: ALg8bN57eFkhL9aB2LSF0dCRmXQLncPSe8ZxIb+uPvFNjoR910LWuIDt1nkzsVV/9nX/g9gk73+P4g==
X-Received: by 2002:a63:5a57:: with SMTP id k23mr3976040pgm.5.1546667551618;
        Fri, 04 Jan 2019 21:52:31 -0800 (PST)
Received: from ash ([171.232.90.54])
        by smtp.gmail.com with ESMTPSA id 125sm77386282pfg.39.2019.01.04.21.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 21:52:31 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 05 Jan 2019 12:52:27 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/10] checkout: avoid the_index when possible
Date:   Sat,  5 Jan 2019 12:51:46 +0700
Message-Id: <20190105055153.3256-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190105055153.3256-1-pclouds@gmail.com>
References: <20190105055153.3256-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 08b0ac48f3..1b672a9fd9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -284,7 +284,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 		return run_add_interactive(revision, "--patch=checkout",
 					   &opts->pathspec);
 
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
 	if (read_cache_preload(&opts->pathspec) < 0)
 		return error(_("index file corrupt"));
 
-- 
2.20.0.482.g66447595a7

