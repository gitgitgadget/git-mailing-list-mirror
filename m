Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889C19EEDA
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251936; cv=none; b=YPSCzM6FaA/cNeFfX+yCSH0D7qlRiCCjUIE5sOG/u5C4KosJe7TkCxW9dCKrbNbhzL01YNs3RB8gCdeHd2ydCVOzc9V9WepieBrigQgFmuZxReeq3Rh8uFW0AP6RxPbOih0btrS5OsIwXolxVHsw9f8TT8PyzQ1nO2NdAMVRRCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251936; c=relaxed/simple;
	bh=J+fGJ1clTrVCt9a+YHzDrZKsx9qhkTwz8HN00EAW8ss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mk/M9bwsqC5iTTGRQt6DNSPyzMrh0INfGeFjVcNlx4sCsEHYAb4B4sFtxTpM+N6NdXhfP5lDDEr7gEPxq1jgnDmYBFXBFHy79soXVgqOTBVtUpTQqlwXv7cB/nL8ZOF4eHCRF8FC/NRkpTs89khMUREme3zDUKtVdQEgGba7eY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ApBmCUkl; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ApBmCUkl"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 36DBA30040;
	Mon, 24 Jun 2024 13:58:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=J+fGJ1clTrVCt9a+YHzDrZKsx9qhkTwz8HN00E
	AW8ss=; b=ApBmCUklCV4q2N8H2P/HG4c12EnO1LtWklbA6yP2ApJe4HNXMxHxB3
	G2Mt74WQKBrYJLPrNk0RGic7/+f74iWT5klEKu7oOq0u1siD5nSElFUxCoYXFoXd
	HtBOSnvDsHNNM2O2JQA34ya1/kzNQJgIQDvKEhRrvkhhLToM9bMuY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2F2223003F;
	Mon, 24 Jun 2024 13:58:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4E7E03003E;
	Mon, 24 Jun 2024 13:58:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Karthik Nayak <karthik.188@gmail.com>,
  git@vger.kernel.org,  Paul Millar <paul.millar@desy.de>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH] describe: refresh the index when 'broken' flag is used
In-Reply-To: <4224c251-c6f7-4b2a-b182-b0a12ee300c8@gmail.com> (Abhijeet
	Sonar's message of "Mon, 24 Jun 2024 23:07:07 +0530")
References: <20240623214301.143796-1-abhijeet.nkt@gmail.com>
	<CAOLa=ZRGramQ3MdzzXzZ19yeUB_rQZPbZ3u=eA=T2SfV3nhYOA@mail.gmail.com>
	<054c6ac1-4714-4600-afa5-7e9b6e9b0e72@gmail.com>
	<69662b07-e216-421b-b947-afa52e56d7ec@gmail.com>
	<735b4a95-fe8e-4bff-9dd3-10ddd4bdb5b5@gmail.com>
	<xmqqcyo6cnbb.fsf@gitster.g>
	<4224c251-c6f7-4b2a-b182-b0a12ee300c8@gmail.com>
Date: Mon, 24 Jun 2024 10:58:49 -0700
Message-ID: <xmqqsex2b4ti.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 69F9506C-3253-11EF-BA18-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:

> Currently, `git describe --dirty --broken` reports the working tree as
> dirty if you change the owner of a file.  And as Phillip pointed out,
> calling `git update-index --unmerged -q --refresh` to update the index
> fixes this.

Starting from a clean state with a tracked file COPYING, I can do
this:

    $ git describe --dirty --broken
    v2.45.2-862-g39ba10deb2
    $ cat COPYING >RENAMING && mv RENAMING COPYING
    $ git diff-index --abbrev=8 HEAD
    :100644 100644 536e5552 00000000 M	COPYING
    $ git describe --dirty --broken
    v2.45.2-862-g39ba10deb2-dirty
    $ git describe --dirty
    v2.45.2-862-g39ba10deb2

This is with a version if Git _without_ your fix, i.e. the one whose
"describe --broken --dirty" does not do "git update-index --refresh".

In other words, the stat-only change to cause "diff-index" to report
a "suspected to be modified" does not have to be that the file is
owned by a different owner.  So I still do not understand why you
want a second user in this test.
