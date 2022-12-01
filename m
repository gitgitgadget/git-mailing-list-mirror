Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1588C4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 00:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiLAAzW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 19:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiLAAzU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 19:55:20 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294BE55CBD
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 16:55:20 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so3661467pje.5
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 16:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POxnntxajg8wk7DQd2cCyZptWH+Vj2Zqgn170AqvPFc=;
        b=hF+JiSFypaDC2XTKhxeh+QgayQISiA3ws9LsksAKDUF9pv6Yq+sV0zy629soz0O360
         F17U3LSa0sBIZD7RbcPUZ8U3lZ9BtwT1sXzzNsG3L/AatDs4OSR35NpmYO7BQtutWfeX
         mvt3MCBgq4dNYVMaCxO44yi02Yz9xmVXkBFnhgv3+1p5JRgY5IfUWSbU2zuruoxcJp2d
         ZACnMklEzhnPgU8fNwW/re255IcvCRjX6/DPA6Rq20aiIrISBUmN2jVQovAcVysVp/er
         bUG4/zsKda/ndRksw25j74smlwTkKnGmfesa6//BY5JUJ0uMk4gyqO+Ulwf/8ziI+9kI
         RVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=POxnntxajg8wk7DQd2cCyZptWH+Vj2Zqgn170AqvPFc=;
        b=a/8E7NlRH6Lwq7bHkFU8FMVKBrFc6icZyYjsSknxtqM9Q7ReDjzqNOy8nu/63Tfy2m
         SziOIy+DPR8p7JxD+D8qH5zApwEfirJBaXYtIgN+uTjMzYwEy4+QZnWrWog0F+YFIkp0
         NQ9eTu9SqB5+496W8OR1wq87THJMOYtMtFYdShiIoPIB7S7XNieNohXqoODjHEm7lEpk
         NbwPYBa0w7btrUDcKKfK27QaOjMWYgsKy4sK5+49TXLveJQ7YqE93M7muNO5G16UlEe0
         Rs02OEgxkvZSsgomJj3kJxDyTusKbFNWxF23/UQvLPUVcDzm0IUssLZhz212SD9/F9Mq
         F59Q==
X-Gm-Message-State: ANoB5plyK5IOL5H/nVvXHJpKT5GKSYY1cTOzTYhpeQgByV2smMbPYlWR
        FTVleI71XSg6jvJpQJrTArY=
X-Google-Smtp-Source: AA0mqf5AcDyeZzb1z7kw0zkGbfsQ4d37e3KKJ94YcCerimGg/IUUgmUB+cdMALCfOYwH6jUVTNLFwg==
X-Received: by 2002:a17:90a:2ec5:b0:213:9451:1775 with SMTP id h5-20020a17090a2ec500b0021394511775mr75328524pjs.90.1669856119584;
        Wed, 30 Nov 2022 16:55:19 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090341cd00b00186f81bb3f0sm2133106ple.122.2022.11.30.16.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 16:55:19 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4] am: Allow passing --no-verify flag
References: <20221130172833.2662751-1-thierry.reding@gmail.com>
        <xmqqr0xkt07x.fsf@gitster.g>
Date:   Thu, 01 Dec 2022 09:55:18 +0900
In-Reply-To: <xmqqr0xkt07x.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        01 Dec 2022 09:51:46 +0900")
Message-ID: <xmqqlenst021.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...
> The same comment as the previous one applies to "test_cmp_rev second"
> check.  I think removing them would make the tests better.

I will queue this on top for now.  Thanks.

 t/t4150-am.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git i/t/t4150-am.sh w/t/t4150-am.sh
index d77c4dcefe..50b257e43f 100755
--- i/t/t4150-am.sh
+++ w/t/t4150-am.sh
@@ -356,7 +356,6 @@ test_expect_success 'am with failing applypatch-msg hook (no verify)' '
 	git am --no-verify patch1 &&
 	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code second &&
-	test_cmp_rev second HEAD &&
 	git log -1 --format=format:%B >actual &&
 	test_cmp msg actual
 '
@@ -401,9 +400,10 @@ test_expect_success 'am with failing pre-applypatch hook (no verify)' '
 	EOF
 	git am --no-verify patch1 &&
 	test_path_is_missing .git/rebase-apply &&
+	test_path_is_file empty-file &&
 	git diff --exit-code second &&
-	test_cmp_rev second HEAD &&
-	test_path_is_file empty-file
+	git log -1 --format=format:%B >actual &&
+	test_cmp msg actual
 '
 
 test_expect_success 'am with post-applypatch hook' '
