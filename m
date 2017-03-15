Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB95E202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 13:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753452AbdCONPR (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 09:15:17 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53415 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753400AbdCONPO (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Mar 2017 09:15:14 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 54B2E20596;
        Wed, 15 Mar 2017 09:15:13 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 15 Mar 2017 09:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
        date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=74X
        qPffU+uXfLSf4Pq+gCcbQ2ds=; b=J7CXl9MGeH4bI4ZcX5eObsF7WazbyycLRzw
        9LJhHH0N3iAmqcPiRcrfYNLTQFyGbBDWWkm9iGDR2vpfR5N/PDAvySkG2oSqz1Bs
        CdNbQ3nybTQMvdDrgH6H23HyfUR9EfP+6QmccrDGmwfpdfv7IacTkUrKQug2xXmb
        PdoXKSQM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc
        :x-sasl-enc; s=smtpout; bh=74XqPffU+uXfLSf4Pq+gCcbQ2ds=; b=V7smG
        NBHoUcvl3uVbgQ5GPhYpHEo5bwOokmMH5oyE3b0uyHajCQSscLk5lUXsryFHDUvr
        q0wBvZOgAAia95F6tYcKRiePE14FlbOP8P3P314dnwEUdNmlf6Fwkn+e4NTdEnwU
        TscwU2xVIYbiOZ9998iWhmUImfTXACUbhTPLnI=
X-ME-Sender: <xms:YT7JWPRch3zx0Z9OTaQFZF1m0Ky0Oq4GP4DxpMci1vh36B0xKqwtRw>
X-Sasl-enc: 1j53AmcaO8lFHfxbx8+Thhe2rOEsVokOEfqdkOPkxBbd 1489583712
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id DFFAF24216;
        Wed, 15 Mar 2017 09:15:12 -0400 (EDT)
From:   Michael J Gruber <git@drmicha.warpmail.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] describe: debug is incompatible with contains
Date:   Wed, 15 Mar 2017 14:15:08 +0100
Message-Id: <d8477234d20fe3b4db43b23cc192c18af1ecdaff.1489581340.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.12.0.384.g157040b11f.dirty
In-Reply-To: <cover.1489581340.git.git@drmicha.warpmail.net>
References: <cover.1489581340.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git describe --contains` calls into `git name-rev` which does not have
any searching to do and thus does not display any debug information.

Say so in the documentation and catch the incompatible arguments.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-describe.txt | 2 +-
 builtin/describe.c             | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 8755f3af7b..0f9adb6e9a 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -69,7 +69,7 @@ OPTIONS
 --debug::
 	Verbosely display information about the searching strategy
 	being employed to standard error.  The tag name will still
-	be printed to standard out.
+	be printed to standard out. This is incompatible with --contains.
 
 --long::
 	Always output the long format (the tag, the number of commits
diff --git a/builtin/describe.c b/builtin/describe.c
index 76c18059bf..01a6d159a0 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -462,6 +462,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 
 	if (longformat && abbrev == 0)
 		die(_("--long is incompatible with --abbrev=0"));
+	if (contains && debug)
+		die(_("--debug is incompatible with --contains"));
 
 	if (contains) {
 		struct string_list_item *item;
-- 
2.12.0.384.g157040b11f.dirty

