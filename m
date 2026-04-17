Received: from 7.mo584.mail-out.ovh.net (7.mo584.mail-out.ovh.net [178.33.253.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CEB3624AF
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.253.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776446765; cv=none; b=J7m5cxw23brCincTp1WqFclgHbOO8bMLDjs+A4SuT72PbjOFMMC+DOfsddFF3tefo3xlCMmIBmzndDPFdQ0STjBsupBsaqiLLiXllnAW3Ilh8QpHjz9IsVhyaqQVrEq9v+ctVboQcT1bHjwvuInjyT8yYPGTXbIF7K4eGWxvdMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776446765; c=relaxed/simple;
	bh=oUwFnuuTo+/ImUl0tvZAFSMMO7A2lr8UdSbLEZ/teUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=imWaPGoHUrKRqkK6rZ8jVYTziETDe45iMU0RklkwEIUzWa8wLWKGYhwcM+f2sXsngLPjdEzRMRvf4EQ9DjuPlPhroUlpHBt2twg9gGOBI31d1hvMyzFWAfASfJiyVyOJYkbWcJ2X+yCMpaoLRIySDspLfEYZ7J03WnSPbIirj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de; spf=pass smtp.mailfrom=schlaraffenlan.de; arc=none smtp.client-ip=178.33.253.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schlaraffenlan.de
Received: from director1.ghost.mail-out.ovh.net (unknown [10.110.54.111])
	by mo584.mail-out.ovh.net (Postfix) with ESMTP id 4fy16k72zjz8Jbx
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 16:48:46 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-7kq2m (unknown [10.110.188.214])
	by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 8B4BFC0FF4;
	Fri, 17 Apr 2026 16:48:46 +0000 (UTC)
Received: from schlaraffenlan.de ([37.59.142.102])
	by ghost-submission-7d8d68f679-7kq2m with ESMTPSA
	id qjjuJGtk4mn7tAwAN7lZ4w:T3
	(envelope-from <kernel@schlaraffenlan.de>); Fri, 17 Apr 2026 16:48:46 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-102R0047e7b406f-dead-4fdd-8534-26c8b1e307fe,
                    B7C68D824A8F199700666F34D4E97AF0708B992A) smtp.auth=mail@schlaraffenlan.de
X-OVh-ClientIp:185.104.138.163
From: Jonas Rebmann <kernel@schlaraffenlan.de>
Date: Fri, 17 Apr 2026 18:48:31 +0200
Subject: [PATCH v3 2/2] rev-parse: use selected alternate terms to look up
 refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-bisect-terms-v3-2-d659fa547261@schlaraffenlan.de>
References: <20260417-bisect-terms-v3-0-d659fa547261@schlaraffenlan.de>
In-Reply-To: <20260417-bisect-terms-v3-0-d659fa547261@schlaraffenlan.de>
To: git@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Jeff King <peff@peff.net>, 
 Jonas Rebmann <kernel@schlaraffenlan.de>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15-dev-bc6c4
x-ovh-tracer-id: 7236721654852715487
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFweXHBPRtDYx/VT0BrMxm+tm7ZQPpIojW3v7HNJZLQGBRdwrXP41KUZsOUXQD4+APtvvOKL/N8LnBGLAwFEPNvfuhwjukkAaiIUND9JWnCvQ+W1uUG4KsacJROlTTr2vcLzlLWcwN6aDlDLzA2vT+X5p78bD1x6ucMNjli2yqWpx5p/9PXs2qdah92INfJIRInw/yJxjWEeGOU71/vUj0qapSLyJHH5a6qOJ/F4URtgSK+6gOz4KkF14rMlqKOeOpwRYMUQ/+EA8vWarRM1fgdv5FmC9dWMa8EB8xARjTLqrgFZB9te01ihNL5elukIjmXLkokaVjPt5+fRNtXuY5vIKRShyfAVTPRrTTzU67UztpRn4lAqKcI9JtnWDyDDpIp6Yj47ftV5U4/AoClhtz44Nmv2zXxSLhpGXisVCXsW5dqbZ8aIQ+HQKht75wdlgND+t4xiOQOYTyGxkdBFCZHEtsB6jE50s1m5DPhnGYfo3BZAUtq5C0Cfy9vKsbq/XhVenpmLn7Re40Y08AigAHVijRH/ec5tkOPogYSfONQ9nUt0+tw/jN94sfvUmazHReXbY1NeN80e2wBBscbpizr5x18U3rHWgozcJADXMvE5/p5hRqWJvIMk8b6N8fdegncQvyHYCl3NGy/dYfv5HZtcJCVoHvxUziozKr+pqHY/Q

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
2.53.0

