Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDE9C71156
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 20:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF3D20717
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 20:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGqGpAfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgKWUF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 15:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgKWUFz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 15:05:55 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6995EC0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 12:05:55 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y7so4494592lji.8
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 12:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:user-agent:mime-version;
        bh=eU+iBAUIR8jjo3TsFV34u1X6K97f1d/J39t8ayv8v1U=;
        b=eGqGpAfjlzvuKcUT6vlgukKp9NRkWYAuGfAtuLNUxdFz5R7XZ4rikRR3K/e3jQ2RkQ
         cZcb4ohD8OG5lL+YJXgf61lpqwBcwzY4HDduKvopDIPMggI+FNmcqy89jjLVUJgSG49a
         EOFr15pmE9EEf/Ve0uMx3OA0OiU4W/vmd0irwgGgo/064BhDXwG/JqhMPm41ZUvjQyNv
         8TFm7sKjSnitGay/l2/VsuLasBph3Q3iKCj3iavrChR6WUmC4KEwciLkOVQN9qNCk6aF
         0vMfE6IfYxzcLl2I2gk9ge37kN9qYY1F6aPjolTJ1Ahy9cSWobOpG7uoZd6dxLo5PsAH
         7P5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :mime-version;
        bh=eU+iBAUIR8jjo3TsFV34u1X6K97f1d/J39t8ayv8v1U=;
        b=AWxjnuVGUFUYjxsKZhcp2VvFPi6RhpeM2+KSOud4GJ0XM2BcWyujQuKW0WPFe9e6Qg
         unEVPPhN24jvppEt/2kR2yNxLSFBxaTIeRvpTPLFNqpMmzzUsrrugn34Q++Uw89dJlIV
         AT73kSO942DG3dWX3dugtv+AfxM+ZPlBIVVY+gC8JC796dJsmBkt2OQI0OCkhtaLi1Jv
         g656G7kVbwUoNre6YXSErLtsFBluVQ30ITerg+OSd0JV/EFOVIC+rJyzjxBpOMOlA7hM
         X0hZOi+XYeB+PUMMnWLtWXKQzt7pXtQ+B0g+dtttrpaow8BoDT71v2grNUXKpBW/+Lg1
         rf+Q==
X-Gm-Message-State: AOAM530nsa7ELJWziqqf/xzi7a0aDFS5Osx2JrLNFpfMYEuTzzrNOPnA
        B5tiLIYouukiMJtrZku2NFVKpuzx4xk=
X-Google-Smtp-Source: ABdhPJwxjMVPBTYrTm60Mln9aPRFh/LfqfgQJlP93cZpo0v1rcp3iYiQwuCojd3/wKzjfAr7KU8lhQ==
X-Received: by 2002:a2e:854a:: with SMTP id u10mr437657ljj.443.1606161953372;
        Mon, 23 Nov 2020 12:05:53 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 125sm1484329lfe.171.2020.11.23.12.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 12:05:52 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] glossary: improve "branch" definition
Date:   Mon, 23 Nov 2020 23:05:51 +0300
Message-ID: <87blfnhm8w.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old phrasing is at least questionable, if not wrong, as there are
a lot of branches out there that didn't see active development for
years, yet they are still branches, ready to become active again any
time.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/glossary-content.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 090c888335d3..8bf198e72771 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -18,7 +18,7 @@
 	Untyped <<def_object,object>>, e.g. the contents of a file.
 
 [[def_branch]]branch::
-	A "branch" is an active line of development.  The most recent
+	A "branch" is a separate line of development.  The most recent
 	<<def_commit,commit>> on a branch is referred to as the tip of
 	that branch.  The tip of the branch is referenced by a branch
 	<<def_head,head>>, which moves forward as additional development
-- 
2.25.1

