Received: from aa.d.sender-sib.com (aa.d.sender-sib.com [185.41.28.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BF511715
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="J3Wq/0Yj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=5nnBAdRhoJe1te0YfbOvD0vFj8t+ETikSkKVTZYBiFA=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=J3Wq/0YjiT3FUvgE1vPOR3reZDbSJ7lQNIQYpsivTnXqW4cE/qdVurGnAO1N95SapYe7EzoB7U0L
        pO38AWAjucLenJ8rg93utkEtIFzj+PsoXJztrbQ2FRvQ/+qPrMBFCbN4eDbFRGBy5Ys0NdPQq3ve
        7FBvDWfcUhgKU/l8nBU=
Received: by smtp-relay.sendinblue.com with ESMTP id ce76a31e-d435-477e-803c-92d0532174eb; Mon, 08 January 2024 09:36:05 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTA4MDkzNjAxLjEzNjM3MC0yLWJyaXR0b24ua2VyaW5AZ21haWwuY29tPn5hYS5kLnNlbmRlci1zaWIuY29t
Date: Mon,  8 Jan 2024 00:36:01 -0900
Subject: [PATCH 1/1] completion: don't comp revs when --no-format-patch
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id 90827520265; Mon,  8 Jan 2024 00:36:03 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108093601.136370-1-britton.kerin@gmail.com>
References: <20240108093601.136370-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <ce76a31e-d435-477e-803c-92d0532174eb@smtp-relay.sendinblue.com>
Origin-messageId: <20240108093601.136370-2-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: -5skfHTk-mwa-oqo7wcz3Hv7T38WoGN1D-rSX988CR5014ymGH7cipYTBqOA9IsSP9IE0fVSaXmo4fuOUxEU7lWZTzzPq9lij4WbWLjCYUPpaRGsBqDiZIdqi2U9bAQP341s_xQgmWt__EQIMqbqhEeJx10CGJOGDxJ8aVWPuHFs
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.128:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

In this case the user has specifically said they don't want send-email
to run format-patch so revs aren't valid argument completions (and it's
likely revs and dirs do have some same names or prefixes as in
Documentation/MyFirstContribution.txt 'psuh').

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash =
b/contrib/completion/git-completion.bash
index 185b47d802..c983f3b2ab 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1242,10 +1242,12 @@ =5F=5Fgit=5Ffind=5Flast=5Fon=5Fcmdline ()
 	while test $# -gt 1; do
 		case =22$1=22 in
 		--show-idx)	show=5Fidx=3Dy ;;
+		--)		shift && break ;;
 		*)		return 1 ;;
 		esac
 		shift
 	done
+	[ $# -eq 1 ] || return 1   # return 1 if we got wrong # of non-opts
 	local wordlist=3D=22$1=22
=20
 	while [ $c -gt =22$=5F=5Fgit=5Fcmd=5Fidx=22 ]; do
@@ -2429,7 +2431,9 @@ =5Fgit=5Fsend=5Femail ()
 		return
 		;;
 	esac
-	=5F=5Fgit=5Fcomplete=5Frevlist
+	if [ =22$(=5F=5Fgit=5Ffind=5Flast=5Fon=5Fcmdline -- =22--format-patch =
--no-format-patch=22)=22 !=3D =22--no-format-patch=22 ]; then
+		=5F=5Fgit=5Fcomplete=5Frevlist
+	fi
 }
=20
 =5Fgit=5Fstage ()
--=20
2.43.0


