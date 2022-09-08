Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21F5C6FA83
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 04:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiIHEvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 00:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIHEvr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 00:51:47 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16866DAF0
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 21:51:45 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso845364wmr.3
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 21:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date;
        bh=caL0yHeH6d4BVbQ5+Jgh7A4CZJcb5PxvKjI2j7mdQQs=;
        b=lhSwH0PXPLcqJeE2re8FDMOrfs9rWgZmYlxz4dSGLTNxDh3qh5HKhl/WfNoLzuTLdg
         yVGL7FR/BTRkR7wVxONNEeCS9fCAqC0V7DKElNmRSXoZmFRuM4aTb7Sbmbr6EC/Qy3O5
         rTbIOOuvF4JnMRgkjJ6kKTnG2KE1KOgYdn18+VNrplTaIXXCn5sGJQqKDh6u2+brDvqN
         rfFFpdFH3tC+dq7mFt4TcOE4qNoO27ZyA8SW674iOK2oKnrMUfcpSOq3AK/AcAxXC5Yu
         1zKxE1uM8BfScu231bjVVcKE/uJoRt3HfoZZVu+5V1OgzdYw3cA2ho78yUi7a147HlkO
         9PZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=caL0yHeH6d4BVbQ5+Jgh7A4CZJcb5PxvKjI2j7mdQQs=;
        b=aKBZYoelu3LLb8WmKcPGy+zQfdBpo55eNhPyk1uKo3sm71HYyR0Btup6VPqf7sbzQR
         MmMMXJxcOI6T0XZPxWZ+kUlUzwLhWXrRg5X9nIE9U/vjjMaZFP7F7FITBQgxchKx9/bR
         iDko7aKivwkspHs8L4PisJjaEk5ZS7L3m0z7ny/8qOym89ZvVU1icdXhy1AVwgGgxF6F
         jhtF4D+0FOSyXFsZixHVKrf9993hLEIlEIVCR0kReTVAq7xRFO/2ekaLeAgTcRZNqVf3
         Rbq8wqZdPviPHSrtuh0mezHmpp/0mlqktx0OX3tV4Rm7bsQLVMzh523RoQDI2Ql2RpK4
         wP+A==
X-Gm-Message-State: ACgBeo3aIf6EpFFMd1OhSYIjbGbW0GUyTwKe5DCyoVopmw+aFg8dnHnV
        AosIzhSd2o7aAdNQVop7fpqRfUkc3zg=
X-Google-Smtp-Source: AA6agR7bFJLD/hcNFtlvdgnWCQ4IiHJlA7OfbNU3RDjXCSuU4oPBXs68k39CkeJWtE/6hIonwspF/A==
X-Received: by 2002:a05:600c:4e92:b0:3a5:fd90:24e3 with SMTP id f18-20020a05600c4e9200b003a5fd9024e3mr885321wmq.59.1662612704440;
        Wed, 07 Sep 2022 21:51:44 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id e28-20020a5d595c000000b0021e13efa17esm19752526wri.70.2022.09.07.21.51.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 21:51:44 -0700 (PDT)
Subject: [PATCH v3 1/2] branch: refactor "edit_description" code path
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     git@vger.kernel.org
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
 <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
Message-ID: <67253834-8bfa-c249-6594-6418d6ae6805@gmail.com>
Date:   Thu, 8 Sep 2022 06:51:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Minor refactoring to reduce the number of returns in the switch case
handling the "edit_description" option, so the calls to strbuf_release
can also be reduced.  New resources to be added also do not need to be
released in multiple places.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 55cd9a6e99..b1f6519cd9 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -791,6 +791,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	} else if (edit_description) {
 		const char *branch_name;
 		struct strbuf branch_ref = STRBUF_INIT;
+		int ret = 0;
 
 		if (!argc) {
 			if (filter.detached)
@@ -803,19 +804,17 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
 		if (!ref_exists(branch_ref.buf)) {
-			strbuf_release(&branch_ref);
-
 			if (!argc)
-				return error(_("No commit on branch '%s' yet."),
+				ret = error(_("No commit on branch '%s' yet."),
 					     branch_name);
 			else
-				return error(_("No branch named '%s'."),
+				ret = error(_("No branch named '%s'."),
 					     branch_name);
-		}
-		strbuf_release(&branch_ref);
+		} else if (edit_branch_description(branch_name))
+			ret = 1;
 
-		if (edit_branch_description(branch_name))
-			return 1;
+		strbuf_release(&branch_ref);
+		return ret;
 	} else if (copy) {
 		if (!argc)
 			die(_("branch name required"));
-- 
2.36.1
