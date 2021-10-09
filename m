Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA3CC433EF
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 13:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB57D60F57
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 13:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhJINgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Oct 2021 09:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbhJINgK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Oct 2021 09:36:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8062C061570
        for <git@vger.kernel.org>; Sat,  9 Oct 2021 06:34:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id y3so5539910wrl.1
        for <git@vger.kernel.org>; Sat, 09 Oct 2021 06:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mrnFHLtLQHidv9izHeOKKu+i+eK28bno1/AqqLm/s2Y=;
        b=aLHSUeddAPu1DaCvzgI/rGYhnXh+4mJvZeTbrd6MBp6RmQN3s695wNv/LXEB4t3sjH
         AStIvZOxeGbOoc4Pyh9/pcK2EeC5EzzHaaMBVhbHYHqVw2Akl7CrGNhYlUF9324Bt1z5
         m7F0QrIO5JE3Fr+T1b5VBg+lL8dURWatdmJcTncNL11ahLo0NatN09pe2p0lXiW7RFv3
         Et5XHB0VhZmkawXO24nwFIRu0shyoRDMXBc3Nl/JiJHEnGVCCGTiFFp0lfGhUIp0UYt0
         A4GosC/7sLKNzAaYV89mla0QKg01VvYNHruoaK/84UhuiYhSKXF1kfPBbkz+/0LjDERi
         Kj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mrnFHLtLQHidv9izHeOKKu+i+eK28bno1/AqqLm/s2Y=;
        b=3Si1IB+mDwurRszDUa0sIrip7xGNpG/eK7XpoXwT4CgYOyfWiDVfI3ai040UG4ZL83
         D1gj9xYEvhQSQbcc7LWGvQvPmun2p37RijmdvzAEJ8ZypTycBnOf3jnU5d8tyPeOQGjQ
         1JH+AWS17g0oszMI/uw5WEtWPLrxtTJ4fSxuOMkeFnhzTEwwl7QLUCatOYrlSn+jVg4J
         0rZbxNycTTcMvRr7eUG5F+8NVxBi4eVpOaL+dDJFJNQJluBzEA68Ha+4rKqdDWwSr61D
         h5VOyeXcWBMDPbbRj6MAZlgnlVQwhq3b/Qm+mVEobrAHuSIotx3/UY3oOYB1kP9Zv8zE
         IQoQ==
X-Gm-Message-State: AOAM531XU/IpMyR8gbCVpGVOnikmiUQfauiitF6faCTNOJEW+bBEjgyw
        dw+tbLt5u0EEJa7/xVexKEGB5iizAuI9Mg==
X-Google-Smtp-Source: ABdhPJwDTAFg8KNZ59kqORv3qMTmT4x5m2YunbmuKS6eUej4i11WcWBAXTWiCkbZ7kt3OnBjX7MH5Q==
X-Received: by 2002:a5d:6dce:: with SMTP id d14mr11517358wrz.363.1633786452053;
        Sat, 09 Oct 2021 06:34:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o15sm2089189wmc.21.2021.10.09.06.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 06:34:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Turner <novalis@novalis.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] unwritable tests: assert exact error output
Date:   Sat,  9 Oct 2021 15:34:02 +0200
Message-Id: <patch-1.2-a5ef8ea47f4-20211009T133354Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1492.gcc3b81fc59a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for fixing a regression where we started emitting some
of these error messages twice, let's assert what the output from "git
commit" and friends is now in the case of permission errors.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0004-unwritable.sh | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
index e3137d638ee..998c9d1be69 100755
--- a/t/t0004-unwritable.sh
+++ b/t/t0004-unwritable.sh
@@ -18,27 +18,55 @@ test_expect_success setup '
 test_expect_success POSIXPERM,SANITY 'write-tree should notice unwritable repository' '
 	test_when_finished "chmod 775 .git/objects .git/objects/??" &&
 	chmod a-w .git/objects .git/objects/?? &&
-	test_must_fail git write-tree
+
+	cat >expect <<-\EOF &&
+	error: insufficient permission for adding an object to repository database .git/objects
+	fatal: git-write-tree: error building trees
+	EOF
+	test_must_fail git write-tree 2>actual &&
+	test_cmp expect actual
 '
 
 test_expect_success POSIXPERM,SANITY 'commit should notice unwritable repository' '
 	test_when_finished "chmod 775 .git/objects .git/objects/??" &&
 	chmod a-w .git/objects .git/objects/?? &&
-	test_must_fail git commit -m second
+
+	cat >expect <<-\EOF &&
+	error: insufficient permission for adding an object to repository database .git/objects
+	error: insufficient permission for adding an object to repository database .git/objects
+	error: Error building trees
+	EOF
+	test_must_fail git commit -m second 2>actual &&
+	test_cmp expect actual
 '
 
 test_expect_success POSIXPERM,SANITY 'update-index should notice unwritable repository' '
 	test_when_finished "chmod 775 .git/objects .git/objects/??" &&
 	echo 6O >file &&
 	chmod a-w .git/objects .git/objects/?? &&
-	test_must_fail git update-index file
+
+	cat >expect <<-\EOF &&
+	error: insufficient permission for adding an object to repository database .git/objects
+	error: file: failed to insert into database
+	fatal: Unable to process path file
+	EOF
+	test_must_fail git update-index file 2>actual &&
+	test_cmp expect actual
 '
 
 test_expect_success POSIXPERM,SANITY 'add should notice unwritable repository' '
 	test_when_finished "chmod 775 .git/objects .git/objects/??" &&
 	echo b >file &&
 	chmod a-w .git/objects .git/objects/?? &&
-	test_must_fail git add file
+
+	cat >expect <<-\EOF &&
+	error: insufficient permission for adding an object to repository database .git/objects
+	error: file: failed to insert into database
+	error: unable to index file '\''file'\''
+	fatal: updating files failed
+	EOF
+	test_must_fail git add file 2>actual &&
+	test_cmp expect actual
 '
 
 test_done
-- 
2.33.0.1492.gcc3b81fc59a

