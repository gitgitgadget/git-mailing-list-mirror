From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 07/10] submodule foreach: send messages to stderr
Date: Fri, 29 Apr 2016 17:40:42 -0700
Message-ID: <1461976845-18228-8-git-send-email-sbeller@google.com>
References: <1461976845-18228-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 02:41:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awIyG-0006iW-Oj
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 02:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbcD3AlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 20:41:11 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35465 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963AbcD3AlF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 20:41:05 -0400
Received: by mail-pa0-f46.google.com with SMTP id iv1so51668636pac.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 17:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A0Rocfp/3jIv4G/63Jf2LmPF/YvleQ5jHLPKtySwvt8=;
        b=KiVz1xpXKDF0sTgUOsIIkulqwxsNV1NKfs4FHUhKFz6ARF2YzMjIHZpzv21AKGlvtP
         PB6gD6PanGnUDk9/YrfKFb89S3smudcOiLnXBBrsrigsQG+wOLwZu8k7nuN+XM4FyPyk
         UqgC887PQln5mZCzNGO5KgJgHDicwfig9SE3mAm2/VkJHcxKzv4tAS6Gflxz5kUq5OPm
         4xESR8RaSAt0UByxMjuyj0anoqsHMWjaJgAUdmn3yVYAiWVKHoSxtEndaf+4nwVcqBb1
         dwsN8LSl0VpfuoKUV5aEzM/Ji2LRSaYQFYVbl7WS89eSKEp2H+IM2BpX7+rMAxgn5UT4
         7SPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A0Rocfp/3jIv4G/63Jf2LmPF/YvleQ5jHLPKtySwvt8=;
        b=CbcoS6lvH2pM6xr92YMfP9JqFU6eJT3L2BFtiMRQzqGus9HIk5N77uucv5dwjqtTbt
         Us4cpuIKQl/LObKv8luYF2ohya4ZH4OvPrNttQKQIkBVEoHXPqdQgcUXC3xVEA4oAEM6
         kB/9gq0/hsvLkLFaPGiiNg6kxvDvXZ0TX604oQtzzyMKvMhSwTV0AxpvEDp8EE4++NzX
         i86E+zMnqOkSXSxcPLY+d/3kuA+RVAf2gR8JcF6fd3Et5HKhEi7+CJWUQR2ZRklM2A1h
         CHngBWqTZoItYHxEGolEdi70ajsiQ6UrQGRYPo87y/QvdqG7y+wqAZLaKtTz6UD+DEaf
         jGhg==
X-Gm-Message-State: AOPr4FUJnVM9lZIvZJgOJZ0VaIQQE5n9eCwbyZm+cOPHKAu63dU5Sg41fzAY2O7+CDxaF9KQ
X-Received: by 10.66.43.143 with SMTP id w15mr28113911pal.76.1461976859429;
        Fri, 29 Apr 2016 17:40:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id kh2sm33483598pad.9.2016.04.29.17.40.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 17:40:58 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461976845-18228-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293093>

Reroute the output of stdout to stderr as it is just informative
messages, not to be consumed by machines.

This should not regress any scripts that try to parse the
current output, as the output is already internationalized
and therefore unstable.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh             |  2 +-
 t/t7407-submodule-foreach.sh | 35 ++++++++++++++++++++++-------------
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3f67f4e..80270db 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -341,7 +341,7 @@ cmd_foreach()
 		if test -e "$sm_path"/.git
 		then
 			displaypath=$(relative_path "$prefix$sm_path")
-			say "$(eval_gettext "Entering '\$displaypath'")"
+			say >&2 "$(eval_gettext "Entering '\$displaypath'")"
 			name=$(git submodule--helper name "$sm_path")
 			(
 				prefix="$prefix$sm_path/"
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 6ba5daf..f9b979a 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -61,29 +61,36 @@ sub3sha1=$(cd super/sub3 && git rev-parse HEAD)
 
 pwd=$(pwd)
 
-cat > expect <<EOF
-Entering 'sub1'
+cat >expect <<EOF
 $pwd/clone-foo1-sub1-$sub1sha1
-Entering 'sub3'
 $pwd/clone-foo3-sub3-$sub3sha1
 EOF
 
+cat >expect2 <<EOF
+Entering 'sub1'
+Entering 'sub3'
+EOF
+
 test_expect_success 'test basic "submodule foreach" usage' '
 	git clone super clone &&
 	(
 		cd clone &&
 		git submodule update --init -- sub1 sub3 &&
-		git submodule foreach "echo \$toplevel-\$name-\$path-\$sha1" > ../actual &&
+		git submodule foreach "echo \$toplevel-\$name-\$path-\$sha1" >../actual 2>../actual2 &&
 		git config foo.bar zar &&
 		git submodule foreach "git config --file \"\$toplevel/.git/config\" foo.bar"
 	) &&
-	test_i18ncmp expect actual
+	test_i18ncmp expect actual &&
+	test_i18ncmp expect2 actual2
 '
 
-cat >expect <<EOF
+cat >expect2 <<EOF
 Entering '../sub1'
-$pwd/clone-foo1-../sub1-$sub1sha1
 Entering '../sub3'
+EOF
+
+cat >expect <<EOF
+$pwd/clone-foo1-../sub1-$sub1sha1
 $pwd/clone-foo3-../sub3-$sub3sha1
 EOF
 
@@ -91,9 +98,10 @@ test_expect_success 'test "submodule foreach" from subdirectory' '
 	mkdir clone/sub &&
 	(
 		cd clone/sub &&
-		git submodule foreach "echo \$toplevel-\$name-\$sm_path-\$sha1" >../../actual
+		git submodule foreach "echo \$toplevel-\$name-\$sm_path-\$sha1" >../../actual 2>../../actual2
 	) &&
-	test_i18ncmp expect actual
+	test_i18ncmp expect actual &&
+	test_i18ncmp expect2 actual2
 '
 
 test_expect_success 'setup nested submodules' '
@@ -172,7 +180,7 @@ EOF
 test_expect_success 'test messages from "foreach --recursive"' '
 	(
 		cd clone2 &&
-		git submodule foreach --recursive "true" > ../actual
+		git submodule foreach --recursive "true" 2>../actual
 	) &&
 	test_i18ncmp expect actual
 '
@@ -192,7 +200,7 @@ test_expect_success 'test messages from "foreach --recursive" from subdirectory'
 		cd clone2 &&
 		mkdir untracked &&
 		cd untracked &&
-		git submodule foreach --recursive >../../actual
+		git submodule foreach --recursive 2>../../actual
 	) &&
 	test_i18ncmp expect actual
 '
@@ -210,9 +218,10 @@ EOF
 test_expect_success 'test "foreach --quiet --recursive"' '
 	(
 		cd clone2 &&
-		git submodule foreach -q --recursive "echo \$name-\$path" > ../actual
+		git submodule foreach -q --recursive "echo \$name-\$path" >../actual 2> ../actual2
 	) &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test_must_be_empty actual2
 '
 
 test_expect_success 'use "update --recursive" to checkout all submodules' '
-- 
2.8.0.32.g71f8beb.dirty
