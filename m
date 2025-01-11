Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232E41547E7
	for <git@vger.kernel.org>; Sat, 11 Jan 2025 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736577546; cv=none; b=Hhr2SoFZlgIetlMD5UbjLkqMoef9TbGfr/dW4xNhfA2IVP33VlLoGAHqTnQrqooWkRedbP5n+R3aiTjAszdy8VeRKLkN4lHLaACKttqaJJI69e4VZAubZ1VVY+YQvGDGrvicbINKrwxMmCK59SAih3557EIQF/vxsShP3OA7fzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736577546; c=relaxed/simple;
	bh=KJ9hFrq+fENWfhWgTNWc+017jo4btt9etYV3D8jJTR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U68AtB9aKlMFCLvq+EeGlF14C43w2i5ytzm/ZKPOk3fNQijcl+8t2XQztBhXqksd/u2RcAVa4qVjB6wkjcU3Nkb2Ukqg6ksn6AcrPIWc1iLyugPOOcSbYK7jacnUAxSzKmW84rtYjVStaN+kV7eFW/Nm12+Le33K2oElUEoC5Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Sam James <sam@gentoo.org>
Subject: [PATCH] meson: fix perl dependencies for Documentation
Date: Sat, 11 Jan 2025 06:38:50 +0000
Message-ID: <79de1bcf31f708960a889066ce3d986e55155ad8.1736577530.git.sam@gentoo.org>
X-Mailer: git-send-email 2.48.0.rc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need an explicit `depends: documentation_deps` so that all of our
Documentation targets know they require asciidoc.conf. This shows up
as parallel build failures with it not yet being available.

Other targets look OK already.

Signed-off-by: Sam James <sam@gentoo.org>
---
 Documentation/technical/meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/technical/meson.build b/Documentation/technical/meson.build
index 21dfb8b5c9..8c93da3566 100644
--- a/Documentation/technical/meson.build
+++ b/Documentation/technical/meson.build
@@ -42,6 +42,7 @@ api_index = custom_target(
     '@OUTPUT@',
   ],
   env: script_environment,
+  depends: documentation_deps,
   input: api_docs,
   output: 'api-index.txt',
 )
@@ -60,6 +61,7 @@ foreach article : api_docs + articles
     command: asciidoc_html_options,
     input: article,
     output: fs.stem(article) + '.html',
+    depends: documentation_deps,
     install: true,
     install_dir: get_option('datadir') / 'doc/git-doc/technical',
   )
-- 
2.48.0.rc2

