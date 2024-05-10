Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7001429A
	for <git@vger.kernel.org>; Fri, 10 May 2024 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715360133; cv=none; b=fqCBSvip4n2e7lZq5OD+HuR9ms3G3+xLQtx9Jqx7LvdpeWdqlwBl1smAc2PW5lg+o5NggSPHtrwXwtThw+l9+YC4H8YCA7NOTSazQFNiD6ISwrSGBsHc1z9UyVfcAnuCY8qiwSnuPmlzvHU5SZ83xQm+DSW7ABmFUo6DVqxjuhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715360133; c=relaxed/simple;
	bh=UfatoE0JUGT7RGVwGmf+Ap8FE5Av75VEbUjyDgc6zMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mh0lyYyeMIMlfd9ry9PWXv7JvITOHZRI4pvzkm0V2K6vldrmzdzpbe6i213s5T4oet5Bj3fAluSbtvVH6EIWpODzJMn767T4RUB1aAEaOnpfLDuNnsSmXOD0NOZlQMXspiNkHOJ4a8a1XbVjSkWpFZkYdAqiHRiTPyrpTCxXPNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qbmCXXyH; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qbmCXXyH"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BEC9A354B4;
	Fri, 10 May 2024 12:55:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=UfatoE0JUGT7RGVwGmf+Ap8FE
	5Av75VEbUjyDgc6zMw=; b=qbmCXXyHOy+JGbs/Tqp3AKH0pbYog6ZJm9zjMeQrI
	u8TE+IIZz9ZQyC8DdGkjsmofqecHXLrBWQJpZSTAvl3qG8Tp1g0d2bieg1P4U0ol
	TWO/g0NT5qJp8+c6tyYqG+0nZqND91uZh0UeFPNhTr7XDBpOt8hb6Kt1nqAMgVjD
	yY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B682E354B3;
	Fri, 10 May 2024 12:55:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 414AD354B2;
	Fri, 10 May 2024 12:55:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Josh Steadmon <steadmon@google.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/2] Describe life cycle of a patch series
Date: Fri, 10 May 2024 09:55:24 -0700
Message-ID: <20240510165526.1412338-1-gitster@pobox.com>
X-Mailer: git-send-email 2.45.0-119-g0f3415f1f8
In-Reply-To: <xmqqy18issfv.fsf@gitster.g>
References: <xmqqy18issfv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 1A95A42C-0EEE-11EF-91C0-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Start the SubmittingPatches document by describing the life cycle of
a typical patch series to give the readers a sense of what process
to expect, including how the key events like rerolls, merge to 'next',
and graduation to 'master' happen, and what are expected of them.

Relative to the initial version,=20

 . [Patch 1/2] explains in its proposed log message that there is no
   content changes except for the section level adjustment

 . [Patch 2/2] has lost a paragraph about how the process is
   different from the "ideal", which is irrelevant to the target
   audience who want to learn what the current practice is.

I'll follow these patches up with a separate patch to clarify the
proposed "decision making" document by making it more focused on
deciding on issues at levels higher than an individual patch series,
which is fully covered by the SubmittingPatches document.

Junio C Hamano (2):
  SubmittingPatches: move the patch-flow section earlier
  SubmittingPatches: extend the "flow" section

 Documentation/SubmittingPatches | 121 ++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 51 deletions(-)

--=20
2.45.0-119-g0f3415f1f8

