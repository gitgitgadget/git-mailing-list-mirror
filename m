Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A87221FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 17:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756067AbcFTRBE (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 13:01:04 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36098 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756064AbcFTRBD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 13:01:03 -0400
Received: by mail-pf0-f176.google.com with SMTP id t190so55889462pfb.3
        for <git@vger.kernel.org>; Mon, 20 Jun 2016 10:00:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HdmJjwGCBsLmaBC6SlCGGMr+HxLaKNCpj79J99LQekY=;
        b=axaOK44CzzTVwqY4yL5ef/Mter/YUQC43wrnx3sx21NuoVXV3Ab8GhiWAmOY8SI5Aq
         PiN0L4QdWwrkUFLeQwPxGzMI4plXmbnMjvo4KaRRy+wIuxiGPLpBb2yRePtpzZ2GlZcS
         TLl1rU5fjHxPWz+mFb43KVeAmaPxqCSVsgVbt/KlxYe38O7sg+7g6OTXxe5CzeEHfHrH
         0HX4QUIIqKtdrq8UkKtLFl2BC+pHnmdK+Jbabhx1+O5/YQV7PCmX3ncVG99Npsk5DFK5
         LDYX35UF7vC76MpNqyELJKg97J97xuMGDhHWFef11wbJOElOa9EKtwhYYXBxUeTt37bJ
         6/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HdmJjwGCBsLmaBC6SlCGGMr+HxLaKNCpj79J99LQekY=;
        b=OEV4SK+a81vS8rMZtAhdnWCoIOxwCM1S7gBhZVUF+0Et8ttEjgy7gzim7SGmXxKVCp
         nFu7kmWq+S9cbQehILtJ6I/Kl1fYCFKjtssXsKnB9xcJpumTqvhOYVDP1ZfBBHcOZZGU
         wUBhnwfk59wB+H+o0oZkimRQcqyDRPMM2y+9siixo+bulFB7dnytg8f+77fBE7zqaZ6w
         mxZmKbTMyUGpEwva0NnoAq0SUp5JxYEurV6eDxZ0tOsV4Q+MemWFoChQgIernySmpXac
         DwGsR0sQUDzG4SZn5fpSCEn3SqyEGspEZZh2zn6DRy6xXHTA53rV0mykSIIcjlt5Swgk
         bySw==
X-Gm-Message-State: ALyK8tJBtZxxvqWgXmhg7eGGts2PX65DRTcbeYfsYJ4TymBBUzfMfjysdpnZ24T39l+4HNUh
X-Received: by 10.98.86.151 with SMTP id h23mr22915622pfj.137.1466442003752;
        Mon, 20 Jun 2016 10:00:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:dd7a:ae19:9fa3:441d])
        by smtp.gmail.com with ESMTPSA id k9sm89566155pao.19.2016.06.20.10.00.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Jun 2016 10:00:03 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com, peff@peff.net
Cc:	git@vger.kernel.org, VADIME@il.ibm.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH] shallow clone to not imply shallow submodules
Date:	Mon, 20 Jun 2016 09:59:58 -0700
Message-Id: <1466441998-18896-1-git-send-email-sbeller@google.com>
X-Mailer: git-send-email 2.7.0.rc0.40.g5328432.dirty
In-Reply-To: <xmqq7fdkx5oz.fsf@gitster.mtv.corp.google.com>
References: <xmqq7fdkx5oz.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Hi Junio, Peff,

I thought about this patch squashed into  
"clone: do not let --depth imply --shallow-submodules" will actually test
for the regression.

Thanks,
Stefan

 t/t5614-clone-submodules.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/t/t5614-clone-submodules.sh b/t/t5614-clone-submodules.sh
index f7c630b..a9aaa01 100755
--- a/t/t5614-clone-submodules.sh
+++ b/t/t5614-clone-submodules.sh
@@ -37,7 +37,7 @@ test_expect_success 'nonshallow clone implies nonshallow submodule' '
 	)
 '
 
-test_expect_success 'shallow clone does not imply shallow submodule' '
+test_expect_success 'shallow clone with shallow submodule' '
 	test_when_finished "rm -rf super_clone" &&
 	git clone --recurse-submodules --depth 2 --shallow-submodules "file://$pwd/." super_clone &&
 	(
@@ -52,6 +52,21 @@ test_expect_success 'shallow clone does not imply shallow submodule' '
 	)
 '
 
+test_expect_success 'shallow clone does not imply shallow submodule' '
+	test_when_finished "rm -rf super_clone" &&
+	git clone --recurse-submodules --depth 2 "file://$pwd/." super_clone &&
+	(
+		cd super_clone &&
+		git log --oneline >lines &&
+		test_line_count = 2 lines
+	) &&
+	(
+		cd super_clone/sub &&
+		git log --oneline >lines &&
+		test_line_count = 3 lines
+	)
+'
+
 test_expect_success 'shallow clone with non shallow submodule' '
 	test_when_finished "rm -rf super_clone" &&
 	git clone --recurse-submodules --depth 2 --no-shallow-submodules "file://$pwd/." super_clone &&
-- 
2.7.0.rc0.40.g5328432.dirty

