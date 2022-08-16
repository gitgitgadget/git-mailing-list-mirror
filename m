Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE26EC25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 21:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbiHPVS6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 17:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbiHPVSz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 17:18:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE04989939
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 14:18:53 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v3so14099657wrp.0
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 14:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc;
        bh=MYH3fqHdLF8gXQtXy6qh5lL4xV46p5jtHu0fdJlCvrQ=;
        b=iWDI7Xk9vzZJ97YUKYYrIf2PNDb/WWsIl4oiPGw3tgH6B6iktqTc+oLtB9uDiD/JDE
         1Ffq9RnDN+Tgc3ZmZMwmzudIVeek1QatZug3zzi0T5sl1W958mDDu2Q6U8KoAEeNeFEB
         jfTZiUVOLPso7N0CBIRtzNyjqR6v49+f6GoxUGR688+eVTqRM7nbTrk6BhXoD3Vj71Vm
         wtJfjSPb99Va/ruYV9eurXe1NsEylFHF8h+H5GQbbiOhkqykvMxAj7D4HuaftREA/dxN
         MWoFN5VTnqvPIL92eTcoGTmTsHCKsvnv/19w7hcLoS+Tihp6JXgHz1V2VMRo41WnF9t7
         zT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc;
        bh=MYH3fqHdLF8gXQtXy6qh5lL4xV46p5jtHu0fdJlCvrQ=;
        b=mHTpiSPCg0IoSfgH/BW3WIufkxNQwcCPI6rn3MpU4zhWt40SAU10taK6qmrwRV/G0o
         3bYPnCH6ZzRGA/z+ccQUP38iZMu6zJd1f3n3UnvNYP4ixHjwErvOhuGE9H/0PLijIoG1
         v6bROqIjJl9uxAiyltKdfLjXrK5+KreU8k4kCgoXdVhwrjpnUWjm6Y6BPu22VZjRz+FR
         8+mY3dSaF+tpbt1PfSSqQiVB+SMx0lNRsSa4sXRMrEBJxb2HooJ2IvFg5AhEOSsuMXLc
         tE6xmm826gLqjbYrqcMHErKYPZ1HUu18Pf/9DAvauWdvdgERx8WgBjbKAP8302HuJcy7
         rKaw==
X-Gm-Message-State: ACgBeo1nTXH2mtrGRfKnl861KZtaA+P9vm4ABqnZKkCAtJC7/i36WiSg
        Sa4/lMoOO4WHrXwhO5RRD0eW1yl0vh2SMA==
X-Google-Smtp-Source: AA6agR7nF4G9OVusf8btZ8lAI6utZEKs0FCuhbqiSEWQ62ZKwPcJiIW/QhmyEJIhKcZvScW7LylMFQ==
X-Received: by 2002:adf:d1c9:0:b0:225:f98:d602 with SMTP id b9-20020adfd1c9000000b002250f98d602mr4817112wrd.419.1660684732359;
        Tue, 16 Aug 2022 14:18:52 -0700 (PDT)
Received: from [192.168.2.52] (68.83-213-117.dynamic.clientes.euskaltel.es. [83.213.117.68])
        by smtp.gmail.com with ESMTPSA id p17-20020a5d48d1000000b0022159d92004sm11084185wrs.82.2022.08.16.14.18.51
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 14:18:52 -0700 (PDT)
Subject: [PATCH v3] branch: allow "-" as a short-hand for "previous branch"
To:     git@vger.kernel.org
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <c24313c1-3ade-eebc-77ae-bf4489b993ab@gmail.com>
Date:   Tue, 16 Aug 2022 23:18:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rubén Justo <rjusto@gmail.com>

Align "branch -d" with the intuitive use of "-" as a short-hand
for "@{-1}", like in "checkout", "rebase" and "merge" commands.

$ git branch -d -      # short-hand for: "git branch -d @{-1}"
$ git branch -D -      # short-hand for: "git branch -D @{-1}"

So I can do:

$ git checkout work_to_review
$ git checkout -
$ git merge - # or git rebase -
$ git branch -d -

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
     branch: allow "-" as a short-hand for "previous branch"

     Align "branch -d" with the intuitive use of "-" as a short-hand for
     "@{-1}", like in "checkout", "rebase" and "merge" commands.

     $ git branch -d - # short-hand for: "git branch -d @{-1}" $ git branch
     -D - # short-hand for: "git branch -D @{-1}"

     So I can do:

     $ git checkout work_to_review $ git checkout - $ git merge - # or git
     rebase - $ git branch -d -

     Signed-off-by: Rubén Justo rjusto@gmail.com

Published-As: 
https://github.com/gitgitgadget/git/releases/tag/pr-1315%2Frjusto%2Fmaster-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git 
pr-1315/rjusto/master-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1315

Range-diff vs v2:

  1:  0fe48ada15b ! 1:  cc28546aea9 allow "-" as short-hand for "@{-1}" 
in "branch -d"
      @@
        ## Metadata ##
      -Author: rjusto <rjusto@gmail.com>
      +Author: Rubén Justo <rjusto@gmail.com>

        ## Commit message ##
      -    allow "-" as short-hand for "@{-1}" in "branch -d"
      +    branch: allow "-" as short-hand for "@{-1}" in "branch -d"

           Align "branch -d" with the intuitive use of "-" as a short-hand
           for "@{-1}", like in "checkout", "rebase" and "merge" commands.
      @@ Commit message
           $ git merge - # or git rebase -
           $ git branch -d -

      -    Signed-off-by: rjusto <rjusto@gmail.com>
      +    Signed-off-by: Rubén Justo <rjusto@gmail.com>

        ## builtin/branch.c ##
       @@ builtin/branch.c: static int delete_branches(int argc, const 
char **argv, int force, int kinds,


  builtin/branch.c | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 55cd9a6e998..7f7589bd4a8 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -241,6 +241,9 @@ static int delete_branches(int argc, const char 
**argv, int force, int kinds,
  			die(_("Couldn't look up commit object for HEAD"));
  	}

+	if ((argc == 1) && !strcmp(argv[0], "-"))
+		argv[0] = "@{-1}";
+
  	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
  		char *target = NULL;
  		int flags = 0;

base-commit: 679aad9e82d0dfd8ef3d1f98fa4629665496cec9
-- 
2.36.1
