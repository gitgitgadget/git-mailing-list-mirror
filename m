Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBB7C33CA2
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03E72075A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNA8aPtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgAGExf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:53:35 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43483 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbgAGExe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 23:53:34 -0500
Received: by mail-qk1-f193.google.com with SMTP id t129so41604816qke.10
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 20:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Td/HO+1GEy+nHul/PamMoe9ZN3pML0c3MFJoApdqXgA=;
        b=QNA8aPtcNOqPR2Ej1Iewv8vvvFNVS2dRui6o6eBBaB3Le28I8BgmTr9ln2NTyXtbza
         a/3ASaOnKehgCaKG6iY7gbs4M67uKGI1hnu0oxwUgENLS00QfGhdO83XnheY1LnDCMuC
         +DZ3GGHQ77n6wUcKNBEvDwPup7TvNfpJB6S3GbSUNg+p9HwyuQeLu/Zf+n+RdIzpAJyo
         dPt0aLvReIN4FqdsneXmbsgR/yW6mJzcZHDNH+eJ46Dbjjleld80J0Aq7PeWeUA/Apd4
         Y1LgpESqIPg65qVlyvngLVOyP/fMYQ5O7mggvaoLxO0YxtciRknCrOMJxcIi1OwuJqTI
         xYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Td/HO+1GEy+nHul/PamMoe9ZN3pML0c3MFJoApdqXgA=;
        b=ioGfpUMOL3YDa0FEKNDkyl48Wrmx/nu+cfSlAN6y6urOTk/5S65FVVbVq0fWTemzxZ
         h/QuXKQG7nlKKACiVFZgTzLheKCYWfRcvVbRK6FJQTUDoK05r9zmXl7RSKZN+5h0Eo9I
         npIZ4p08bLzdC+ylXXg8QuAOMNG9BRVv3X+3ezU8IfI1FOTgRktIaAg5xDVfDheW46iD
         ArkGM/2GaaLmf1cLAWgVaR+C1EGei6/2oa4EADnV9+JXTxQqK9Gdk+KOXdVUG++7PFHP
         66QmYrfkzms0HvIG7qRsDoiD6893PQzvQ1fUHu/k1/eRXuc0KYcEjWftnJHcpyWSgL8/
         MMiQ==
X-Gm-Message-State: APjAAAVO5hLbwh4kRRF1pZeZB1zlV4KkBeFiZ1UKACv1RqJfgz8Gcw69
        S3aXr1LGAZ91mHFxeIW5hFDYgWf6
X-Google-Smtp-Source: APXvYqxzw5qJQ6siVhQ/hwjo5EGywaVsoJ2/1BzzwNr5UdC9GwlK3cKmMnPL2hkf4462DXcsZxzNxw==
X-Received: by 2002:a37:c449:: with SMTP id h9mr83322897qkm.124.1578372813248;
        Mon, 06 Jan 2020 20:53:33 -0800 (PST)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id t2sm21663893qkc.31.2020.01.06.20.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 20:53:32 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/16] t2018: replace "sha" with "oid"
Date:   Mon,  6 Jan 2020 23:53:04 -0500
Message-Id: <71f84811c73174f3e8f85ca173dc65b37b698ad2.1578372682.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.180.g49a268d3eb
In-Reply-To: <cover.1578372682.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com> <cover.1578372682.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of the effort to become more hash-agnostic, replace all
instances of "sha" with "oid".

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t2018-checkout-branch.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index caf43571b1..bbca7ef8da 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -4,12 +4,12 @@ test_description='checkout'
 
 . ./test-lib.sh
 
-# Arguments: [!] <branch> <sha> [<checkout options>]
+# Arguments: [!] <branch> <oid> [<checkout options>]
 #
 # Runs "git checkout" to switch to <branch>, testing that
 #
 #   1) we are on the specified branch, <branch>;
-#   2) HEAD is <sha>; if <sha> is not specified, the old HEAD is used.
+#   2) HEAD is <oid>; if <oid> is not specified, the old HEAD is used.
 #
 # If <checkout options> is not specified, "git checkout" is run with -b.
 #
@@ -25,8 +25,8 @@ do_checkout () {
 	exp_branch=$1 &&
 	exp_ref="refs/heads/$exp_branch" &&
 
-	# if <sha> is not specified, use HEAD.
-	exp_sha=${2:-$(git rev-parse --verify HEAD)} &&
+	# if <oid> is not specified, use HEAD.
+	exp_oid=${2:-$(git rev-parse --verify HEAD)} &&
 
 	# default options for git checkout: -b
 	if test -z "$3"
@@ -38,15 +38,15 @@ do_checkout () {
 
 	if test -n "$should_fail"
 	then
-		test_must_fail git checkout $opts $exp_branch $exp_sha
+		test_must_fail git checkout $opts $exp_branch $exp_oid
 	else
-		git checkout $opts $exp_branch $exp_sha &&
+		git checkout $opts $exp_branch $exp_oid &&
 		echo "$exp_ref" >ref.expect &&
 		git rev-parse --symbolic-full-name HEAD >ref.actual &&
 		test_cmp ref.expect ref.actual &&
-		echo "$exp_sha" >sha.expect &&
-		git rev-parse --verify HEAD >sha.actual &&
-		test_cmp sha.expect sha.actual
+		echo "$exp_oid" >oid.expect &&
+		git rev-parse --verify HEAD >oid.actual &&
+		test_cmp oid.expect oid.actual
 	fi
 }
 
-- 
2.25.0.rc1.180.g49a268d3eb

