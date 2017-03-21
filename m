Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13ED32095B
	for <e@80x24.org>; Tue, 21 Mar 2017 22:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932758AbdCUWMV (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 18:12:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34942 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758127AbdCUWMS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 18:12:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id z133so5628610wmb.2
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 15:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yhBaN3h3zh0WsmzuhP98lK7RKN3WwfYuYQZ6r1otKWk=;
        b=ogY5bZwygXP8laX9R4adPF4290GmLWDqGgwCsXGpW1JiyZrBy7ExokS0euk1WcRDku
         n6Tz+ZwkG9CGeM5t8EqURk4AU74Hv3TojON2r1puXMjTM6vLXQRreS1AueOy7pHleBPs
         /nnyAeY3EnTFos7isZpTBi+S5Npdd16Y15KuZzDUBLv+zTTistJeAxDkuIz9TVO58IHV
         Z4yz66zEgANeniZPlAcJNFBiLnBn33gLz6jWCgM8xHb/BRLbGNq25fRG6gvpuHhegsb9
         JVHBBCN/vagFMQQ15rilhbZL3ShzASB9nQavEA3fZPr/Fw2OVrnLsPrFcDzIHrz0Re/y
         /CpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yhBaN3h3zh0WsmzuhP98lK7RKN3WwfYuYQZ6r1otKWk=;
        b=LFzKIc+NGbL8ZlmJEOKXw5oD1nsHCXsK2qbEQNzzVhnTnI+oxsIeS65KaoOJf28Cft
         yRAs3ETGAgdEql0stNWNaChkZGS+IE8J+12QBYG3UwGYNkKXL2ToU6yhl/GYssZkyr8t
         Iiyk0yhaySi/fYzo39fi1gouAZXgXUsQLwlQZpY3n7/zMJo3xqeQhekBo97J+YRTEAxs
         dSW3ji5zfisOLtQHEPnStGnA0rNd53nqQzeuibulbBq7PuyMxkZ6G30+ad501osp+V4O
         xMusCpO+ZX/yV3dOSjW6bxvBvrSFT1SiRL1H4JvgFw1l0ZJRy2J2pWQFiSacWvlf0J3n
         WedA==
X-Gm-Message-State: AFeK/H2+inXjeBuY6HpIjq7apudeldXgfBsoVOsEb11NnCL+RXxIy9lgT9JYFMcrykt8/Q==
X-Received: by 10.28.173.193 with SMTP id w184mr4941540wme.106.1490134328614;
        Tue, 21 Mar 2017 15:12:08 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id 94sm11155266wrp.34.2017.03.21.15.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Mar 2017 15:12:08 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 2/3] stash: pass the pathspec argument to git reset
Date:   Tue, 21 Mar 2017 22:12:18 +0000
Message-Id: <20170321221219.28041-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.401.g98d3b1bb99.dirty
In-Reply-To: <20170321221219.28041-1-t.gummerer@gmail.com>
References: <20170319202351.8825-1-t.gummerer@gmail.com>
 <20170321221219.28041-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For "git stash -p --no-keep-index", the pathspec argument is currently
not passed to "git reset".  This means that changes that are staged but
that are excluded from the pathspec still get unstaged by git stash -p.

Make sure that doesn't happen by passing the pathspec argument to the
git reset in question, bringing the behaviour in line with "git stash --
<pathspec>".

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 git-stash.sh           | 2 +-
 t/t3904-stash-patch.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index ba86d84321..13711764a9 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -322,7 +322,7 @@ push_stash () {
 
 		if test "$keep_index" != "t"
 		then
-			git reset -q
+			git reset -q -- "$@"
 		fi
 	fi
 }
diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index 38e730090f..83744f8c93 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -77,6 +77,14 @@ test_expect_success 'git stash --no-keep-index -p' '
 	verify_state dir/foo work index
 '
 
+test_expect_success 'stash -p --no-keep-index -- <pathspec> does not unstage other files' '
+	set_state HEAD HEADfile_work HEADfile_index &&
+	set_state dir/foo work index &&
+	echo y | git stash push -p --no-keep-index -- HEAD &&
+	verify_state HEAD committed committed &&
+	verify_state dir/foo work index
+'
+
 test_expect_success 'none of this moved HEAD' '
 	verify_saved_head
 '
-- 
2.12.0.401.g98d3b1bb99.dirty

