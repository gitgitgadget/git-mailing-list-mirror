Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B123C20248
	for <e@80x24.org>; Tue, 26 Feb 2019 05:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfBZFSZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 00:18:25 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32973 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfBZFSX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 00:18:23 -0500
Received: by mail-qt1-f196.google.com with SMTP id z39so13558283qtz.0
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 21:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wfOGdJUiZvT2aoDcuRaI476AOwB+2at0V1yPERfuFEk=;
        b=ptOKQ+a4VXlwd1txG2XWM/h7mxp9Ojbdxza6/7H+m0CYSlioejbA1OdDlR8ILonhno
         7IMgbPgHJEvfw5NkGBWg2cAl+1Ni/SvwUiLpXcUWepnGsXQkGhpVbNRrfXtf+o2ECKAk
         O98rjEyX8LY7R4NZLbcl0R5F6yucKF7FCHH8jqo/KbRYyGLYYdaQiCQMUhwEinWFktud
         ur0TRtIkQ/rY51LklTu9BTe3wKprOfe4iaoIgzq6ghFUD8dj2MlBIEsCgtx9Rl6/7Pe3
         MxGzeaj5MOimtczvKWxvfAQfA9lqmOGz4FSNizbiMjEquSqlUOUwX50tStQZqPlTsbKz
         cuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wfOGdJUiZvT2aoDcuRaI476AOwB+2at0V1yPERfuFEk=;
        b=HNFATKzJ6WwZFfq9gaAij7s61j5ghZAkYMRw5oIAM07C0HtxOPmc5LdwWxYBz+1eFW
         /rw7PWV+nrH53rs3GAkNGE81y6s2N8JNPbXCKyzlgfkvDx+K8ITUmAI8LLEjnRjqbbp2
         z1WRADNLFFIOyNGmV2s29/PyrLKbdo9ZdcoYju6DFkE3SPWRvOCJLHWasuM+/mjgSJ88
         Pi5TB8weL3O7zWpCIrMYuBuJchYwj15H4zkwQrOy2xe7Ys1CERIgREUFs98XX2RqiNkf
         o1eHN2KzCKxfPCXMUwgTNBR5WBkh6r1CGQfyMq6JswTYmS+BHdWvAxslhPPuqTw2PkkL
         FilA==
X-Gm-Message-State: AHQUAub2AL5l+lc81Pk45c9IGQbnC0Xlq8KBvXaiuwXAeaEYl51LcWW7
        Lt4dz4nNzM3pd16xcGXlgC4mTYt4EO8=
X-Google-Smtp-Source: AHgI3Ib4Hc3/SnzyiGqWC3lJQ8xvdonY4n5K7FJPhfE4odWnGkklL1J76QxFVMqguCFWzBwK5iWtaw==
X-Received: by 2002:aed:3aaa:: with SMTP id o39mr16882737qte.109.1551158302059;
        Mon, 25 Feb 2019 21:18:22 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id k39sm7698738qtb.37.2019.02.25.21.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 21:18:21 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [WIP RFC PATCH v2 3/5] clone: copy hidden paths at local clone
Date:   Tue, 26 Feb 2019 02:18:02 -0300
Message-Id: <20190226051804.10631-4-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226051804.10631-1-matheus.bernardino@usp.br>
References: <20190226051804.10631-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the copy_or_link_directory function no longer skip hidden paths.
This function, used to copy .git/objects, currently skips all hidden
directories but not hidden files, which is an odd behaviour. The reason
for that could be unintentional: probably the intention was to skip '.'
and '..' only but it ended up accidentally skipping all directories
starting with '.'. Besides being more natural, the new behaviour is more
permissive to the user.

Also adjusted tests to reflect this change.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/clone.c            | 2 +-
 t/t5604-clone-reference.sh | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..cae069f03b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -428,7 +428,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 			continue;
 		}
 		if (S_ISDIR(buf.st_mode)) {
-			if (de->d_name[0] != '.')
+			if (!is_dot_or_dotdot(de->d_name))
 				copy_or_link_directory(src, dest,
 						       src_repo, src_baselen);
 			continue;
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 6f9c77049e..f1a8e74c44 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -262,16 +262,25 @@ test_expect_success SHA1,SYMLINKS 'clone repo with manually symlinked objects/*'
 	test_cmp expected actual &&
 	find S-* -name "*some*" | sort >actual &&
 	cat >expected <<-EOF &&
+	S--dissociate/.git/objects/.some-hidden-dir
+	S--dissociate/.git/objects/.some-hidden-dir/.some-dot-file
+	S--dissociate/.git/objects/.some-hidden-dir/some-file
 	S--dissociate/.git/objects/.some-hidden-file
 	S--dissociate/.git/objects/some-dir
 	S--dissociate/.git/objects/some-dir/.some-dot-file
 	S--dissociate/.git/objects/some-dir/some-file
 	S--dissociate/.git/objects/some-file
+	S--local/.git/objects/.some-hidden-dir
+	S--local/.git/objects/.some-hidden-dir/.some-dot-file
+	S--local/.git/objects/.some-hidden-dir/some-file
 	S--local/.git/objects/.some-hidden-file
 	S--local/.git/objects/some-dir
 	S--local/.git/objects/some-dir/.some-dot-file
 	S--local/.git/objects/some-dir/some-file
 	S--local/.git/objects/some-file
+	S--no-hardlinks/.git/objects/.some-hidden-dir
+	S--no-hardlinks/.git/objects/.some-hidden-dir/.some-dot-file
+	S--no-hardlinks/.git/objects/.some-hidden-dir/some-file
 	S--no-hardlinks/.git/objects/.some-hidden-file
 	S--no-hardlinks/.git/objects/some-dir
 	S--no-hardlinks/.git/objects/some-dir/.some-dot-file
-- 
2.20.1

