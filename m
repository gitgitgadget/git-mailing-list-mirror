Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0DCC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiCUXWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiCUXV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:21:58 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6402A37490D
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:14:09 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r64so9415219wmr.4
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZsgTYiiyI1UuwLV+Sl9E4OerIW9rlcp/Vf3NQEYip/s=;
        b=X6PGHeOQBuXD78BUaXVAkp1E4bg/XEyWtohb1WEFzvIsIU8DzSIuSJ+mVFU1ChbjMc
         GMUooPud0Rc+FCIdkzfJt9njpAH7acHyPtLLcHWKB9A1yWHO83jK7Tl3Hr44BUUf695s
         hk1nLxmv7hW87saWufoarC8GA64vACJ4LzIv8t3waxYdWfU7OdKQUjJOi0PDZ8HBMEkW
         vub9kh06G6B1jY//3NrdT1xFQW4+AwEAQ0gqddniEeKa5/F3XnWY6/CqOe/SckCU5Hwj
         yeS4yP9fHXuleEjcpgKLo8MIBKLvu6plGhu8cinOo9MoJtTuHSIMkpuXi8p2g+Jd+gMR
         cJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZsgTYiiyI1UuwLV+Sl9E4OerIW9rlcp/Vf3NQEYip/s=;
        b=FDmxFrbpPwFTWL5nHc2R5XukU7WLK6LYM2NoG/VaflkYTT/MaPOUJLRtqVB7pm6iKQ
         gaqG7eU223ZZlgwh8A8kwyONp8jso0scPHMas3vfmeEGNCwxHMXgJt49gGuLx7eCICWO
         KE7QQwMaTW8y/ZcbZGRU0LfTcnGyOJnKP32hRQ4oj+WRbbzUZ9DBE7d38jNS9n/0WCFk
         6ZDnSMsar8j4QBh7d17A62uzQ6oN4Wb2h8otwBSzXHEmvl2FNsLiFmdo75+rsUMIp5Af
         OPx0HEAIBSu40ZeatEnfY/K/2n8+5tHt2Q2G3bNV3oSRCygFcm5lYFMrFgzXzABG7ODI
         T2Mg==
X-Gm-Message-State: AOAM530bD/91vZ/BDtLNqjjN6MJk7906zwY6Sv0L3836aFAiqVdoTHhF
        eiI7131b+fLGsg3jOWqBgwUu+7eeh2I=
X-Google-Smtp-Source: ABdhPJxVtBvydYnhrMMBFsBGnRYh5aYU7knjQGgg9wYmHfzhblQSGMVzYeSLZy4IOiRF8grTKKLMlQ==
X-Received: by 2002:a1c:7518:0:b0:37c:7eb:f255 with SMTP id o24-20020a1c7518000000b0037c07ebf255mr1097093wmc.29.1647903374605;
        Mon, 21 Mar 2022 15:56:14 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:56:14 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 35/41] shell.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:17 +0000
Message-Id: <20220321225523.724509-36-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321225523.724509-1-gitter.spiros@gmail.com>
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C standard specifies two constants, EXIT_SUCCESS and  EXIT_FAILURE, that may
be  passed  to exit() to indicate successful or unsuccessful termination,
respectively. The value of status in exit(status) may be EXIT_SUCCESS,
EXIT_FAILURE, or any other value, though only the least significant 8 bits (that
is, status & 0377) shall be available to a waiting parent proces. So exit(-1)
return 255.

Use the C standard EXIT_SUCCESS and EXIT_FAILURE to indicate the program exit
status instead of "0" or "1", respectively. In <stdlib.h> EXIT_FAILURE has the
value "1": use EXIT_FAILURE even if the program uses exit(-1), ie 255, for
consistency.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 shell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/shell.c b/shell.c
index 811e13b9c9..d2d1718e9c 100644
--- a/shell.c
+++ b/shell.c
@@ -146,7 +146,7 @@ int cmd_main(int argc, const char **argv)
 			    "and have read and execute access.");
 		}
 		run_shell();
-		exit(0);
+		exit(EXIT_SUCCESS);
 	} else if (argc != 3 || strcmp(argv[1], "-c")) {
 		/*
 		 * We do not accept any other modes except "-c" followed by
-- 
2.35.1

