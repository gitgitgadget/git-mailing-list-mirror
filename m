Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F8261F453
	for <e@80x24.org>; Sun, 21 Oct 2018 08:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbeJUQvT (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 12:51:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36569 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbeJUQvT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 12:51:19 -0400
Received: by mail-lj1-f196.google.com with SMTP id p89-v6so34274770ljb.3
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 01:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hkp183dhYDDqAJa7O0zWZ/zMwg2aTHpxW/+1lZAMdxI=;
        b=bjT8rI6T52So81ERIaGKDno4rCUA/Od0S43KBvlIZ0tqBzDelx/Qo4J+HG38/i0IuP
         jVQlxArudJ291qEINP3Epdi85mBMH/Yc+DoDTYQ62eISE/HQr14FXQE2HiMQctcDmA5f
         CvIvMN+2GHTX/QnFySf9xIWVeqo/J7PSbh3Yql4DYNBUPUMMeYqDZYidl34KrlXhqxqO
         0a+I1l+ipOxXdXPwuUM7LrAd4Wfevz1K50rc3s/onoi249cJwXezMni+mUYFjfLFb9Hc
         lYBz9DsSBV71SAZWxASDzF3G2c+ySp4DvVbkoEmgvZIzSzlZW81FwBhk3NpKk8aOYotM
         kt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hkp183dhYDDqAJa7O0zWZ/zMwg2aTHpxW/+1lZAMdxI=;
        b=tsYyxpGkxo38kNwdXGc4OQ2OR+USbRljxiBTZ79nbGZ389rCCnz18em+5MZL58hxaU
         AGgC84F5q5Vg2CNm/xq+Cri3FYjeJjdVcn48Lk06U6dtTOvapZEcYspSI/oZzPv2cLFt
         vzhbf1QsdYcKpXL5ADJfbCk0ZVOIrMXXE7qXJ7xC6MVBegRrF0q8h5mLDYdscCVrGT93
         MWh7E9LYDvZW2YAZJH7CkJJuiRtSD/nXbGMPG2LWAZVOmQruFe0vVQHu8xhtbErjBqAE
         M8/NiWGfAfZUXngGgmWXKMtTgBxV2X7uz1Ov8SO/UdgkH6EC2p3a8pTGACtdaRET5GEx
         DR6Q==
X-Gm-Message-State: ABuFfohhcS8f3icwnEpBWk63Cu9c9hBoM6cUprN8z47203bZMmW5x3fA
        Z6RKUPq46R4Je1oJiXBRH5ra2gBv
X-Google-Smtp-Source: ACcGV61vJwoekdKwKmndO1x0b4cdAbLNvwe8paRwE+gt7mhdV00tjoasaY2pqitJb7zcB78G97U0/g==
X-Received: by 2002:a2e:7e07:: with SMTP id z7-v6mr8343178ljc.84.1540111063181;
        Sun, 21 Oct 2018 01:37:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id q13-v6sm6273930ljj.72.2018.10.21.01.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 01:37:42 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] completion: fix __gitcomp_builtin no longer consider extra options
Date:   Sun, 21 Oct 2018 10:37:31 +0200
Message-Id: <20181021083731.8009-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

__gitcomp_builtin() has the main completion list provided by

    git xxx --git-completion-helper

but the caller can also add extra options that is not provided by
--git-completion-helper. The only call site that does this is "git
difftool" completion.

This support is broken by b221b5ab9b (completion: collapse extra
--no-.. options - 2018-06-06), which adds a special value "--" to mark
that the rest of the options can be hidden by default. The commit
forgets the fact that extra options are appended after
"$(git xxx --git-completion-helper)", i.e. after this "--", and will
be incorrectly hidden as well.

Prepend the extra options before "$(git xxx --git-completion-helper)"
to avoid this.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index db7fd87b6b..c8fdcf8644 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -400,7 +400,7 @@ __gitcomp_builtin ()
 	if [ -z "$options" ]; then
 		# leading and trailing spaces are significant to make
 		# option removal work correctly.
-		options=" $(__git ${cmd/_/ } --git-completion-helper) $incl "
+		options=" $incl $(__git ${cmd/_/ } --git-completion-helper) "
 		for i in $excl; do
 			options="${options/ $i / }"
 		done
-- 
2.19.1.647.g708186aaf9

