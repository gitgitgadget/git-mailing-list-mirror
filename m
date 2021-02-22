Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36C1C433DB
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 17:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C7764EEC
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 17:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhBVR1Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 12:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhBVR1X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 12:27:23 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF17AC061574
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 09:26:42 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id t29so6987972pfg.11
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 09:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+MItqV3DSLdybRymUZEmL8sGPtlXTaQ2quEcjfubN7c=;
        b=RT6vMIVzv9U2n2pxZUl5f7zbqG3ybkH+FNdNaLxwzmqu9i2uF5jF5uV0OVFDE+7il3
         IBWj/h3cUVRrhLHqjY3Z3UPFN4S2o4fOLdzLGl6H9i0MBXNFSm+7EDeDRPdnhR46ENMB
         TEomsA/dGSKdJdGVo3tiOx0iubRkJVCk64Wledle15gGfwcmi7vBF1c0qXV9YIWLA50L
         9wHct/Qax+czk8ZDBV3SGaHGlhx914v8m77movMN9RXPyjWgpKxstJeqH0Le2rRtb3Nm
         t3yOuY/pASOu3ZJxdquxCRE8F269kCnkdAwr+tfsVYEOurX58mIvs7WWG7EkWBLMR1vt
         LAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+MItqV3DSLdybRymUZEmL8sGPtlXTaQ2quEcjfubN7c=;
        b=Lwa6+guxSDYjzhmfQYCCVdieu5UxWUx9U7LnXJVjm+auP8MRFWvu/znDgu4SLkbfHL
         Qz6ivGl7y0MKZWTJKujlmhR5I6Heini39Pb5ycz6TKRg4TqSgCrybRpavkNw44jT0qtg
         hwc7YMWYNX9dG+XUrXQCpvH3TikriZzUEOg+BV7eFYKpTWXMNACiYP63G41B9jeQBOOm
         iBxNESxM8unN2zdZfYllicfF++LDZw68aKkkldfZQ1F0JrPbv6pyIQcHb+jC2d0EibCE
         5Dlm8fS+yn/1litE+D2I8CytYaleVu3EISKR1qIlzyOaz5x9OUivDPdnmhhFrpJx9UOv
         8NCQ==
X-Gm-Message-State: AOAM530NdGGTf7RRE1d9u1I2/iALyJ/GnBRmYqpiWzRSm5EGUk4xU9JS
        G4WH4tKY4EfP0rfWG41NNfc=
X-Google-Smtp-Source: ABdhPJwWb2/2tAFGBPQDvmIyve1DenShdONzm8UbH4/S0ZKCGvCJCIn1IcCkOzbUiIR9h213ZWa60Q==
X-Received: by 2002:a62:fc45:0:b029:1ed:bdd2:a07d with SMTP id e66-20020a62fc450000b02901edbdd2a07dmr2487396pfh.0.1614014802554;
        Mon, 22 Feb 2021 09:26:42 -0800 (PST)
Received: from localhost.localdomain ([122.161.0.245])
        by smtp.gmail.com with ESMTPSA id x80sm4737437pfc.71.2021.02.22.09.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 09:26:42 -0800 (PST)
From:   Shourya Shukla <periperidip@gmail.com>
To:     periperidip@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        levraiphilippeblain@gmail.com
Subject: [PATCH v2 0/1] rm: stage submodule removal from '.gitmodules'
Date:   Mon, 22 Feb 2021 22:56:22 +0530
Message-Id: <20210222172623.69313-1-periperidip@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218184931.83613-1-periperidip@gmail.com>
References: <20210218184931.83613-1-periperidip@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

This is the v2 of the patch with the same title. After suggestions from
Phillipe and Junio, I have improved the commit messages, squashed the
two commits and did the following:

	1. Change the definition and declaration of
	   'remove_path_from_gitmodules()' to account in for the
	   'index_only' variable denoting the presence of '--cached'
	   option in the 'git rm' command. In case of the variable being
	   1, remove the submodule entry from the index copy of the
	   '.gitmodules' else do the same for the working tree copy.

	2. Remove the 'gitmodules_modified' variable and instead call
	   'stage_updated_gitmodules()' just after the
	   'remove_path_from_gitmodules()' call.

	3. Account for the above changes in 't3600' and make changes in
	   the same.

I am facing some problem with point (2) in the sense that what Junio
suggested in his mail:
https://lore.kernel.org/git/xmqqblchdoej.fsf@gitster.g/

-----8<-----
 - Since the previous point will maintain the correct contents in
   the index in all cases, get rid of gitmodules_modified and calls
   to stage_updated_gitmodules().  The call to write_locked_index()
   at the end will take care of the actual writing out of the index.
----->8-----

I am not able to get rid of the 'stage_updated_gitmodules()' call
without failing tests in t3600 (t3600.4 is the first one to fail). What
am I doing wrong here?

Comments and reviews are appreciated. Thank you Phillipe and Junio for
the constructive feedback on the v1!

Regards,
Shourya Shukla

Shourya Shukla (1):
  rm: stage submodule removal from '.gitmodules' when using '--cached'

 builtin/rm.c  | 42 +++++++++++++++++++++---------------------
 submodule.c   |  5 +++--
 submodule.h   |  2 +-
 t/t3600-rm.sh |  6 ++----
 4 files changed, 27 insertions(+), 28 deletions(-)

-- 
2.25.1

