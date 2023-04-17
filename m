Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD67C77B78
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 19:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjDQTLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 15:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjDQTK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 15:10:56 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811197AA1
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 12:10:54 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id e8so9452031ljn.2
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 12:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681758652; x=1684350652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zs44uYEVyY0L3k41dMzAcWmuhbt5LVq3BistLup/0Kc=;
        b=Z/C7CGpSZBxVVEE62+qKWCzvsfxCOh3hkPwS67AOXOHb5umIefZ+EiZdfO4MWF+Yw8
         PvEBY96suM9npgW5AjimELYa8Ble9EJZPcDa+UY2txJsCltRjZM76nvHQl3zPAMTEPNS
         9Ei1t0XrwnPWcwi59GQv1kX7hfRycd9JtCWV/h4mwsha1wKtycOaGYLRMXqAKwh1cR2a
         GuPdCkvb0VRQlJ1EVcPTvLrlEzIqp7JTvirU/nDd7sbwMVto8JK+112YQ3yiYUcbz+gf
         GV3NR++IkWa3wsRwNeXYRL7ZJesipNJkTVs44e8bC/9wrtbuihXFy6bB2uTvYxzdFpR1
         mRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681758652; x=1684350652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zs44uYEVyY0L3k41dMzAcWmuhbt5LVq3BistLup/0Kc=;
        b=V5tcSeMKENvjunmWybPgPSpDoikFdjvS59shu15EUxdJkPk0Irbf+Ko4B/z0L4hwHC
         +LiAEeobTKTc6oUnQJ7omZzhbshwMsIApSaqClWYG8oEMDc6Y8Nk8/s35dPr9dFUHHQ+
         PHU+ZcOZdIXjQC+YZXQE1M9xhMicgc4Jd3V4lZOJxK4w9YW8qZfK4E2sHsoxXZL4TwCV
         rukpR7arTjONXK9FRpIQYwD3D5ywuXc/v1zHtUWB11L9nL4DOuvy4bRDC4Sg7UIu5dkm
         JpxLJcJLFzfYIqFFnow5vkeGkdoUZR/w4mBbKql6gNAmGLcCcO6PxqzwQwUAOxLBjeHZ
         7B9A==
X-Gm-Message-State: AAQBX9fuaP5lZ3wb7ta5OFz9+f4XOssE6rYqsSNbkggskJPAJWdD5blz
        xplNRuBFOMKIxOlS/MABw9tTctG64xIhRg==
X-Google-Smtp-Source: AKy350axlpI0w2zdfP9i8sonDMIg3MeuuTiDwYPx0HoRi+Nq6x2S5yIvlKOJ5Cu50IU1u1mcZC9qkQ==
X-Received: by 2002:a2e:380a:0:b0:2a8:ad87:279d with SMTP id f10-20020a2e380a000000b002a8ad87279dmr3021400lja.34.1681758652295;
        Mon, 17 Apr 2023 12:10:52 -0700 (PDT)
Received: from titov.fritz.box ([195.246.120.47])
        by smtp.gmail.com with ESMTPSA id x1-20020a2e9c81000000b002a76e600228sm2304319lji.47.2023.04.17.12.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:10:52 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/6] t1502: don't create unused files
Date:   Mon, 17 Apr 2023 21:10:43 +0200
Message-Id: <20230417191044.909094-6-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230417191044.909094-1-rybak.a.v@gmail.com>
References: <20230403223338.468025-1-rybak.a.v@gmail.com>
 <20230417191044.909094-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Three tests in file t1502-rev-parse-parseopt.sh use three redirections
with invocation of "git rev-parse --parseopt --".  All three tests
redirect standard output to file "out" and file "spec" to standard
input.  Two of the tests redirect standard output a second time to file
"actual", and the third test redirects standard error to file "err".
These tests check contents of files "actual" and "err", but don't use
the files named "out" for assertions.  The two tests that redirect to
standard output twice might also be confusing to the reader.

Don't redirect standard output of "git rev-parse" to file "out" in
t1502-rev-parse-parseopt.sh to avoid creating unnecessary files.

Acked-by: Øystein Walle <oystwa@gmail.com>
Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1502-rev-parse-parseopt.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index de1d48f3ba..dd811b7fb4 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -302,14 +302,14 @@ test_expect_success 'test --parseopt help output: "wrapped" options normal "or:"
 	|EOF
 	END_EXPECT
 
-	test_must_fail git rev-parse --parseopt -- -h >out <spec >actual &&
+	test_must_fail git rev-parse --parseopt -- -h <spec >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'test --parseopt invalid opt-spec' '
 	test_write_lines x -- "=, x" >spec &&
 	echo "fatal: missing opt-spec before option flags" >expect &&
-	test_must_fail git rev-parse --parseopt -- >out <spec 2>err &&
+	test_must_fail git rev-parse --parseopt -- <spec 2>err &&
 	test_cmp expect err
 '
 
@@ -339,7 +339,7 @@ test_expect_success 'test --parseopt help output: multi-line blurb after empty l
 	|EOF
 	END_EXPECT
 
-	test_must_fail git rev-parse --parseopt -- -h >out <spec >actual &&
+	test_must_fail git rev-parse --parseopt -- -h <spec >actual &&
 	test_cmp expect actual
 '
 
-- 
2.40.0

