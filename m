Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED8BC6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjDAIsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjDAIrc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:32 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7B5F74C
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:03 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-177b78067ffso25638157fac.7
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwSB1xBD/+SYbKX15/UH6WwLA+mR6uX0LqTI2v5JKmo=;
        b=ZDOllOhusZ9gCKAWWPpfW5VlIKfvydCT3osHKfnnwHG42022lDSvgafG4idzNdrsRu
         2ySeQ612R6pr1Paru3wlsDnuyXY83yCAWa3Nql8BsjprhiKZIZxZyb/YCdhp1qO3iNJP
         ca1pRNBq/UM/6Wp90EQWATSS7T8b7PcuedEmmvzec1tlccpFh5VEViUzttq/Gm+7kCn/
         wQVeKtL3H1TMpJ+dt+OqFLTd3lJHczzQA3eOTpsEuVFoGzMIlbPrXnPFDNVT0XBzhUb3
         5pSOkqhO9iI40hwm3+m+ouiuXyGtdVnzT0AFtxNFru2uY2ca/I1MY2cpWlfiR1P0OhvZ
         ETGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwSB1xBD/+SYbKX15/UH6WwLA+mR6uX0LqTI2v5JKmo=;
        b=qdRMbBrmuQyBn3+4xn4k/48q0v+U6W1DXvlKKk/5CGhbJtSM2/LAbdVa6shWKRFUdn
         e2peUxaOmondd1BV9FUPI9C5gAfEFrWgBNtqSTz9aJCZc280iSbnwsa6twU9fMmw2LHQ
         ZdQIokrZOHAPeIeyvl+sz3vhTqBgDLHvNy/wKAE+f6MClwoyrYZ/vN04KFeq/rroKwl6
         18CaY/eCPFmEGv/903nWrFt6YT4UdA0Pzm9IF1X0vYLLwS8Mc6zv6HZSg9F4AAI6V77f
         ULkTT38629CHhxk/OKNduWo1KwjNhC6vJmhFGsZiq3lzVsaHPai90s2q9cF/V1gpr8b4
         MqbQ==
X-Gm-Message-State: AAQBX9eJUuRBAvq2nzGi8CDc6nnqcyXXTnInApoDnfPBCkvhNmSMmW3V
        kAz50WIrY1RP5tzq1YvzkjnXXOKPslo=
X-Google-Smtp-Source: AK7set+NBzBuq44EuIpKnv8htdwW3TzhxjccMIEA2+kj78m/8vtnfREPkGmCgy+1yWZXGV4JdJubdA==
X-Received: by 2002:a05:6870:580e:b0:177:9b40:97b6 with SMTP id r14-20020a056870580e00b001779b4097b6mr17178811oap.24.1680338822456;
        Sat, 01 Apr 2023 01:47:02 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id j19-20020a9d7f13000000b006a13dd5c8a2sm2095107otq.5.2023.04.01.01.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:02 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 25/49] completion: zsh: add excluded options
Date:   Sat,  1 Apr 2023 02:46:02 -0600
Message-Id: <20230401084626.304356-26-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add more excluded options, for example: --bare excludes --git-dir.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 17 +++++++++--------
 t/t9904-completion-zsh.sh             |  2 +-
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 038ab30869..0c8fdb584f 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -212,15 +212,16 @@ __git_zsh_main ()
 	local -a __git_C_args
 
 	_arguments -C \
-		'(-p --paginate --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
-		'(-p --paginate)--no-pager[do not pipe git output into a pager]' \
-		'--git-dir=[set the path to the repository]: :_directories' \
-		'--bare[treat the repository as a bare repository]' \
+		'(-p --paginate -P --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
+		'(-p --paginate -P --no-pager)'{-P,--no-pager}'[do not pipe git output into a pager]' \
+		'(--bare)--git-dir=[set the path to the repository]: :_directories' \
+		'(--git-dir)--bare[treat the repository as a bare repository]' \
 		'(- :)--version[prints the git suite version]' \
-		'--exec-path=[path to where your core git programs are installed]:: :_directories' \
-		'--html-path[print the path where git''s HTML documentation is installed]' \
-		'--info-path[print the path where the Info files are installed]' \
-		'--man-path[print the manpath (see `man(1)`) for the man pages]' \
+		'--exec-path=[path to where your core git programs are installed]: :_directories' \
+		'(- :)--exec-path[print the path where your core git programs are installed]' \
+		'(- :)--html-path[print the path where git''s HTML documentation is installed]' \
+		'(- :)--info-path[print the path where the Info files are installed]' \
+		'(- :)--man-path[print the manpath (see `man(1)`) for the man pages]' \
 		'--work-tree=[set the path to the working tree]: :_directories' \
 		'--namespace=[set the git namespace]:' \
 		'--no-replace-objects[do not use replacement refs to replace git objects]' \
diff --git a/t/t9904-completion-zsh.sh b/t/t9904-completion-zsh.sh
index 4355552434..c0be5573ee 100755
--- a/t/t9904-completion-zsh.sh
+++ b/t/t9904-completion-zsh.sh
@@ -821,7 +821,7 @@ test_expect_success 'general options' '
 	test_completion "git --no-r" "--no-replace-objects"
 '
 
-test_expect_failure 'general options plus command' '
+test_expect_success 'general options plus command' '
 	test_completion "git --version check" "" &&
 	test_completion "git --paginate check" "checkout" &&
 	test_completion "git --git-dir=foo check" "checkout" &&
-- 
2.33.0

