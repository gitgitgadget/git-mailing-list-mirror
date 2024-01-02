Received: from aa.d.sender-sib.com (aa.d.sender-sib.com [185.41.28.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6691642A
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="NikABz6S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=EwHth4Wf8RKasRYK+iVEJ5qxoMKviQZohIYWZcwE48U=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=NikABz6Svo91D0iCl+KOxMtxdAN5jyEV26d6eCzqah2dPP19gTotsokRLPaotuHzrq/yQg89P+Wu
        Wk/ne9IGo4c+MYMbgehkTrqlxumNiEg1afNf/bfjbKNSwOiqVeZt89AJZ1g8fpujGTquQAaJGcJf
        LXp4S9O4DuRZu1GXs0g=
Received: by smtp-relay.sendinblue.com with ESMTP id cda06ddc-3de6-4fef-a6e2-a3da8c0bac25; Tue, 02 January 2024 19:57:55 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTAyMTk1NzQ0LjQ3ODUwMy02LWJyaXR0b24ua2VyaW5AZ21haWwuY29tPn5hYS5kLnNlbmRlci1zaWIuY29t
Date: Tue,  2 Jan 2024 10:57:43 -0900
Subject: [RFC PATCH 5/6] completion: recognize but do not complete 'view'
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id E6484520263; Tue,  2 Jan 2024 10:57:52 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102195744.478503-1-britton.kerin@gmail.com>
References: <20240102195744.478503-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <cda06ddc-3de6-4fef-a6e2-a3da8c0bac25@smtp-relay.sendinblue.com>
Origin-messageId: <20240102195744.478503-6-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: EqSk34DoGcqbfgSyS6NXUfesj1fWarMKoVIcUYQTxUiHomX9DmtHUNcbtgxvrSKVABZFpFgj8kCldFzEW4t8yNh3dX-htFB9ih6tGFU5L8a_JHAQ54UHAfvQytX4JMApIZy1-acQabBdRyh62z19GYRYwDbwOm4N28wgNlvUBE0r
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.128:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

Completing it might annoy some existing users by creating completion
ambiguity on 'v' and 'vi' without adding anything useful in terms of
interface discovery/recall (because 'view' is just an alias anyway).

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash =
b/contrib/completion/git-completion.bash
index a09598c5c1..3bb790220a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1589,13 +1589,16 @@ =5Fgit=5Fbisect ()
 		term=5Fgood=3D`=5F=5Fgit bisect terms --term-good`
 	fi
=20
-	local subcommands=3D=22start bad new $term=5Fbad good old $term=5Fgood =
terms skip reset visualize replay log run help=22
+	# We want to recognize 'view' but not complete it, because it overlaps
+	# with 'visualize' too much and is just an alias for it.
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
@@ -1613,7 +1616,7 @@ =5Fgit=5Fbisect ()
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


