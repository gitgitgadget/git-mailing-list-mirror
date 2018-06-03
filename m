Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 370681F403
	for <e@80x24.org>; Sun,  3 Jun 2018 16:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbeFCQip (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 12:38:45 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:52674
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750952AbeFCQio (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Jun 2018 12:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1528043923;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=wBMVtGxeq+nCO+Q0TCgjH9QUiO2oWx72D5Yaikhl1GU=;
        b=w7biu2n0KiEI0TdAOAo+aJohx6IpM/uQQi6lUXQmatCN1jrYi5/n+kZp5SExSgih
        IN2+k/Cekw9Q4ZfwdLi+SPuiH+o/ryoPQ86M1rTR3GQSv8BcYv23VXwXOBX4BJxkW+Q
        gcRHRdgBQgx/zeTAonrAQD6oT7tsscNg9lC3+WW8=
From:   Rick van Hattem <wolph@wol.ph>
To:     git@vger.kernel.org
Message-ID: <01020163c683e753-04629405-15f8-4a30-9dc3-e4e3f2a5aa26-000000@eu-west-1.amazonses.com>
Subject: [PATCH] Use ZSH_NAME instead of ZSH_VERSION because it's redefined
 by git-completion.zsh
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sun, 3 Jun 2018 16:38:43 +0000
X-SES-Outgoing: 2018.06.03-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `git-completion.zsh` unsets the `$ZSH_VERSION` which makes this check moot. The result (at least for me) is that zsh segfaults because of all the variables it's unsetting.
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 12814e9bbf6be..7e2b9ad454930 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -348,7 +348,7 @@ __gitcomp ()
 
 # Clear the variables caching builtins' options when (re-)sourcing
 # the completion script.
-if [[ -n ${ZSH_VERSION-} ]]; then
+if [[ -n ${ZSH_NAME-} ]]; then
 	unset $(set |sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\)=.*/\1/p') 2>/dev/null
 else
 	unset $(compgen -v __gitcomp_builtin_)

--
https://github.com/git/git/pull/500
