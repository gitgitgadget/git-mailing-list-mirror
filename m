Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C59C1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 21:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeJLEro (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 00:47:44 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:54948 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJLEro (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 00:47:44 -0400
Received: by mail-io1-f74.google.com with SMTP id l24-v6so9145894iok.21
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UUZ6Va/mNKFe/YVnUcUO+5XlmtcsDZnNJk0zm8ELkRw=;
        b=Isa5cz0hNDaxj1oP780s/A3Oqfu7rl6/c0pmq8YNTIdyJKZSjnePHuCmY1kSM0K1G2
         WAVzQ0+sjiyUZJ+AvEGtcRKnYymspX9mHaTqm1/Gzh6NSoTVH4ExBIqwOoX2wTqlegO0
         N47AqRfImA+129InyOKrprfenHyi05Ts2O+NAFO+EAXzt+HZZIZVYs7cQQC1aLH5CE3N
         aMysqZXv8mt03xJ09tjnBY1lrHffP/no+N2QJ15hZWZPg3dsBI1DarVlMOTx79cqj7rP
         u8ArOw+WMsvNm39NKkObh/x2c3MOHyWNrQcnkgXvDEjRGYH2HUwlB18uevzPIon/byVG
         VWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UUZ6Va/mNKFe/YVnUcUO+5XlmtcsDZnNJk0zm8ELkRw=;
        b=C8dbVlkegyD1y40g03FtrSJWB+SzXmzWBU0VkSFgH0o/SCjyDkIZ1TXBiVhNsvbhAC
         Hsqo0/4aO8X3P7IQ5ueqAD7i2ZxpiZPmwzCm+dTimpYzHZOEakkGxzbiAnAeJA2XH6s5
         X689udMcBv6L3SuGF76TkczEFxDtZqHagGvC6zDwsy5IhoRsQZIlQOKw3tQXs1oS0EwF
         RaVL/EtuK345+b9oadmOKZBuRpTdn5AyoS2lrh+flte+b9mNKfjKM2siFYgL+9W7mKTb
         h0U0KdgbxDV8KInFDXC96vDfLN8TXZwruev2HTuXwoMrm2XFQ+8BmYHNdgQteCJPCNBC
         vtmw==
X-Gm-Message-State: ABuFfoiOfhVxdcl55jxINVNXrymYstUT6nHm6Qp0ZwGX6MT9n33XI3hd
        23NhrwX7HhqKXukCjOSb54FSr3VMlPIlBSWQw55GVeaq71+HKta/YSSf8LLbM6T1/QURr7A6e8Z
        PsW0VZ3M+itBLZBkAHpEQrd+fs2UyfsoBpnIQ5oWlWOOhjXddKhpt/FdPZamw
X-Google-Smtp-Source: ACcGV60meAc0xKicrSSHGPHuorsHrniDmCgK9zx4XDOBxq4PIjCyIX+7lUfB9DMwBP3vf+EKTNLhr/rRx1Zh
X-Received: by 2002:a24:3d14:: with SMTP id n20-v6mr2868284itn.13.1539292719249;
 Thu, 11 Oct 2018 14:18:39 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:17:53 -0700
In-Reply-To: <20181011211754.31369-1-sbeller@google.com>
Message-Id: <20181011211754.31369-19-sbeller@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 18/19] submodule: don't add submodule as odb for push
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The submodule was added as an alternative in eb21c732d6 (push: teach
--recurse-submodules the on-demand option, 2012-03-29), but was
not explained, why.

In similar code, submodule_has_commits, the submodule is added as an
alternative to perform a quick check if we need to dive into the submodule.

However in push_submodule
(a) for_each_remote_ref_submodule will also provide the quick check and
(b) after that we don't need to have submodule objects around, as all
    further code is to spawn a separate process.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 5e1a6c0b7c..f70d75ef45 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1006,9 +1006,6 @@ static int push_submodule(const char *path,
 			  const struct string_list *push_options,
 			  int dry_run)
 {
-	if (add_submodule_odb(path))
-		return 1;
-
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		argv_array_push(&cp.args, "push");
-- 
2.19.0

