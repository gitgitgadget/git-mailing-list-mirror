Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0A1ECAAD4
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiH3JcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiH3JcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:09 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18F5B274A
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:31:53 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11eb44f520dso11112597fac.10
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2xjN05x539BvqXC8gi6MLSSXHmj/V1TNE8iLh/qHNMA=;
        b=IuEVZ4rZowjL5+9cAbHrku3ct8xDKXh6tjDx/rvz2gdRuP+kzxWXjk14rusIe9WASe
         6lazECdPcXLJBPYAhvsS5lK+ZqSJomE7x63MebM7mrXQOlIRKN7ISlEtnXMT/yy9Fq6+
         qvFD5xLcXclpvPAFvcZ/bLM4HrCfq8weBGEGXYFBfy1Kp+SeUz4EJSbbEVVahiothFda
         W8cMkgezABOXZmEFeO8R3oljwTSDO04dDoIy0dlH3z70WSPeKH3IS8VeS0PXG4RCypY3
         tZ0/fsQO+hRNK/pLSImCr8DgZY0MHlQylfzYieGmZYqFJWWRmqxsYXjQcxMh7bt8qaE4
         XxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2xjN05x539BvqXC8gi6MLSSXHmj/V1TNE8iLh/qHNMA=;
        b=2ARV75aamW2xuB0//jDZWK+QHgM49FpT+E7oMJwlKyV++EUML712piR1uVNgMkjc/2
         sdcYsRl9U8cYoyeNa9ZMLcgIHwdNSPmXm8LQ+faIfXb2NR4thXLbbQZ7cJc7s3DwlH3b
         slp2ocHnTKHfkIlmcmsrar0O8zvMD7fvYSwg/pYnPO93Dw9K5G2pY5HUHEkZOUjLRf2z
         NyuMtkE7I10porXnD+Z5tanCZnuVCTdkshifymcZ2u6OaqQ8SFrzIVr0ygf+EaaYfDCd
         2I6v6fzeBxhQ1/ixyx3iMyPJFBaiAR1dka8J9lfHkNY01O19S9Xf9punyRoaVXpL/MQv
         utQw==
X-Gm-Message-State: ACgBeo0dvAZ3ek3HsjoJ+u1ZU8GMndxQ2ptBJo0kPAvuhPAZoScq/9uR
        mF+i1iWzi2nJicrE/Sc8ZMhOKdIz0Tc=
X-Google-Smtp-Source: AA6agR4M/CKRrs0LchymSgBpp2GH4AgeFDSir+4EzqAbjc0eGjiUPw/wiwMtLNOU2b2MjfJ+0csDuw==
X-Received: by 2002:a05:6870:4256:b0:11f:2202:b292 with SMTP id v22-20020a056870425600b0011f2202b292mr2503215oac.145.1661851912392;
        Tue, 30 Aug 2022 02:31:52 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id h6-20020a4aa746000000b00425806a20f5sm6417563oom.3.2022.08.30.02.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:31:51 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/51] zsh: simplify realpath dirname idiom
Date:   Tue, 30 Aug 2022 04:30:54 -0500
Message-Id: <20220830093138.1581538-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's a much simpler way in zsh.

It's a shame that ${0:A:h} doesn't work probably due to a bug in zsh.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 1a405ba0a2..18ad897568 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -33,7 +33,7 @@ if [ -z "$script" ]; then
 		bash_completion='/usr/share/bash-completion/completions/'
 
 	locations=(
-		"$(dirname $(realpath ${funcsourcetrace[1]%:*}))"/git-completion.bash
+		"${${funcsourcetrace[1]%:*}:A:h}"/git-completion.bash
 		"$HOME/.local/share/bash-completion/completions/git"
 		'/usr/local/share/bash-completion/completions/git'
 		"$bash_completion/git"
-- 
2.37.2.351.g9bf691b78c.dirty

