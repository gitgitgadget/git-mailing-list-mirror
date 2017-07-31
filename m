Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D4121F991
	for <e@80x24.org>; Mon, 31 Jul 2017 21:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbdGaVDE (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 17:03:04 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:38735 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751607AbdGaVDD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 17:03:03 -0400
Received: by mail-pg0-f53.google.com with SMTP id l64so1835618pge.5
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 14:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2HVdbfyMrCAD6++nks1kjwKgNzp/aw3oDCBT4FqRfr4=;
        b=owBhlNsqrJWa30ElVj6NSiNZJ3dDhawbw1Tk7p2OqeSjA5NW0DH381fxXBAtwlT9HQ
         sL9n+af1DC84fBEDigIIRnKokWfAq0IVDA4AozZuexa9DiEoxOrDZxHv5ebwABlA7ZCI
         B/DD8SR9wRAOs+EY/A+FgCbRVOFHn8elAHi9RirTF3EOHE7Cs0ohmVV5AVWgKnLLwIT4
         QBdOLZ7aG3eysRfaLF9lEP5sit+XwYVGJYzNIyn4aRJz73V9J0Z5BE5+/Ny1QIWrlWfy
         6dJ1Ggw42H9HM5xtFvl0UPJUl+lhUZC/ranPhX/PJOTNtTBVwPUX+TyEtjgv0vuIkbkY
         DUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=2HVdbfyMrCAD6++nks1kjwKgNzp/aw3oDCBT4FqRfr4=;
        b=Z6ApeoignC/tYHPjCsgK94mus48lc7r12Oe7BqGaTUyRm4TqkSRCBIQbR5dTBF2tTn
         FqUT0Wi39kYq2vFMV5lS3ZU7t/vwamih+Al5JYwp4llMTVHczq2wINdZJU1dgU+Tbw3e
         KpUFFTB/WxcoU66lfzQeBRy/LQmR2c4M+UugbfyfjLrMpVWESOuUdhWDxlzc6sf4yXvu
         Ot+xkxIh6V8oBBhJ6a+FV1aaaTHn6PLN7tkiF/AEBjl4kMUoquqKo3fSelH238q48YUv
         rxf5iqbZ/zbZAHcXlbQ/MKPCnUoCy39eTnfUvv/O+35qpICym5z0HEDLQDZWi/6rBrzC
         Fe1Q==
X-Gm-Message-State: AIVw111XA1ni3CKFDDYFdK9u1GiSGBPd7+4AO4ITTmzxAJ3Oiy2JCK9I
        b4wbrx6Qp4UIp/14h5B7iA==
X-Received: by 10.101.85.132 with SMTP id j4mr17312340pgs.68.1501534982086;
        Mon, 31 Jul 2017 14:03:02 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id k185sm53231673pgc.31.2017.07.31.14.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Jul 2017 14:03:00 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peartben@gmail.com, christian.couder@gmail.com
Subject: [PATCH v2 4/5] fsck: support lazy objects as CLI argument
Date:   Mon, 31 Jul 2017 14:02:46 -0700
Message-Id: <c02229e54e5d8d4626ad6d39f223871dfa1df255.1501532294.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <cover.1501532294.git.jonathantanmy@google.com>
References: <cover.1501532294.git.jonathantanmy@google.com>
In-Reply-To: <cover.1501532294.git.jonathantanmy@google.com>
References: <cover.1501111615.git.jonathantanmy@google.com> <cover.1501532294.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach fsck to not treat missing objects provided on the CLI as an error
when extensions.lazyobject is set.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fsck.c         |  2 ++
 t/t0410-lazy-object.sh | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 19681c5b3..20415902f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -754,6 +754,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			struct object *obj = lookup_object(oid.hash);
 
 			if (!obj || !(obj->flags & HAS_OBJ)) {
+				if (repository_format_lazy_object)
+					continue;
 				error("%s: object missing", oid_to_hex(&oid));
 				errors_found |= ERROR_OBJECT;
 				continue;
diff --git a/t/t0410-lazy-object.sh b/t/t0410-lazy-object.sh
index 45f665a15..3ac61c1c5 100755
--- a/t/t0410-lazy-object.sh
+++ b/t/t0410-lazy-object.sh
@@ -76,4 +76,20 @@ test_expect_success '...but succeeds if lazyobject is set' '
 	git -C repo fsck
 '
 
+test_expect_success 'fsck fails on lazy object directly given in command-line' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo 1 &&
+	HASH=$(git hash-object repo/1.t) &&
+	delete_object repo "$HASH" &&
+
+	test_must_fail git -C repo fsck "$HASH"
+'
+
+test_expect_success '...but succeeds if lazyobject is set' '
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.lazyobject "arbitrary string" &&
+	git -C repo fsck "$HASH"
+'
+
 test_done
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

