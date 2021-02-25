Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAD6C433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 01:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A7864EF1
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 01:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbhBYBWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 20:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhBYBWO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 20:22:14 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16B6C061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 17:21:33 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v22so4819461edx.13
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 17:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDNHpLrbSyqzqsGery8ZHoiwn4Ba6YpJ1y87xoiVHnE=;
        b=P/cP5JM3h9fS1W8pd5PxtrgdT8r4AEBy66TYchoLyxvJznU1lna+/B+c9dXX+8Eq8+
         ZmYRlmqrO2Ci49DJmWqffuvir6GliGd5gPUtI2MUVzEWjtnguWMvSjREHwBwk1bTMJYi
         CQG+awH05Gv2VXsCibXrBDHlS7LAV47femEuTdq0HSY3PUQmwiAGVM6egUw2F4LIgev/
         hySWv/Ozcc1VSw7EJD2VjymN0FwahSdRRM8PiIjunqDwWPfEkBnf9l99+oZMwqP974BB
         pbuJQhNjI4LXtFDLsZwLs1dQEx2ST5C8SmO+3VdfiC0horkrwm8BXKQuuxAREjcwJiet
         T9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDNHpLrbSyqzqsGery8ZHoiwn4Ba6YpJ1y87xoiVHnE=;
        b=hRkfnfTWFKLKKIOBSqK7lFpGA2cnZ9Q6dtGfehqdS52SiT35bK0crhjTTNqmZNcbd9
         GF+pXH8NUJjX3oPs3dWN5Xak2snBoTu+keFXZNKo+zRjcOw8S00Oe07Eqvs1YqoK81j8
         /mfvo87M2C3s45XGsgy3rmWrfTgWdrmCzLevFdLr+MbmDS8p0R6maEVTwjHWkQqJgFTm
         IkL2vocRdh+7hHHeYrw0trISlHOIXF41N5D427b/ZcgaMU1xd5aEMeFVzhaxO/hhirNu
         18SWxvklg3KaWe/aIbeeioLcYGMbtx1Ji6swHRbVdh4iE90uDyCBZiyye+vah0WgPy6u
         l2yQ==
X-Gm-Message-State: AOAM532xQIEAdYTeMdrHQhnCxVv/TOxBV9vfWzAF39oKhJMyFeueYiud
        Pd/C2Uz3frByBOpV3BkoL+xCJiVusn/JVg==
X-Google-Smtp-Source: ABdhPJy6Thekw1CdNv74nqkz+9+pwGAHR+1oapsekGTxews+bWRI4P8rkc3UuIG68LxwJeyN6sCFhQ==
X-Received: by 2002:a05:6402:158d:: with SMTP id c13mr537752edv.297.1614216092173;
        Wed, 24 Feb 2021 17:21:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12sm2648216edb.52.2021.02.24.17.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 17:21:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] remote: add camel-cased *.tagOpt key, like clone
Date:   Thu, 25 Feb 2021 02:21:16 +0100
Message-Id: <20210225012117.17331-1-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change "git remote add" so that it adds a *.tagOpt key, and not the
lower-cased *.tagopt on "git remote add --no-tags", just as "git clone
--no-tags" would do.

This doesn't matter for anything that reads the config. It's just
prettier if we write config keys in their documented camelCase form to
user-readable config files.

When I added support for "clone -no-tags" in 0dab2468ee5 (clone: add a
--no-tags option to clone without tags, 2017-04-26) I made it use
the *.tagOpt form, but the older "git remote add" added in
111fb858654 (remote add: add a --[no-]tags option, 2010-04-20) has
been using *.tagopt all this time.

It's easy enough to add a test for this, so let's do that. We can't
use "git config -l" there, because it'll normalize the keys to their
lower-cased form. Let's add the test for "git clone" too for good
measure, not just to the "git remote" codepath we're fixing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I also noticed that we write e.g. init.objectformat instead of
init.objectFormat, and core.logallrefupdates etc. If anyone's got an
even even worse case of OCD there's an interesting #leftoverbits
project there of scouring the code for more cases of this sort of
thing...

 builtin/remote.c         | 2 +-
 t/t5505-remote.sh        | 1 +
 t/t5612-clone-refspec.sh | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d11a5589e49..f286ae97538 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -221,7 +221,7 @@ static int add(int argc, const char **argv)
 
 	if (fetch_tags != TAGS_DEFAULT) {
 		strbuf_reset(&buf);
-		strbuf_addf(&buf, "remote.%s.tagopt", name);
+		strbuf_addf(&buf, "remote.%s.tagOpt", name);
 		git_config_set(buf.buf,
 			       fetch_tags == TAGS_SET ? "--tags" : "--no-tags");
 	}
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 045398b94e6..2a7b5cd00a0 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -594,6 +594,7 @@ test_expect_success 'add --no-tags' '
 		cd add-no-tags &&
 		git init &&
 		git remote add -f --no-tags origin ../one &&
+		grep tagOpt .git/config &&
 		git tag -l some-tag >../test/output &&
 		git tag -l foobar-tag >../test/output &&
 		git config remote.origin.tagopt >>../test/output
diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index 6a6af7449ca..3126cfd7e9d 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -97,6 +97,7 @@ test_expect_success 'by default no tags will be kept updated' '
 test_expect_success 'clone with --no-tags' '
 	(
 		cd dir_all_no_tags &&
+		grep tagOpt .git/config &&
 		git fetch &&
 		git for-each-ref refs/tags >../actual
 	) &&
-- 
2.30.0.284.gd98b1dd5eaa7

