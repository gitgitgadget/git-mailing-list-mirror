Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AC4249F5
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 22:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvveJ833"
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05917D51
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 14:26:03 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40906fc54fdso40817495e9.0
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 14:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699914361; x=1700519161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+4uS4hD+bdxkP46+UjPce6bPKLk5dOg+LsWplo8bKt4=;
        b=OvveJ833tjYD3qXhZQRYLjC3sg4avmgXntz1gyoX3asdx1/3KrV1GGmFzBe/0ZuEca
         uyOovfo6gNzvRUcRZFP7ifLWRzPqd81T1d8DDxMS5vzmClwH8z6s6TaEvloZSlzdKI8r
         TgGhFk1yKWO2+OkyAPM/B2+bfl++TNATZL2g8HpRv5goeX0H8B89TY/aQ6z9O8WU3UD0
         ve2ov7XxwPtsABPfZm8fxMzb6tfiTGLPwvboEhwph9gYsnZSpmNS72kW/0HTi0W8rXOq
         hdnzd1j7bxMBMO8jQ22yiDGRE5J6L4xP2Ue8okED/OjWgCd0FysaxxvS2o8lnUtr/dfc
         bwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699914361; x=1700519161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4uS4hD+bdxkP46+UjPce6bPKLk5dOg+LsWplo8bKt4=;
        b=LcHI3Kkye/Aa8zrAFlXGntEDRwdmxF24LChGjVBo5BA5BAkl31ZCsZSNSxuURXYI3H
         rb+TpfRH/8bG83j/5Nbahn9q8uELlU21PWqOR2MEc8j+29X2pqMK/9qohWkr1entjf2e
         vXP36LJvacRGuS3L4lVmPBPS+d1X6g29mLZZA9HVoB4GVKyl7JmPUSD9Fyg6mghu+m1q
         PtTyn8z983+kijPgOA3/XXyyjBVQ1oeZ7eGu9N2suNGrrJ8bIHbdrZqcLgMVonEh3dGW
         iVNIae1JnnZqb2mj0z+2+RBli0JFFFKkpPfa0Gkx6GHrHe9TbIng4xGkputIA5TAUCYj
         mxZw==
X-Gm-Message-State: AOJu0YzyrTtjARwXj1Ss+hsLs70BdOF+XqT6f37FeqE0SulLyZ3sGrDr
	qXD+HkaHMt4mH9g1QszYC3Zcd5hzsQs=
X-Google-Smtp-Source: AGHT+IE7Bx31GF9eiBuhBaNKIst7fvB4YOp4Oynb2QAvI2QNPahq462PyoWkNTvGe/6Cvz+eSCd2tw==
X-Received: by 2002:a05:600c:4689:b0:406:53f1:d629 with SMTP id p9-20020a05600c468900b0040653f1d629mr6193993wmo.5.1699914361048;
        Mon, 13 Nov 2023 14:26:01 -0800 (PST)
Received: from localhost (94-21-23-134.pool.digikabel.hu. [94.21.23.134])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c444500b003fefb94ccc9sm9274445wmn.11.2023.11.13.14.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 14:26:00 -0800 (PST)
From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] completion: add and use the __git_get_config_subsection helper function
Date: Mon, 13 Nov 2023 23:25:27 +0100
Message-ID: <20231113222528.62771-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.43.0.rc1.528.g8f9d60d041
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Our Bash completion script recently learned to complete configured
trailer key aliases for 'git config --trailer=<TAB>', but the helper
function extracting the key alias from 'git config's output, i.e. the
subsection from 'trailer.*.key', ended up more complex than necessary,
with considerable overhead from executing four external processes in a
pipe.

Replace those commands in the pipe with a simple shell loop using only
a pair of parameter expansions and a builtin 'echo', which is easier
to understand and should perform better (I assume that users don't
have that many subsections in any particular section to make the
processing with an external process (let alone four) worth it).

And while at it, let's extract this loop into a generic
__git_get_config_subsections() helper function, as it might be useful
elsewhere in the future as well (at the moment it isn't, AFAICT).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 14 +++++++++++++-
 t/t9902-completion.sh                  | 13 +++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 13a39ebd2e..34bbb66f85 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1148,6 +1148,18 @@ __git_get_config_variables ()
 	done
 }
 
+# Lists all subsections in the given section which contain the given
+# config variable, with the section and variable names removed.
+__git_get_config_subsections ()
+{
+	local section="$1" var="$2" i IFS=$'\n'
+	for i in $(__git config --name-only --get-regexp "^$section\..*\.$var$"); do
+		i=${i#$section.}
+		i=${i%.$var}
+		echo "$i"
+	done
+}
+
 __git_pretty_aliases ()
 {
 	__git_get_config_variables "pretty"
@@ -1681,7 +1693,7 @@ __git_untracked_file_modes="all no normal"
 
 __git_trailer_tokens ()
 {
-	__git config --name-only --get-regexp '^trailer\..*\.key$' | cut -d. -f 2- | rev | cut -d. -f2- | rev
+	__git_get_config_subsections trailer key
 }
 
 _git_commit ()
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index a7c3b4eb63..11ed83d0ed 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2130,6 +2130,19 @@ test_expect_success '__git_get_config_variables' '
 	test_cmp expect actual
 '
 
+test_expect_success '__git_get_config_subsections' '
+	cat >expect <<-\EOF &&
+	subsection-1
+	SubSection-2
+	sub.section.3
+	EOF
+	test_config interesting.subsection-1.name good &&
+	test_config Interesting.SubSection-2.Name good &&
+	test_config interesting.sub.section.3.name good &&
+	__git_get_config_subsections interesting name >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '__git_pretty_aliases' '
 	cat >expect <<-EOF &&
 	author
-- 
2.43.0.rc1.528.g8f9d60d041

