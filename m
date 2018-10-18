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
	by dcvr.yhbt.net (Postfix) with ESMTP id D55791F453
	for <e@80x24.org>; Thu, 18 Oct 2018 07:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeJRP2f (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 11:28:35 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:60346
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726323AbeJRP2e (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Oct 2018 11:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1539847734;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=qHOAeeraypiH5GJbyi/PWxoubnajRBErQEHhE481sb0=;
        b=LdozsS33fO1o50I4tDRHQzmCE8FnDvVl7EFt/bwrACrji3WIjwCoQyX+XGNKWCXa
        vZqjhVrCeDTfGO5WqB7SO6BfloIKmDzKCCnrlLHWlgGgCtW2Nqbx87VE2I+ixd8OPMF
        elBr5+wU9OeAqc0ce2RILok4pPzHGNStHBGIXlVk=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <010201668613c46c-c42176a8-e4b9-4f31-a384-3ed9848377ef-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201668613c3de-23d41696-1476-4949-9834-a31adeb0650e-000000@eu-west-1.amazonses.com>
References: <010201668613c3de-23d41696-1476-4949-9834-a31adeb0650e-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 2/3] ls-remote: release memory instead of UNLEAK
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 18 Oct 2018 07:28:54 +0000
X-SES-Outgoing: 2018.10.18-54.240.7.12
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
