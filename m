Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B71644360
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863479; cv=none; b=Ya8YqWfdmxaTzTCRrYzYP8xPJWUzrz6LX6j3ZdPPZ9vZ/lOOa4BdwmIoaR/Q5yosTH52WKa1+RqqI6X4lEj9+lNBdNU2NFomjvk4/nv45rBkfDEWTeTx3GFjOHhBYCIzrVv4p7aHhHN4TeUy37uhEHVW1Af36qcdXWCnL6JWbTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863479; c=relaxed/simple;
	bh=iFyyfmQPz7lzRqZuSPXr9gjCEND6Zq03SnJusFF54uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ELQsJH3J9RD6/+w2VuK46cNt8+28lowd+uuBNlx5V2KxtcQY31ga624O0zV7zFTsgtHTWCXh+IPno3GrOw9m9/Tb0H6pig3718sQq0SAfGVHPqOq2FKKyz/w1cBNiH4JDND/pXw8ewHXX7axt9oGBu5KxTuzd0MMzNJwDg307D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Sam James <sam@gentoo.org>
Subject: [PATCH v2] meson: fix perl dependencies for Documentation
Date: Tue, 14 Jan 2025 14:03:47 +0000
Message-ID: <5114dc9a00377826a55f6bab007d2ad1a4de8bc5.1736863427.git.sam@gentoo.org>
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

