Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419F3C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 19:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B12D60EB9
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 19:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhHKTRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 15:17:05 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:37418 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhHKTRE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 15:17:04 -0400
Received: by mail-lj1-f174.google.com with SMTP id e11so892326ljq.4
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 12:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VkSm1t1ogPkrsQbszmzB2x58avutf/nGn3zw31wxapY=;
        b=Q4vckVQinwIOs7pl0X0RHURbC39fOSmhCrX/g9qR0N0iq3LcSgSIMV+QZvFGb7fKH0
         lafZEC+Bup151o5/AOFJgkjYkLVDypIa2niDU9yEat0pTnXQhNWNXUcUIdx/WNjb9Awd
         jvZURJp4fHyOkFh1jjLsywGqBpGRm9iF7rHQuOUwuXPoBJjjUPtZ07WsCVIHTzSiAeMF
         p8G6H8HTlkstCQln2AO6vZxife/Ec8xUo/O/4HfVQl5TsfqbmvmNVH1JtEOm3zzJOusD
         mEmiHv7VFKb8gfydD16eb9nAu5/R1b+FQyR6yf74Q+zA2nmHOlUZtUP1cL2zWIr42Shz
         1mMw==
X-Gm-Message-State: AOAM530UZrA4902M04eWHPz9nieTU2RI7MO4p+p9E+1GqtNLdJZFyN0i
        zU70w/+G0Wlpwd+FW+osE1xzdCjyVbU=
X-Google-Smtp-Source: ABdhPJx1fFLDn3XhmqYlVtyvzx6E9tioXAZXahdmk1elVbfQdcwPdqI40BiLeyytFFmE/zQiZB5oGA==
X-Received: by 2002:a05:651c:114b:: with SMTP id h11mr167642ljo.146.1628709399463;
        Wed, 11 Aug 2021 12:16:39 -0700 (PDT)
Received: from localhost.localdomain (dyjfhjkqfhw33tvjwmy2t-4.rev.dnainternet.fi. [2001:14bb:1c8:63a1:a434:af78:44f2:502d])
        by smtp.gmail.com with ESMTPSA id t27sm29081ljk.110.2021.08.11.12.16.38
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 12:16:38 -0700 (PDT)
From:   =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To:     git@vger.kernel.org
Subject: [PATCH] completion: avoid config variable name lookup error in nounset mode
Date:   Wed, 11 Aug 2021 22:16:37 +0300
Message-Id: <20210811191637.775693-1-ville.skytta@iki.fi>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Config variable name lookup accesses the `sfx` variable before it has
been set, causing an error in "nounset" mode. Initialize to an empty
string to avoid that.

    $ git config submodule.<Tab>bash: sfx: unbound variable

Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4bdd27ddc8..ecc9352755 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2631,7 +2631,7 @@ __git_complete_config_variable_value ()
 #                 subsections) instead of the default space.
 __git_complete_config_variable_name ()
 {
-	local cur_="$cur" sfx
+	local cur_="$cur" sfx=""
 
 	while test $# != 0; do
 		case "$1" in
-- 
2.25.1

