Received: from 9.mo581.mail-out.ovh.net (9.mo581.mail-out.ovh.net [46.105.60.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A2225417
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 01:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.60.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774055640; cv=none; b=b/kpAydOV3rOM8XyrBD0zDPlvQ6SwHtWFGNwiUZQw4P6EG+/5/j/xF656uqqN9dfB5bJttdHNjYH0cMb8zD8oK8+nSwcor2Y+3szzqZyYrhkJVukN5tp2PZ71yEU/27hcCaBlwJE3Hj/zdg4wmPDyKfgOzNsWh892gB9XLboTWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774055640; c=relaxed/simple;
	bh=Ya5l+AWtx3ahMS1CT1ozOXfJ73mpZZXBPS9RVAWNLpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Nmuwg4Xno7MaZDKJqpFNuUVjUDMz+CpJLsGMlf1TUAzEYGYcplQXOw74hOoE31FqY7DqZNDSqRMHQlKZi4gPv5ocNVCezcMo9k+baOEipDzrK8f+H8ngxCq17tKhs5i/akPSMWIIhfwqhUl2IMHXm/dB7A/HTUal+hNozUzG6wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de; spf=pass smtp.mailfrom=schlaraffenlan.de; arc=none smtp.client-ip=46.105.60.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schlaraffenlan.de
Received: from director10.ghost.mail-out.ovh.net (unknown [10.110.43.217])
	by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4fcrC04NxLz5xGg
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 18:07:56 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-jwpfw (unknown [10.110.188.54])
	by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 1B6E5C1017;
	Fri, 20 Mar 2026 18:07:56 +0000 (UTC)
Received: from schlaraffenlan.de ([37.59.142.109])
	by ghost-submission-7d8d68f679-jwpfw with ESMTPSA
	id A1sXN/uMvWk0LS8A1sYYng
	(envelope-from <kernel@schlaraffenlan.de>); Fri, 20 Mar 2026 18:07:56 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-109S003046d674b-9f68-4263-aa03-d57d77718664,
                    578593E53A8C33563E81521E5E811B7E74F4CCB6) smtp.auth=mail@schlaraffenlan.de
X-OVh-ClientIp:95.90.63.4
From: Jonas Rebmann <kernel@schlaraffenlan.de>
Date: Fri, 20 Mar 2026 19:07:52 +0100
Subject: [PATCH] bisect: use selected alternate terms in status output
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-bisect-terms-v1-1-c30c9540542a@schlaraffenlan.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QpAQBBFf0XzbGutWvEr8sAajLK0g9Tm3w26T
 +fWOREYAyFDlUQIeBLT6gWyNAE3tX5ERb0wGG2szo1WHTG6Xe0YFlaFfNYWstKBKFvAga4vVzc
 /89HNIrwNuO8HsXSN63AAAAA=
X-Change-ID: 20260320-bisect-terms-76036676769c
To: git@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Jeff King <peff@peff.net>, 
 Jonas Rebmann <kernel@schlaraffenlan.de>
X-Mailer: b4 0.14.3
x-ovh-tracer-id: 10158994859933074209
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE4w9TsqG1wOqVzCEl4vj40TpiVEaBdpRB6RMF4UdMwkLcVHMM8EJetHMyqCIlYVpBhAiHdzy/uA290AnhTIlQi+ZRYqunbCLSr82tcksW6b05mqCePpEwWsYqlF1Na9uC/shzg4kWS7QPxjaBJ+8qhiUqYGGKobNLov7PP7zyRlPIUysR9LCGu0WNFOFaDfU9/7MqWw7Xa+GI3YW3VMjWUENLpq5qAJDqb+JG0MHGQLQ5bCtbX7QbbozqnDI4LxP127D7g0pZJQcGZkyQNL5+m7CDTmaN6N0P6iwZX4mMk8BlvlYB6xIFo+K2MwVDzNYIVdg1RRi6vq68hHTsuIr1SrQSw4/jXNcmB/qqhCLHxyf3qRi/P2qidu5brMCsXabePUhHxfo8oawqXbxH2KDmTLhSIfxN/s8YDZ9zV0oJQcCw3U0YiwZ88xJ2f2vdlmLwKgUTAmpMsabiNt2VzCXZ51Ccq7kSzAf/oXS+rrbr/7pDGU2M1uPry5hUOeSqf2R2wX38HEA7051opM8xbd9X/POt8BB3DtVYOBrqiDHCOS+jRPSGw4d3d9CwURzuFTa+dIAJDOlZprSBp3lRk6+8/bYB5XH47rfAH0GG/TeriHKq7PP6p3TRHDktSlVjVN0jhQnR98XRZ8hIi5M467gRB0L3wbZeSPiMeoBqiMp6i9g

Alternate bisect terms are helpful when the terms "good" and "bad" are
confusing such as when bisecting for the resolution of an issue (the
first good commit) rather than the introduction of a regression. If
alternate terms are chosen, the terms "good" and "bad" should not be
used in git's output to avoid confusion.

An old/new bisect should end with
$ git bisect old
[sha] is the first new commit

not with
$ git bisect old
[sha] is the first bad commit

Using hardcoded good/bad vocabulary can give confusion about what action
is required:

  status: waiting for bad commit, 1 good commit known
  $ git bisect bad
  error: Invalid command: you're currently in a new/old bisect
  fatal: unknown command: 'bad'

To avoid confusion, use alternate terms consistently across the bisect
output.

Signed-off-by: Jonas Rebmann <kernel@schlaraffenlan.de>
---
 builtin/bisect.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 4520e585d0..ee6a2c83b8 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -465,13 +465,16 @@ static void bisect_print_status(const struct bisect_terms *terms)
 		return;
 
 	if (!state.nr_good && !state.nr_bad)
-		bisect_log_printf(_("status: waiting for both good and bad commits\n"));
+		bisect_log_printf(_("status: waiting for both %s and %s commits\n"),
+				  terms->term_good, terms->term_bad);
 	else if (state.nr_good)
-		bisect_log_printf(Q_("status: waiting for bad commit, %d good commit known\n",
-				     "status: waiting for bad commit, %d good commits known\n",
-				     state.nr_good), state.nr_good);
+		bisect_log_printf(Q_("status: waiting for %s commit, %d %s commit known\n",
+				     "status: waiting for %s commit, %d %s commits known\n",
+				     state.nr_good),
+				  terms->term_bad, state.nr_good, terms->term_good);
 	else
-		bisect_log_printf(_("status: waiting for good commit(s), bad commit known\n"));
+		bisect_log_printf(_("status: waiting for %s commit(s), %s commit known\n"),
+				  terms->term_good, terms->term_bad);
 }
 
 static int bisect_next_check(const struct bisect_terms *terms,
@@ -1262,14 +1265,14 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 			int rc = verify_good(terms, command.buf);
 			is_first_run = 0;
 			if (rc < 0 || 128 <= rc) {
-				error(_("unable to verify %s on good"
-					" revision"), command.buf);
+				error(_("unable to verify %s on %s"
+					" revision"), command.buf, terms->term_good);
 				res = BISECT_FAILED;
 				break;
 			}
 			if (rc == res) {
-				error(_("bogus exit code %d for good revision"),
-				      rc);
+				error(_("bogus exit code %d for %s revision"),
+				      rc, terms->term_good);
 				res = BISECT_FAILED;
 				break;
 			}
@@ -1314,7 +1317,7 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 			puts(_("bisect run success"));
 			res = BISECT_OK;
 		} else if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
-			puts(_("bisect found first bad commit"));
+			printf(_("bisect found first %s commit\n"), terms->term_bad);
 			res = BISECT_OK;
 		} else if (res) {
 			error(_("bisect run failed: 'git bisect %s'"

---
base-commit: 1eceb487f285f1efa78465e6208770318f9f4892
change-id: 20260320-bisect-terms-76036676769c

Best regards,
-- 
Jonas Rebmann <kernel@schlaraffenlan.de>

