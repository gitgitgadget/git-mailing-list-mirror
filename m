Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB32BC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70CFD23407
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbgLPSwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732283AbgLPSwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:52:25 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42841C0611E4
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:47 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id l11so51011082lfg.0
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0W3us1d0G5MzwFNR/Pz+9/j1tIqVyxQx+lyRwVD3uME=;
        b=Ee6eJrvKBZSKrZ++SSd2HUmQCbH6u5CZFRFEG4TPSZ8inuac2as55CPcnidPMp+GUt
         IytYkvJf7oHi52Z4IsI0knP60TyxAwIzO22CoXigWv+NY22owUDGhGJaBg9aLMmPdPoI
         71JmIkDblkghV70gV7N8vORY8rVGSF7lhLPOkwXqVh3IuN0WQgwuQhhXUqfAXGyRqNet
         4jP0Veyjt3C141MfXJGqFwyEOubt9YCqF9X+nxiD3TmJVSgGvk/ihkfEKCwO3ZT4AxtU
         5c+/Vq3hTuBCzv9JqIck/QcoN3/BfZPh54lVumR5BJH+FBOYCMts443NNZnSQMoKboIb
         kMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0W3us1d0G5MzwFNR/Pz+9/j1tIqVyxQx+lyRwVD3uME=;
        b=i74gjhPMLXT8OR0XHEaEk7qMb24iLxSzq70PHViHIzzuFVGt6IWF8tD2W1ITcvqGNk
         PXOUFUV/5DDRC9gGRHQXP0x0qgkscfZPiKrM84CxOFYRataO3YKGPDb/wZgDisDv4JyF
         eJbbdWPdtL5W7DTbhgLxKZKuENa2+pO42dVQpInjkRnrh8NYpmNsPP0rAIJ8pH/aD2/p
         ihoU8avXd6/uPAju6RhFmd715QYvP4+hcIOlw5gcRJ14LtKi/gecaV8C4PfMeiFNb/6u
         eRK8fM8h9f3/qco3icK4t5gkbuZOwlzvT5/c7/aZZmODyXkbTCtXRuROY3cW7W46geha
         tj2A==
X-Gm-Message-State: AOAM532Isu0++kbpNO2iad/f1/MGIJ4b2rzqn5c5j/fozBgLE8KoPzaH
        wYPLGA99io5dFeWhDZ0qr2s=
X-Google-Smtp-Source: ABdhPJwkfJaXvjgk4vs8SMJMnV4a07FsEjzekI3gxW/dlThozXAlFcfrKCxuDXVQZugwSS9x6T6/8A==
X-Received: by 2002:a2e:9f53:: with SMTP id v19mr14839657ljk.109.1608144644936;
        Wed, 16 Dec 2020 10:50:44 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:44 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 18/33] diff-merges: group diff-merge flags next to each other inside 'rev_info'
Date:   Wed, 16 Dec 2020 21:49:14 +0300
Message-Id: <20201216184929.3924-19-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The relevant flags were somewhat scattered over definition of 'struct
rev_info'. Rearrange them to group them together.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 revision.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/revision.h b/revision.h
index fcc532c873d1..dcfa14454a55 100644
--- a/revision.h
+++ b/revision.h
@@ -191,13 +191,14 @@ struct rev_info {
 			match_missing:1,
 			no_commit_id:1,
 			verbose_header:1,
+			always_show_header:1,
+			/* Diff-merge flags */
 			explicit_diff_merges: 1,
 			separate_merges: 1,
 			combine_merges:1,
 			combined_all_paths:1,
 			dense_combined_merges:1,
-			first_parent_merges:1,
-			always_show_header:1;
+			first_parent_merges:1;
 
 	/* Format info */
 	int		show_notes;
-- 
2.25.1

