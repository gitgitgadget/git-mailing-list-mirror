Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DDE1862A
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906387; cv=none; b=oNJILq3RU98R767AOeV4cXxi0xGHfjO4myU25rry0pKWId6liAnh3t/3xOyx+kEA5n87n+Yqn6ymF06m1NRZcFsCg/80WXRZLb8gIbrHI8NvrfufwPsj2CZsQLnCoExvo/5DBxt/aMoy6jB7+sFXZI2Ahnrm7vM8OUYlBjW4RoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906387; c=relaxed/simple;
	bh=eHQQmPMMzwVz4PRh310UR/rN+cRLzseRonB5Ih/fi3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElsaVzpxatodPm6xBv6uOl+9GPbrafM49X6d0S4mDTEJ17SN4ltoCmi6p7Dk2GuQxwGVnBzTFL1InQN6cmqzOFRcX4QMNKM+45Ni8NTaQIGoFM+pdGJDW+pbLOxlqD4BAT5pdJTj1rhFhCLCZLUFTM4pNpGepNEeVU4JB8IUJbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RniTBdf2; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RniTBdf2"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CF3CA26BBA;
	Fri,  2 Feb 2024 15:39:44 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=eHQQmPMMzwVz4PRh310UR/rN+
	cRLzseRonB5Ih/fi3k=; b=RniTBdf2EZwf/+aE5KkIZ9x4bxphhG5SUA/NiI2Yi
	NEsF6MQvqlOC7xAXtyd0XhufrruMbF1JYNcrIqAbJUcVs82abtqEJn4rVXAnIqY/
	qtsZwWoOTXZ7AFAruMEgjPqYV5FHLgDyYzBHVlkUK9LMNk0V/4CHc4bNrLsKv+uk
	as=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C6BFF26BB9;
	Fri,  2 Feb 2024 15:39:44 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DD06226BB8;
	Fri,  2 Feb 2024 15:39:40 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Oscar Dominguez <dominguez.celada@gmail.com>
Subject: [PATCH 1/2] GitHub Actions: update to checkout@v4
Date: Fri,  2 Feb 2024 12:39:34 -0800
Message-ID: <20240202203935.1240458-2-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-522-g2a540e432f
In-Reply-To: <20240202203935.1240458-1-gitster@pobox.com>
References: <20240202203935.1240458-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 308010A4-C20B-11EE-962C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

We seem to be getting "Node.js 16 actions are deprecated." warnings
for jobs that use checkout@v3.  Except for the i686 containers job
that is kept at checkout@v1 [*], update to checkout@v4, which is
said to use Node.js 20.

[*] 6cf4d908 (ci(main): upgrade actions/checkout to v3, 2022-12-05)
    refers to https://github.com/actions/runner/issues/2115 and
    explains why container jobs are kept at checkout@v1.  We may
    want to check the current status of the issue and move it to the
    same version as other jobs, but that is outside the scope of
    this step.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .github/workflows/check-whitespace.yml |  2 +-
 .github/workflows/coverity.yml         |  2 +-
 .github/workflows/main.yml             | 18 +++++++++---------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/c=
heck-whitespace.yml
index a58e2dc8ad..a241a63428 100644
--- a/.github/workflows/check-whitespace.yml
+++ b/.github/workflows/check-whitespace.yml
@@ -19,7 +19,7 @@ jobs:
   check-whitespace:
     runs-on: ubuntu-latest
     steps:
-    - uses: actions/checkout@v3
+    - uses: actions/checkout@v4
       with:
         fetch-depth: 0
=20
diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.=
yml
index e5532d381b..a81a7566d1 100644
--- a/.github/workflows/coverity.yml
+++ b/.github/workflows/coverity.yml
@@ -38,7 +38,7 @@ jobs:
       COVERITY_LANGUAGE: cxx
       COVERITY_PLATFORM: overridden-below
     steps:
-      - uses: actions/checkout@v3
+      - uses: actions/checkout@v4
       - name: install minimal Git for Windows SDK
         if: contains(matrix.os, 'windows')
         uses: git-for-windows/setup-git-for-windows-sdk@v1
diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 4d97da57ec..90973f9693 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -112,7 +112,7 @@ jobs:
       group: windows-build-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent =3D=
=3D 'yes' }}
     steps:
-    - uses: actions/checkout@v3
+    - uses: actions/checkout@v4
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: build
       shell: bash
@@ -173,10 +173,10 @@ jobs:
       group: vs-build-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent =3D=
=3D 'yes' }}
     steps:
-    - uses: actions/checkout@v3
+    - uses: actions/checkout@v4
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: initialize vcpkg
-      uses: actions/checkout@v3
+      uses: actions/checkout@v4
       with:
         repository: 'microsoft/vcpkg'
         path: 'compat/vcbuild/vcpkg'
@@ -297,7 +297,7 @@ jobs:
       runs_on_pool: ${{matrix.vector.pool}}
     runs-on: ${{matrix.vector.pool}}
     steps:
-    - uses: actions/checkout@v3
+    - uses: actions/checkout@v4
     - run: ci/install-dependencies.sh
     - run: ci/run-build-and-tests.sh
     - name: print test failures
@@ -317,7 +317,7 @@ jobs:
       CC: clang
     runs-on: ubuntu-latest
     steps:
-    - uses: actions/checkout@v3
+    - uses: actions/checkout@v4
     - run: ci/install-dependencies.sh
     - run: ci/run-build-and-minimal-fuzzers.sh
   dockerized:
@@ -342,7 +342,7 @@ jobs:
     runs-on: ubuntu-latest
     container: ${{matrix.vector.image}}
     steps:
-    - uses: actions/checkout@v3
+    - uses: actions/checkout@v4
       if: matrix.vector.jobname !=3D 'linux32'
     - uses: actions/checkout@v1
       if: matrix.vector.jobname =3D=3D 'linux32'
@@ -373,7 +373,7 @@ jobs:
       group: static-analysis-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent =3D=
=3D 'yes' }}
     steps:
-    - uses: actions/checkout@v3
+    - uses: actions/checkout@v4
     - run: ci/install-dependencies.sh
     - run: ci/run-static-analysis.sh
     - run: ci/check-directional-formatting.bash
@@ -396,7 +396,7 @@ jobs:
         artifact: sparse-20.04
     - name: Install the current `sparse` package
       run: sudo dpkg -i sparse-20.04/sparse_*.deb
-    - uses: actions/checkout@v3
+    - uses: actions/checkout@v4
     - name: Install other dependencies
       run: ci/install-dependencies.sh
     - run: make sparse
@@ -411,6 +411,6 @@ jobs:
       jobname: Documentation
     runs-on: ubuntu-latest
     steps:
-    - uses: actions/checkout@v3
+    - uses: actions/checkout@v4
     - run: ci/install-dependencies.sh
     - run: ci/test-documentation.sh
--=20
2.43.0-522-g2a540e432f

