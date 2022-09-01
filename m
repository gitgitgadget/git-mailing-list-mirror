Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97A8ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 17:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiIAR6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 13:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiIAR55 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 13:57:57 -0400
X-Greylist: delayed 1038 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Sep 2022 10:57:56 PDT
Received: from dalaran.tastycake.net (dalaran.tastycake.net [IPv6:2001:ba8:0:1c0::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B04676967
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 10:57:55 -0700 (PDT)
Received: from 77.116.2.81.in-addr.arpa ([81.2.116.77] helo=lucy.dinwoodie.org)
        by dalaran.tastycake.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <adam@dinwoodie.org>)
        id 1oToAJ-0005K0-EK; Thu, 01 Sep 2022 18:39:43 +0100
Received: from adam by lucy.dinwoodie.org with local (Exim 4.94.2)
        (envelope-from <adam@dinwoodie.org>)
        id 1oToAI-007IEE-AT; Thu, 01 Sep 2022 18:39:42 +0100
Date:   Thu, 1 Sep 2022 18:39:42 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH] t1800: correct test to handle Cygwin
Message-ID: <20220901173942.abolcr4aa5gixncm@lucy.dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Cygwin, when failing to spawn a process using start_command, Git
outputs the same error as on Linux systems, rather than using the
GIT_WINDOWS_NATIVE-specific error output.  The WINDOWS test prerequisite
is set in both Cygwin and native Windows environments, which means it's
not appropriate to use to anticipate the error output from
start_command.  Instead, use the MINGW test prerequisite, which is only
set for Git in native Windows environments, and not for Cygwin.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---

The job of setting Cygwin up to get Git CI builds, either as part of the
main CI builds or as something using separate automation, is rapidly
rising up my when-I-have-the-time to-do list...

 t/t1800-hook.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 64096adac7..fae8b2faf9 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -159,7 +159,7 @@ test_expect_success 'git hook run a hook with a bad shebang' '
 	# TODO: We should emit the same (or at least a more similar)
 	# error on Windows and !Windows. See the OS-specific code in
 	# start_command()
-	if test_have_prereq !WINDOWS
+	if test_have_prereq !MINGW
 	then
 		cat >expect <<-\EOF
 		fatal: cannot run bad-hooks/test-hook: ...
-- 
2.37.2
