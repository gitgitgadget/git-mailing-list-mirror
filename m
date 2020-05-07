Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AFBC38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 05:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FCCA20753
	for <git@archiver.kernel.org>; Thu,  7 May 2020 05:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/xVjXNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgEGFvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 01:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgEGFvy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 01:51:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9541C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 22:51:52 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 145so2427711pfw.13
        for <git@vger.kernel.org>; Wed, 06 May 2020 22:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lq2kFwtyKSJ88AwJVpJVujE3bOp/Mk9LG9ekW/VXwX8=;
        b=m/xVjXNsKJzlB3mxukTQ0fb9cxBhpzKNj3sSXiHoG/c395kMdX84U67hDeiP64Sdhk
         3LkeK12CBfcCPbmCqAH/hcXruC2wjWDop4dj9KpJonWLwzbeUB9foA3tz5GLWn4AWb2z
         oCgz6RR3Ke8RIkBArpxjmFu9Q24GqPb3U/QLPv/WBy3H44nihwrLfHEUBCeXt4QBJDMS
         glHrMpRAi+dWmdTqbVR2R2BpFxe1ma7J8In613B8w/0hwaePeEretGxPpOUXMio66OKz
         Mscx5Q1diUrQNwd7EBhyccSBINkMyOcF58LI3LeW42ESFHzX5GcZ6zYOKMHsI/IGj4/d
         AuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lq2kFwtyKSJ88AwJVpJVujE3bOp/Mk9LG9ekW/VXwX8=;
        b=gB3iRZrrKLjKxUlP0Q6+H4k0PVk/JH7eJc4ctF1XjySdyjMeYPO4B5SCsXdNNyHhxM
         +MybJW2GlOV0jdBzfRPW7K4/tiHTfbuxNlTlu7kELQTnT3HJO8ZISYBky7Cnpgc0eP3o
         MPxg32i5GIVfB4hNz74auTRfJ0XWpgx5og681JfTU+1dt4bYOE2MSLNgEtI/FLj8RCw8
         k4gq3IPPVJHd+uW8OGUSczdOGY7IgJNOfprQLCpU5csXLO6xUupcNQQ6BCko9GOQOeWg
         fuqD1981j58XeIecjcHTpMFmP6ec8BROmPwwiKzIYY7XClEDsUpXdbonuY2ATG59t+mZ
         yDHw==
X-Gm-Message-State: AGi0PubW2t+SXZ3XO6Ik65XS/8Hx4JpOCoCL/pgQwyKPToQA1du52ah8
        MT6HbeqXUhRmMeiiPO7/BkTBaMHi
X-Google-Smtp-Source: APiQypJgIKbf+9EiI3LAEw939i6osCbWqtQLYue5c3TmK75thcsLbvimFrde6x7+wK4q4dTPf5Lr5w==
X-Received: by 2002:a63:1447:: with SMTP id 7mr9936749pgu.253.1588830711766;
        Wed, 06 May 2020 22:51:51 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id t206sm2046629pfc.212.2020.05.06.22.51.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2020 22:51:51 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     congdanhqx@gmail.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] t/test_lib: avoid naked bash arrays in file_lineno
Date:   Wed,  6 May 2020 22:51:18 -0700
Message-Id: <20200507055118.69971-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.686.gfaf46a9ccd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

662f9cf154 (tests: when run in Bash, annotate test failures with file
name/line number, 2020-04-11), introduces a way to report the location
(file:lineno) of a failed test case by traversing the bash callstack.

The implementation requires bash and is therefore protected by a guard
but NetBSD sh will still have to parse the function and therefore will
result in:

  ** t0000-basic.sh ***
  ./test-lib.sh: 681: Syntax error: Bad substitution

Enclose the bash specific code inside an eval to avoid parsing errors
and while at it, simplify the logic so that instead of traversing the
callstack just pop the two topmost entries that are required.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/test-lib.sh | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1b221951a8..60b8e70678 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -677,14 +677,13 @@ die () {
 
 file_lineno () {
 	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" && test -n "$BASH" || return 0
-	local i
-	for i in ${!BASH_SOURCE[*]}
-	do
-		case $i,"${BASH_SOURCE[$i]##*/}" in
-		0,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:$LINENO: ${1+$1: }"; return;;
-		*,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:${BASH_LINENO[$(($i-1))]}: ${1+$1: }"; return;;
-		esac
-	done
+	eval '
+		local n=$(echo ${#BASH_SOURCE[*]})
+		if test $n -ge 2
+		then
+			echo "${BASH_SOURCE[$n - 1]}:${BASH_LINENO[$n - 2]}: $1: "
+		fi
+	'
 }
 
 GIT_EXIT_OK=
-- 
2.26.2.686.gfaf46a9ccd

