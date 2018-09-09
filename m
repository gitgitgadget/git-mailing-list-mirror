Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 795B01F404
	for <e@80x24.org>; Sun,  9 Sep 2018 08:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeIINnx (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 09:43:53 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:33673 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeIINnw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 09:43:52 -0400
Received: by mail-lj1-f175.google.com with SMTP id s12-v6so15435611ljj.0
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 01:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Swu0MtJE77sk/muXFPsKqAJgYD6gc5gHQKIkUct9OdM=;
        b=AIPMamhxRZ5Nmk7E+xb4FZHp2Q8ILOGlS8U1j2/MHaQ2v3ybnAQk+HGa3mTcklVIBr
         rns5H20RMJMGZtiICLFTu5fXUGdi2aq6dnjLXFLEYB11tq1X32nSYxqZlJSgA5kGqMfd
         mr0ByGh2Ug1sAuROkTyeywd1ZkfWyOt4tnaKTOfzioXBbbEswcEyh0rpyeyT+GMBOFQW
         01EMsBkHBbAH49fkMUn6zMC4nxgEEwKtAILlXcTOcSCdhnKU+JagOk8cAKnypaKH0ODu
         inpfiNMK3wiOO7PzneyO8hAqt1DrnAN3Mf2+v1PV0yDzqlNuhiR+s4uvFdfJNEqlDy7l
         joJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Swu0MtJE77sk/muXFPsKqAJgYD6gc5gHQKIkUct9OdM=;
        b=RGPPwfDjaS5SKEJmL9vsIbvlLE4MgMCQ9J5M3ze8lZaCZpESdRIvVywfv3wREeCyof
         eTvfjUB/pQc3ptc+VoCSFfeI6+r3aTbpQ8VgxotPF3Mu3iynqzhnnQ0547x3vr2L+xTG
         wu9YMCN8jY5/bxUaLLLlbUeb7Mpm1tehQq7SX+u1whsCbrpynB2R+sE9xj30D17PyJtG
         aDpo5ZcGnLGZqQr0X73eWBeYOlve093lXWic8s45LxhBKyMimQz6Ll6Z35mp6Mr1ZlYF
         Bxw1rsdir+oxSAf8QDv6yLbBInb06OT0h4M40iVG1+VPwPWCn5bCyQa7X4xjE5LBIJJX
         kXkg==
X-Gm-Message-State: APzg51B6os0Z4OVsN+W8L+vw5HGmZEkfUWm0H/j6x3esCPfyG3Prztnq
        xh3N6zTz2ecBtaMLzZ2JVmjShcCy
X-Google-Smtp-Source: ANB0Vdae95mbk9x7yBZUOmzTVRVqawkfNM7QfaFwKaITAZz0BwnnkgICZwJbave4Q+xew9XCmorSWg==
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr9027304lji.17.1536483293906;
        Sun, 09 Sep 2018 01:54:53 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g16-v6sm2102525lfb.5.2018.09.09.01.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 01:54:53 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 20/23] tree-diff.c: remove implicit dependency on the_index
Date:   Sun,  9 Sep 2018 10:54:15 +0200
Message-Id: <20180909085418.31531-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180909085418.31531-1-pclouds@gmail.com>
References: <20180903180932.32260-1-pclouds@gmail.com>
 <20180909085418.31531-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 tree-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tree-diff.c b/tree-diff.c
index 57a15f51f0..16b28ff6d6 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -605,7 +605,7 @@ static void try_to_follow_renames(const struct object_id *old_oid,
 	choice = q->queue[0];
 	q->nr = 0;
 
-	repo_diff_setup(the_repository, &diff_opts);
+	repo_diff_setup(opt->repo, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.flags.find_copies_harder = 1;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-- 
2.19.0.rc0.337.ge906d732e7

