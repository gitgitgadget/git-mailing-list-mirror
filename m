Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="DQ+jfd2Z"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A5D2694
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 03:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1701863536; x=1702468336; i=l.s.r@web.de;
	bh=e30VSexU6iTY4JnyBJisySZzkyqUVTSP6NRtOFAYujQ=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=DQ+jfd2ZuUlBlJiCcRBAO0w6OqtZlZz6YNqQlAr3GhXzG656TSdtWvLSiXwhuJt9
	 euOK3tQq7BAhdTOxu1eUUO9o3uxZKil5MxOAH5pAqBJ9Vs+nSjs38OxMnnm5YuDfu
	 CZ3/shYbnJCEkgIi2OgfzlHFRMuY2op7lCMBs8y4XkHe/bFjyzEBurJt5a05/+9wN
	 FTjXdwhpp19s68ieHHA52gT0N+aDONjSgZjytPDU5tJSEcqX+huXsYsn9aUwoGd5I
	 9O18IMiIDdbSBJ7vmzvDBf88HLR5wcc9Bq7r3wT3j+s8l5vbcSNnxWaVUKe50oRRZ
	 +JWtU9vxMbBuxUNEjQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.29.38]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1N0qr9-1rPViP1dgL-00wnJs for <git@vger.kernel.org>; Wed, 06 Dec 2023 12:52:16
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 1/7] push: use die_for_incompatible_opt4() for --delete/--tags/--all/--mirror
Date: Wed,  6 Dec 2023 12:51:55 +0100
Message-ID: <20231206115215.94467-2-l.s.r@web.de>
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
X-Provags-ID: V03:K1:fM6cV4jVYi+djW8zTjZNNv31ViK4u50xEpWV0RMMtyd6BD+Tudb
 HHHwU0Gpd3Z8O6pdpFa7WYYsF0ZDw5mK1UDM/a6t5s5i5K0Kfa4fr0rMoB++ELEYXk4ecZg
 R+iyvkpfJqMZm2qd6qF62tBN9KVxJtG2jIxo26MmgJ17mNeVcooOrILoWK0LXJoK3NLoYZ2
 YUiD9UkqbQQXm0Bl1PRdw==
UI-OutboundReport: notjunk:1;M01:P0:ZBePyZbcw/k=;Q3OAU/s2aF+7RwtZX4zjQWJoVhT
 Gvj9RIHNBNnjKAW0vpz9RyE8sLMm6BeFF7ahJVxA0ema+mmdklR+SG9MBSVEpPG2otyZjBEmx
 /9j9BVf2Szw6aMSqor2QW/krdMRSD1UXexg/11MogaU6t8os7WAIrgE8iRZYigVlm+Fm8v0fe
 +6iXpXoCJYydPfJ6cj5rRnxCEhriRrLcL90xXJbQwRTfDUQEKrrS+rwyFv8hD2PeuxKzXmce8
 ShAnmJWSjJdsfitH1hqbhsqOm6U0TN4KQbYT+wDdwthF6Ew/YKud7wXdXN6fTdxeEh4lbphQg
 5WQwe3msIoY687QN3My8uh4oqV60klkhgr9L32OFNYi7rqO+kcqvxjAS840iA7m6ocS1ThP4O
 oqFvRquvm/d03PR+msKuYwkp9SizThQTRqn4OIENUKW1K4XS+snAUwLmEc+Pn5ZPrRoaDbeMp
 lFZQVBCaSTZzzZptX7WBkyewAgHjUf/q/8QCUKTugcb7UhqASidyrO9SkAhjjepv64N4TcfVj
 mPYZh2Tiq4LVbV5LN4E96UBdM4gcK332Jnt0rd32S31tJs/zHzBQVe6XVgk/fE0lh4KtfcTax
 tJAVZt4Egxae1LGpmMN78O4Yiq8Lz4WeR4WEtWR7MTGCwkMjqQfZ1eJWm63AjtJZ3C4JsZdhp
 S1BgCO5r+a2qR9tikFwRmz8HCFCKorv8qKm6jcC8feDKXyfKHSflzGyBUj0N+8R3CBftLHQ2a
 7VU2gfja1Pt0zYDq41QMWk2bSCc6KhQnn7Tc/dGnN+bXxvh50cbK/9MTuhj3JCjx1eG4MprPL
 yg9ilcrA+BdWXIJY2R41CE3JwyZR4l7PwCuFZjgwxMcF1HAPfbPcmUeq84jusQt+cJIxwHscB
 2FEKnxnpqu/hG3wRb2QzemaAlB6giydnaJ0ETfmSpqsrdqz4VUnMRwENZRukPmFwNurUWSMMq
 1LuIOxuZzvm75jCJbT9mWzvwtnw=

The push option --delete is incompatible with --all, --mirror, and
=2D-tags; --tags is incompatible with --all and --mirror; --all is
incompatible with --mirror.  This means they are all incompatible with
each other.  And --branches is an alias for --all.

Use the function for checking four mutually incompatible options,
die_for_incompatible_opt4(), to perform this check in one place and
without repetition.  This is shorter and clearer.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/push.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 2e708383c2..f77f424324 100644
=2D-- a/builtin/push.c
+++ b/builtin/push.c
@@ -639,8 +639,10 @@ int cmd_push(int argc, const char **argv, const char =
*prefix)
 		: &push_options_config);
 	set_push_cert_flags(&flags, push_cert);

-	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH=
_MIRROR))))
-		die(_("options '%s' and '%s' cannot be used together"), "--delete", "--=
all/--branches/--mirror/--tags");
+	die_for_incompatible_opt4(deleterefs, "--delete",
+				  tags, "--tags",
+				  flags & TRANSPORT_PUSH_ALL, "--all/--branches",
+				  flags & TRANSPORT_PUSH_MIRROR, "--mirror");
 	if (deleterefs && argc < 2)
 		die(_("--delete doesn't make sense without any refs"));

@@ -677,19 +679,13 @@ int cmd_push(int argc, const char **argv, const char=
 *prefix)
 		flags |=3D (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);

 	if (flags & TRANSPORT_PUSH_ALL) {
-		if (tags)
-			die(_("options '%s' and '%s' cannot be used together"), "--all", "--ta=
gs");
 		if (argc >=3D 2)
 			die(_("--all can't be combined with refspecs"));
 	}
 	if (flags & TRANSPORT_PUSH_MIRROR) {
-		if (tags)
-			die(_("options '%s' and '%s' cannot be used together"), "--mirror", "-=
-tags");
 		if (argc >=3D 2)
 			die(_("--mirror can't be combined with refspecs"));
 	}
-	if ((flags & TRANSPORT_PUSH_ALL) && (flags & TRANSPORT_PUSH_MIRROR))
-		die(_("options '%s' and '%s' cannot be used together"), "--all", "--mir=
ror");

 	if (!is_empty_cas(&cas) && (flags & TRANSPORT_PUSH_FORCE_IF_INCLUDES))
 		cas.use_force_if_includes =3D 1;
=2D-
2.43.0

