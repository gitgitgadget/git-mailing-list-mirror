Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AD0C54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 09:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiIGJwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 05:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiIGJwb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 05:52:31 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F1AB5147
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 02:52:28 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e20so19456912wri.13
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 02:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date;
        bh=O+e+igINtQQjsQPcKyiah7H4IMlxjDwaEiA1Uir/tPE=;
        b=Yzn8Z52xuMeM0reWzvAK6CpZ0diP7t6wllXooWEF1ecM67MynIp8AWRNfzZ+aNLgB+
         o0Q0pJ28Vkdal1hgl1iEXkkg4Gzx4o6LkNWwBxcaBxl6OjHZSuI51nbe4QqMxNYgUgPa
         UdH5pYGonUztVx9QvRFcnSOoVrdY88NMZlaoFDUNabihD2c0iZ8RS3HJreyeOtXXhLtO
         IBgR8RQvTmzVWsF3VTjieaWuPKUGfylx7Ny9Kt6s+XBqZ8lkr99fXbj4A4D23Andwb2p
         W1/fukftKROokQLocT9j/SbAxMhiUapcLrbpPqh7+G66j10hScj1FCue7uCoawqebv0D
         jQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=O+e+igINtQQjsQPcKyiah7H4IMlxjDwaEiA1Uir/tPE=;
        b=nE9VvtKz18iJbKs2WAihvt5jwuyV3DfAGGhYP2Esl8/3xWhQH+MjBc6RijlM81Gvcp
         M2K/G3KzW2D13+9Bc33nnjxqA5OOpWC14hX7oh4Rikt9I/HPBZke/Mx8RGmeOJsAYnXo
         NHRP1H1bO9u+uOnKCHEmfNMNrtju6yQS60E6NtnlsikaQRBW2SSjHwKDBH1jJFwKLq3V
         Y/TbKSi6TYBKin6VCczpOOdmbdQQ9mvQC+JvyLmpsLo3lawN+lYhBSEPfCH93mW6ROvy
         P2TwpkSQE82Z6eb0/ohg/Q25XQuiRyl9utLC57CC27JYbDAZ6HPrjTUSHnvFIGITmv37
         DGdg==
X-Gm-Message-State: ACgBeo2kdA8B2T0Cv9pVHs3abSYcwQ3wKMdPym5nxV3NZrLccuKEiQx4
        2bAgdWT3XRdQohj7DPwlFLQgsL3/mDw=
X-Google-Smtp-Source: AA6agR6aAfSaYo/bp2IqgUDgb/0+X6+jv9aaZwDl7ezCuhwZNGZgKgZ03U0LJpUI0EA2xwvYWEk78A==
X-Received: by 2002:a5d:6d88:0:b0:222:c8e2:f5fb with SMTP id l8-20020a5d6d88000000b00222c8e2f5fbmr1571290wrs.35.1662544347435;
        Wed, 07 Sep 2022 02:52:27 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id j10-20020a5d604a000000b0022917d58603sm1534062wrt.32.2022.09.07.02.52.26
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 02:52:27 -0700 (PDT)
Subject: [PATCH v2 1/2] branch: refactor "edit_description" code path
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     git@vger.kernel.org
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
Message-ID: <d2624238-048c-ac5b-1d45-e08051202c79@gmail.com>
Date:   Wed, 7 Sep 2022 11:52:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
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
 builtin/branch.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 55cd9a6e99..5229cb796f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -614,7 +614,7 @@ static int edit_branch_description(const char *branch_name)
 	strbuf_reset(&buf);
 	if (launch_editor(edit_description(), &buf, NULL)) {
 		strbuf_release(&buf);
-		return -1;
+		return 1;
 	}
 	strbuf_stripspace(&buf, 1);
 
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
+		} else
+			ret = edit_branch_description(branch_name);
 
-		if (edit_branch_description(branch_name))
-			return 1;
+		strbuf_release(&branch_ref);
+		return ret;
 	} else if (copy) {
 		if (!argc)
 			die(_("branch name required"));
-- 
2.36.1
