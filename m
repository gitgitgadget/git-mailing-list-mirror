Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D399ECAAD4
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiH3Jdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiH3Jch (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:37 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4807E9F768
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:28 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11f11d932a8so6968929fac.3
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=E16kH/87tdgBU8pb58q+jzlJaHKzU5A9XRzYyEfic90=;
        b=ac367KDHby3tRahcOsy0JRv+HloG9+e6QZKe5TJ+MxdYxUIV/BdaUQf8xWG0S5LTvK
         SmTzwO2uce0WMlvXdbBL+EsEY/qsaegLx3wxnUjPbc8/7LXoN8r+9sTUzfKY9FWoPrdc
         E3GdoSbUktUACgFRl7RCrCEekO8MRZCA4Yqv2mc/Lc7w6s9cLf23BewEIaTbldUtDQB+
         Xpx0/qZZfHFEqeHpiyxdMAlENxxjLkKH68BbjIr1oOTmU7FeVkSvVwxX0oIdSUiMH/wA
         xsT/kyL1B2FFD0g1y3QDIb76t4eQBwrJJ3xRn1Q987uMZANh+sj4DfMuUrAYNxfu4/Ew
         civg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=E16kH/87tdgBU8pb58q+jzlJaHKzU5A9XRzYyEfic90=;
        b=uyYSjmQclHXI5f74dRhOj3pCwrVp3bMP5eHpPOUWKz23+anaw6GMzjb7lW9m/LF075
         iSB9VZPNx1J7vxsWMctf7Ard/0aXD+hFGrbLp4QqJYGVmjBkw8E38s/pqQH5peBT8SDX
         +Be/vMKK9SDMWC55rK6/qZA+J/woJI0u4KQ5yfV6oytEUlDLBkjiVww8iDv8QXh0Pgnl
         qAJNIfX7gvKG3KFLXDfkKeSrj5QaNU6iDOryR41SzrG4mbPD1h3xpebZN/H+tl+ndyO/
         mrNnTMuEhaEg5CfC1WZjxMthwe1Go8I5rYdFFDJ3O7gEqmRxbD2qUDoOZLmGY45DT3Ke
         kzdw==
X-Gm-Message-State: ACgBeo2el2LV8ifJI8JOSsie7WYtBUHJ/+3YPkzYpCuYCemjyqwukPT+
        uJcpJqI7XMTcvaPUrBIWVkeCgCgES6c=
X-Google-Smtp-Source: AA6agR60RNv0/I1cw4P8E7zEb8aHaly+5w0CvvPzFgJlgMVCkFg8VmVkh05R7c+lRfdJhXcYI1eBVA==
X-Received: by 2002:a05:6808:1381:b0:344:d4b5:9a30 with SMTP id c1-20020a056808138100b00344d4b59a30mr8919005oiw.223.1661851947453;
        Tue, 30 Aug 2022 02:32:27 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id k23-20020a9d7dd7000000b00636d6571ff7sm7019231otn.70.2022.08.30.02.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:26 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 28/51] completion: simplify equal suffix check
Date:   Tue, 30 Aug 2022 04:31:15 -0500
Message-Id: <20220830093138.1581538-29-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We know the prefix is already '--no-', there's no need to check for the
first '--'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 contrib/completion/git-completion.zsh  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 86c335cfce..2a5e32e457 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -349,7 +349,7 @@ __gitcomp ()
 			c="$c${4-}"
 			if [[ $c == "$cur_"* ]]; then
 				case $c in
-				--*=|*.) ;;
+				*=|*.) ;;
 				*) c="$c " ;;
 				esac
 				COMPREPLY[i++]="${2-}$c"
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 808cf87f84..a8ff9c089a 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -68,7 +68,7 @@ __gitcomp ()
 			fi
 			c="$c${4-}"
 			case $c in
-			--*=|*.) ;;
+			*=|*.) ;;
 			*) c="$c " ;;
 			esac
 			array+=("$c")
-- 
2.37.2.351.g9bf691b78c.dirty

