Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71D2920135
	for <e@80x24.org>; Thu,  9 Mar 2017 01:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754559AbdCIBch (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 20:32:37 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36616 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754236AbdCIBcg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 20:32:36 -0500
Received: by mail-pf0-f171.google.com with SMTP id o126so21865359pfb.3
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 17:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ez0bjEWBhWxqhMRY/YR4g/cnH8H04nWiC8HXZmNPVSc=;
        b=ElD/xULoDKc93owhWlnAdH+v+uTuabkP9FScIuwmclBpgCAGAAcXgr/t5fKKCoewEp
         p8RcLcFXbU7mWqZO0isFiHkaQV0aqAtiXizw138sjujbGgw98NAa6qcXbrN8kFuNb8Sl
         wy0STG6txPCcCABGVkL7uXJn8r10pw6g0jGFyhZVOpBhXsy7YGkKjXPmx5OXn3Rys332
         q10v48Nukox9+6kviAutsp+sgs54iPC3CIju2IvQJtHJu4yeU9RrS+lWPsG7535KIu/L
         zGqplHzhKpwhRewDlfyOIFm5ceSgCyKiuexSEyyTfGwAhlzdQzosfMbkiOlABVSYiPNe
         VE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ez0bjEWBhWxqhMRY/YR4g/cnH8H04nWiC8HXZmNPVSc=;
        b=OHbg7lHdESjJbs3vS/zvB6h3IMH0TLF4f/6Oed9I2naRHh6uuTzrT+XFjrID3lTXRL
         Fqk90MGHiQHAzePNCp54NtSB7tGvEY6nR9AXwB/nKe69TUFtJnl7RFXxn/1I5vYazdqr
         qohzzdlz6U4VGLcSJQ8PURlvNZH5xxEWokFb6Bw/zavHsUUuURMAVVlC1VPrV2JKdfIV
         YYF0EttBnE1jvSKI/8N3mlpd4i7UsUlZagtnCdf/aPgHSEwgRhUBtcopqzadxgtjz733
         CcRb4WdYdhfMPAqvVo11QYw5CezxS3hSAKKpxWT5AXfMyjQBd0vna/bU86xEC0Wc9atU
         fqkw==
X-Gm-Message-State: AMke39nIPs11zj0lKdWZLVb/ov7E8Pl3Jb7cGBF49Wf3QzbxO8llvNKXkvvG9GYjG9YNqNbr
X-Received: by 10.99.129.200 with SMTP id t191mr10798103pgd.41.1489022639641;
        Wed, 08 Mar 2017 17:23:59 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id l71sm8479948pga.7.2017.03.08.17.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Mar 2017 17:23:58 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v2 04/11] submodule sync: use submodule--helper is-active
Date:   Wed,  8 Mar 2017 17:23:38 -0800
Message-Id: <20170309012345.180702-5-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170309012345.180702-1-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
 <20170309012345.180702-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 1c2064cc1..7ed1aaba3 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1101,7 +1101,7 @@ cmd_sync()
 			;;
 		esac
 
-		if git config "submodule.$name.url" >/dev/null 2>/dev/null
+		if git submodule--helper is-active "$sm_path"
 		then
 			displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 			say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
-- 
2.12.0.246.ga2ecc84866-goog

