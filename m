Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E564E18CBE6
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725922830; cv=none; b=sEpIk4FkPV2c0N33kqXNGYCFMfA54aQoDEC08wTtp01Rn+nexZ8MADAA6eM4QlSZSWuYXTOvZrBbTcY9kftKazVNOT/n6G35ywYHgJ3fHXrzfuNczAU9fqIetDyIH2y1AcfRQ+raE50ZbGqsujGRvgI7K05b2s2f+hF7p8LCeJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725922830; c=relaxed/simple;
	bh=6Lp+08hPZN+t/j0j8emQeHJmCTm55+RP66qBTny4pJo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LuT91HEEm16jk08DBQ5f9F8e/D1R8CWeGsTLFtJ+LVm1xINXriCnJtYCA2AIKHGozGWs8+LGPMyk98arRZdryPsStoi0ZsoMHXBI2Biz7JlzdLMNf9GZdtWJdcd/eAsxqi8zOhvgLP/XG3qu++1ppPEs1puqHWcDemi7c5SIfZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pIowIUCz; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pIowIUCz"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 578A22D302;
	Mon,  9 Sep 2024 19:00:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=6
	Lp+08hPZN+t/j0j8emQeHJmCTm55+RP66qBTny4pJo=; b=pIowIUCzhlsXoa8oa
	fwKuG9BMWUElKKsTz9xd4V/8H330nxxooGUuqvrWeFw8/ue4Zfsx3PJsP8CqKZ5d
	fKkmKdGLUqCR9Si3r1f9+SV2bFHEIUzLJ0pxoTc0m/pdQVUHus8Iu9LgNv9hdNdS
	B6jBsjnXHETgZfH7tKjlxwpYew=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4ED8D2D301;
	Mon,  9 Sep 2024 19:00:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C2EA2D300;
	Mon,  9 Sep 2024 19:00:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] ci: remove 'Upload failed tests' directories' step from
 linux32 jobs
Date: Mon, 09 Sep 2024 16:00:20 -0700
Message-ID: <xmqqy140o2kb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4A737D4C-6EFF-11EF-A047-9B0F950A682E-77302942!pb-smtp2.pobox.com

Linux32 jobs seem to be getting:

    Error: This request has been automatically failed because it uses a
    deprecated version of `actions/upload-artifact: v1`. Learn more:
    https://github.blog/changelog/2024-02-13-deprecation-notice-v1-and-v2-of-the-artifact-actions/

before doing anything useful.  For now, disable the step.

Ever since actions/upload-artifact@v1 got disabled, mentioning the
offending version of it seems to stop anything from happening.  At
least this should run the same build and test.

See

    https://github.com/git/git/actions/runs/10780030750/job/29894867249

for example.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .github/workflows/main.yml | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 1ee0433acc..97f9b06310 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -365,12 +365,6 @@ jobs:
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
-    - name: Upload failed tests' directories
-      if: failure() && env.FAILED_TEST_ARTIFACTS != '' && matrix.vector.jobname == 'linux32'
-      uses: actions/upload-artifact@v1 # cannot be upgraded because Node.js Actions aren't supported in this container
-      with:
-        name: failed-tests-${{matrix.vector.jobname}}
-        path: ${{env.FAILED_TEST_ARTIFACTS}}
   static-analysis:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
-- 
2.46.0-701-g65fb39cb77

