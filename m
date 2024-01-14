Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260BA7E
	for <git@vger.kernel.org>; Sun, 14 Jan 2024 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOa6iQEM"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3376f71fcbbso5724584f8f.1
        for <git@vger.kernel.org>; Sun, 14 Jan 2024 03:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705231012; x=1705835812; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1HqbWBGo9nQCVvLxp8jSP+bnwCCx3UiEYQ4Y22hMCS8=;
        b=AOa6iQEM7+QOSHuzx8djalBMxfgUFcjNwRBW2zpeS9h9s+9LdJ0bGoRbTssqE31kHf
         StJSmz6ViIVlDO592/MX/Lor8bmjbCpOdpvdUd3Qo71YJaTAYLgjsx7+1nCxlPnrbDIT
         ihToa4KFRy4zCBGyruy0hSEnF+dQyN5PHHbSlDBwzTrSn0JE9o2QWKE5BWantQrNlvZg
         ZAaGeuGg6oxy4W0b+m3y1B/6LneJBL5DZnafGtr2Klla9rsLN9BoO67tjPhlglFUF3ad
         lSPSPcF/Mue6SmNSQxkdWe6K/sS9+5td+sryoReL5sTdXc2t5kD9iIwwSK4gCsFmMucO
         YI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705231012; x=1705835812;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1HqbWBGo9nQCVvLxp8jSP+bnwCCx3UiEYQ4Y22hMCS8=;
        b=XwyUyzRY/3EAWvXPQHg7BT9l3zu9y3W8lU0SS8fqaZCflYO1K528w40YywdQKJ9GA9
         vKFj5IW8vqnKj1HtWunFp4JM56UVmOML0v2+/7rFz5f/Lvun/H559QuqBAq33sqeKHdA
         qTOS9Bf8gbxpDKP08qWoHG01j1q6a/V9LIOL/jCsEQgHoyAuIYvcRBzBYILTAovXWK7B
         0DuXaRirUi/oAQ9axp+kJFXyZTCprdzp5Cjlze9kmSgYazKAOCTtyUqeutxEktXV7Y4f
         c+K5eEPag2yR73RwRDJg+InkilxOzg+DuMTWBc3n/ZfXOPAvTc7JeQDdUNuYmvcj6NGf
         RAfQ==
X-Gm-Message-State: AOJu0YxxVU3if5JZms2KIaMuaW+gWRq2tU6eToIDGtK8ytpNjKzpGQUz
	06lKWeKiXegWQXdTaWCWiDO/FcdF9rQ=
X-Google-Smtp-Source: AGHT+IGy3wSbbNMEgl67C5Potcy7/BFPaKHuya7nBeEVUorWoy9Sa2NMyIRHr0dqNMFYr3X44qgKew==
X-Received: by 2002:a05:6000:188d:b0:337:9b5f:95 with SMTP id a13-20020a056000188d00b003379b5f0095mr1242853wri.133.1705231011383;
        Sun, 14 Jan 2024 03:16:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r12-20020adfca8c000000b0033668b27f8fsm8882267wrh.4.2024.01.14.03.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 03:16:51 -0800 (PST)
Message-ID: <pull.1644.git.git.1705231010118.gitgitgadget@gmail.com>
From: "Nikolay Edigaryev via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jan 2024 11:16:49 +0000
Subject: [PATCH] clone: support cloning of filtered bundles
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
    Nikolay Edigaryev <edigaryev@gmail.com>,
    Nikolay Edigaryev <edigaryev@gmail.com>

From: Nikolay Edigaryev <edigaryev@gmail.com>

f18b512bbb (bundle: create filtered bundles, 2022-03-09) introduced an
incredibly useful ability to create filtered bundles, which advances
the partial clone/promisor support in Git and allows for archiving
large repositories to object storages like S3 in bundles that are:

* easy to manage
  * bundle is just a single file, it's easier to guarantee atomic
    replacements in object storages like S3 and they are faster to
    fetch than a bare repository since there's only a single GET
    request involved
* incredibly tiny
  * no indexes (which may be more than 10 MB for some repositories)
    and other fluff, compared to cloning a bare repository
  * bundle can be filtered to only contain the tips of refs neccessary
    for e.g. code-analysis purposes

However, in 86fdd94d72 (clone: fail gracefully when cloning filtered
bundle, 2022-03-09) the cloning of such bundles was disabled, with a
note that this behavior is not desired, and it the long-term this
should be possible.

The commit above states that it's not possible to have this at the
moment due to lack of remote and a repository-global config that
specifies an object filter, yet it's unclear why a remote-specific
config can't be used instead, which is what this change does.

Signed-off-by: Nikolay Edigaryev <edigaryev@gmail.com>
---
    clone: support cloning of filtered bundles
    
    f18b512bbb (bundle: create filtered bundles, 2022-03-09) introduced an
    incredibly useful ability to create filtered bundles, which advances the
    partial clone/promisor support in Git and allows for archiving large
    repositories to object storages like S3 in bundles that are:
    
     * easy to manage
       * bundle is just a single file, it's easier to guarantee atomic
         replacements in object storages like S3 and they are faster to
         fetch than a bare repository since there's only a single GET
         request involved
     * incredibly tiny
       * no indexes (which may be more than 10 MB for some repositories) and
         other fluff, compared to cloning a bare repository
       * bundle can be filtered to only contain the tips of refs neccessary
         for e.g. code-analysis purposes
    
    However, in 86fdd94d72 (clone: fail gracefully when cloning filtered
    bundle, 2022-03-09) the cloning of such bundles was disabled, with a
    note that this behavior is not desired, and it the long-term this should
    be possible.
    
    The commit above states that it's not possible to have this at the
    moment due to lack of remote and a repository-global config that
    specifies an object filter, yet it's unclear why a remote-specific
    config can't be used instead, which is what this change does.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1644%2Fedigaryev%2Fclone-filtered-bundles-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1644/edigaryev/clone-filtered-bundles-v1
Pull-Request: https://github.com/git/git/pull/1644

 builtin/clone.c        | 13 +++++++++++--
 t/t6020-bundle-misc.sh | 13 +++----------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index c6357af9498..4b3fedf78ed 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1227,9 +1227,18 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 		if (fd > 0)
 			close(fd);
+
+		if (has_filter) {
+			strbuf_addf(&key, "remote.%s.promisor", remote_name);
+			git_config_set(key.buf, "true");
+			strbuf_reset(&key);
+
+			strbuf_addf(&key, "remote.%s.partialclonefilter", remote_name);
+			git_config_set(key.buf, expand_list_objects_filter_spec(&header.filter));
+			strbuf_reset(&key);
+		}
+
 		bundle_header_release(&header);
-		if (has_filter)
-			die(_("cannot clone from filtered bundle"));
 	}
 
 	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 3e6bcbf30cd..f449df00642 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -555,16 +555,9 @@ do
 	'
 done
 
-# NEEDSWORK: 'git clone --bare' should be able to clone from a filtered
-# bundle, but that requires a change to promisor/filter config options.
-# For now, we fail gracefully with a helpful error. This behavior can be
-# changed in the future to succeed as much as possible.
-test_expect_success 'cloning from filtered bundle has useful error' '
-	git bundle create partial.bdl \
-		--all \
-		--filter=blob:none &&
-	test_must_fail git clone --bare partial.bdl partial 2>err &&
-	grep "cannot clone from filtered bundle" err
+test_expect_success 'cloning from filtered bundle works' '
+	git bundle create partial.bdl --all --filter=blob:none &&
+	git clone --bare partial.bdl partial 2>err
 '
 
 test_expect_success 'verify catches unreachable, broken prerequisites' '

base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
-- 
gitgitgadget
