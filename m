Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B25021F404
	for <e@80x24.org>; Mon, 19 Mar 2018 14:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755610AbeCSOtL (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 10:49:11 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:38029 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755243AbeCSOtK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 10:49:10 -0400
Received: by mail-wr0-f174.google.com with SMTP id l8so18891727wrg.5
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 07:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=QjDCt1n1r4fMXH6b96CR7WKfOGatfElJIePfCYQlWXk=;
        b=WxcfN0+F0B0BbN8kvB4CuSH6oMPzUiAh/Z29MHJW7TfAZKMrq0J4ejkLK05F5kkMjb
         hffVGvThzi0j92ZEEpSw2kmHmHSfA8+kzbpLlYcHB6cZ8zMp78pC3aaapQ/G002B0Nos
         I+U0lS5Dkw44Qfzw8mT7G8MCDjrNEn1ewfzEZn0rPuLsOuNYPDEnYV/ASn40EvY3ecOD
         GMJJfIfKIzjOq/Bpr7amkmemMpEcunhodT3QoPMR9dJJSNKjVXTi2uuln4kiQdDLaO62
         GwzzhBt0kn2aVdmREFz/7Bo1FTs722QllxZF8xaVsCS9dAFRtH8TBJvCzUTekwEuAWID
         bAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=QjDCt1n1r4fMXH6b96CR7WKfOGatfElJIePfCYQlWXk=;
        b=IMdwTPC+3sq0aMpjqeZ1R1DkS9Y3xSlbGgoIz7+3QVkqNnu54yhxXjRUP/y19h4h8G
         k2enUth8/Tdf+uxXG/oi/+WcDwmx/M1UMjLLnJVikA7dPlaBdiZPkTKIXY6UMm7bipGh
         zue2er352NEmau5uS6SNv1N31HyrCzoL9EOmTYmkuYpL2UIOLMqRa4Y+98Lt09Qlb9cG
         C7e1YWTFQgDfYse831+5fJxztdwqco6sIlRloUMtpgw3c/zg9/mVU/Y0+J/8EOvZFvwI
         Wzps77tZknoUvDQTViWYGY3YGU2f+joBpdD5/Il0dQ0Lr1n96Rr/5aRo1MK5MJCfaLIq
         Nuaw==
X-Gm-Message-State: AElRT7EOSKOsJXS7Ekxj9MAyNafXTkFo5Z+48cZNHBZNzBKyysfdzPnr
        Txrv12IMMffnqICBqIC7lY7TkjQl
X-Google-Smtp-Source: AG47ELtq2RYy7IvdxsQCFTlrkzR3X0xJZqlc5Xbo8pgdsJyy19NbTYtDkTbyreV+1w85F/f+TG/lNg==
X-Received: by 10.223.152.80 with SMTP id v74mr9211631wrb.163.1521470949242;
        Mon, 19 Mar 2018 07:49:09 -0700 (PDT)
Received: from FUJITSU-PCD-030.progesoft.local (151-0-155-178.ip281.fastwebnet.it. [151.0.155.178])
        by smtp.gmail.com with ESMTPSA id l11sm193852wrg.71.2018.03.19.07.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 07:49:08 -0700 (PDT)
From:   Michele Locati <michele@locati.it>
To:     git@vger.kernel.org
Cc:     michele@locati.it
Subject: [PATCH] filter-branch: use printf instead of echo -e
Date:   Mon, 19 Mar 2018 15:49:05 +0100
Message-Id: <20180319144905.11564-1-michele@locati.it>
X-Mailer: git-send-email 2.16.2.windows.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to echo a tab character, it's better to use printf instead of
"echo -e", because it's more portable (for instance, "echo -e" doesn't work
as expected on a Mac).

This solves the "fatal: Not a valid object name" error in git-filter-branch
when using the --state-branch option.

Signed-off-by: Michele Locati <michele@locati.it>
---
 git-filter-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 1b7e4b2cd..21d84eff3 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -627,7 +627,7 @@ then
 				print H "$_:$f\n" or die;
 			}
 			close(H) or die;' || die "Unable to save state")
-	state_tree=$(/bin/echo -e "100644 blob $state_blob\tfilter.map" | git mktree)
+	state_tree=$(printf '100644 blob %s\tfilter.map\n' "$state_blob" | git mktree)
 	if test -n "$state_commit"
 	then
 		state_commit=$(/bin/echo "Sync" | git commit-tree "$state_tree" -p "$state_commit")
-- 
2.16.2.windows.1

