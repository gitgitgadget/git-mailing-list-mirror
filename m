Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="KeEdlKW6"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB552699
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 03:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1701863537; x=1702468337; i=l.s.r@web.de;
	bh=NxOpT11+q7hNGVCSOPVILaxBvK7225Koc9zvX+NQf8I=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=KeEdlKW6kVjnitxeFyrbmkJrwxgoFEtn7rfv2j+nwf4xQI8GMDZUackXAsE1gjZ4
	 5+/1oGqHNyff25BmbSyEVfRKleN4mkxtkDctRayipZIvf/O0Y+FjtvnRFVtGhtm8e
	 oJ/a/WXJAGUnbij/JTJbWwM39svm651FMyzu4aI6jDuPGYvoJEBolV5IQtIDksviw
	 AeUuT+8rlqo0wqyZTXkCvRScmzvQ3OQcELBrSvsFmkYtwrSbhVpcXYU+hUQyv74jR
	 v+aawpe2bhMhMVaaeE6Puf3YWtQEXukT/9oKGSnnRaNRvmxSKkhrG+zaPWMcyCBUv
	 2kODZbR9BVoycmLdPA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.29.38]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MbCHy-1rmOC105d2-00bY53 for <git@vger.kernel.org>; Wed, 06 Dec 2023 12:52:17
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 5/7] clean: factorize incompatibility message
Date: Wed,  6 Dec 2023 12:51:59 +0100
Message-ID: <20231206115215.94467-6-l.s.r@web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206115215.94467-1-l.s.r@web.de>
References: <20231206115215.94467-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hessLX5cjneo1Rc4JYK2ayLuyvJN+Q1BHmgeNzJRU/hq/eZmY4K
 lXqCUSnWf/tJ5QNZk4qdLb3fJqpJMm1iKArx7DcHLbD+LRHhEB50tjljvRfQTuHmbJjKESP
 qjHyz1/nCDnKJmFEdwY/pYkYYE3jjcqXABKmy7mTWuoJ40T/931V2FXaqH9atWA+FeMBDTa
 DH0aKS1oiJXs5ltBCPYdQ==
UI-OutboundReport: notjunk:1;M01:P0:7VencJWmXy4=;7YxQv4GnNFh/VxOU/D871AQB59y
 IVMEoTX71iGxOZxVZL7t++SAzCEwRp8LxxXSwhu39OIscJKhrPqHfM6PXc1ZRuHGmk1ZtLPhv
 Wn0thc/NzPUf2ru0KIoXTb5ptekhl3JB9KPHBn3wXdlvdVxc25bYikQ+2ydW34EYa5r/Dblpn
 8Sz/xnORPq4RRj/W3IAdym/rTfoL6Vy8gbKsGQBTwCGKHmHNId1E5oaoztx9OVOGlr4fNwu/m
 qBCOmc/1bOK1+4e7jn9FvpZGMLtlKyx6asmmbb/NNHVExEyNBxSCJWDKA9+bd7b7FidcSS3d1
 h5WoFQ7vFNzwkbOdDJ94lxmZKwF/+GO3qqAvQOoRndjlqZqEBAJUXfgXSQXR6RBDAXDSX8FZx
 nm8rOSkyLv33Tiwj+EVStyvtx+3lnfsXPcFn/Negx5RUWgj3GCMY2RxK9j4APEjUCCFsp0c8e
 Ovk2BPDta4sYfq3fTbt3hP7DUbYz1cBNybX8EL/q3Do547UR5YzcxRI9aQaOFISemU9mfFBN2
 9DYEKEYrYQinsA4/In/3qwuUhWi3RSqEfL/aGCO/qS1rpoF9wmh0zLdCzy5b6yfynvoc6+8r+
 8NC0GUsBG61BOgx/+CNHOiL3Szeq/tbplu76ah7OFmnbdxAVtVpBbO3COkQXZdsUJlnRMzcp1
 +nHvH0sPW80wQH4EjZlDn5E/7nkNUCsI1LAxT17hA7+C5Gel32Dk3a8jvyzoesI1iwYNRZooG
 NSl6s2LXAN0kiEEugQsQywOyC+UisFLZ5mwkiJPi0rgMQmlu4ZyXjKynDfv5xfoP6AWkM/Fw9
 TGiZdIS2fxn93tpvNodZZcx+rwGX+au0Fk2jPnojsKsIDNV5iC3J2JIICmJNP7kTzqD/tsEJj
 WDOcrm+OAIRCg+pPVRC2uaRUF5xP5HUNLp7N6DoCRg5ImOnXlmfkywXx0qgrsZOcS3Oip6T8x
 xJr+ig==

Use the standard parameterized message for reporting incompatible
options to inform users that they can't use -x and -X together.  This
reduces the number of strings to translate and makes the UI slightly
more consistent.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/clean.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 49c224e626..d90766cad3 100644
=2D-- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -971,7 +971,7 @@ int cmd_clean(int argc, const char **argv, const char =
*prefix)
 	dir.flags |=3D DIR_SHOW_OTHER_DIRECTORIES;

 	if (ignored && ignored_only)
-		die(_("-x and -X cannot be used together"));
+		die(_("options '%s' and '%s' cannot be used together"), "-x", "-X");
 	if (!ignored)
 		setup_standard_excludes(&dir);
 	if (ignored_only)
=2D-
2.43.0

