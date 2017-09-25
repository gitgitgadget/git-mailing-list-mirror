Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17561202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 22:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935155AbdIYWu7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 18:50:59 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:46879 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934953AbdIYWu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 18:50:58 -0400
Received: by mail-pf0-f174.google.com with SMTP id r68so4561288pfj.3
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 15:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iaQO4n+6Y05xLudlPBUbqc5I7AvNFy73R3ChpP2ZyXg=;
        b=QQOGJgqpI8qi7VeF+sev6fcTpfVUweVha5QR7x8uaU4yQ7iF87ugb0v2IVjnrAr23R
         wvwABpzREZ488Pb2j7QrD07W0mbahptz4CCBMyly9YkTvasWNBJ9pPgyTK/bYYx49i3+
         AIhRNzghy0AIep2YVyjGJQI2TfEXz4cbQVNOXXECBLNEYKsF63tgzv9N9slvx8/3SDIq
         rAco/piHA9JHs4fd9DncNhtqMV+wBmehibXrwh0717q5L/3goq7NuIvp7S476LJjlPAy
         AiwazG3BxNoNUun2R45jgexO5quVXsQLMcpOIqQW1Vgt04UMN1OPpa9lvzdzvKjJ+rPv
         MN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iaQO4n+6Y05xLudlPBUbqc5I7AvNFy73R3ChpP2ZyXg=;
        b=OMPqSmN8Aa4M81npFJ+6uyBl4Ydv3aDK00cwAeV1OK9OVzuwWI+6+If99iVlkeqADI
         NkWQJROhzSohAZ4R+SWYSE/mbtg+Zj0CUdsUbcm6+h8ylUwyeuXnIIg6RAfEuOUhO8cR
         jm7Q3jSqRlOZmKOOZbKn2L8+XR1fE4QvEAowkOrNfEz8MbiEiX+n4SKHwGgMa+8+M+te
         YaD9MTgtgJccIYsZNXrUWag/qQOd+t9Kxg1nwfOLbzPJ9fFlRl0lJlCf3eCBjWpnbSl7
         wv+xrhfVkD5P/6O46uH5Msdxcye3C3bQIrD6D5TSE3XJnHoeKVgKtwOZBfxQvtsTKY4s
         XRNA==
X-Gm-Message-State: AHPjjUhq4O4J+arDDduGsyGfJZzagH+FSzDNq0PjgHdOekA7sCm58Ni1
        DLp3PQtzkBs4qkfzMPe4/Cku7g==
X-Google-Smtp-Source: AOwi7QBtWriSNKCE6b2ZZqozzoUQpHT2q1NFbe9lT2wgb5DwIAccgbNKq7Tkg0zsnWc+xI/bQcjPCQ==
X-Received: by 10.101.87.139 with SMTP id b11mr8822697pgr.186.1506379857431;
        Mon, 25 Sep 2017 15:50:57 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6810:20db:ec03:dc8a])
        by smtp.gmail.com with ESMTPSA id g66sm13417434pfj.161.2017.09.25.15.50.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 15:50:56 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: [PATCH] t7406: submodule.<name>.update command must not be run from .gitmodules
Date:   Mon, 25 Sep 2017 15:50:54 -0700
Message-Id: <20170925225054.10819-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <20170925200448.GY27425@aiede.mtv.corp.google.com>
References: <20170925200448.GY27425@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

submodule.<name>.update can be assigned an arbitrary command via setting
it to "!command". When this command is found in the regular config, Git
ought to just run that command instead of other update mechanisms.

However if that command is just found in the .gitmodules file, it is
potentially untrusted, which is why we do not run it.  Add a test
confirming the behavior.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

 updated to use the super robust script.
 Thanks Jonathan,
 
 Stefan

 t/t7406-submodule-update.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 034914a14f..d718cb00e7 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -406,6 +406,20 @@ test_expect_success 'submodule update - command in .git/config' '
 	)
 '
 
+test_expect_success 'submodule update - command in .gitmodules is ignored' '
+	test_when_finished "git -C super reset --hard HEAD^" &&
+
+	write_script must_not_run.sh <<-EOF &&
+	>$TEST_DIRECTORY/bad
+	EOF
+
+	git -C super config -f .gitmodules submodule.submodule.update "!$TEST_DIRECTORY/must_not_run.sh" &&
+	git -C super commit -a -m "add command to .gitmodules file" &&
+	git -C super/submodule reset --hard $submodulesha1^ &&
+	git -C super submodule update submodule &&
+	test_path_is_missing bad
+'
+
 cat << EOF >expect
 Execution of 'false $submodulesha1' failed in submodule path 'submodule'
 EOF
-- 
2.14.0.rc0.3.g6c2e499285

