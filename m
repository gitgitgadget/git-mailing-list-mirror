Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C0B1B9B59
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530619; cv=none; b=iPfo/GAgtur3kojE5ychxVPXV8FnveG1n/3ZGmzm3VD1SSRPRCPzyipY8EnWUBGgR95IhnjqyFYASpUOIlsyPJ9ds1MwEsrh1VJ7mnneLXCXa0e+I/sGo9gyKDSORgBmaPG0bG8auBCGqwfNMb4AhoPe+0Ad/JWoOdOGXwvhy6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530619; c=relaxed/simple;
	bh=TBdtsQgVvkah4YnCFKJycVgoygx1VYgF8JG/eBWh/K8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IpEmhIbXYyp/M4UxFx0TpIh9uCI7iUx8a4s4CSSdwGO3eqgAvWBPozzER7VlyxqvRCS3MKd0JXB2rEXex4WiT5N7UI9Y35OkEC9u2hQlpfQ7lpno0vB2JhoZc0oH2XROOlQl3MkhUtGyxyQFF3PQAWiRjrUJhIGB0eRrhjCaogk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AHrEJe0j; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AHrEJe0j"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC9722A9CA;
	Thu,  1 Aug 2024 12:43:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TBdtsQgVvkah4YnCFKJycVgoygx1VYgF8JG/eB
	Wh/K8=; b=AHrEJe0j/Fy0z9Fy08LxIM/+TrbgCQvvc82m5Rz/EMDsXriJ/nu/JP
	GvMBBmWNEC5xPsyxabPAu89bUrcuSjCj5Z3yJNf19xoGLx4GRX1iyCvXQem+sUnL
	4lMiNTH+JfNSAGHkRat4gHmn1oPyu49jLKOnOm4jkqYAIompvk+Qc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A2BBE2A9C9;
	Thu,  1 Aug 2024 12:43:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E53A32A9C8;
	Thu,  1 Aug 2024 12:43:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff King <peff@peff.net>,
  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <avila.jn@gmail.com>,
  Linus Arver <linusarver@gmail.com>,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 3/3] ref-filter: populate symref from iterator
In-Reply-To: <3e147e7d850773f44b48d1b86e89aef1415a0ccd.1722524334.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Thu, 01 Aug 2024 14:58:54
	+0000")
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
	<pull.1712.v2.git.git.1722524334.gitgitgadget@gmail.com>
	<3e147e7d850773f44b48d1b86e89aef1415a0ccd.1722524334.git.gitgitgadget@gmail.com>
Date: Thu, 01 Aug 2024 09:43:33 -0700
Message-ID: <xmqq4j84w5vu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 31B24886-5025-11EF-AAA1-34EEED2EC81B-77302942!pb-smtp1.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -2852,6 +2852,8 @@ static struct ref_array_item *apply_ref_filter(const char *refname, const struct
>  	ref->commit = commit;
>  	ref->flag = flag;
>  	ref->kind = kind;
> +	if (flag & REF_ISSYMREF)
> +		ref->symref = xstrdup_or_null(referent);

The same reaction as [1/3].  Doesn't the null-ness of referent
convey the same information as the ISSYMREF bit in flag?  IOW,
can't we do this assignment unconditionally?

