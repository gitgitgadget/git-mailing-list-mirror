Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E7E12023D
	for <e@80x24.org>; Thu,  2 Mar 2017 02:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754091AbdCBCAZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 21:00:25 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34647 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753973AbdCBCAY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 21:00:24 -0500
Received: by mail-pg0-f45.google.com with SMTP id p5so26352423pga.1
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 18:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sE2Ytny25Ww5RLrnAZ7AImdW2h7Ptk4bNO/xIgvl6r8=;
        b=F3vCt85+pTi4xQ07WObq6GVXh+I7ij/nz+dA1sQSnuWbbsmaNaK0YiIOl7NhvwULyH
         8VNZN6Zm4a1UC/4ObRRzeNjNkCrN3ETK1XblybEP6g0DEkwlL7K/W4SyBUXiKbtYzhUx
         BVqUShQgt658ZNrjwCrEYbCPCw7pqtoTlBPcCQDxswbO9ADnNo6q52VJSrI8YCChs/JR
         lrAi3NwtO5DKYniurnF6S/mhgXo2AzrmRxmWVnuhMvqBqYG24lKxXDnT5qUdzoXePRo9
         Rz2+lY9Ilaw+hOCFuUZuQS2xrP0ufVulmQMbMFimjCuLGrDy3iqz91BxhcGBIRSbJb4v
         hJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sE2Ytny25Ww5RLrnAZ7AImdW2h7Ptk4bNO/xIgvl6r8=;
        b=IJhTvmBYeR+66FZhc4qwnUn9n2VkUxWJXSdE+mQ922arGHyhMq3r5fBsS/woMwntOJ
         EFZLCvqes/Ht62UgaMfNoS/lEQAyYVR0UVNCJUAlgX/QnfuIXaSZttTPLHpPntZRchQj
         WEoxYD0k5hKOSQbTikDQHZ+IgsPuHqwF3eBtuvDlEpAsPINj/A81wGLUHAhtI+q1F2ZC
         fzVpeVIkh9fUe1p5tffFyO6qZnQnCuwHMNInjcoI34ne06BUzIETv4ADKcaX3c44ZR+8
         hCG0Rrn3KhUOIRY4xI2kx+FRKg9BIVaG66afkuB6VQ9daRaxvoJddNNUbBfON4Ld91by
         WdZQ==
X-Gm-Message-State: AMke39k79tVnfNrHyLNIg1fFqqfHexagrcBpmdzAkLn79ohUeo6NBFwT6UDmiFrrSzoX/Hg6
X-Received: by 10.84.218.204 with SMTP id g12mr14216927plm.78.1488415687749;
        Wed, 01 Mar 2017 16:48:07 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:695f:c2a1:ec60:5665])
        by smtp.gmail.com with ESMTPSA id e129sm12781834pfe.8.2017.03.01.16.48.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 16:48:07 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net, gitster@pobox.com,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 03/18] lib-submodule-update: teach test_submodule_content the -C <dir> flag
Date:   Wed,  1 Mar 2017 16:47:44 -0800
Message-Id: <20170302004759.27852-4-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170302004759.27852-1-sbeller@google.com>
References: <20170223225735.10994-1-sbeller@google.com/>
 <20170302004759.27852-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/lib-submodule-update.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index c0d6325133..a906c92cfb 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -193,6 +193,11 @@ test_superproject_content () {
 # Test that the given submodule at path "$1" contains the content according
 # to the submodule commit recorded in the superproject's commit "$2"
 test_submodule_content () {
+	if test "$1" == "-C"
+	then
+		cd "$2"
+		shift; shift;
+	fi
 	if test $# != 2
 	then
 		echo "test_submodule_content needs two arguments"
-- 
2.12.0.rc1.52.ge239d7e709.dirty

