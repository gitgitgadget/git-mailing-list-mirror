Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF20FECAAD4
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiH3Jcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiH3Jc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:28 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B37A1A61
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:12 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11edd61a9edso9321799fac.5
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=G9nlGz7A7j2RJ5umqF/L4Fw9IL4RiOh2I0NPMQFzOTI=;
        b=EE3ohUCJ+TfjmrCHvdzBSa/JGKXMAaPspr/ljpPoBdonW17PFAPWlSCkgDc29X+2d/
         Mf2UdQK/TcMZ8aTrEnSeCh+syPkhxY6tWIZMxdROtLqaosKnkhe3QEOQE/A37wuooCgy
         Ls3vM/cp3gal9deydHzqtnVi65YTWzNcQ5fGb/9VRhv4dnJ0TALzRq5FouNsJzM7eEgT
         VKCVfBBNGfuhngMsjqPSpLkMX9zmo7MWAwr9l7e/pnsGVc+/+3/hDT25+bjc2jydLJ7s
         emPUKisI/kVvg5aBxPoCj8WOwqZaHlvVfLdvZnJgp6hLfPfLAbtFlH/N7Xrii9SrQaEL
         l4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=G9nlGz7A7j2RJ5umqF/L4Fw9IL4RiOh2I0NPMQFzOTI=;
        b=kRoElV/OSPNIhWaXFwwFKJGJ4hQM8V7PNGkuEisXyGnxk5EtnLSvohHfOvQTNR6Mo1
         wpDLAZRgSF4UJOeG28ya4A8lB5dB3qeeK7PnVkbjiKtcUIPbCabgd1IHtXJMkT+kI3ZD
         6REhBddmUZAuMeL+7pFBujsHcYEX5wdRq1kM3yGpND+1X+6NFoTReAWND+H/25hT2Non
         6LQywcUtXQ0X898mTm3sLy2847pAYs82ydl1SI8WHwtr85G8w8G7tJg+8XhQvJaS3too
         1lnlTtSfpKiy6vc6EVysIc4nesh7K3DPAtjaUz55N2/4RknaRfFBo18QuYKJhurQfFtW
         lBow==
X-Gm-Message-State: ACgBeo3R735w+Sho4wrW5OEfe4rK2XiUf1rdWhtRJDY6OSrwgDLrYqBf
        wrKuONeg8O/Buf/fkBP/LwFwSnfp0CM=
X-Google-Smtp-Source: AA6agR74VXymCRnpkwry9qqFPpHWfSAurm3UzO3lKou+zZaaL0QbsLSQmRH7275QpEptJQUUIkA5SQ==
X-Received: by 2002:a05:6870:5705:b0:11e:553:1a6f with SMTP id k5-20020a056870570500b0011e05531a6fmr9445972oap.97.1661851931546;
        Tue, 30 Aug 2022 02:32:11 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id c5-20020a9d4805000000b0061c3753c30dsm7041791otf.17.2022.08.30.02.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:11 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 19/51] completion: zsh: fix options with arguments
Date:   Tue, 30 Aug 2022 04:31:06 -0500
Message-Id: <20220830093138.1581538-20-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They support both '--git-dir=value' and '--git-dir value'. Fix the
arguments to support both.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 35300a08cd..10ad15face 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -215,15 +215,15 @@ __git_zsh_main ()
 	_arguments -C \
 		'(-p --paginate --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
 		'(-p --paginate)--no-pager[do not pipe git output into a pager]' \
-		'--git-dir=-[set the path to the repository]: :_directories' \
+		'--git-dir=[set the path to the repository]: :_directories' \
 		'--bare[treat the repository as a bare repository]' \
 		'(- :)--version[prints the git suite version]' \
-		'--exec-path=-[path to where your core git programs are installed]:: :_directories' \
+		'--exec-path=[path to where your core git programs are installed]:: :_directories' \
 		'--html-path[print the path where git''s HTML documentation is installed]' \
 		'--info-path[print the path where the Info files are installed]' \
 		'--man-path[print the manpath (see `man(1)`) for the man pages]' \
-		'--work-tree=-[set the path to the working tree]: :_directories' \
-		'--namespace=-[set the git namespace]' \
+		'--work-tree=[set the path to the working tree]: :_directories' \
+		'--namespace=[set the git namespace]:' \
 		'--no-replace-objects[do not use replacement refs to replace git objects]' \
 		'(- :)--help[prints the synopsis and a list of the most commonly used commands]: :->arg' \
 		'(-): :->command' \
-- 
2.37.2.351.g9bf691b78c.dirty

