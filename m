Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F22C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 01:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345136AbiA1B6W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 20:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbiA1B6V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 20:58:21 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC08C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 17:58:21 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso7114373wmh.4
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 17:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=/9zq0JTPS0G097TAOHKN86aKPBt6S6nCuxmR1/MAziA=;
        b=qAmAjZjD3LPJwRVVSzFGoarWLwJd754/SEb6kYvVhGkEmsELSXbRAk3ioNI6MC9UZq
         XCmaDtLzk/pytqJkYeH1NmDYBqr5I3m7CYB2B+6UKzfvTZyxujKK/GuMN5PmQ8WqxM8m
         BxppgI7Kr6EtGTl1E7z7bEFHG2a1rBLGN03aRx1GQVElP+HPgTOQg8mBRc/rkEUkz1jV
         taHgjA0jWqiIRrpsnP3FCGJ0GSDQhNKPvcEwk8FfHpTwgcBvJwe7Zoki2sI6HGTEgi+f
         hQgDKzRgKVGXFfkn1fixyE9R8+H7NeV+0/4ub53DJEFJHDQ2jS/c4cH7gOy3+HFzFbL6
         PIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/9zq0JTPS0G097TAOHKN86aKPBt6S6nCuxmR1/MAziA=;
        b=FsXi4KD5EGn0Xa/wEFS2FwG6EMZGDjsbyEeZe4oQktVpLCQryv/SrLG3UX+MSRt17e
         q5sAhvpNG0q+8Ue/fb6POUwtqMkYC5MMBNSvQ3f5y3v8pusNuFNmznnuOk0CCV/GdhFN
         q7zijnta9injINrXI2ges7g54Ycm/kn4oP+8CDr6fw7j09HC0C4JqwNkozuDMpAhhi5+
         6ClJCcZ7Z0hIQ9nLSGKp1ILDjyhW7CrFPqIgmWSF2IXCCEkONg/GBcEKJ7Vls9T6rUax
         zv9/NLfDo8Y+887gSRkCTrzTh8F0MnomMhQDkMF2OQCnrPBY6MbzjWhywRQ00QYC3nN6
         jZ4Q==
X-Gm-Message-State: AOAM533LIOe8vH60FH6N68SdkbE/fHjKzyKsvnz0gX7cF4qwdndnvQ4R
        pOrzlXoqUcPDqzaSIZI3/rrJbYihbyg=
X-Google-Smtp-Source: ABdhPJxtro0+tVfxwfNj0FbErtlVo38pa51rSYuLL/eHBDXL7IbRst070xntwPaDgKx2v/jN3J4t3A==
X-Received: by 2002:a7b:c933:: with SMTP id h19mr5486296wml.114.1643335099712;
        Thu, 27 Jan 2022 17:58:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm3370562wrq.70.2022.01.27.17.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 17:58:19 -0800 (PST)
Message-Id: <pull.1189.git.git.1643335098710.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Jan 2022 01:58:18 +0000
Subject: [PATCH] sparse-checkout: fix a couple minor memory leaks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

These were introduced in commit 55dfcf9591 ("sparse-checkout: clear
tracked sparse dirs", 2021-09-08) and missed in my review at the time.
Plug the leaks.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    sparse-checkout: fix a couple minor memory leaks

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1189%2Fnewren%2Fsparse-directory-cleaning-memleaks-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1189/newren/sparse-directory-cleaning-memleaks-v1
Pull-Request: https://github.com/git/git/pull/1189

 builtin/sparse-checkout.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 679c1070368..c655517e019 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -185,6 +185,8 @@ static void clean_tracked_sparse_directories(struct repository *r)
 				item->string);
 		}
 
+		strvec_clear(&s);
+		clear_pathspec(&p);
 		dir_clear(&dir);
 	}
 

base-commit: 1ffcbaa1a5f10c9f706314d77f88de20a4a498c2
-- 
gitgitgadget
