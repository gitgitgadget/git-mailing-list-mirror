Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219011552FC
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866080; cv=none; b=lCisVs24OGZD8gYmJuCYP4GuMOjWz6tVEB0//swWWoTiDYgFHSMeU81yDn1QVFaSFeP2zXUDPYgl2UpfwtRIuBLD7u76TOXe9YSLzt7gY4vUaAgnxwqpDsvxoxwrkYlYmELSWv3rZH2YaKt/Tpg1455j35NSzpRugSWc5COFO7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866080; c=relaxed/simple;
	bh=3GGuAt3wX+GQddiqMU7KzzTptflalZzpT/dKmcmEiX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fwkFzMm2uxL33udZMIufHycMIwobnG8R6z8/x8rRq6fvdE2F4P2cI5DuJbDZCQzJo+7nyyGruTnjH1mcyIrAJRRgLcZpD4D0kdMxb3zHxxufNqarqvb/gadARqkPMXAl9tehOUjqVtSMviAs8V/qKiJk8oUB753ltk3z35har98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Sam James <sam@gentoo.org>
Subject: [PATCH v3] meson: fix missing deps for technical articles
Date: Tue, 14 Jan 2025 14:47:10 +0000
Message-ID: <5114dc9a00377826a55f6bab007d2ad1a4de8bc5.1736866030.git.sam@gentoo.org>
X-Mailer: git-send-email 2.48.0
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
v3: Fixed commit message.
v2: Drop incorrect dep I'd added for api-index.sh as pointed out by Patrick.

 Documentation/technical/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/technical/meson.build b/Documentation/technical/meson.build
index 21dfb8b5c9..3a65ee59b3 100644
--- a/Documentation/technical/meson.build
+++ b/Documentation/technical/meson.build
@@ -60,6 +60,7 @@ foreach article : api_docs + articles
     command: asciidoc_html_options,
     input: article,
     output: fs.stem(article) + '.html',
+    depends: documentation_deps,
     install: true,
     install_dir: get_option('datadir') / 'doc/git-doc/technical',
   )
-- 
2.48.0

