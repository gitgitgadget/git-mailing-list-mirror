Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380AFC433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345956AbiFJCCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242173AbiFJCBx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:01:53 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C4C18360
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:01:52 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k19so34625439wrd.8
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XGNmSpSpfSDkLWTSy2n/vhwP9r9FFd+nv1nUtVBWVLY=;
        b=XKURAhSdIhIo5Pd0o8wQdW4f9/eGWIfn2gRnxpH+TjgcM6OZaYRjUsS9ecaG3wncr2
         +RSAodctTdITziVCkG8mz+qD3Cubub/kNbC4AEjJgQ+7uPldsF/PpiMHHkHw+nJSqnYG
         dVbKUnsRnuBZrh6+kzwWzICP7gY318PluPPygqsrYjJKpEjCOUhTzw6EmxQAJu2bBMRs
         qRcPnEXsoM0c2VQlRzSrM/+L3EChguE9rl7TCaS6cUZ+Rvq3eEFlUY3OeFhW0P47zHQy
         uV25oEWEDOKv64IOeiQam6ujYS3tLhnYq2VDvVStmDT4iXCGIAVqRaeoVpwnozF5A3df
         6K/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XGNmSpSpfSDkLWTSy2n/vhwP9r9FFd+nv1nUtVBWVLY=;
        b=MLgJyb0TBFbUqpSLKlv6dP7FmG3RlorQVimxDj3uZBN1SxwIrCucM2Y7QQLb+q9480
         JCfX2ntlCiFfFTIWZKMua4wRtYeiP8wul5UZXnuAiRcSeK/WRaiAADKoribEh2BDfpuR
         5FoaqttE/tT1HjVhTN9uXvkSqvM8x2KoAZzcO79f4akXPdi6BdoxUPbQUW5zCpsqN8qW
         F2ZeMCj2FPtyxvTDWNdgmobFZA6xj0MXIVGIrqlVQbeGyLIxjRvGFv35E8XrsasJWT/t
         BWjfZqWLJgRdce0xsQITbYDyzVx+q0g/UjPE0aCZVnYENK086oFZmTq4iBUz/sLqRBJG
         NwMg==
X-Gm-Message-State: AOAM5313NEKFzPQL3rZZqH/zSTY0aGXnlwnbODH8ggMZBEyx4PK3qNix
        YNwaUbigEfTbdglffSEBNhOqa0d4m6YStA==
X-Google-Smtp-Source: ABdhPJz7v7EbmrYyGoqir9A0vYe9zIzW97fJkzKjUZeqUKoO3Qnt2QZ7d5GUBEhcbtSfcZoA/3cKGg==
X-Received: by 2002:a05:6000:1847:b0:218:4336:5590 with SMTP id c7-20020a056000184700b0021843365590mr22980120wri.511.1654826511174;
        Thu, 09 Jun 2022 19:01:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b00219e8d28fb1sm122547wrs.57.2022.06.09.19.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:01:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 07/20] git-submodule.sh: create a "case" dispatch statement
Date:   Fri, 10 Jun 2022 04:01:19 +0200
Message-Id: <RFC-patch-07.20-9f5cfbb864a-20220610T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.gb5b1747c546
In-Reply-To: <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com> <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a "case/esac" dispatch statement at the end of git-submodule.sh
and move the contents of the trivial cmd_absorbgitdirs() function to
it.

This template will be expanded on in subsequent commits, but for now
we're moving the trivial "git submodule absorb-git-dirs" to it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 70258eaf38e..fb13f818c63 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -554,11 +554,6 @@ cmd_sync()
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper sync ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
 }
 
-cmd_absorbgitdirs()
-{
-	git submodule--helper absorbgitdirs --prefix "$wt_prefix" "$@"
-}
-
 # This loop parses the command line arguments to find the
 # subcommand name to dispatch.  Parsing of the subcommand specific
 # options are primarily done by the subcommand implementations.
@@ -607,4 +602,11 @@ then
 	usage
 fi
 
-"cmd_$(echo $command | sed -e s/-/_/g)" "$@"
+case "$command" in
+absorbgitdirs)
+	git submodule--helper "$command" --prefix "$wt_prefix" "$@"
+	;;
+*)
+	"cmd_$(echo $command | sed -e s/-/_/g)" "$@"
+	;;
+esac
-- 
2.36.1.1178.gb5b1747c546

