Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A08187544
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021092; cv=none; b=soDPEVIPexxOmZ44Q5vdT0oCQj/muNR0PhNCtNqVohuIeJzEFQKhjfOdXq1mRkCcERprX9wKEyYL9fY0PDv071wYk6Rx+k2GBj5ef2fTR0E7vYF7lSdcx1QIEZvQMhdAG7uGtILyMgrT463t1jRuQmNALzDYoyiPL97kWL2Q8OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021092; c=relaxed/simple;
	bh=x6DALACC6B2N+pJfbvmGQKhBY4UG9yzz7iq1AgK/qqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uP+gEv6mzuAPZ1NJKxxQXyfUcgzH2FhS6bbtDviDhBzse/8xbq4oJFxStfT7u/pLEmEv0C5iYDtP7NGe08Art/65Vowas+0COpL8MGXE0qHGfeYQ63V8Cn4dFIeMZOb3hc+3UuIw3gLlCaRqkIVYIv3zM266hAGUBJscsKT42Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HdrliTaq; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HdrliTaq"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D70BC2E056;
	Wed,  3 Jul 2024 11:38:10 -0400 (EDT)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=x6DALACC6B2N+pJfbvmGQKhBY
	4UG9yzz7iq1AgK/qqE=; b=HdrliTaqcxEAlq3rHUsxmp1gre11jeYjDV23K5WZF
	y9tvqAywECWMIqhJeGtWN21ZbCYBVJNEL9YNyorXhQR5zxBhmM8r/Xl+2y9CFcyB
	GkrWqsO8FjUh6+0NnUq3fV/GZ8ytRmrOJBcGgYZRBZFwFtj99pHET1p7z3MNwZ2G
	fI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BB9A92E055;
	Wed,  3 Jul 2024 11:38:10 -0400 (EDT)
	(envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.204.171.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 07BDF2E052;
	Wed,  3 Jul 2024 11:38:04 -0400 (EDT)
	(envelope-from tmz@pobox.com)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Kousik Sanagavarapu <five231003@gmail.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>
Subject: [PATCH 2/2] t/lib-gpg: call prepare_gnupghome() in GPG2 prereq
Date: Wed,  3 Jul 2024 11:37:32 -0400
Message-ID: <20240703153738.916469-3-tmz@pobox.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703153738.916469-1-tmz@pobox.com>
References: <20240703153738.916469-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 3E127DA6-3952-11EF-AAC0-C38742FD603B-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

The GPG2 prereq added in 2f36339fa8 (t/lib-gpg: introduce new prereq
GPG2, 2023-06-04) does not create the $GNUPGHOME directory.

Tests which use the GPG2 prereq without previously using the GPG prereq
fail because of the missing directory.  This currently affects
t1016-compatObjectFormat.

Ensure $GNUPGHOME is created in the GPG2 prereq.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 t/lib-gpg.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 4e44f182bb..21666b2ab0 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -66,6 +66,7 @@ test_lazy_prereq GPG2 '
 		exit 1
 		;;
 	*)
+		prepare_gnupghome &&
 		(gpgconf --kill all || : ) &&
 		gpg --homedir "${GNUPGHOME}" --import \
 			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
--=20
2.45.2

