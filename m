Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AFDE1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbcHCUpT (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:45:19 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35574 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932213AbcHCUpS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:45:18 -0400
Received: by mail-pa0-f47.google.com with SMTP id iw10so76996428pac.2
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 13:44:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=UXXvcZwzEcNkzww6Xd552L1tQ+jS/FmyKMwQFbSy/y4=;
        b=U4aSWWmDZGy0GxApDwCBdhLlvhKOcMahg2tBogII8cJjd1r1j/p4Y3j/HP0RDz8Qts
         Kb2imcOsOW283UYOSD+p4eXyQkFktrosXrR2kBejrXSNyTnHeTgPFY2q421k7yNHN0tD
         xAl2VYuRdyirJK3grMiBmLN/i8AdSe9zff88fT+BwlpfT7elCMhdxHkChoheihQvayBS
         ccGxuSe71dnTJ878cqJ8isxlezecHCupapF5IJSGOeaAEkMTCkQMKG9V2CHrlDFbGAjC
         u5yB+7mDiC2c/APQ/COCfRMPf+R9DzaHarvkoA4FBF5KAVLadtvzu0lh0xYGscpMo5bx
         XQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UXXvcZwzEcNkzww6Xd552L1tQ+jS/FmyKMwQFbSy/y4=;
        b=eDI1TJ3Ul8fvZIPG6z//Pa7bkmy7520p5pMFo1TLoLGgaFKiiuzJu/4NOX1sJ91Bn/
         9SJtDAK2RAx7jK5++rFxJ9BANyDneu0bLYkFv7P2sDNfnNLrUv9GxR3duzZx0liO++z5
         CMim97xMg9vB/0ChINI3SUFBt190I/IUrSxkEf8sK/gYod0RUd92wVNSc3aHS/5fvk/9
         5ahjHkkK+6f0IEbs1WKJzaPtlEilXuTrRZtr/xdOuVrrRLbDk5m8HwmVO1L5NgSr6vbl
         y7n+jKup0KINe90k/8jQbFCTIYZ8n8S1EAaU+NA39AOD/jhFAlGv6djW05TrTFihxskW
         84mA==
X-Gm-Message-State: AEkoous8FL9M/4NELNOOlCCod5BgPtosD0tRY5hV7akVRadt7F7HYF7VZEFbEmu9uYxU1ArL
X-Received: by 10.67.3.164 with SMTP id bx4mr121311794pad.9.1470257061232;
        Wed, 03 Aug 2016 13:44:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f855:e892:92e2:7149])
        by smtp.gmail.com with ESMTPSA id 191sm14701889pfx.68.2016.08.03.13.44.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 13:44:20 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, apenwarr@gmail.com,
	jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 {6,7}/7] submodule update: allow '.' for branch value
Date:	Wed,  3 Aug 2016 13:44:02 -0700
Message-Id: <20160803204404.3356-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.524.gdbd1860
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This replaces the last two commits of  sb/submodule-update-dot-branch.

Thanks Jeff for pointing out the possible segfault.
In the last commit I removed commented code in the test.

Thanks,
Stefan

diff to sb/submodule-update-dot-branch:
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ae88eff..f1acc4d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -906,6 +906,9 @@ static const char *remote_submodule_branch(const char *path)
        git_config(submodule_config, NULL);
 
        sub = submodule_from_path(null_sha1, path);
+       if (!sub)
+               return NULL;
+
        if (!sub->branch)
                return "master";
 
@@ -933,11 +936,16 @@ static const char *remote_submodule_branch(const char *path)
 static int resolve_remote_submodule_branch(int argc, const char **argv,
                const char *prefix)
 {
+       const char *ret;
        struct strbuf sb = STRBUF_INIT;
        if (argc != 2)
                die("submodule--helper remote-branch takes exactly one arguments, got %d", argc);
 
-       printf("%s", remote_submodule_branch(argv[1]));
+       ret = remote_submodule_branch(argv[1]);
+       if (!ret)
+               die("submodule %s doesn't exist", argv[1]);
+
+       printf("%s", ret);
        strbuf_release(&sb);
        return 0;
 }
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 1c4c1f2..d7983cf 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -238,7 +238,6 @@ test_expect_success 'submodule update --remote should fetch upstream changes wit
                test_cmp expect actual &&
                git checkout master &&
                git branch -d test-branch &&
-               #~ git -C ../submodule branch -d test-branch &&
                git reset --hard HEAD^
        )
 '

Stefan Beller (2):
  submodule--helper: add remote-branch helper
  submodule update: allow '.' for branch value

 builtin/submodule--helper.c | 54 ++++++++++++++++++++++++++++++++++++++++++++-
 git-submodule.sh            |  2 +-
 t/t7406-submodule-update.sh | 35 ++++++++++++++++++++++++++++-
 3 files changed, 88 insertions(+), 3 deletions(-)

-- 
2.9.2.524.gdbd1860

