Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28562C38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 20:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIHU5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 16:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIHU5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 16:57:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FD7F10D3
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 13:57:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d2so11156972wrn.1
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 13:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:cc:references:to:from:subject:from:to:cc
         :subject:date;
        bh=TyNbI6kN/6x+3DW5gvS+GyPW1RBF/LvUyQdpdoxWnRc=;
        b=ByFO6PahCEm5B6wq81OVHz5zf0VKyPBNCUGWXbulnkcR7UJlXXLyMBGOB1Nq0bG7pt
         yOvRKbVcqHHP4XR8BiLusElfCweaNAE1KhzBRxcW+1Y+RCm9U3/7P4w2cVrrE9CP9OSB
         1yyC/8d9bG5EhYPcm7GlzU6LTZGkjo8R6G9Htm2VpFLjC7HVWYCzE9SrEdhO+rqbgHmP
         tc6250iShD70x8hQ7aTvEZPz8bFSDu2rVvfMatn26ypymqBzz1GFb5HqNdaBI7SOAkHu
         bh+gx4Nv68Ul0wSs0c2PwoaTKFP0AN6BqpL/oNxWBDduYEaYT8YG4LVOKtxFdTlzno2n
         Urdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:cc:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TyNbI6kN/6x+3DW5gvS+GyPW1RBF/LvUyQdpdoxWnRc=;
        b=bwCW2LdtQQrl5k5FXbxsPn7AT63oBS3dvRKayItVclGXI4jOlpGU8LbuxDQf71X2eI
         zN9825XjuM69BaqZlned/5IXJ+H7kimirkvrsj4B+Js6fl8a6cuDFLYYYXsiJyHaxqE1
         vlStMKmTYSBucwxRd6rlc/eFVeC5lJ4OsYcou/R0b+28GDJpXV5KlPsqtNsLASZufn2n
         S0DYgXd5iu9xrKWZpjHjZnVMXf+5eM+QHxsUwCWjfey44W2Qntq6j7MwDhbOSntVGxvK
         djU1JxCIFVHNyEox9GXn6HB8BExQRN9pG0/oJk23ACJeoQBKEXGEmxGx9EKBS1X9+1CW
         0u6Q==
X-Gm-Message-State: ACgBeo2fYBIhSWg/utJwbeOjTRv2kcamOznqUCTd7c6+uJ7rrnz/fu0i
        ddYsei/WrGXkrwYoSJndtZ40v/AWLEc=
X-Google-Smtp-Source: AA6agR5qmcGHMQS47bdfocf5yMSu334mWMwTrUMaM2cmrePhJDTaQTfyGFxLWFwUrOFENfRlJd3IRQ==
X-Received: by 2002:adf:dd0e:0:b0:226:df82:dd5d with SMTP id a14-20020adfdd0e000000b00226df82dd5dmr6419282wrm.672.1662670634021;
        Thu, 08 Sep 2022 13:57:14 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id b9-20020adff249000000b002238ea5750csm135728wrp.72.2022.09.08.13.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 13:57:13 -0700 (PDT)
Subject: [PATCH] branch: error codes for "edit_description"
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
 <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
 <67253834-8bfa-c249-6594-6418d6ae6805@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <de06f80c-4778-7e43-3a88-d7aeae788e0d@gmail.com>
Date:   Thu, 8 Sep 2022 22:57:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <67253834-8bfa-c249-6594-6418d6ae6805@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stick to the convention of exit with 1 on error.  May break some
third party tool that expects -1 on "No branch named 'bla'" or
"No commit on branch 'bla' yet." errors.

Test added to avoid regresion on this behaviour.
---

Junio, here is the patch for the change you suggested [1].  My concern is
this might break some third party tool or script.  If no one thinks this
is an issue, I can squash it with the patch I'm responding to.


[1] https://lore.kernel.org/git/xmqq7d2fszhk.fsf@gitster.g/

 builtin/branch.c  | 6 +++---
 t/t3200-branch.sh | 8 ++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b1f6519cd9..01b6364f58 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -810,11 +810,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			else
 				ret = error(_("No branch named '%s'."),
 					     branch_name);
-		} else if (edit_branch_description(branch_name))
-			ret = 1;
+		} else
+			ret = edit_branch_description(branch_name);
 
 		strbuf_release(&branch_ref);
-		return ret;
+		return -ret;
 	} else if (copy) {
 		if (!argc)
 			die(_("branch name required"));
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 9723c2827c..d09db3fe3d 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1409,6 +1409,14 @@ test_expect_success 'refuse --edit-description on unborn branch for now' '
 	test_must_fail env EDITOR=./editor git branch --edit-description
 '
 
+test_expect_success 'test error codes using --edit-description' '
+	test_expect_code 1 env EDITOR=./invalid-editor git branch --edit-description main &&
+	write_script editor <<-\EOF &&
+		echo "New contents" >"$1"
+	EOF
+	test_expect_code 1 env EDITOR=./editor git branch --edit-description no-such-branch
+'
+
 test_expect_success '--merged catches invalid object names' '
 	test_must_fail git branch --merged 0000000000000000000000000000000000000000
 '
-- 
2.36.1
