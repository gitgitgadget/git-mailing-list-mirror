From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [RFC/PATCH 2/2] config: Add test of safe-include feature
Date: Fri,  3 Oct 2014 03:37:34 +0200
Message-ID: <1412300254-11281-3-git-send-email-rv@rasmusvillemoes.dk>
References: <xmqqy4t7a5vx.fsf@gitster.dls.corp.google.com>
 <1412300254-11281-1-git-send-email-rv@rasmusvillemoes.dk>
Cc: Jeff King <peff@peff.net>, Joe Perches <joe@perches.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 03 03:38:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZrou-00016E-IM
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 03:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436AbaJCBh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 21:37:59 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:59260 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbaJCBh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 21:37:57 -0400
Received: by mail-la0-f48.google.com with SMTP id gi9so232301lab.21
        for <git@vger.kernel.org>; Thu, 02 Oct 2014 18:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EvIA3qxOXOUDxip+KOCmVcNKdR4pT3V86jXRlKUg09A=;
        b=GE8BVnZMgAqbohF07JbHclJhFptr6sopzvaZag4hoaGu6NF+5dp+k7ucdpqk/pw1+E
         4qzee/kNnZ3GD/3Gi30OKBAa4SomZJrRqon0F1KZ24hTJq7aTJo36hcV5Om9+unl902A
         d3KU2qhb+pVVL57939aKW2usgFILt03FLPreI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EvIA3qxOXOUDxip+KOCmVcNKdR4pT3V86jXRlKUg09A=;
        b=DR1+Cp2hyxMsdNwsXwm8mlAHYLqxZCsx+YeuHiS2ga1ntd+7iCCGzXnCHnBw/GR6Ye
         1tFvletablVSsKGARiCmRd27wZYlZTwbCP47J/9CI4aFBibJxFXd8MA1T8RWjrMjfRM4
         jqe/P/UgI1i75h9bjx5Ts5FG1Wm5qK/FkH0l8nuWONoOa+5iefbiHHta8pW/LoF1801p
         p03FfAknLgC9hGeApbgy2pCzHhc5NSq3i4xUHSHZ8FhL5DDhsbp8Yv4fm9NPp1YgB71B
         +P5vRARLv9urDHI3up7DSfv2ueI6ntv2dhKR2FTInoMNHFDKtIgctXiMOgo/Ii6AE7Wu
         MTDw==
X-Gm-Message-State: ALoCoQlfKByglNTgOl6cSbe1Q/pjWA+tvIHCYfPzPoYybcdHuJzlEBFQ7H5CL5R+6v+LH+2vT35s
X-Received: by 10.152.88.97 with SMTP id bf1mr2318954lab.58.1412300275772;
        Thu, 02 Oct 2014 18:37:55 -0700 (PDT)
Received: from spencer.imf.au.dk ([130.225.20.51])
        by mx.google.com with ESMTPSA id v7sm2126751lbp.44.2014.10.02.18.37.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Oct 2014 18:37:55 -0700 (PDT)
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1412300254-11281-1-git-send-email-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257828>

This adds a script for testing various aspects of the safe-include feature.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 t/t1309-config-safe-include.sh | 96 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100755 t/t1309-config-safe-include.sh

diff --git a/t/t1309-config-safe-include.sh b/t/t1309-config-safe-include.sh
new file mode 100755
index 0000000..b8ccc94
--- /dev/null
+++ b/t/t1309-config-safe-include.sh
@@ -0,0 +1,96 @@
+#!/bin/sh
+
+test_description='test config file safe-include directives'
+. ./test-lib.sh
+
+
+test_expect_success 'blacklist by default' '
+	echo "[diff]external = badprog" >project &&
+	echo "[safe-include]path = project" >.gitconfig &&
+	test_must_fail git config diff.external
+'
+
+
+test_expect_success 'builtin safe rules' '
+	echo "[diff]renames = true" >project &&
+	echo "[safe-include]path = project" >.gitconfig &&
+	echo true >expect &&
+	git config diff.renames >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'user blacklist taking precedence' '
+	echo "[diff]renames = true" >project &&
+	cat >.gitconfig <<-\EOF &&
+	[diff]renames = false
+	[safe-include]whitelist = !diff.renames
+	[safe-include]path = project
+	EOF
+	echo false >expect &&
+	git config diff.renames >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'wildcard matching' '
+	cat >project <<-\EOF &&
+	[test]beer = true
+	[test]bar = true
+	[test]foo = true
+	EOF
+	cat >.gitconfig <<-\EOF &&
+	[safe-include]whitelist = test.b*r
+	[safe-include]path = project
+	EOF
+	printf "test.bar true\ntest.beer true\n" | sort >expect &&
+	git config --get-regexp "^test" | sort >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ignore whitelist directives in safe-included files' '
+	cat >project <<-\EOF &&
+	[safe-include]whitelist = *
+	[diff]external = badprog
+	EOF
+	echo "[safe-include]path = project" >.gitconfig &&
+	test_must_fail git config diff.external
+'
+
+test_expect_success 'multiple whitelist/blacklist patterns in one line' '
+	cat >.gitconfig <<-\EOF &&
+	[safe-include]whitelist = !* foo.bar squirrel.* !squirrel.xyz
+	[safe-include]path = project
+	EOF
+	cat >project <<-\EOF &&
+	[diff]renames = true
+	[foo]bar = bar
+	[squirrel]abc = abc
+	[squirrel]xyz = xyz
+	EOF
+	test_must_fail git config diff.renames &&
+	test_must_fail git config squirrel.xyz &&
+	echo bar >expect &&
+	git config foo.bar >actual &&
+	test_cmp expect actual
+	echo abc >expect &&
+	git config squirrel.abc >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'case insensitivity' '
+	cat >.gitconfig <<-\EOF &&
+	[safe-include]whitelist = Test.Abc test.xyz
+	[safe-include]path = project
+	EOF
+	cat >project <<-\EOF &&
+	[test]abc = abc
+	[TeST]XyZ = XyZ
+	EOF
+	echo abc >expect &&
+	git config test.abc >actual &&
+	test_cmp expect actual &&
+	echo XyZ >expect &&
+	git config test.xyz >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.0.4
