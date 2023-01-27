Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF22C61DA4
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 20:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbjA0UH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 15:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjA0UHd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 15:07:33 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA52D1EBEA
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 12:06:08 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id k16so4205569wms.2
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 12:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIz5w1mSCRudVQy3sVj0CM5aMF3+UR1XyIRPn+Y+U2E=;
        b=H/J9Q74As2tdlQ3zrFin0VClNCTZyLeicbC7vuuNqkCWpfFh/+XozpDL8auKt5KE0t
         HAXMHyDA551cGLPm4Is7cBnzdW2vp3mfz3D+45cHjVnAfLZ50p+lqRPiJ8Q7SBv2di0g
         NgvzxEbrVD6o4reYKCzolBUKLydx0jcUWQgiPWJqbGJOyu+jr+izMqZNttSUOD5ykgAX
         4KFdvV5MTz+FZ40g7O7w8MKcZMkE+pEGcElvv6X6epKoR2EWBXlfEJAFHv/Uy0C8PWGi
         bvAlXyLq+PddoTj9lGjtaZ9T9TNB7vvPQau4tD1AWMwKegAqS0Q+uq+BXssdhHvG7eEj
         /BgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIz5w1mSCRudVQy3sVj0CM5aMF3+UR1XyIRPn+Y+U2E=;
        b=2AoAvFoZdPKCSh6uMG7S5p/5dTArEDRTAMh0m7EUjSlUfhPxyYmZ/3BamS9GQcj0vh
         k+osx8zV8vA9oVzBgWB3BG7y7oCVJh26HE9am9iCHOy12qhqWqo6qUpXyOXC9COeNeIU
         c5L4sD5au+bXnZeqMzWagtVmyxu4rdjkkPURSpAp/e7yszSJMKuA74vxXKzUdUQ22zO5
         I1MzXAgKL5gXaS23/mHrgHWKwFyzRslxHi7hhdCp28OPbJESdD0ZKZCKpLmSN7ZV8RGl
         aGDU8/qntDr6Gq4YIpYgLyUeuxZab3KWyv5U9AdRB6MBjMHYx6XPuFJcpwYd1pyZWyy2
         QdZg==
X-Gm-Message-State: AFqh2krkSnomeLBzi0JcFhugjzZCEEFBVhOwUJ/RGx7UKhyJqypHTj+n
        AL331/0V5SW4JSxqzKW6+A5rBAqYVNk=
X-Google-Smtp-Source: AMrXdXseSIynkKoTMxesRNHgSAoe0qGxYdJ4EqEg714PfrYXjnaK9cZqiPYLI6H4duVK3WuXrx2zTw==
X-Received: by 2002:a05:600c:444b:b0:3da:fd06:a6f1 with SMTP id v11-20020a05600c444b00b003dafd06a6f1mr39459361wmn.31.1674849965791;
        Fri, 27 Jan 2023 12:06:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id hg6-20020a05600c538600b003dafbd859a6sm8669933wmb.43.2023.01.27.12.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 12:06:05 -0800 (PST)
Message-Id: <f05325c862b618067c67e727c81dafdf4463e4fc.1674849963.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1473.git.1674849963.gitgitgadget@gmail.com>
References: <pull.1473.git.1674849963.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Jan 2023 20:06:02 +0000
Subject: [PATCH 2/3] t921*: test scalar behavior starting maintenance
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

A user recently reported issues with 'scalar register' and 'scalar
clone' in that they failed when the system had permissions locked down
so both 'crontab' and 'systemctl' commands failed when trying to enable
background maintenance.

This hard error is undesirable, but let's create tests that demonstrate
this behavior before modiying the behavior. We can use
GIT_TEST_MAINT_SCHEDULER to guarantee failure and check the exit code
and error message.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t9210-scalar.sh       | 7 +++++++
 t/t9211-scalar-clone.sh | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 25f500cf682..13a4f6dbcf4 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -104,6 +104,13 @@ test_expect_success FSMONITOR_DAEMON 'scalar register starts fsmon daemon' '
 	test_cmp_config -C test/src true core.fsmonitor
 '
 
+test_expect_success 'scalar register fails when background maintenance fails' '
+	git init register-repo &&
+	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
+		test_must_fail scalar register register-repo 2>err &&
+	grep "could not turn on maintenance" err
+'
+
 test_expect_success 'scalar unregister' '
 	git init vanish/src &&
 	scalar register vanish/src &&
diff --git a/t/t9211-scalar-clone.sh b/t/t9211-scalar-clone.sh
index 02d32fb6ede..a6156da29ac 100755
--- a/t/t9211-scalar-clone.sh
+++ b/t/t9211-scalar-clone.sh
@@ -174,4 +174,10 @@ test_expect_success 'progress without tty' '
 	cleanup_clone $enlistment
 '
 
+test_expect_success 'scalar clone fails when background maintenance fails' '
+	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
+		test_must_fail scalar clone "file://$(pwd)/to-clone" maint-fail 2>err &&
+	grep "could not turn on maintenance" err
+'
+
 test_done
-- 
gitgitgadget

