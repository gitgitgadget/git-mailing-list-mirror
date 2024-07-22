Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF38FC13C
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721670784; cv=none; b=iqumldrsEyDWlDXB18JD8SYPXjTmLZvxaL7mYhWDgBwIjFPH+jIcrYDdNG9jGhEZaygYQrZRXkCSdZrlRKZQ8ExDl8qtaeANrlxAloRdiCimkKhHutlWFn4RmspPJyzlJGYUFIfOcHh/oPwNWTNlY6h8+T1MZNY+ktPhTzRMeQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721670784; c=relaxed/simple;
	bh=rnVavhW/WKJIlWwZfLQEe4CblBXQsZ2mzc5k5WCBEe4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hs4f5FvHuR5u8O6BiBbri3/ottBBFd6dL6/8jhD+bOTyLqLeVlzqu1uUpwdPnXPt9W0sK4vy3DRQcWA3Fb/k8iOFxSyKy/aZ+UzpCSPwBuRiGz5fbmw2AqOqRiphlmV5DdBpa4/1HiiwUbv4O2z82AygX01fw9CQAZdaRWdVhro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vP8BMGiZ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vP8BMGiZ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C31E12090E;
	Mon, 22 Jul 2024 13:53:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rnVavhW/WKJIlWwZfLQEe4CblBXQsZ2mzc5k5W
	CBEe4=; b=vP8BMGiZeVjEm6dRSJa7MId5j/lE5QFKPZqaf4KpaDZ0yiiHcMnbOa
	/pGqpGS1xDnCKioI9fb5PCU1bawRl9qTXr3hI2icTtSOYRpKJ/KXfz+Ks/cvZxhf
	OFiL20EHxBi9F/jXei49huNJ1h8ezCzFoY2PhRxxIFIV21vZtfyyI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BB9DD2090D;
	Mon, 22 Jul 2024 13:53:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 08CEA2090B;
	Mon, 22 Jul 2024 13:53:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org,  karthik188@gmail.com,  chriscool@tuxfamily.org
Subject: Re: [PATCH v5 2/5] t: move reftable/tree_test.c to the unit testing
 framework
In-Reply-To: <20240722061836.4176-3-chandrapratap3519@gmail.com> (Chandra
	Pratap's message of "Mon, 22 Jul 2024 11:27:55 +0530")
References: <20240716075641.4264-1-chandrapratap3519@gmail.com>
	<20240722061836.4176-1-chandrapratap3519@gmail.com>
	<20240722061836.4176-3-chandrapratap3519@gmail.com>
Date: Mon, 22 Jul 2024 10:52:59 -0700
Message-ID: <xmqqcyn5co04.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3CC34092-4853-11EF-8AA9-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> +	/* pseudo-randomly insert the pointers for elements between
> +	 * values[1] and values[10] (included) in the tree.
> +	 */

Style?
