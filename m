Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47B1C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 08:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9CD460E0B
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 08:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhJ1IcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 04:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhJ1IcF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 04:32:05 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB56C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 01:29:38 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bi35so11889632lfb.9
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 01:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=V6fmS6ESH0WJzu6tNX4jb3hHh9eLf3hxBxmGGt9mp0U=;
        b=PMZHCXtAPCNk0zUsVySDgrqPYcVzRkcLCWHoh1obs6G3dmudZZwiRBxa11zf6DvSlE
         3IhpzXjOx/C+NWHjfXuVMkjDZJPKuo/akeDSilydGtP8bgvu/TyF0GPT0+xsMWJuu5+d
         UPy/XRlGFMeoKJZpwdnJnfenHR3yMqNOqFsXFNZceZ8rXHBXPfC2oZVg5DXyAnluO7iw
         BnOcl2GbM/uqL5U5zqvqEkbQKWMBE4+c4dWBzVCNC5m2XYRVPI78D8ZccuCNovZJH372
         lchTeMFZsSitM1MmQjqnrghFDszN0wzCGfm5Wb872YeQv2aO/5ft5xDkBklO7RcstrW1
         rBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=V6fmS6ESH0WJzu6tNX4jb3hHh9eLf3hxBxmGGt9mp0U=;
        b=h3fA8G5LvN+3TzDqLhK/ALbaqZNV+bSK0ooyPeGf5asqnlhm1N47xdUD2YAMIRvblt
         WSeLjzP0hG2J9eUNB9TmuDR85wg+3a7tvLA4AgQkhUqAxSAINPmoEhldiGTXGLbHguIb
         CSwo4t5Y4NhO+MGTeNX+Why7hhkqHlyeQJ43Qk6PRRULQBBLzNQIHOxiI0XQFZVCRA6c
         smQSpP8S7P00RaglIGN4HfiSIAEvDOP5tJIXhKG7uHpgEMS9II1r9rg2d8dqZicVjLta
         TFN/9HeND50nABDqY7e/UEJsZU93zr1BnQFp5DwUrrlwt6PEHtv49QSSJ9mR5ACXTJ0I
         SlXg==
X-Gm-Message-State: AOAM531/UEZdX9qwvOyH4hkYDChfA7SJ6WFEyM+JWw3kX8KtDdH0sPbH
        Hy4RF/sEVJjVTXXucpEtQwSWUZJQxsg=
X-Google-Smtp-Source: ABdhPJw2teJfqEx+oJ9aKM+89Ddievb4SPauUu+PILYL0zbBUbkqKWbIcs3wiQO47WvlkmbmX9qXgQ==
X-Received: by 2002:a05:6512:1056:: with SMTP id c22mr2968927lfb.26.1635409776132;
        Thu, 28 Oct 2021 01:29:36 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 198sm207590ljf.101.2021.10.28.01.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 01:29:35 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] stash: get rid of unused argument in stash_staged()
References: <875yugcs3l.fsf@osv.gnss.ru> <87lf2zz59w.fsf@osv.gnss.ru>
        <87fst2gwia.fsf_-_@osv.gnss.ru> <87pms2mi1p.fsf_-_@osv.gnss.ru>
        <87wnlya40k.fsf_-_@osv.gnss.ru> <xmqqfssmupvq.fsf@gitster.g>
Date:   Thu, 28 Oct 2021 11:29:34 +0300
In-Reply-To: <xmqqfssmupvq.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        27 Oct 2021 14:19:53 -0700")
Message-ID: <87k0hx5z81.fsf_-_@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unused 'ps' argument was a left-over from original copy-paste of
stash_patch(). Removed.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/stash.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 8d6f0e582ce0..18c812bbe032 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1132,8 +1132,8 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 	return ret;
 }
 
-static int stash_staged(struct stash_info *info, const struct pathspec *ps,
-			struct strbuf *out_patch, int quiet)
+static int stash_staged(struct stash_info *info, struct strbuf *out_patch,
+			int quiet)
 {
 	int ret = 0;
 	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
@@ -1370,7 +1370,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 			goto done;
 		}
 	} else if (only_staged) {
-		ret = stash_staged(info, ps, patch, quiet);
+		ret = stash_staged(info, patch, quiet);
 		if (ret < 0) {
 			if (!quiet)
 				fprintf_ln(stderr, _("Cannot save the current "
-- 
2.25.1
