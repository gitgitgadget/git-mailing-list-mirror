Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BC1C433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 20:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242587AbiERU0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 16:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242586AbiERU0K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 16:26:10 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B94F7DE23
        for <git@vger.kernel.org>; Wed, 18 May 2022 13:26:05 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g3so2579313qtb.7
        for <git@vger.kernel.org>; Wed, 18 May 2022 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=9FvEm0zg8TqGVxWKawWt1UT5n5tBsfIQvgqFry4bIg4=;
        b=7tQNO/N1CijEPmvxPQr4JA21ZSQuXVQF9uPqFob4FeykHGQ1m/p85be6xAJIhwsiF+
         +yBblWWo/06XZNotZFe6fuPDI7Te0WdFM39o6Y8KZ5+8jNnp0IBHoGTv7L7w1DTYI0Bs
         sLjVmWIatUjoVXlKCUmlx6SHF1EJ8CjnTCkozIrgWLGNY0xsgaQCH1V2SzmPVbjQhukJ
         zCUKvCEJwZP81MlvFizh0dA3dvq7CY/P5NmqhTQghRfXf1m4eyVDRzVb8vs6lntlu7Lh
         jnEgbv8SU7/TXeLtABLcBml8OiQBrfBCRzgZRzLY4yijvQAdEMJ3eV1lQoiqqtfSnd83
         yuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9FvEm0zg8TqGVxWKawWt1UT5n5tBsfIQvgqFry4bIg4=;
        b=EFoW+8vTvZ0JqIxUKG2bPksejB48424CYXJoHHbg6sPu2vXM6xH6NNtmMi6Slc57zS
         3A9s0mLm4fRkoEbCxeUl2aKaj6L+24ypFGUMacQV1AdWQInQZvC15xQaAlcm9PpoYd69
         8dqTJ3mI7ZwLzaywAoFIULjUsVocJZx5R1iP9F+QOXDz7Z1hCV+VQ21tkZGYpG6Cvg2u
         WaPcQ9J3LKDq5Jya2+7gVSU6fWxvW9EQ1/k/B69viYyNVzDA7q3TrLun4dkxoPtXuGEc
         a4zn+EgYv0chsfgwSq7yJi/7bAXjnPkgccW0HgeQn4Q7fR9mfiWHS9V4ZBqtGyCDaZ2l
         trGg==
X-Gm-Message-State: AOAM533AqcTi+wu56gpVexSudRo5mKOG42ccAeN1ZrJPDRUOZKddrhgz
        8F5n3qfWsM6gCyg5OaY8GZWp9jCe6Id37YVQ
X-Google-Smtp-Source: ABdhPJxGJMj3JVuOYmDGfAjnSzd71P3jbOjFMmCvqTOp7FLH9fuMN3FT9kEe+XvylAVzVEBKA8BSAw==
X-Received: by 2002:a05:622a:510:b0:2f3:db74:1487 with SMTP id l16-20020a05622a051000b002f3db741487mr1420171qtx.510.1652905563988;
        Wed, 18 May 2022 13:26:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u1-20020a379201000000b0069fc13ce1d7sm157458qkd.8.2022.05.18.13.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:26:03 -0700 (PDT)
Date:   Wed, 18 May 2022 16:26:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com
Subject: [PATCH] builtin/receive-pack.c: remove redundant 'if'
Message-ID: <d22f2ca975778d594449857d64be8cd8c0d4a327.1652905549.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In c7c4bdeccf (run-command API: remove "env" member, always use
"env_array", 2021-11-25), there was a push to replace

    cld.env = env->v;

with

    strvec_pushv(&cld.env_array, env->v);

The conversion in c7c4bdeccf was mostly plug-and-play, with the snag
that some instances of strvec_pushv() became guarded with a NULL check
to ensure that the second argument was non-NULL.

This conversion was slightly over-eager to add a conditional in
builtin/receive-pack.c::unpack(), since we know at the point that we
add the result of `tmp_objdir_env()` into the child process's
environment, that `tmp_objdir` is non-NULL.

This follows from the conditional just before our strvec_pushv() call
(which returns from the function if `tmp_objdir` was NULL), as well as
the call to tmp_objdir_add_as_alternate() just below, which relies on
its argument (`tmp_objdir`) being non-NULL.

In the meantime, this extra conditional isn't hurting anything. But it
is redundant and thus unnecessarily confusing. So let's remove it.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/receive-pack.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9aabffa1af..f673e0e76e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2214,8 +2214,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 			close(err_fd);
 		return "unable to create temporary object directory";
 	}
-	if (tmp_objdir)
-		strvec_pushv(&child.env_array, tmp_objdir_env(tmp_objdir));
+	strvec_pushv(&child.env_array, tmp_objdir_env(tmp_objdir));
 
 	/*
 	 * Normally we just pass the tmp_objdir environment to the child
-- 
2.36.1.94.gb0d54bedca
