Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2878C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjDAItD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjDAIr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:56 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5B12369A
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:14 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-177b78067ffso25638443fac.7
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJDprGFN/4Jgr5Wmnt4L/FLmivfW1CJhGkGffWQBysk=;
        b=MenNraJ8En5XuXgxjd63RpSZfvez/ik37BvWRpu/z/Qa9BcdxGHVS6IiOMKIQG8GL6
         5RZyj9BAvRNu5ojlrv11wC6BnChkX/xST51khlTP/mWMmFZAZWUomx3DYZlKUdad7XZU
         fJ9fyQ0G2bCNtO4hR7aYy9ye7lkxNUYGtZms78WVPUF/1HMXG0G/3AbCiE2+r77CRg3g
         D2Ia5btgehy8S3NSkN9E9Ugv1aE+2FFvQ/JyXhR9ngWAqT+xzKS0mnmmhZJ86XUAlrMy
         TpbufE0eaonmiZVPvMlRckqW2NcYa0lCd2IEN5IvWDz+juGIya+5ntYqDODGccUvxvnq
         rf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJDprGFN/4Jgr5Wmnt4L/FLmivfW1CJhGkGffWQBysk=;
        b=U+YKCx46DjwF4takGshNjavO2fo8ApOcxv6vEYDC/oEfcSvoZilJQoFZi5zrwqUQF+
         Qw4XvFRNVDgjGmIqIneHZfPa2PwA+FZfspt2OEh22vZNhJ1cpiapIngxzmdsKeuVHhg2
         4GHp9scTFvnG7WfQPB7A27kGJqU0PLbZuS2m9L8W+17kg1XD0QbIwRr/ye+nI+K8eX8+
         78HJRl4j1ncrzsUPm80YXA+3apIklfMrwjn/9EFZ06Rex8BeI/cb8cS3OJ6/Mgx8p5kJ
         YFWTsiRODINQmgvg+UOJUDxDsh6j5q8q+77kFyQ++Bm6MIICVElzGLBc/m0k1TxuUPkl
         Rjpg==
X-Gm-Message-State: AAQBX9fbJZVP9fVYVlmWOhkSywMps0KwTKb+vLz1gZtr8UUlrh+NlJK8
        dkOJBslNWDsRSy1XeikFhNw7YZPyHoc=
X-Google-Smtp-Source: AKy350Zhh1UM4qaGEGKCuVJ/ARuDcN/K72ST8jdz+0Ajezq6AYKbqEUwCPxrxMZtcNrukTa6dShMtw==
X-Received: by 2002:a05:6870:d212:b0:172:a59c:7fcd with SMTP id g18-20020a056870d21200b00172a59c7fcdmr16981393oac.31.1680338834320;
        Sat, 01 Apr 2023 01:47:14 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id bf10-20020a0568700a0a00b0017264f96879sm1726015oac.17.2023.04.01.01.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:13 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 34/49] completion: bash: simplify config_variable_name
Date:   Sat,  1 Apr 2023 02:46:11 -0600
Message-Id: <20230401084626.304356-35-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now sfx is never null.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index eb7be6aa6c..2974604e99 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2631,7 +2631,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	guitool.*.*)
@@ -2665,7 +2665,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__git_compute_all_commands
-		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	remote.*.*)
@@ -2681,7 +2681,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	url.*.*)
-- 
2.33.0

