Received: from bi.d.mailin.fr (bi.d.mailin.fr [185.41.28.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB46023C1
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 02:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bi.d.mailin.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="CgRBtiqJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=gsdFisq7I74/ralwbeBVzQ+Fcm7pPGrvr8GYTC8zm2A=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=CgRBtiqJlKmyXjKJzpn4EkH24WXgjN15xpIl+giRQdr7Ywds7wxBFCYiu8L3Em1ssglZ0Zjw5YJH
        5ARWS+XmZ9blQZdp+K7FrUMAYb8DhuKfUOJl1M8v62CCq/3eWF+oL5GJ0amOj/PLLOJqcK/ieBOE
        i1TTZbSoWYfrz+MqKlc=
Received: by smtp-relay.sendinblue.com with ESMTP id d746ef2d-71ab-4691-b960-c88bc7e5487e; Wed, 10 January 2024 02:03:51 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTEwMDIwMzQ3LjY3MzE1NS02LWJyaXR0b24ua2VyaW5AZ21haWwuY29tPn5iaS5kLm1haWxpbi5mcg%3D%3D
Date: Tue,  9 Jan 2024 17:03:47 -0900
Subject: [PATCH v2 5/5] completion: custom git-bisect terms
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id 3FF7452026D; Tue,  9 Jan 2024 17:03:49 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110020347.673155-1-britton.kerin@gmail.com>
References: <9e180f50-4bf4-4822-9b02-2a1b50114e09@smtp-relay.sendinblue.com> <20240110020347.673155-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <d746ef2d-71ab-4691-b960-c88bc7e5487e@smtp-relay.sendinblue.com>
Origin-messageId: <20240110020347.673155-6-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: Hg6v-nIryEnNdROK2lVLUBElVLwYAt5TZdC9yle6q15Bc8v7gAZuvKDhAgFmuaHdrePoG3OGNYtuOsUscabAS5yGAOCA9sZXzyoG8JlZgjZjziEvHrebicgL2uI7uvd4fD_wXxcXO6ueOKf-rNhmNbc51IzZ7JX2Z7g01u5cGP9L
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.109:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash =
b/contrib/completion/git-completion.bash
index ad80df6630..87cf7b2561 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1591,13 +1591,22 @@ =5Fgit=5Fbisect ()
 		term=5Fgood=3D`=5F=5Fgit bisect terms --term-good`
 	fi
=20
-	local subcommands=3D=22start bad new $term=5Fbad good old $term=5Fgood =
terms skip reset visualize replay log run help=22
+	# We will complete any custom terms, but still always complete the
+	# more usual bad/new/good/old because git bisect gives a good error
+	# message if these are given when not in use and that's better than
+	# silent refusal to complete if the user is confused.
+	#
+	# We want to recognize 'view' but not complete it, because it overlaps
+	# with 'visualize' too much and is just an alias for it.
+	#
+	local completable=5Fsubcommands=3D=22start bad new $term=5Fbad good old =
$term=5Fgood terms skip reset visualize replay log run help=22
+	local all=5Fsubcommands=3D=22$completable=5Fsubcommands view=22
=20
-	local subcommand=3D=22$(=5F=5Fgit=5Ffind=5Fon=5Fcmdline =
=22$subcommands=22)=22
+	local subcommand=3D=22$(=5F=5Fgit=5Ffind=5Fon=5Fcmdline =
=22$all=5Fsubcommands=22)=22
=20
 	if [ -z =22$subcommand=22 ]; then
 		if [ -f =22$=5F=5Fgit=5Frepo=5Fpath=22/BISECT=5FSTART ]; then
-			=5F=5Fgitcomp =22$subcommands=22
+			=5F=5Fgitcomp =22$completable=5Fsubcommands=22
 		else
 			=5F=5Fgitcomp =22replay start=22
 		fi
@@ -1615,7 +1624,7 @@ =5Fgit=5Fbisect ()
 			;;
 		esac
 		;;
-	visualize)
+	visualize|view)
 		case =22$cur=22 in
 		-*)
 			=5F=5Fgit=5Fcomplete=5Flog=5Fopts
--=20
2.43.0


