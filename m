Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E62C433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 05:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbiGTF2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 01:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiGTF17 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 01:27:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDE266ADC
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 22:27:56 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b26so24529063wrc.2
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 22:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ato9JpmiTnwcVJXN1EZ0x/RdzUIYasOKA2RO0HN1yGk=;
        b=Cmt5z7EhV0sQ+eFi4O5/51SraJteSvngoLgE7bnA10PGZ+sfPEAl6HuwKEQ6JwNdOu
         rzCHcxXTb82Ibp7ULo57+O/oPKVUr1Vw/M2iSLdubEX8qhwneKxhV2HDiruoV7H72hRF
         s0esVYVFczRqFoKbReQUWcgKncT5FTodp12TWo3CB5Qzsgb8XAum5ukqA9eOhYeEkSGQ
         JajZYXMOeXV/DVzc261bjNkvH/NBotnxwiQ/77g6MnzWbpozPM+Am0dR7VH5Q3lj1MMx
         0QTTGcsMZGznYlAa7Nb5IIeaNJIP8BA/DCBoGO2Ls39okn5EOKNfMVZRi4A5wAXrmVIz
         rQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ato9JpmiTnwcVJXN1EZ0x/RdzUIYasOKA2RO0HN1yGk=;
        b=ReBwl1bmuZL4n7c7bDNO6TU0UQFBOWr6QNJVFpZVp7k1GGu/Oiy7p5hghe2tbRyutS
         oWeBIbxizhWpSjzjUv6shXNdhmbz/Pa2LfGnQV5cJlnffrI95upAwuTNpXyqEghigSqO
         WP4HD9wCrTkhCsNroqyiwPYgMOsWR7ZlPGhOMRgJGD+HHvx8i6q+7nCUxeYBzq6gr8zV
         bUX5M+4C/ue5Apl5JpoCwfr631uIgN/G4pciDPHuGKPwNuo3Ajm7S9mPdOOad1tLA0DJ
         VBEF+G5sqknsylaMoWlSXELQju0GY+Gtq3Xqax+E7rI6oCSpGpJ+0CyHpoDbDaSeMssn
         BCmQ==
X-Gm-Message-State: AJIora9yiP6uw+vW0Lli0Ooh0Qbu/L/g4QOnOI9AiNPmKQ3EXf99qGKi
        W/7oALEwXVU5y4vk88MJZ15IhL4qp2I=
X-Google-Smtp-Source: AGRyM1tUcEa0XZyjJU5PCN+YiSWTF+WkwGh7XJfRj95/HaUcGuC17OIeWtxoTlZIql2teJTFC26uuw==
X-Received: by 2002:a5d:45c5:0:b0:21d:978e:f93 with SMTP id b5-20020a5d45c5000000b0021d978e0f93mr29680910wrs.134.1658294875158;
        Tue, 19 Jul 2022 22:27:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bp7-20020a5d5a87000000b0021d80f53324sm15203956wrb.7.2022.07.19.22.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 22:27:54 -0700 (PDT)
Message-Id: <pull.1294.git.git.1658294873702.gitgitgadget@gmail.com>
From:   "Moritz Baumann via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jul 2022 05:27:53 +0000
Subject: [PATCH] git-p4: fix crlf handling for utf16 files on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>,
        Moritz Baumann <moritz.baumann@sap.com>,
        Moritz Baumann <moritz.baumann@sap.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Moritz Baumann <moritz.baumann@sap.com>

Signed-off-by: Moritz Baumann <moritz.baumann@sap.com>
---
    git-p4: fix crlf handling for utf16 files on Windows
    
    Signed-off-by: Moritz Baumann moritz.baumann@sap.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1294%2Fmbs-c%2Ffix-crlf-conversion-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1294/mbs-c/fix-crlf-conversion-v1
Pull-Request: https://github.com/git/git/pull/1294

 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 8fbf6eb1fe3..0a9d7e2ed7c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3148,7 +3148,7 @@ class P4Sync(Command, P4UserMap):
                     raise e
             else:
                 if p4_version_string().find('/NT') >= 0:
-                    text = text.replace(b'\r\n', b'\n')
+                    text = text.replace(b'\x0d\x00\x0a\x00', b'\x0a\x00')
                 contents = [text]
 
         if type_base == "apple":

base-commit: bbea4dcf42b28eb7ce64a6306cdde875ae5d09ca
-- 
gitgitgadget
