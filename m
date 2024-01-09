Received: from aa.d.sender-sib.com (aa.d.sender-sib.com [185.41.28.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F2F818
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 01:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="SE+NUuip"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=5nnBAdRhoJe1te0YfbOvD0vFj8t+ETikSkKVTZYBiFA=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=SE+NUuipPIL3NmmTZfeF7tCaSmiquC1pXUmCXSHPSVxq5/TM55TqUhonoDUu0om24flOE362y33Q
        JNx7jFvHcDV/FiKP6R9ymlZOtr2Bn3StA68Tc1E5FlF9rzraPtpyXjH4wVWuIin7WHxzm57qio8s
        xrguohhOjM6IHfS+NgI=
Received: by smtp-relay.sendinblue.com with ESMTP id a718b5ee-afb0-44bd-a299-3208fac43506; Tue, 09 January 2024 01:08:34 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTA5MDEwODMwLjQ1ODc3NS0yLWJyaXR0b24ua2VyaW5AZ21haWwuY29tPn5hYS5kLnNlbmRlci1zaWIuY29t
Date: Mon,  8 Jan 2024 16:08:30 -0900
Subject: [PATCH v2 1/1] completion: don't complete revs when --no-format-patch
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id C5CE8520261; Mon,  8 Jan 2024 16:08:31 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109010830.458775-1-britton.kerin@gmail.com>
References: <9627364b-c0c9-4b85-a81a-ba1ef0735c9a@smtp-relay.sendinblue.com> <20240109010830.458775-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <a718b5ee-afb0-44bd-a299-3208fac43506@smtp-relay.sendinblue.com>
Origin-messageId: <20240109010830.458775-2-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: fAOLrfaSFPBB6fSXGQwIhNtabU7NaR3FXjhT8S8U6y1DPXPgZF0xB16uI_5c5ge1uI0RIl-KDTcu84sZ1na_cRi77Y2qwd5riPLJ6XcZSzpV5okFhg5v0278pLcLKoL4xegcmTrnIjBKVJQYJ38aTICxDKozpIi3HRDHnYEZ5s4x
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


