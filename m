Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTTP_ESCAPED_HOST,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D884C433DF
	for <git@archiver.kernel.org>; Thu, 14 May 2020 21:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22A1B20709
	for <git@archiver.kernel.org>; Thu, 14 May 2020 21:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF2XMToy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgENVF3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 17:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727122AbgENVF3 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 May 2020 17:05:29 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC661C061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 14:05:28 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g11so40322plp.1
        for <git@vger.kernel.org>; Thu, 14 May 2020 14:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=slRP9w9pbxRjq0L3cObnKVMs+bo1POvfenr1JET37Hc=;
        b=cF2XMToyW7bGI6bu/l+Tm4FgbsFf6BYWOgDMfHi0eao/EYAJZbG7k88wuXimoqEAfD
         VcY8q/zia5XiXXl9wCmJZ53vk5DLVbyVIYlZovA2YSjMicC2CcVKITcP89zPBHr/BtoW
         Zpu0xtP6eAh2VaRS3A8X1aHK1X5b3nB/W+4bKLpwxH8gjqKXKj42b0A/Slyi1X1RNXRR
         eCZPgTy1Cfn2G8xujoqbrYz00KnG1Y8+egLBNCQ7j+AqEs76rBr76VM/DTaoMpTvubje
         tzKXQAHDvAhN6gmV+CT38cHYvPuEcNBgfj9ozZsJ1wjTdXz7oVQiJqseEIPse/AjkCup
         zwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=slRP9w9pbxRjq0L3cObnKVMs+bo1POvfenr1JET37Hc=;
        b=PxouC+zNlVXdc2sHmfCS4O9ytJe0/q3v2Xi8SjKMGY4dtjMh/DR39ogBRw5DBmCG37
         0cQM+Zk0SbBfNee2XMFybwpxxtwmYad9tbNiKTgEjTst5z5FDjV4+zdziut8+hNYiSVH
         MmvVPAU4p1t4mW9wmwER7yepKctT6BrFTjvzCDuiXEeNH4ayWYkz5PvJYONAwfa6/4eV
         T1yHCMqcw4WGiqmkGipRSe4RsJuRiZWZx/77VmvZlJrPZWDmgGgG3zPIfjNOdWnZJy5m
         y9IHvrY6iBHOgGB8OqTcBwEAWs87ct5ibpGwcB/uy6Qc0pAsj9f4yi1aKpgQk6ybQiPa
         NVPQ==
X-Gm-Message-State: AGi0PuYFvrdsp9DsDjjmjfGxm2lOAk60R7RmkBq64aE12o6SaCssVgbL
        CAzSDTsdwNQY+1+5IhuKiFJwtFdt
X-Google-Smtp-Source: APiQypIm9vkptoAsX9gZ31uu8w88CS+VdR5skvHqgPD6TEawkHEB+Rb97ILoKT1F/4AtuQbXeer/4w==
X-Received: by 2002:a17:90a:d504:: with SMTP id t4mr42426151pju.123.1589490327851;
        Thu, 14 May 2020 14:05:27 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id d20sm106585pgl.72.2020.05.14.14.05.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 14:05:27 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] t0300: workaround bug in FreeBSD < 10 sh
Date:   Thu, 14 May 2020 14:05:18 -0700
Message-Id: <20200514210518.56101-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.812.g046d49d455
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

4c5971e18a (credential: treat "?" and "#" in URLs as end of host,
2020-04-14) introduces check_host_and_path to t0300 and some tests that
use it, but fail in at least FreeBSD 9.3.

The variables in the here-doc fail to be expanded until they are used as
part of the eval in check(), resulting in (ex: url=fill) instead of what
was expected.

Transfer the 3 parameters to local variables which will be used instead
and that will be in scope without conflicting names.

While at it, make sure all of the parameters which potentially sensitive
characters (ex: ?#), are quote protected.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t0300-credentials.sh | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index bc2d74098f..e0b7c001f1 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -622,37 +622,43 @@ test_expect_success 'credential system refuses to work with missing protocol' '
 
 # usage: check_host_and_path <url> <expected-host> <expected-path>
 check_host_and_path () {
+	local url=$1
+	local host=$2
+	local path=$3
+
 	# we always parse the path component, but we need this to make sure it
 	# is passed to the helper
 	test_config credential.useHTTPPath true &&
-	check fill "verbatim user pass" <<-EOF
-	url=$1
+	check fill 'verbatim user pass' <<-EOF
+	url=$url
 	--
 	protocol=https
-	host=$2
-	path=$3
+	host=$host
+	path=$path
 	username=user
 	password=pass
 	--
 	verbatim: get
 	verbatim: protocol=https
-	verbatim: host=$2
-	verbatim: path=$3
+	verbatim: host=$host
+	verbatim: path=$path
 	EOF
 }
 
-test_expect_success 'url parser handles bare query marker' '
-	check_host_and_path https://example.com?foo.git example.com ?foo.git
-'
+test_expect_success 'url parser handles bare query marker' "
+	check_host_and_path 'https://example.com?foo.git' \
+		example.com '?foo.git'
+"
 
-test_expect_success 'url parser handles bare fragment marker' '
-	check_host_and_path https://example.com#foo.git example.com "#foo.git"
-'
+test_expect_success 'url parser handles bare fragment marker' "
+	check_host_and_path 'https://example.com#foo.git' \
+		example.com '#foo.git'
+"
 
-test_expect_success 'url parser not confused by encoded markers' '
-	check_host_and_path https://example.com%23%3f%2f/foo.git \
-		"example.com#?/" foo.git
-'
+test_expect_success 'url parser not confused by encoded markers' "
+	check_host_and_path 'https://example.com%23%3f%2f/foo.git' \
+		'example.com#?/' foo.git
+"
 
 test_expect_success 'credential config with partial URLs' '
 	echo "echo password=yep" | write_script git-credential-yep &&
-- 
2.26.2.812.g046d49d455

