Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DD4C2BB55
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D031B207FF
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvrPNDBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgDJRvn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:51:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33227 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgDJRvm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 13:51:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id z65so3364441ede.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 10:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uKuuHJEYmJLprzJwDK7aADJABshMqhpuzDAb3cVwbSs=;
        b=bvrPNDBtruJ/aY7YvKYWzYKAkSPH5U19LowgP8wV9rb74rzISCh7tBSkKE9EnT+XS+
         2EqfYZPzDBI4wKwZ1DFUPx9uFpJMApH8nsF9Wi/fMNMDQN4Vkc8UYCAavcSIHVVLXdHO
         k/rE76RSGEWPEn7s+1BqoALQVpbGeJV4PfCqUuAqQ3poOarEBTaQL7VHE/U0jzWAN/A+
         ACibONQY7whKAbrt7yknzuMMggvyp65FglCG9bLmV2a50Cc/rYy95cV0kraiSEB3SZBl
         8zWqsqePPjm9mSkQCQlzAQ2419/lav8mvZLFv+9F2OGWa2FJOpwP+PISywChKrVoMMn7
         7F1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uKuuHJEYmJLprzJwDK7aADJABshMqhpuzDAb3cVwbSs=;
        b=TifvDagFf4HGXD4fkPHewXsl6x1qNJ6LW5YMdIZlov07CEcMG5W6R+GCBb+4WjUuMD
         hm/mqH2OjNW7IZCyK3+iHNw3ZRz76sE6oR6wS8dk6vB/eVuMyZWXZOYIceWX2nkIlJ2x
         XOZjfzDdDAvOtERMhEh9tE/x3wYMLo4HR6x5h1VIxvcI+Oe5+5KYMYt+fx8L74CMrJj7
         CX2GyK10v6yJfzjoZChi66aQDD3zUTd7zTQZJnHkFctdJMbTLMOkBPJ5DDVmB3p/hG4o
         +8GWtq9+MZUPUYq3EF3Dkiu4eIrJVu3ixf5tux94nJt2iqNQzdRScyBciN6Ldg4r35nx
         ktvw==
X-Gm-Message-State: AGi0PuabiT9MUptzO6XPEXD3/KZUymdjBprNQauinlkN6TRr+7EkaioV
        BA1Y/wdiYJA6YhPl/HpuuKolrIN6
X-Google-Smtp-Source: APiQypKOQbH9YGtnQ+RIH90gv77nHYN78ziYm+n89iaH2KWDcVpzl4hn7t23XULnGkYujxL9/BDePg==
X-Received: by 2002:a17:906:9494:: with SMTP id t20mr4382269ejx.51.1586541099033;
        Fri, 10 Apr 2020 10:51:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m18sm154606eda.14.2020.04.10.10.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:51:38 -0700 (PDT)
Message-Id: <ee5e42361fcdeb5dc04765a6a4eeeaf69ab720b1.1586541094.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com>
References: <pull.757.git.git.1586474800276.gitgitgadget@gmail.com>
        <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Apr 2020 17:51:34 +0000
Subject: [PATCH v2 3/3] rebase: fix an incompatible-options error message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        bturner@atlassian.com, sami@boukortt.com,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When the user specifies the apply backend with options that only work
with the merge backend, such as

    git rebase --apply --exec /bin/true HEAD~3

the error message has always been

    fatal: --exec requires an interactive rebase

This error message is misleading and was one of the reasons we renamed
the interactive backend to the merge backend.  Update the error message
to state that these options merely require use of the merge backend.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 022aa2589a5..0e223a96d46 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -561,7 +561,7 @@ static void imply_merge(struct rebase_options *opts, const char *option)
 {
 	switch (opts->type) {
 	case REBASE_APPLY:
-		die(_("%s requires an interactive rebase"), option);
+		die(_("%s requires the merge backend"), option);
 		break;
 	case REBASE_MERGE:
 	case REBASE_PRESERVE_MERGES:
-- 
gitgitgadget
