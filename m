Received: from 15.mo584.mail-out.ovh.net (15.mo584.mail-out.ovh.net [91.121.62.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BCD3AF647
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.62.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774336364; cv=none; b=Os+DYO5GvipafnW6lag2yoOJd/xgPIsJi2A8WVirzBoOfEGQ/IJTh/VQNDUGnmSeX4RgeCK6yWF4dDNxuOGvOKI6jrjGmW2P2LC7Rbsfv6BqnSjbZmMtzUDLA/iOZQ3QB95NsHz6eQmNPNFFVD3T2ewOKcfVK7yaS7WJYlsjmtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774336364; c=relaxed/simple;
	bh=mbzp4HtVM7GweGfIhvu708NVrgFYygjINk0nQktUR3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JYVWTaw47L6XIUHF0kOOqk3ZKo0EtB0PzJYrVrfaJIVdXVVl/6A1sbteQhJ+NVQaLlEDScmqc5mqBk1CQfiMjpREbwrfLsCUCHZ3UzAkcTj2G//jgxPV1IpENm7NxmrqrZgaGArBSQp7Kwvsz1s2AzEq7TXhVe4Vwg+lLWxEYRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de; spf=pass smtp.mailfrom=schlaraffenlan.de; arc=none smtp.client-ip=91.121.62.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schlaraffenlan.de
Received: from director8.ghost.mail-out.ovh.net (unknown [10.110.54.21])
	by mo584.mail-out.ovh.net (Postfix) with ESMTP id 4ffpJ44YLqz88YR
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 22:49:08 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-77wzd (unknown [10.108.54.44])
	by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 530A9C002A;
	Mon, 23 Mar 2026 22:49:08 +0000 (UTC)
Received: from schlaraffenlan.de ([37.59.142.102])
	by ghost-submission-7d8d68f679-77wzd with ESMTPSA
	id mhIMMGLDwWl78T0AiVxfvA:T3
	(envelope-from <kernel@schlaraffenlan.de>); Mon, 23 Mar 2026 22:49:08 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-102R004032af809-09ba-445d-b4e5-8d49099c407e,
                    CF5F45155CC526890A7B96C462E82A48810857C8) smtp.auth=mail@schlaraffenlan.de
X-OVh-ClientIp:95.90.63.4
From: Jonas Rebmann <kernel@schlaraffenlan.de>
Date: Mon, 23 Mar 2026 23:49:00 +0100
Subject: [PATCH v2 2/2] rev-parse: use selected alternate terms too look up
 refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-bisect-terms-v2-2-8d6bdb2c9c7e@schlaraffenlan.de>
References: <20260323-bisect-terms-v2-0-8d6bdb2c9c7e@schlaraffenlan.de>
In-Reply-To: <20260323-bisect-terms-v2-0-8d6bdb2c9c7e@schlaraffenlan.de>
To: git@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Jeff King <peff@peff.net>, 
 Jonas Rebmann <kernel@schlaraffenlan.de>
X-Mailer: b4 0.15-dev-bc6c4
x-ovh-tracer-id: 14079378337809990531
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGCOKmilFZY0xn7KtNqWcWaoSJYVp6S4ux6HgOeCxItNsp96kyGpK21LDFn+9JmIEgIh6fafeLnh/R4zGAxj5p7NraRD3k0iGMP474HvBtQX/T7wWnFUO4Y+ZzbEG3MeATluciy2Z/ouEeZ8uWGITkqKQPA0TpNDFc0pzlwoLaKvosLwKDxhA6JY2QeSZJP0x1z0Cdj3byhh/JVa02fTBsFoqG2jbSzavijyEMzKi8L3WGXbqgzWyv9gI3Dgeh1bEGGTvdgSjaRica1IWYhDuFLI4fNn01O1XE0dwmVy4/L2nVlHBwd0u2H4rHFXddCZm3yK72jtPkpP56cc6Q6k26TigPAL0pycn7/1YSTJ3gYJD5zLHOG+jauGF5ZZtAiAesdFngC/yqI7lAvIfel+nWLV6KuVK6ovd72tCxX4QfkfB0OazBlIbXg+g2QOXHEw7Fx6BDFl+Hl/axwiPtlkm438GmVasCUjCnFSN8zyKHrEWNm9hN0EHByAKrgDb6DbmXEBY4V5+2LfqnJOLic00WH6Ku5oziGoOiWEigglnTejMnFbdOQYPrZ0NccrLYSUtAAlrfcee4UEBXXg3MTk8NSfEtNFsPUowC0RR0RAH7fPc+kisTsuB4pGbB/exskv6uMa5NngO3M8ZaaXasD0/nOJhujpS5lH68cHmf8/2elRQ

An old/new bisect will name refs "refs/bisect/old" (or new) accordingly
so the hardcoded "refs/bisect/bad" (and good) yields no results in a
bisect using alternate terms.

Use the current bisect_terms to make rev-parse --bisect work in an
alternate term bisect.

Signed-off-by: Jonas Rebmann <kernel@schlaraffenlan.de>
---
 builtin/rev-parse.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 01a62800e8..f20f0554ed 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -10,6 +10,7 @@
 #include "builtin.h"
 
 #include "abspath.h"
+#include "bisect.h"
 #include "config.h"
 #include "commit.h"
 #include "environment.h"
@@ -940,11 +941,14 @@ int cmd_rev_parse(int argc,
 				continue;
 			}
 			if (!strcmp(arg, "--bisect")) {
+				char *term_bad = NULL;
+				char *term_good = NULL;
 				struct refs_for_each_ref_options opts = { 0 };
-				opts.prefix = "refs/bisect/bad";
+				read_bisect_terms(&term_bad, &term_good);
+				opts.prefix = xstrfmt("refs/bisect/%s", term_bad);
 				refs_for_each_ref_ext(get_main_ref_store(the_repository),
 						      show_reference, NULL, &opts);
-				opts.prefix = "refs/bisect/good";
+				opts.prefix = xstrfmt("refs/bisect/%s", term_good);
 				refs_for_each_ref_ext(get_main_ref_store(the_repository),
 						      anti_reference, NULL, &opts);
 				continue;

-- 
2.53.0

