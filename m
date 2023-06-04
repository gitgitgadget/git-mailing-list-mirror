Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E17AC7EE23
	for <git@archiver.kernel.org>; Sun,  4 Jun 2023 18:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjFDS7D (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jun 2023 14:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjFDS67 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2023 14:58:59 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4271DD2
        for <git@vger.kernel.org>; Sun,  4 Jun 2023 11:58:58 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-565eb83efe4so52147407b3.0
        for <git@vger.kernel.org>; Sun, 04 Jun 2023 11:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685905137; x=1688497137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLBYpuXIdAo1XdqJJ0cUkU/XOLZqaE4M5xpXHQDvBOE=;
        b=lusdoQTXAULxV9yVu1cyhxyiCZEjfGd7g5zkHFOjUXvYJYCEpQaXBFr9TVKWT7lWPy
         GkvlV4ThTUfy5mEEY3K5Yoc5JI/f+yoOwOg6hrMz02gC7jQFfrUy8XJ17HEuQFWBZ3iX
         +0AH9wJ57VDv6Rj1+zvmrmisNPo/icIb4og9AEapmz+PRF34GOaPnfjL7r3trXG5ECAq
         zOKlHWwkdunkmh/VcpPcsk33VX8MjmPsdzyHVCEe2fBan+IxQLkEWptolQZT/Il+g2Xn
         D12/Oy7oEbGj1245SgOUW79jbcD3SMVtMK8pdHZLCIyPpAeI4RCX7o38ow+cFPyOQG+E
         UOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685905137; x=1688497137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLBYpuXIdAo1XdqJJ0cUkU/XOLZqaE4M5xpXHQDvBOE=;
        b=EbIW7fT2N8bGItr5U9Pdei6Fuu9UUaIAdqjRWzU9yd+FhPaS1LRJ7/l7p+Q7LZtREM
         D/nzm6eUuh9RtdEYiRFSKBf2f20f1YVszixdfu4pI8sejeLe96xOnfUkExeBAUlGygRC
         aMc9cm4MvLJA/5ODKdPSi1iKtvH3gATLN00UN3m34WdMKV+57oWn3KJF9x6JgQ2ery/L
         KS8P4d7rMzXivGI1qF0IaUfY+T30o0cPFNEtbITS5aUFLbcAvGNJw/HjhUbTIs+XyGXS
         ajvGVGHJkiX/bt8e+zjNF4714oIgA6JaRA+hk4qqUYzLcsLA7ocpdY7sOWqCs+oTy60j
         obXQ==
X-Gm-Message-State: AC+VfDwXENsLxWhdYozpFZ6205oNGj+eOPjOIbiUXyYo6A0a/BrvZ4hP
        bsFV8hnpOtLmZCIh8wjsj/Db7ZME8seZFdT3
X-Google-Smtp-Source: ACHHUZ6vxnIERxv8TgXtHRt4/Kpj4NgqgXEsJXHaTCtnP0ksUMJctqCITiLZE3NjQ+urLUs6lYNSeg==
X-Received: by 2002:a0d:d954:0:b0:561:b7bb:9cc with SMTP id b81-20020a0dd954000000b00561b7bb09ccmr9630328ywe.16.1685905137164;
        Sun, 04 Jun 2023 11:58:57 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.151.19])
        by smtp.gmail.com with ESMTPSA id mh12-20020a17090b4acc00b00256a4657519sm4495805pjb.15.2023.06.04.11.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 11:58:56 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: [PATCH v3 1/2] t/lib-gpg: introduce new prereq GPG2
Date:   Sun,  4 Jun 2023 23:52:46 +0530
Message-ID: <20230604185815.15761-2-five231003@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230604185815.15761-1-five231003@gmail.com>
References: <20230602023105.17979-1-five231003@gmail.com>
 <20230604185815.15761-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GnuPG v2.0.0 released in 2006, which according to its release notes

	https://gnupg.org/download/release_notes.html

is the "First stable version of GnuPG integrating OpenPGP and S/MIME".

Use this version or its successors for tests that will fail for
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
index 114785586a..d219a09362 100644
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
+	"gpg (GnuPG) "[01].*)
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

