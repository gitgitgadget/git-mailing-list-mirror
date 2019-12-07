Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F58AC43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AF1205F4
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Puff+zLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfLGRrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 12:47:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47067 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfLGRrs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 12:47:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so11228288wrl.13
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 09:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z5bbmaVjWTEBlGwbALe96MP/a+9xy4gA1x7Nw3wmnbY=;
        b=Puff+zLLNJADWGfkNzX7flizrxMusHzlWv8UksvmTv3oWfFiv0ndvYBWZGqSG90a0M
         ToKZOFxYyYiUtic5NAexYRMHD5czVHd7myfLjbGP3gTrL5wgUG9V2njaG6StHkFbfIiL
         GQoGIUZTWP5HwZiL9u9b/vzg0MV6DnsOrLYoGDkp3lbFuS5ml6ZYfBWiguHquFujZDWo
         2QP16HpnfZzW4oD6cjLA54O+9s+n78xyuOQ9tKRCJkhhmQgaMuEaAfm9sKVdcBWIaPk5
         dCDE0mzv59pOAeJcH6DXm0oF6W8Nth69aTEKtHYXvPGzifL2++Scn3mNbBkhpxQPk9DD
         4Dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z5bbmaVjWTEBlGwbALe96MP/a+9xy4gA1x7Nw3wmnbY=;
        b=P/5k1pa3ebMVi73W5zoFSDRUwwQsi9ZJ1EGIWVIDsFeGIJBSeFSc/ThKk2YiASdIAK
         0uydDXVIO3Pcp1oNXvC0HqExU6SdEkBDQ2nE/8vnEkh6RdPvY6ewp54NfWIkWYtC0w0h
         DnBC5VOYGFJXbKZCBKHIpB0VfPKIB2WQiHfzlxiLkRqXW1cgEdfZVbTdr/A4gQTu/WXd
         sCQtHHjFnDwuxQS6s19+XXXPQvOTOeiFt9c47M8BujwPckzbLhaXxsiQiVeDM1Z+1d4w
         XFZI2Slt94kZ8ne88W4nm7hArTpCX4KxL1TsLpkN2zlUI/S5GDkRMvxonGjQwgPzw7Nq
         AvnQ==
X-Gm-Message-State: APjAAAVBZuKLW+ftwBJIo1yYgoEF/S/rJ51iyN2h8WqDPvhp15QMtW1g
        d1tA5Vtp2zuiJzNaFAucPFulFsJ6
X-Google-Smtp-Source: APXvYqzgv70K6eWJTyVIJcYCj04/R3bKVVZBZbtbXnYcRcHNHauIKUMbcLCJi7qbsrDHKSgmMpGhWA==
X-Received: by 2002:adf:e887:: with SMTP id d7mr21174827wrm.162.1575740866121;
        Sat, 07 Dec 2019 09:47:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l17sm7485357wme.45.2019.12.07.09.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 09:47:45 -0800 (PST)
Message-Id: <bb7f8f0a0aeba323a8cfa0d4012acf91b53394a0.1575740863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
From:   "Jeff King via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Dec 2019 17:47:29 +0000
Subject: [PATCH v5 01/15] t/gitweb-lib.sh: drop confusing quotes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Some variables assignments in gitweb_run() look like this:

  FOO=""$1""

The extra quotes aren't doing anything. Each set opens and closes an
empty string, and $1 is actually outside of any double-quotes (which is
OK, because variable assignment does not do whitespace splitting on the
expanded value).

Let's drop them, as they're simply confusing.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/gitweb-lib.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 1f32ca66ea..b8455d1182 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -60,7 +60,10 @@ gitweb_run () {
 	REQUEST_METHOD='GET'
 	QUERY_STRING=$1
 	PATH_INFO=$2
+<<<<<<< HEAD
 	REQUEST_URI=/gitweb.cgi$PATH_INFO
+=======
+>>>>>>> t/gitweb-lib.sh: drop confusing quotes
 	export GATEWAY_INTERFACE HTTP_ACCEPT REQUEST_METHOD \
 		QUERY_STRING PATH_INFO REQUEST_URI
 
-- 
gitgitgadget

