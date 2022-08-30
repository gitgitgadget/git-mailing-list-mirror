Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CCFECAAD4
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiH3Jc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiH3JcK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:10 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF26A2AA1
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:31:54 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11edd61a9edso9320356fac.5
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=qtmTPmGqyXKWpAUmv4NjuF3YtIG+Z0tJK74Y+XaK6Hw=;
        b=GlakI9oK92jW3NT+zMQTBEq7UcpAtpSMfRcPQAw/Dm9lKFNHGpsgguJkKQViuoqknt
         6KGmmPn6YMyOfq4Wi8rlLHgJD66Bz38JlE5+oeEtmIMZ9jcvrEf85bIk/B8zjoVNEJnF
         TLyQRnFR9qWj0TUYfYQyUBYkmNXqV/Z+j4MbpogTKwTvARnLnsihSY+8KyFwpqigfl/D
         QW3RRNRP+52Lu7oAECd/s0Y6bzLTVvQ6CIeksy5p2Z3Oc3hxyE791BSpDRbOimgQEyZE
         Cxeuj10ufZru7PZqrPA5BNKWoK5y5olbkeOkzbf+aTLqNjgwUiHH3WBjtdpNsLr2Ge8M
         7sCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=qtmTPmGqyXKWpAUmv4NjuF3YtIG+Z0tJK74Y+XaK6Hw=;
        b=PKzzcdrb/1nnn7AUPaHPCaN8EW/bmoLnWwJOwNPNoEVFJrsQFMAAlyT2he8jJRPUIW
         +qkQjAieHArLcH7M2xPbobz5xBRyS/bbvW3b52LbmxqpeQOlhMaGiBme9xtYymeWYGuf
         0VKyK1tbwGxmKbUlX9sZq0c30k0SKwFKJ5MVB47fcY+yWFl5uc/QcZHY86Whr9/qnoXm
         Pg/NMc1R1y4thyQO3fGfDY8G3OaeSUJ6rwK7E5L46mza0Epm1ccbXO7brPG2aZlg5SzS
         lZdcTR38OsC3Fif/CHVBIY38RlSUxcDh+XHwmELaPAY7rw6vE58eUEKD83f9b1YeBuAi
         N4/Q==
X-Gm-Message-State: ACgBeo1VowKnY21ZdzHVqYYpvndnhuoLwj0UkD3OaZvcgxIYaOkd9Dc5
        Azay0yfeuBwHIcZ1FxbmHYieuZDAcWA=
X-Google-Smtp-Source: AA6agR7TGKiOFjTWMVK+1eXVU/eEIJGZ9mvxzOTcr7t1pXykiIF4yPyVecAIPSq4OwCQkZszYqFtdw==
X-Received: by 2002:a05:6808:16a1:b0:345:ca3c:318e with SMTP id bb33-20020a05680816a100b00345ca3c318emr7153406oib.2.1661851913867;
        Tue, 30 Aug 2022 02:31:53 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id k4-20020a056870958400b000fb2aa6eef2sm7485611oao.32.2022.08.30.02.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:31:53 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 08/51] test: reset environment variables
Date:   Tue, 30 Aug 2022 04:30:55 -0500
Message-Id: <20220830093138.1581538-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These should not affect the tests.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9903-bash-prompt.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 6a30f5719c..c94c351e23 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -18,6 +18,14 @@ c_green='\\[\\e[32m\\]'
 c_lblue='\\[\\e[1;34m\\]'
 c_clear='\\[\\e[0m\\]'
 
+unset GIT_PS1_SHOWDIRTYSTATE
+unset GIT_PS1_SHOWSTASHSTATE
+unset GIT_PS1_SHOWUNTRACKEDFILES
+unset GIT_PS1_COMPRESSSPARSESTATE
+unset GIT_PS1_SHOWUPSTREAM
+unset GIT_PS1_STATESEPARATOR
+unset GIT_PS1_SHOWCOLORHINTS
+
 test_expect_success 'setup for prompt tests' '
 	git init otherrepo &&
 	echo 1 >file &&
-- 
2.37.2.351.g9bf691b78c.dirty

