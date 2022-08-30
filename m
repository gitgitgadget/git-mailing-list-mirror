Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1809BECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiH3JfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiH3JeE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:34:04 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1BAE3940
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:55 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 92-20020a9d0be5000000b0063946111607so7658090oth.10
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=h0o2dfYhUCQdsu9/5qAPOewvAtrTC1t2Eyd4ohoXrGA=;
        b=Cwmld5ObIomsE0MY75hauAh3O+u6UtbuY853wv6qoZd2fpjS53NyQeV/20ltOBIs8F
         WiKfWx7S3XIHJXuUDh8C22d2IKgH9hpqTPm3MBzjBhsNJ86yjb7U30k/HnmieP5jNc8I
         pvcyftt09St+/Nu6BMHWuKVXUNQvYUx6+uikA8JXkWgansnV9nBUKDrN+BLzNjFzpJ0O
         LpK9Zg+SmidytuVgdF28r1FczUJlSXRgzEJZd07mi/chG+NSCP50Aln4dqV8kb7fAuDq
         yIrKxqrket2nXy5wIJBQtkaaQM1rKNb0zj5qQnRb4lWrgt5EFEnPI1mOMIgyY0qQOubl
         8w8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=h0o2dfYhUCQdsu9/5qAPOewvAtrTC1t2Eyd4ohoXrGA=;
        b=16cWDxL9EkIfoAsP7O7/3t2nU8ADuoBiZgPPVhhsnewjACevvUAZaf6FIJ/VuHt7A7
         i5mvMAW/FtxgOwcRAxlexjg+Vcy/kAtog9ckJT4I00JWhQT24BxWP8gJxYrQtixS8GRG
         YWl9AP2PkU/Aeu8TqtH2x1hzsTEjoVN1mCVrJb4bhMqW6N6326TiO3fxRecc1I46h4Bt
         OtL73NzSR2k5Th2RHWQ5nMlqhShsSClIHByPZKu159kvCfb2eXvhnaehKtyOWZ5tZeoZ
         QI3c2q0X9jZZWbPc2qHX86XTVY1qEU8WJMhPD2gJg3l5EDAWkCGGsLSQsN9WzxMe9EOB
         RniQ==
X-Gm-Message-State: ACgBeo3rpLZRCCIOosQOJK0MhSdkGdLd5XzN7miLYu5FT6pilOyf47hJ
        yTTiZvU/w+iZyk1nF3w/l+VGgRmToHA=
X-Google-Smtp-Source: AA6agR4XNvUmVXPHvRy/pNoHFUVxRaXrByhkUonMxxjcFe30cmRKuMp8rHDbVsphi6yiJfOrbbqpKQ==
X-Received: by 2002:a9d:7a8d:0:b0:636:eb5c:df96 with SMTP id l13-20020a9d7a8d000000b00636eb5cdf96mr8016986otn.173.1661851970270;
        Tue, 30 Aug 2022 02:32:50 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id s19-20020a056870e6d300b0011dca1bd2cdsm7540459oak.0.2022.08.30.02.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:49 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 41/51] completion: zsh: fix direct quoting
Date:   Tue, 30 Aug 2022 04:31:28 -0500
Message-Id: <20220830093138.1581538-42-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apparently using "compadd -Q" is almost always wrong, we want zsh to add
quoting when necessary. However, if we remove the -Q option, that would
make zsh add an extra "\ " at the end of some completions.

We can manually remove the spaces from the completions that have them,
and then add the suffix with the -S option, thus there's no more need
for the -Q option.

This makes completions like "stash@{0}" complete correctly:

  git stash show <tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 645b4bac31..27ca6efe89 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -55,7 +55,7 @@ __gitcomp ()
 	emulate -L zsh
 
 	local IFS=$' \t\n'
-	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+	compadd -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
 }
 
 __gitcomp_opts ()
@@ -85,14 +85,17 @@ __gitcomp_opts ()
 		fi
 		array+=("$c$sfx")
 	done
-	compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
+	compadd -S '' -p "${2-}" -a -- array && _ret=0
 }
 
 __gitcomp_nl ()
 {
 	emulate -L zsh
 
-	compadd -Q -S "${4- }" -p "${2-}" -- ${(f)1} && _ret=0
+	# words that don't end up in space
+	compadd -p "${2-}" -S "${4- }" -q -- ${${(f)1}:#*\ } && _ret=0
+	# words that end in space
+	compadd -p "${2-}" -S " ${4- }" -q -- ${${(M)${(f)1}:#*\ }% } && _ret=0
 }
 
 __gitcomp_file ()
-- 
2.37.2.351.g9bf691b78c.dirty

