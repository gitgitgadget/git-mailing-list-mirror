Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2BF101C1
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Iz2KuWVq"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A93F532DEA;
	Tue, 26 Dec 2023 18:32:24 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=Z6pRVTN9disRR9vUQXm2JSu2A
	5PhQzBkzM1fPjUq8Ug=; b=Iz2KuWVq2HYFuzyfBfU/Htcod+JQHoBcxBnvIGQGU
	BIe0UynR2ntCtKPNlskalWYhfatWnnMuPApZnLY/5L6wXHVacl0ungcSQ3LDiuad
	DIXljE9VF3GXeEN66LdYr99/D5VO3qgvDQ4FcwZ8zFfV5SxExS+1RUqGuJMSmPyG
	Ks=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A1E4F32DE9;
	Tue, 26 Dec 2023 18:32:24 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3252F32DE8;
	Tue, 26 Dec 2023 18:32:20 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 0/3] apply with core.filemode=false
Date: Tue, 26 Dec 2023 15:32:15 -0800
Message-ID: <20231226233218.472054-1-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-174-g055bb6e996
In-Reply-To: <pull.1620.v3.git.1703066893657.gitgitgadget@gmail.com>
References: <pull.1620.v3.git.1703066893657.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 036D4474-A447-11EE-B7E0-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Chandra Pratap noticed that "git apply" on a filesystem without
executable bit support gives a warning when applying a patch that
expects the preimage file to have executable bit on.  Dscho noticed
that the initial fix by Chandra did not work well when applying a
patch in reverse.  It turns out that apply.c:reverse_patches()
invalidates the "a patch that does not change mode bits have the
mode bits in .old_mode member and not in .new_mode member" invariant
we rely on.

Here is the result of concerted effort.

Chandra Pratap (1):
  apply: ignore working tree filemode when !core.filemode

Junio C Hamano (2):
  apply: correctly reverse patch's pre- and post-image mode bits
  apply: code simplification

 apply.c                   | 16 +++++++++++++---
 t/t4129-apply-samemode.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 3 deletions(-)

--=20
2.43.0-174-g055bb6e996

