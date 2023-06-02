Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01967C7EE2F
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 02:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjFBCcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 22:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbjFBCbz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 22:31:55 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6291192
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 19:31:53 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-555828f66deso1133370eaf.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 19:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685673113; x=1688265113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxPdBope8DlXyw5JfYNAgC59JcT1Npb5RFIa9R2U5UM=;
        b=S+uzhgcciJ7y2AKRuh2MRUKTRcZF6nE2QqwgaDOhyM4nILeoha8uj1buR5zE/+L/+z
         x6i8KHyBnVF2ExS8GNgfgLfweTz1QrMqjRY3zdUpPLhgiNVj39jH7TaDk696K7d2D1gt
         6j9fY/LWAK75g+iwKy+H1YGKLQhrggW+LNqfQ2ZX0Ro/C8QXlpYrGXhcAVSzVqAajumC
         Sb2LJL4Hic98cn2bfXDig0I50/0oZH6y5j0BgmpwEGIYYb7Gr/RlIonjvF4ets9LyuuD
         awnziO8+zfM4lGotLISo85ujCxNSGjmoZZ69FwL0UOPUDmqD/uX4Q5vE0WuzAuk0xe+R
         LHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685673113; x=1688265113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxPdBope8DlXyw5JfYNAgC59JcT1Npb5RFIa9R2U5UM=;
        b=R1FC9CYO5UeMKob08m2PGZqqqtMzWCH3Qqp8wGW3PTC/Kp+86sWvWYeDzeXA2ffAjQ
         zmiipU0xo2op/oB5lRe9BpR/ilqQauBgq/qItSxCa/w4A0FMnF58JpK84DPkmmv8s86M
         +HfX6Azs6pFJsAopSH8PCMxMusXYKOaGCbT4ut06HthIGfMnc+xvl5y2S2akhcjTBXu+
         15X/LuteWEWN2/0B6q9Ernu+nDtF30USSoO8TlfyeGKtmm4i0CNUsd5EBzllbCLzgu9u
         lm1cPwaM0UopVOq21VWPW/Z8rqXVC0y921eisxm8oEJ9Y4fI2q8Eserm6rfcGw7u2SXO
         2kig==
X-Gm-Message-State: AC+VfDyN4vw3JBdEgkrXJUtMRKRVAJVKMmoXVt0f6H0MWeosKdl5QfMu
        ELDh3llEfvw5EW3WcmZbFmkjegK81VsZ94er
X-Google-Smtp-Source: ACHHUZ4mf9V1dGuKi2szb+J8klfEomhfced9Q3Yf43p5RrWRzEpO3zIhwlPcqEG/iykY1Yzy68NzfA==
X-Received: by 2002:a05:6808:110:b0:399:6025:e285 with SMTP id b16-20020a056808011000b003996025e285mr1104487oie.15.1685673112700;
        Thu, 01 Jun 2023 19:31:52 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.144.109])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b001b0395c4002sm71251plg.210.2023.06.01.19.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 19:31:52 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Kousik Sanagavarapu <five231003@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: [PATCH v2 1/2] t/lib-gpg: introduce new prereq GPG2
Date:   Fri,  2 Jun 2023 07:41:54 +0530
Message-ID: <20230602023105.17979-2-five231003@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230602023105.17979-1-five231003@gmail.com>
References: <20230529192209.17747-1-five231003@gmail.com>
 <20230602023105.17979-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GnuPG v2.0.0 released in 2006, which according to its release notes

	https://gnupg.org/download/release_notes.html

is the "First stable version of GnuPG integrating OpenPGP and S/MIME".

Use this version or it's successors for tests that will fail for
versions less than v2.0.0 because of the difference in the output on
stderr between the versions (v2.* vs v0.* or v2.* vs v1.*). Skip if
the GPG version detected is less than v2.0.0.

Do not, however, remove the existing prereq GPG yet since a lot of tests
still work with the prereq GPG (that is even with versions v0.* or v1.*)
and some systems still use these versions.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 t/lib-gpg.sh             | 21 +++++++++++++++++++++
 t/t7510-signed-commit.sh |  7 +++++++
 2 files changed, 28 insertions(+)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 114785586a..aba8f861ed 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -51,6 +51,27 @@ test_lazy_prereq GPG '
 	esac
 '
 
+test_lazy_prereq GPG2 '
+	gpg_version=$(gpg --version 2>&1)
+	test $? != 127 || exit 1
+
+	case "$gpg_version" in
+	"gpg (GnuPG) 0."* | "gpg (GnuPG) 1.*")
+		say "This test requires a GPG version >= v2.0.0"
+		exit 1
+		;;
+	*)
+		(gpgconf --kill all || : ) &&
+		gpg --homedir "${GNUPGHOME}" --import \
+			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
+		gpg --homedir "${GNUPGHOME}" --import-ownertrust \
+			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
+		gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null \
+			--sign -u committer@example.com
+		;;
+	esac
+'
+
 test_lazy_prereq GPGSM '
 	test_have_prereq GPG &&
 	# Available key info:
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index ccbc416402..0d2dd29fe6 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -218,6 +218,13 @@ test_expect_success GPG 'amending already signed commit' '
 	! grep "BAD signature from" actual
 '
 
+test_expect_success GPG2 'bare signature' '
+	git verify-commit fifth-signed 2>expect &&
+	echo >>expect &&
+	git log -1 --format="%GG" fifth-signed >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success GPG 'show good signature with custom format' '
 	cat >expect <<-\EOF &&
 	G
-- 
2.41.0

