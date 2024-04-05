Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45286161313
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332980; cv=none; b=LC1480VUIqksMJ0rvw2czBS/zKuzayodC9wcDk3HR8NZ0IKGyy2AyJKqcC/KU8OrdicYHOrCj4lNOjrkGOs61tu7Wb82iPePzFx1oH8+fyrRk52U4aVVcCma7W7HMhUPcT57EZm02ZqAq4tBG/teJa28znmrPs+b+sY2opnFDFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332980; c=relaxed/simple;
	bh=xRV/CECdQA4hTdhxuHCeTsx8r7p2K4/NaWk9PsOv+bc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h/WAQ7fSQkOhp5xeS/CUWequLdyzM3QXizqnWrknbhd+NE1hthmuEFX8WlUBPRsH4JRypfUIYAYRlX0Q8h3BSYdZCBXfKP8YLNc+hPnmLHmmx+t0Ye63GiHTs+/OmSNSnu+rplGpjhTuKoNapgPcxtTDB7eGL5sdN+v0+cIluJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MLH/jyfm; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MLH/jyfm"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6F7E221054;
	Fri,  5 Apr 2024 12:02:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xRV/CECdQA4hTdhxuHCeTsx8r7p2K4/NaWk9Ps
	Ov+bc=; b=MLH/jyfmg3VGjYqY8+Y2TsTEgQX9WYmslupCWXHfjRaTQ+M3BhUvtO
	FvMx2+H/qLbzFMR0rm6kN+4Q8MVPmsqOSvmYYV1IrB+mAdhM9w8usv2quEESdXtm
	qPvxe7j1fI9u+PNaX+0BdOKkPoVnhDzEWMiuWHfqjtdVSkyqvGICM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6750321053;
	Fri,  5 Apr 2024 12:02:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DAE3F21052;
	Fri,  5 Apr 2024 12:02:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwenn@gmail.com>,  Josh
 Steadmon <steadmon@google.com>,  Luca Milanesio
 <luca.milanesio@gmail.com>,  JGit Developers list <jgit-dev@eclipse.org>
Subject: Re: [PATCH 11/12] t0610: fix non-portable variable assignment
In-Reply-To: <c2c2747ff57f68ccad8b509af037e1fc4a524fa1.1712235356.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 4 Apr 2024 15:25:48 +0200")
References: <cover.1712235356.git.ps@pks.im>
	<c2c2747ff57f68ccad8b509af037e1fc4a524fa1.1712235356.git.ps@pks.im>
Date: Fri, 05 Apr 2024 09:02:47 -0700
Message-ID: <xmqqmsq7yezc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F2FF3FF2-F365-11EE-B580-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>  test_expect_perms () {
>  	local perms="$1"
>  	local file="$2"
> -	local actual=$(ls -l "$file") &&
> +	local actual
>  
> +	actual=$(ls -l "$file") &&

Isn't this the same as what ebee5580 (parallel-checkout: avoid dash
local bug in tests, 2021-06-06) fixed?

The rule for variable assignment is mishandled when local is
involved by some shells.

	perms=$1
	file=$2
	actual=$(ls -l "$file")

would be perfectly fine, and should be fine with "local" prefixed on
these lines, but the last one with local without "" qround $(...)
incorrectly makes the substitution subject to field splitting.

I think the right fix should look rather like this, instead.

 t/t0610-reftable-basics.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git i/t/t0610-reftable-basics.sh w/t/t0610-reftable-basics.sh
index 686781192e..894896933e 100755
--- i/t/t0610-reftable-basics.sh
+++ w/t/t0610-reftable-basics.sh
@@ -81,9 +81,9 @@ test_expect_success 'init: reinitializing reftable with files backend fails' '
 '
 
 test_expect_perms () {
-	local perms="$1"
-	local file="$2"
-	local actual=$(ls -l "$file") &&
+	local perms="$1" &&
+	local file="$2" &&
+	local actual="$(ls -l "$file")" &&
 
 	case "$actual" in
 	$perms*)

