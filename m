Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F3D11F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 08:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeJIPeH (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 11:34:07 -0400
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:38058
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbeJIPeH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Oct 2018 11:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1539073102;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=qHOAeeraypiH5GJbyi/PWxoubnajRBErQEHhE481sb0=;
        b=XztGvpM/+yDBq8I2t9scy7ldrFSYEOgUHL4CRyjyrIr0e3HxxJBnxiDgrah6IEFV
        LECktXw/O5Xy3kQnYSjw06R+t0lhC/HdDD/Jxry0Oumz5cNC0FC8zFWjNME7mm+Tdfd
        H5eweGbXsBNe5QnnCrc1HNZkyOF2veiReuqcVwfI=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016657e7d068-16e15ab5-335e-4a2a-8bbb-bf2242514ad2-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016657e7cfee-f1343b1e-9a85-4cae-990a-cc7177ea8487-000000@eu-west-1.amazonses.com>
References: <0102016657e7cfee-f1343b1e-9a85-4cae-990a-cc7177ea8487-000000@eu-west-1.amazonses.com>
Subject: [PATCH 2/3] ls-remote: release memory instead of UNLEAK
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 9 Oct 2018 08:18:21 +0000
X-SES-Outgoing: 2018.10.09-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use ref_array_clear() to release memory instead of UNLEAK macros.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 builtin/ls-remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 1a25df7ee15b4..6a0cdec30d2d7 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -151,6 +151,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	}
 
 	UNLEAK(sorting);
-	UNLEAK(ref_array);
+	ref_array_clear(&ref_array);
 	return status;
 }

--
https://github.com/git/git/pull/538
