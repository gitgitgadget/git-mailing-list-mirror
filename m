Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D110036B
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712362995; cv=none; b=RJcn14fhJG6J7JKyjE5KA/zzGo9Nfg1Y+cs35kZrcttnGiYzoK0PefO3kmbCIgfQTA/OByIEDyXn3npn8Zsc2+ioqIV/Z/+eI+83u81WNBT5kCIvyfzTM2mXmcb9lwgnmoe0uw9CF1BfCYr7W7bah0qofWElnsRNx6uSYeCAXlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712362995; c=relaxed/simple;
	bh=lnvSReRq4rauhMOgBWb1eXzJPMUu5XqogkVCqtoufoA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FjVAtEh3MAZvhBp7xJAgXvTODnIn87L1JClTs53AYT2wInGB1MaauqLn5pck6duO9MYsGdS6TmOOLrTQUJa3UFYlfVsS/f8Uf/bkknaKOXcuvx3lW7r6BTZS9p3XvKpkdx7I2l0UtrBDBjTKRmaY2NDfXUvh+9iGE+urdzTXK4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BTRiU6Bu; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BTRiU6Bu"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A85A1DB409;
	Fri,  5 Apr 2024 20:23:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lnvSReRq4rauhMOgBWb1eXzJPMUu5XqogkVCqt
	oufoA=; b=BTRiU6ButsFi475/Z12w8jShpQG/TOXdEXcHI2TLsouQjKKGovC9uc
	FK2m2RPpWYbwnfQLW/l/iWcINu1nNmcJePORqNDxEbbOc8VjoqPv5J8xR7WKAEP7
	cHcutBUd2ZlBBdqcnajlM0mpffOSvbAEARWn1oA3YaR5YQJ6XxdrE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9303D1DB408;
	Fri,  5 Apr 2024 20:23:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EAA4E1DB407;
	Fri,  5 Apr 2024 20:23:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 7/6] t0610: local VAR="VAL" fix
In-Reply-To: <20240406000902.3082301-1-gitster@pobox.com> (Junio C. Hamano's
	message of "Fri, 5 Apr 2024 17:08:56 -0700")
References: <20240406000902.3082301-1-gitster@pobox.com>
Date: Fri, 05 Apr 2024 17:23:10 -0700
Message-ID: <xmqqttkfs5jl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DA234E10-F3AB-11EE-802B-25B3960A682E-77302942!pb-smtp2.pobox.com

The series was based on maint and fixes all the tests that exist
there, but we have acquired a few more.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0610-reftable-basics.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git i/t/t0610-reftable-basics.sh w/t/t0610-reftable-basics.sh
index 686781192e..c8074ebab2 100755
--- i/t/t0610-reftable-basics.sh
+++ w/t/t0610-reftable-basics.sh
@@ -83,7 +83,7 @@ test_expect_success 'init: reinitializing reftable with files backend fails' '
 test_expect_perms () {
 	local perms="$1"
 	local file="$2"
-	local actual=$(ls -l "$file") &&
+	local actual="$(ls -l "$file")" &&
 
 	case "$actual" in
 	$perms*)
