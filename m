Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F38A1D6A6
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496660; cv=none; b=pCiVZtPke3xhhM4238b18JfDuTInpcAl9tkad51lpi8jZ7LXXcx8vmpbt2lts6LZNpqqCplM54IflQSlm1sTYHCUB2CKJ7ac4Sdt8rJgXjBtxkdVIij7KTHsm6nCEfvLy0qjiKNEpUiANZJMyEudL2AvdAWyGMTEaJa+uS0o5zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496660; c=relaxed/simple;
	bh=nIt8pp4O3dTQawbjukPxzP1o3sXOIv/4+Pw3z4uigKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V+TJxxLGN26uk9vREbIr8nJvPZU2q/FPvVwyXbwfk6drZq4oRl/nOC8aLIk75QruXC6SnXIgnhaxK+UR1RVBsvPfj6OOHqbVD49ymxekaao7K5401ZpmOi6gsWbgHhOzIuK3TorL5DBablP/geu2cCzFDweuHntKqkvWX5SG5vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=A68jbQyY; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A68jbQyY"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E2801E6C4;
	Fri,  9 Feb 2024 11:37:37 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nIt8pp4O3dTQawbjukPxzP1o3sXOIv/4+Pw3z4
	uigKE=; b=A68jbQyYOQYe0e+oNJ+gDLpe6OsL2K3Ot6Q9j3OUM277q8GcX1KVIo
	WjrMonlemnpbtSK92ovXtcR5r7f8ijU1pHckXH6Tf5GbyByPiCGlnTxejSdRAgDv
	XvEVj4LQm4gBG+0bU33NWb+22LuTa5mBP2AtbaI1ovUtQfVUV4cSQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 767AA1E6C3;
	Fri,  9 Feb 2024 11:37:37 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 99F091E6C2;
	Fri,  9 Feb 2024 11:37:34 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Kyle Lippincott <spectral@google.com>,  Johannes Schindelin via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] Always check the return value of `repo_read_object_file()`
In-Reply-To: <5fd95ae0-cd50-ddc4-5095-ee953c2640b3@gmx.de> (Johannes
	Schindelin's message of "Fri, 9 Feb 2024 09:06:53 +0100 (CET)")
References: <pull.1650.git.1707143753726.gitgitgadget@gmail.com>
	<CAO_smVhrMn=-uF1B6+RA8A+VLCEN=o57zbQPtr8hpxRKY=qJRQ@mail.gmail.com>
	<5fd95ae0-cd50-ddc4-5095-ee953c2640b3@gmx.de>
Date: Fri, 09 Feb 2024 08:37:33 -0800
Message-ID: <xmqqjzndk302.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 870EE04A-C769-11EE-A1A4-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It does change behavior. The previous behavior looked up the note OID,
> then tried to read it, and if it was missing just pretended that there had
> not been a note.
>
> I'm not quite sure whether we should keep that behavior, as it is unclear
> in which scenarios it would be desirable to paper over missing objects.

Yeah, an object that does not have any notes attached to is a norm
so the calling application must be prepared for it, but this
codepath is different.  The notes tree says it has notes, we try to
read it and it is not there---at least we noticed an inconsistent
notes tree (and object store), and if we were to run "git fsck" at
that point, we would certainly complain about a missing blob object
(can a tree object at an intermediate level be missing and would we
notice, by the way, I wonder).  It is only prudent to report it,
instead of pretending that the notes are not there.

So I think this tightening falls into the "bugfix" category.

Thanks.
