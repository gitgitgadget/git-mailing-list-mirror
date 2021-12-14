Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAA1C433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 04:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhLNEJX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 23:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbhLNEJR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 23:09:17 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A39EC06173F
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 20:09:17 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t18so30240340wrg.11
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 20:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KCDeweA+/ubYaoD9XQgWyyRMiO8wIWbgEtEFVicDa2A=;
        b=azh0LorksuRIQJTgcp4g3HZiwORq/TIRLN1lVsuou3oLi0qomjxiBuatMK3s8nGCW2
         NAB1hEm7Pe0iD43YVMZn7uLNWvLVREVllXoibwPQ9m9Jqtes4r2ZhE2izRlwyIrmz8Eq
         iSyrniM0jRLMgp7nslPNvoTbE8pHrjHVt6+2G0ssuYPOdu0iSWV5sqhplwhK5ZJ8GJiw
         J5x97dYLTYIzDfrTJe0gypdY2PvQ0lIoj47iqtOhwxe7TGEMs8Qd2I9uvnJD1vEMtTFC
         m4kS7P5/w2ch5aHatdnsEp8r9GbIVVWD5V6X71yqOSbUsAYOvJYkLjKd/V2ZrOeSeFX7
         FB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KCDeweA+/ubYaoD9XQgWyyRMiO8wIWbgEtEFVicDa2A=;
        b=sX43J91C9foZlzOLRBYsMdLildhw1lpMwmMNIHRhLuQeBWJMXidpNrLwwalwZPIf8c
         bcfxZclyhTuZ8W6GR2K1KsgJZdq8Fjfq4iEiRq72ZOI/GOy1f3mZL3JGqbLJmJZCybb8
         SshvFe8JoWaLQyDhDqa6Hv9qyU1hBUYYWqu59xv60NeDS08lWlei2s/jGKB4rgVRiQNL
         C+fS9YS5szybN+zv4WePmmo3FvFY2OHBNgd5JbKXhouqFdNTnzBBpX61Qo7cv3IpODNz
         HJWqk9bbVE/HcxrV9YtsOY6C6egQMZx6Toa6mvtQzbQvzkPbZT8+FFWIi17dGzBswp7Y
         x/aA==
X-Gm-Message-State: AOAM533x1l/cQK+A+Cgj9E+QBJn3c7t4VMd6MA+Wqp0RpPo2TQSiVzdC
        /mjxj82GqHAcxiYR4+jv3GVSY3cDrqc=
X-Google-Smtp-Source: ABdhPJwiDH5hm1ozZx4cp9PnQp7tnwfxTuhU6zyGuEaP5hcX6wLzx/yTCDuTkYPcDFEFxZirJl1iTg==
X-Received: by 2002:a5d:6b09:: with SMTP id v9mr2828668wrw.591.1639454955597;
        Mon, 13 Dec 2021 20:09:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm14703034wrs.17.2021.12.13.20.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 20:09:15 -0800 (PST)
Message-Id: <5882332b97f7766332ef5890e8bb8ee31b527fa2.1639454952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com>
References: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
        <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Dec 2021 04:09:06 +0000
Subject: [PATCH v4 04/10] sparse-checkout: disallow --no-stdin as an argument
 to set
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We intentionally added --stdin as an option to `sparse-checkout set`,
but didn't intend for --no-stdin to be permitted as well.

Reported-by: Victoria Dye <vdye@github.com>
Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Reviewed-by: Victoria Dye <vdye@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index eb8fbd36b0b..387903eafe7 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -699,8 +699,9 @@ static struct sparse_checkout_set_opts {
 static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_sparse_checkout_set_options[] = {
-		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
-			 N_("read patterns from standard in")),
+		OPT_BOOL_F(0, "stdin", &set_opts.use_stdin,
+			   N_("read patterns from standard in"),
+			   PARSE_OPT_NONEG),
 		OPT_END(),
 	};
 
-- 
gitgitgadget

