Received: from 12.mo561.mail-out.ovh.net (12.mo561.mail-out.ovh.net [188.165.41.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAE718EB0
	for <git@vger.kernel.org>; Thu, 14 May 2026 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.41.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778754172; cv=none; b=pPm2JgOTMHHZZUAGJCGVW6ymEjIQs8G0rJhzzVM1L7nSyvpZ6smI+oLRcGyH4zPEP1Nse+btqIBvBdySZwUOsBoTuxXvZz47PKh2eUch2A2ntQsOULL5gTqOGmPDL04P1k9O06Dx3IK88t+byVBG6o31C2km9WLmvXigaZUve0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778754172; c=relaxed/simple;
	bh=UBZqTzPTuQwXQnTwRxpVeOnY3MFptq0LhlW+9RHMLFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sinNW3ueYrix2DZ7fZkSknnB5rQftp7JU8mt2W60p8ZAwSm1rPYaj7KWf0lUO8bYXARdz50y8GZRvpF6T+IFFL3faoHnekwizIoQqp1uKU6ktIMzq0VkOaR7shWNR/Paa3rVrIspStWEkT1lauB6aWfre/v1CZFi5G7nG4Z7RvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de; spf=pass smtp.mailfrom=schlaraffenlan.de; arc=none smtp.client-ip=188.165.41.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schlaraffenlan.de
Received: from director3.ghost.mail-out.ovh.net (unknown [10.109.231.194])
	by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4gGPbf3rs3z60Vx
	for <git@vger.kernel.org>; Thu, 14 May 2026 09:07:10 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-d4cxr (unknown [10.110.113.233])
	by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 387BAC04E3;
	Thu, 14 May 2026 09:07:10 +0000 (UTC)
Received: from schlaraffenlan.de ([37.59.142.114])
	by ghost-submission-7d8d68f679-d4cxr with ESMTPSA
	id kOqGG7yQBWrumSQAmZP82g:T4
	(envelope-from <kernel@schlaraffenlan.de>); Thu, 14 May 2026 09:07:10 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-114S008af4490e1-64da-4304-b5a8-cd8f7c7ff1f5,
                    C39F0B467605CB235B8620DBAA124B5209E80D88) smtp.auth=mail@schlaraffenlan.de
X-OVh-ClientIp:95.90.63.4
From: Jonas Rebmann <kernel@schlaraffenlan.de>
Date: Thu, 14 May 2026 11:07:06 +0200
Subject: [PATCH v4 3/3] rev-parse: use selected alternate terms to look up
 refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-bisect-terms-v4-3-b3e3cf1b06ce@schlaraffenlan.de>
References: <20260514-bisect-terms-v4-0-b3e3cf1b06ce@schlaraffenlan.de>
In-Reply-To: <20260514-bisect-terms-v4-0-b3e3cf1b06ce@schlaraffenlan.de>
To: git@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Jeff King <peff@peff.net>, 
 Jonas Rebmann <kernel@schlaraffenlan.de>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15-dev-bc6c4
x-ovh-tracer-id: 10429773789517546273
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFcOjeNfd26R86/ODmyj5aIGkM2RT+7sDH6zAs5NouMmax32jf8r9BZHnSkO06pjzEa7iyv+AQLSlhEy4AwzQlQT9vxR59c+4GG9yA06dJwDIiKhG06ZkHRRd5NLfA+4vBIMoWcHZVvrEe2rq9Ij2fzHd0SPSwXawvkgNxKIPd7sDmzXcjYHnWCs+nZ5FIW3zRs3NxGQYXkjXWq+z/vIxMqkAnhnPMruSKJHkf5D4cTq7W/MnUotPU12Z0AXyLoE86UmUo6Vnd1JSz8sOc3jxKRE194yjg0FFmTw7+Zd1NbnCWtqxD+tKU/4OoxSqU4BC8UpySOgEbx4VGY5GZPInpkk72D7DWEQ/nj0al4ggFqpdlqofv7Fum6E3K/CViPIQi0pjP6+KULenc7m7yg5TWkASGQg9P2gPyfGNkVNFKfexNg3xs8U/4qMCJ4sMEtQf+eLSwq//20CpHdktzM+wlmX2jVfM43bxntQqjATeQJQUihD68thER15K2kysTYJE05ENbbxkjynl9EcuS/YbSWehaDsomgaFlmFbymL8Q0YyVHYo8G1rf8TBa3O6exv1SLTc7Y9PAC9HCyIO2uEg7kmTOsJuFoKSIyMPfwrO52D0+M4wUMSdijNVCBJkJjLYWdptl/sTnxrh5E4mSNGGOi+7eRf8gKcavOpgCXi54yBw

git rev-parse --bisect does not work when alternate bisect terms are
used, simply listing no revisions at all.

This is because a such bisect using e.g. "old" and "new" in place of
"good" and "bad" will name refs "refs/bisect/old" (or new) accordingly
so the hardcoded "refs/bisect/bad" (and good) yields no results in a
bisect using alternate terms.

Use the current bisect_terms to make rev-parse --bisect work in an
alternate term bisect.

Signed-off-by: Jonas Rebmann <kernel@schlaraffenlan.de>
---
 builtin/rev-parse.c  | 15 +++++++++++++--
 t/t1500-rev-parse.sh | 25 +++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 218b5f34d6..7531edae9e 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -10,6 +10,7 @@
 #include "builtin.h"
 
 #include "abspath.h"
+#include "bisect.h"
 #include "config.h"
 #include "commit.h"
 #include "environment.h"
@@ -940,13 +941,23 @@ int cmd_rev_parse(int argc,
 				continue;
 			}
 			if (!strcmp(arg, "--bisect")) {
+				char *prefix;
+				char *term_bad = NULL;
+				char *term_good = NULL;
 				struct refs_for_each_ref_options opts = { 0 };
-				opts.prefix = "refs/bisect/bad";
+				read_bisect_terms(&term_bad, &term_good);
+				prefix = xstrfmt("refs/bisect/%s", term_bad);
+				opts.prefix = prefix;
 				refs_for_each_ref_ext(get_main_ref_store(the_repository),
 						      show_reference, NULL, &opts);
-				opts.prefix = "refs/bisect/good";
+				free(prefix);
+				prefix = xstrfmt("refs/bisect/%s", term_good);
+				opts.prefix = prefix;
 				refs_for_each_ref_ext(get_main_ref_store(the_repository),
 						      anti_reference, NULL, &opts);
+				free(prefix);
+				free(term_good);
+				free(term_bad);
 				continue;
 			}
 			if (opt_with_value(arg, "--branches", &arg)) {
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 98c5a772bd..38067d95f7 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -337,6 +337,31 @@ test_expect_success 'rev-parse --bisect includes bad, excludes good' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rev-parse --bisect works with alternate terms' '
+	test_commit_bulk 6 &&
+
+	git bisect start --term-old=known --term-new=curious &&
+
+	git update-ref refs/bisect/curious-1 HEAD~1 &&
+	git update-ref refs/bisect/bad HEAD~2 &&
+	git update-ref refs/bisect/curious-3 HEAD~3 &&
+	git update-ref refs/bisect/known-3 HEAD~3 &&
+	git update-ref refs/bisect/curious-4 HEAD~4 &&
+	git update-ref refs/bisect/good HEAD~4 &&
+
+	# Note: refs/bisect/bad and refs/bisect/goood should be ignored because this
+	# is a bisect with custom terms (known/curious)
+	cat >expect <<-EOF &&
+	refs/bisect/curious-1
+	refs/bisect/curious-3
+	refs/bisect/curious-4
+	^refs/bisect/known-3
+	EOF
+
+	git rev-parse --symbolic-full-name --bisect >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--short= truncates to the actual hash length' '
 	git rev-parse HEAD >expect &&
 	git rev-parse --short=100 HEAD >actual &&

-- 
2.54.0

