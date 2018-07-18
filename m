Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A37211F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbeGRU22 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:28:28 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:33117 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbeGRU22 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:28:28 -0400
Received: by mail-io0-f201.google.com with SMTP id s14-v6so4197755ioc.0
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=GB4gszDxibuOwJW6zH2IHAhldz1ACRjrAFcdtL/dXWo=;
        b=hyx8n9VC1GRsl1YzbS31G3EZn3vWgtCsjQ7/EMm2rPWTtGiHkygyW5ak3fn66GZ3H4
         UhcX3XCs4UfkGXjSUj5CfYDzkDoUGkxVKQPB6q/OEBeZXOk6BBpHeo6djZSWlJ4J/HD1
         EGZBtQZioVqXvmeBTHCmWTUVnYd3B0M5x3sx2Z/jJ3b1BZC1rolTftLSWzAKilMLlqSp
         aLpQV99l1H+Je1Iw7Mlizkwipd1K7E88o6uWCGeuG1xENTq44aiS8Zdsi2m+/K7RIh72
         X01gt8Qm6olOVtfuFYeg2t+VAZTvNSHGq6krvNoVrYGjLOOlWq65etQWOS5dOz85Cle3
         0y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=GB4gszDxibuOwJW6zH2IHAhldz1ACRjrAFcdtL/dXWo=;
        b=O0EplN5PUb2X2siA8t+WmaBM7zqo694whQ3kI7dmDW+ozp3iEFGoyqXaTx0HvoVRMC
         voxezbUh/FoMV309nS84g93LvoHHjy0IWJ2mZO6qfxngVbCstNmQQKjCtWziA1mS5ENe
         b7/fLebnVil7PkKIubbe13S/WuT9HhKGRWJCOI4VdvKdUPhkZazdlC0jVSUTOemBUiT1
         7plbNKu7tjF3omadQNcA2eqOeRRbFohymRgl6jThOyxThi4ZjIAG/ZIMyxYET/oYuauT
         svFTKrfEdQjEoV/XzOrV6XRW5ZHGXcajpdj5pFSGlbOIxZScOOI1niN9hp3wJ2QaP0E7
         Ptfw==
X-Gm-Message-State: AOUpUlFwWdF71YIPxUn4O4zFMgPu6OSeBD/DQCpBh9gFqleFol/AAoqq
        FaGL5rlD7KrAKYZehMzxV9B2md5LS2EwrmQCEsWe8F/QWTEwYlEUWmrq0EycfR8Ex9mmWSCF/h0
        zB1zuLAFulpohlzzTN7yFi7uX+rmu1uCpGy8y3yAQXwbnPEmn8gb3S7VzNYiH
X-Google-Smtp-Source: AAOMgpfJaUGmBf0fUYNOMG7PByL1REhPtZOrRFNZQxtYK8nEGB66fMn7kz9kDg9nGWb14ux9AlR+SFSEkMYZ
MIME-Version: 1.0
X-Received: by 2002:a24:2847:: with SMTP id h68-v6mr1575875ith.33.1531943343774;
 Wed, 18 Jul 2018 12:49:03 -0700 (PDT)
Date:   Wed, 18 Jul 2018 12:48:48 -0700
In-Reply-To: <20180718194853.57994-1-sbeller@google.com>
Message-Id: <20180718194853.57994-2-sbeller@google.com>
References: <20180718194853.57994-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 1/6] git-submodule.sh: align error reporting for update mode
 to use path
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, szeder.dev@gmail.com, stolee@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All other error messages in cmd_update are reporting the submodule based
on its path, so let's do that for invalid update modes, too.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5f9d9f6ea37..8a611865397 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -627,7 +627,7 @@ cmd_update()
 				must_die_on_failure=yes
 				;;
 			*)
-				die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
+				die "$(eval_gettext "Invalid update mode '$update_module' for submodule path '$path'")"
 			esac
 
 			if (sanitize_submodule_env; cd "$sm_path" && $command "$sha1")
-- 
2.18.0.233.g985f88cf7e-goog

