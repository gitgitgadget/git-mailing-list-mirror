Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F938ECAAD3
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 07:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiIOH5Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 03:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIOH5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 03:57:24 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A57B9750C
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 00:57:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l8so7939940wmi.2
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 00:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TIXlXvo0D85lb/igp7x6w/DpGXvO7qH24wcvtLyDDRU=;
        b=Y41ef7qWkufBYf0Qc+mJ+xvdPM9SL5TtVTHWn6c0pMAtXD5sTEAe53uqVq26ZMq3XV
         WPCvEyCCayTMzLod5322Gr3nSyUTHtjHx0dOwKy/ISk/fs1C9GLEticSwkgQd7oOo7/3
         0cp98GcKbF7KSCW2KuRI+dUq8mlOoRwvmoynQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TIXlXvo0D85lb/igp7x6w/DpGXvO7qH24wcvtLyDDRU=;
        b=ccQc/82uYZP6o1ESSeRm2rxYNSyFrf38skAImyPrL7N/6bEGun+mXK3MkG9fVUXVif
         YTnvPULNz4Qwoetpu44cOIQsqDiaMSQBKG/HwBdtCLjmunSDSZ5rMx3tHTZhuaUjwhXu
         kyfuRKbmeUnOSwMDX1zBzqXuZtyi2g4eSsSzGdmthWs4xauwpmJKCaWk8RDDayPlqxhq
         yXT9b0BS/cDs+0zGrVXwowYVbbjcXQ8KV8qDYDa7pI5CSLxnl+wjrZTj6gvzVC1gKvF3
         BuptYlyRR+iAFB3gukAVEnatK8QxXVV+qAVwGXnjaZ34BCO51EegyMh2NOD6PEtqpWQv
         wk8g==
X-Gm-Message-State: ACgBeo3h+pPyLeA9WXDh+ShuJkG/NL50mrt9ajumkHitW9i6Cl4UqETB
        HTOtO7aEYwsWE9fldDlJsvclKXY/b2U8dKk1
X-Google-Smtp-Source: AA6agR7T3q/Pk/7Ia3s/eqOYawxKK6iWmcdM2PlGqx4snefCzDs8QtN7OJ/Y90ME3xnVtn2J/ymCWQ==
X-Received: by 2002:a05:600c:35c3:b0:3b4:a686:45c6 with SMTP id r3-20020a05600c35c300b003b4a68645c6mr3499236wmq.86.1663228640868;
        Thu, 15 Sep 2022 00:57:20 -0700 (PDT)
Received: from lucy.home (77.116.2.81.in-addr.arpa. [81.2.116.77])
        by smtp.gmail.com with ESMTPSA id z9-20020adfd0c9000000b0022a839d053csm1664612wrh.98.2022.09.15.00.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 00:57:19 -0700 (PDT)
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com
Subject: [PATCH v2] t1800: correct test to handle Cygwin
Date:   Thu, 15 Sep 2022 08:57:17 +0100
Message-Id: <20220915075717.425673-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220901173942.abolcr4aa5gixncm@lucy.dinwoodie.org>
References: <20220901173942.abolcr4aa5gixncm@lucy.dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Helped-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

With apologies to folk receiving this multiple times; it looks like my
SMTP setup was causing problems for some servers, and while the mails
seemed to be arriving with me, they didn't seem to be appearing at
https://public-inbox.org/git/?q=t1800

 t/t1800-hook.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 64096adac7..43fcb7c0bf 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -157,9 +157,9 @@ test_expect_success 'git hook run a hook with a bad shebang' '
 	write_script bad-hooks/test-hook "/bad/path/no/spaces" </dev/null &&
 
 	# TODO: We should emit the same (or at least a more similar)
-	# error on Windows and !Windows. See the OS-specific code in
-	# start_command()
-	if test_have_prereq !WINDOWS
+	# error on MINGW (essentially Git for Windows) and all other
+	# platforms.. See the OS-specific code in start_command()
+	if test_have_prereq !MINGW
 	then
 		cat >expect <<-\EOF
 		fatal: cannot run bad-hooks/test-hook: ...
-- 
2.34.1

