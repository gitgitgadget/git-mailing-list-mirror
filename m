Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BBE17BB0A
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769717; cv=none; b=JEe9h7Yd4vxKa2q5kAVCvULGiMUu8e2LxIx+ih5v6ID0Uq3KqkJkYmMrp/hWgP8LDN5/Hxm1iUPqkEt463hibSxdLXJK5ulf9jDdYmsA5WOFAlRoQhPFQEg9NuZHv0zXgWjqe+GPR3rnTIV8aZIru5kWFjkwsmlKGVg5ff8cBiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769717; c=relaxed/simple;
	bh=7z93/AwEsW/weSzOcGpk74kWDXmy5xE3Bj+vr77Yk68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HT3H510+BAtkMBHtARd7nCwhAXr5ipzJ5uUmlcSQyr/KypIqjBHkXuWxU32AnDXfnElQP3iDSlFyFjGn/KA/Std7QX0jYWvh4/1l4zIPa0hik4vwWsWA/6o4PZZSBk7HXDSWskgaSrXcNIDlM5auNpqss0J/70kEvaBTm9L+hCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GLrMZHvD; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GLrMZHvD"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 07D6F2FCF0;
	Wed, 10 Apr 2024 13:21:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7z93/AwEsW/weSzOcGpk74kWDXmy5xE3Bj+vr7
	7Yk68=; b=GLrMZHvDp5qNQkYlBF8v1eK0LURHlh0E9mXOSvYOdkApiSow/z7e/0
	2oI8Iz1gVrTHLEqZPmW3dQRBaaIaKD61D/72cyaTXbi341FUBaEkG+sgtxkVjbhF
	mSVXzuneThR0zhuPZmAnFGGZZjMazbwzMBUaXZT1OUC/x28r71q44=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F37BC2FCEF;
	Wed, 10 Apr 2024 13:21:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7D00D2FCED;
	Wed, 10 Apr 2024 13:21:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Toon claes <toon@iotcl.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Han-Wen Nienhuys
 <hanwenn@gmail.com>,  Josh Steadmon <steadmon@google.com>,  Luca Milanesio
 <luca.milanesio@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 03/12] ci: allow skipping sudo on dockerized jobs
In-Reply-To: <874jc9kvls.fsf@to1.studio> (Toon claes's message of "Wed, 10 Apr
	2024 18:53:19 +0200")
References: <cover.1712235356.git.ps@pks.im> <cover.1712555682.git.ps@pks.im>
	<16603d40fdf96948580c04a7c2b791a97ec64fe7.1712555682.git.ps@pks.im>
	<874jc9kvls.fsf@to1.studio>
Date: Wed, 10 Apr 2024 10:21:48 -0700
Message-ID: <xmqqjzl5uo9f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D149374E-F75E-11EE-9C1D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Toon claes <toon@iotcl.com> writes:

>> [PATCH v2 03/12] ci: allow skipping sudo on dockerized jobs
>
> I think this title is somewhat misleading. While it's true, I don't
> think it's limited to dockerized jobs. Something more along the lines of
> "allow running install-dependencies.sh as root" would make more sense to
> me.

It is true that dockerized is not the essential part of this change;
and it is that we skip sudo when we are already root.  So I agree
with you that the original title is misleading.

"allow running as root" is somehow a bit unsatisfactory, though.  It
sounds as if _we_ were not allowing it before---what was preventing
us from doing so was a system without sudo.

Stepping back a bit, I wonder if install-dependencies.sh will stay
to be the only one among ci/ scripts that need to run things as
root.  If we moved the new logic in this patch to ci/lib.sh that is
included by everybody, then the title of the patch can become a
short and sweet

    ci: skip sudo when we are already root

> That's the only tiny remark I have on this patch series.

Thanks.
