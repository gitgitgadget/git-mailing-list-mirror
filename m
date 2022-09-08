Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B152BECAAD5
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 04:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIHErR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 00:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIHErQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 00:47:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B8F89923
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 21:47:14 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t14so16691249wrx.8
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 21:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date;
        bh=q+Ob6X2dW8U+6TC2zO8+brli2TRFX9ZZEY55uRs4Nyo=;
        b=fC12N5ZfY44ThknI+CAT7eBL2Sw6pRNkocwS+ojBnyMgpj51bRr/4TuxA3h4DohLZF
         A346HSimwimivNFe7/3LZuqpxzuHnyCF00Z3NnyySy4VeT4oo9PlooTnFaj8ede4xKeV
         jG5oj/YHjlMHQPVRgXsNNeI2PKV319HuEfmkFZRLWqAtdEN76Rj/EhprLp6f1Nd07IDW
         X6bVOSG8wgYXFiZT81IwUybZnApRbqLBb8zKHHxXxBs7Z1tmoAqZKvN3AJchucsVkBIq
         +o6LOZIdCKsl1ijO3i/csi5dXWHUygS3pikBHnmb+bUxndY+ZmUnOHtnEsMin7L9Tlzf
         OCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=q+Ob6X2dW8U+6TC2zO8+brli2TRFX9ZZEY55uRs4Nyo=;
        b=SqOnSTLwVNVmXuilT9KGu5BWo0dsNH+7IGSHhrEP3Bd4wEhvfsF4xijjJ9GVF8ydrx
         /fEuKVGaof2AS4ODrVQBO9r+tlwpH9pnx6V4TD3NBLW4u0Tvo2hdK7dnSF5LnOeEbH47
         xlGZijlbcXlPCrq0PLnCCZq8PisSPqYGZGxvQ+syEzvco4BSIEDyX5sH2qN+GFdeCRgS
         +lRTE78GqXFkGuApi0/EMnjIwp/vsbxAofKgwyyz+dwTRjFVnZdQIK3N+MyCzLSFa56w
         s7BmevfUpUQTCH+aAR8GUJMayMossBVARZJA7vYfn4Gn2zIOWkRWM+1mxC5OQeIBH6IB
         LUgA==
X-Gm-Message-State: ACgBeo2pHX7f7uXODf+JwNGLy0Xr2y62Ta2S07zastT8pzJdeCxwbbbf
        wRFgdl/aDVDjkt309MN3TURjssZK+LI=
X-Google-Smtp-Source: AA6agR68fT5SrqYh+R2AAPLEsJ3L0IYD8xi/kI7AenLcDbnglcMkT47KxoythMcqk71wdg4Dni6yxA==
X-Received: by 2002:a5d:5a9d:0:b0:225:2783:d6f1 with SMTP id bp29-20020a5d5a9d000000b002252783d6f1mr3951178wrb.385.1662612433387;
        Wed, 07 Sep 2022 21:47:13 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id v3-20020a7bcb43000000b003a32251c3f9sm1321984wmj.5.2022.09.07.21.47.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 21:47:13 -0700 (PDT)
Subject: [PATCH v3 0/2] branch: support for shortcuts like @{-1}, completed
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     git@vger.kernel.org
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
Message-ID: <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
Date:   Thu, 8 Sep 2022 06:47:00 +0200
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

branch options: "edit-description", "set-upstream-to" and "unset-upstream"
don't handle shortcuts like @{-1}.
 
This patch address this problem.
 
Changes in v3 are about following code conventions to avoid unnecessary confusions, pointed out by Junio in <xmqq7d2fszhk.fsf@gitster.g>.
 
Thanks.


Rubén Justo (2):
  branch: refactor "edit_description" code path
  branch: support for shortcuts like @{-1} completed

 builtin/branch.c                      | 44 ++++++++++++++++++---------
 t/t3204-branch-name-interpretation.sh | 25 +++++++++++++++
 2 files changed, 55 insertions(+), 14 deletions(-)


Range-diff:
1:  ce14194187 ! 1:  0a69b6cf18 branch: refactor "edit_description" code path
    @@ Commit message
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
     
      ## builtin/branch.c ##
    -@@ builtin/branch.c: static int edit_branch_description(const char *branch_name)
    - 	strbuf_reset(&buf);
    - 	if (launch_editor(edit_description(), &buf, NULL)) {
    - 		strbuf_release(&buf);
    --		return -1;
    -+		return 1;
    - 	}
    - 	strbuf_stripspace(&buf, 1);
    - 
     @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const char *prefix)
      	} else if (edit_description) {
      		const char *branch_name;
    @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const char *prefix
      					     branch_name);
     -		}
     -		strbuf_release(&branch_ref);
    -+		} else
    -+			ret = edit_branch_description(branch_name);
    ++		} else if (edit_branch_description(branch_name))
    ++			ret = 1;
      
     -		if (edit_branch_description(branch_name))
     -			return 1;
2:  3a591cab8a ! 2:  91b308b52a branch: support for shortcuts like @{-1} completed
    @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const char *prefix
      			die(_("cannot edit description of more than one branch"));
      
     @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const char *prefix)
    - 			ret = edit_branch_description(branch_name);
    + 			ret = 1;
      
      		strbuf_release(&branch_ref);
     +		strbuf_release(&buf);
-- 
2.36.1
