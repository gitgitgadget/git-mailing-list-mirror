Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0CAC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5952071B
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBB/G7Wd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKVTAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:00:04 -0500
Received: from mail-pj1-f48.google.com ([209.85.216.48]:37071 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfKVTAE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 14:00:04 -0500
Received: by mail-pj1-f48.google.com with SMTP id f3so3413145pjg.4
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 11:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K/ClFB5556FgGanGwl+H3GwERPMtefLc3BXA6NIC56o=;
        b=kBB/G7Wd1RZyBxQ3nPyRwI80dRYUAko2NOOOv5CdYCBXh3mvvg85QiGSFHPdc7H/nR
         8HL15+YQly/fRoiXCqQTZnw83Pks4H0qRVePkRbAhj7WqhDYf6Lz0ZBsj0D4p6oyrEWv
         7o41YVM6qnNnxJk30tyln65oiSWWxV4zCxYD4lhZh7hRPaIySNc3Za9Psq+QYLP6gs+5
         IxA97eZtLbUarZegF/fliOd8RFPXHnZN6bP52kXVcR3QB9PjS6LCXHA98mxl9CawvKOM
         a7EfBg3NRu2PIryPv+MhUsQOk53XNDM9OsnrhNOwhFFmA641lBmDgQQbvD8ySdScz83+
         /Ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K/ClFB5556FgGanGwl+H3GwERPMtefLc3BXA6NIC56o=;
        b=YLFInZY7Rs95+OJksKCZJdzid765pXHS/MvhI6sIKg6SEZdwMPOS0O3aGj8aDTBjIb
         65Txop5lhpnCrkZHzsXz+PxrEjHrHKNmTvaVhmCkzq6gB17qxvWzwKpU++O05cnYgWYj
         kE4vT1AytQ3E35HIaj1vOfeEprb5h11TRJJ7NeQ1Lp0COi6UzXG0SJEJ+vc85Qqk4XqU
         gT+jD/cNMbQjk5fG6fZq0/aZakP0APan6sMjlCfDLmIT7Gid6JhaXKJW2+QFarw3WflH
         csUit4Gh4x2U7lgd2QtR+zenJM8sISlo/DxmlJvZnNTb8t3XRrnrpFmaQJxj8TRjbwfW
         a8Dw==
X-Gm-Message-State: APjAAAUQC4++/VHkNI87eTHdGJNWIYWBCJqNFnfR1Dy3hd1LtmMqFMcM
        vIKF/OdrOa2l/CvZr9X2j6dfdQ2D
X-Google-Smtp-Source: APXvYqx3gtNqGmuq6BAJ2qIMsh2Z7/eEV8xUy3ctvPWnlnDq6xAN16OdFwlLcqzZBQ25OZesWhM5SA==
X-Received: by 2002:a17:90a:170a:: with SMTP id z10mr21419654pjd.86.1574449203469;
        Fri, 22 Nov 2019 11:00:03 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id 136sm8238717pfb.49.2019.11.22.11.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 11:00:02 -0800 (PST)
Date:   Fri, 22 Nov 2019 11:00:01 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 08/22] t3600: comment on inducing SIGPIPE in `git rm`
Message-ID: <d35c054344bee8c2b81532b384a49d9984b96471.1574449072.git.liu.denton@gmail.com>
References: <cover.1574296987.git.liu.denton@gmail.com>
 <cover.1574449072.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574449072.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a comment about intentionally inducing SIGPIPE since this is unusual
and future developers should be aware. Also, even though we are trying
to refactor git commands out of the upstream of pipes, we cannot do it
here since we rely on it being upstream to induce SIGPIPE. Comment on
that as well so that future developers do not try to change it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3600-rm.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 0c3bf10edd..0ea858d652 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -251,6 +251,7 @@ test_expect_success 'choking "git rm" should not let it die with cruft' '
 		echo "100644 $hash 0	some-file-$i"
 		i=$(( $i + 1 ))
 	done | git update-index --index-info &&
+	# git command is intentionally placed upstream of pipe to induce SIGPIPE
 	git rm -n "some-file-*" | : &&
 	test_path_is_missing .git/index.lock
 '
-- 
2.24.0.497.g17aadd8971

