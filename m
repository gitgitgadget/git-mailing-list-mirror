Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C40F1BF20
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257790; cv=none; b=fB5PbJ96LWJX0o7QH5o+Q8bQeKE7ODBZ/jAzXamI8ZcmPw0oiX5ZZMfwSYelxyZiF4QdozmjtbolmHpZsQoocSklW/FefRMO24mgh2pf85GhmtbSh4vB9z8Iz5A5fU9DF3EZs0hDbIPho2AmOvp8qrCAXCDt4ATbNVofch0tWQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257790; c=relaxed/simple;
	bh=XDp2SfSKjfygvpt3fd3cBzlw/Xw291V8N0tpiQ/RRPE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dYFUYsu8G3xVjjQGasL6rQoURT+HaNGWRoxezmgM+f6QSMthZDbfFCgD+leMW73+5y2t/WbgGCa6tc81GlxBgxU41rL9UdUrHgL7Isv0/XWt5YV+i91FrDX+U3SbOxKFOhhNNeTE9JYZsJOq8qZbb/x3zTQbKC4V+YHcqo9kdrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Oitwwcjd; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Oitwwcjd"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B815E1CED31;
	Tue,  6 Feb 2024 17:16:26 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XDp2SfSKjfygvpt3fd3cBzlw/Xw291V8N0tpiQ
	/RRPE=; b=OitwwcjdvmmyqIwaDAQGdjcql/KFJ5TlSdYW4nqYRM66NF4803pkd4
	YudLZkYnAoM6FVxahVa5ka4se5V7n7yzPIA3G5KNPGucCXlCwUem8YC+d60jJsmZ
	PX61Zo8flbWCb8UhsFH6Pi2lhWQWNo7G8VVGCPCfrnlaPN+x9vkUw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AEE071CED30;
	Tue,  6 Feb 2024 17:16:26 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2147F1CED2F;
	Tue,  6 Feb 2024 17:16:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
In-Reply-To: <CAOLa=ZSZJ=_VCppHXcJeE=Z61go4_040xyc1NBTu-o=xysLrdg@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 6 Feb 2024 14:10:41 -0800")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240129113527.607022-1-karthik.188@gmail.com>
	<20240129113527.607022-5-karthik.188@gmail.com>
	<98d79d33-0d7e-4a9c-a6a3-ed9b58cd7445@gmail.com>
	<CAOLa=ZR=_tt=ppphGMkxqj_YB5G+YkTMWGzRzcHTbrZz4ysb5w@mail.gmail.com>
	<92ba680d-0b48-49f0-aafc-f503e5a5e0ea@gmail.com>
	<xmqqle7xjzic.fsf@gitster.g> <xmqqr0hph1ku.fsf@gitster.g>
	<CAOLa=ZSZJ=_VCppHXcJeE=Z61go4_040xyc1NBTu-o=xysLrdg@mail.gmail.com>
Date: Tue, 06 Feb 2024 14:16:24 -0800
Message-ID: <xmqqcyt9fdc7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5E5781B2-C53D-11EE-B6B3-25B3960A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> I think this was what the earlier discussion in the RFC series was too,
> but Phillip definitely helped consolidate the point.
>
> I'll send a new version of this patch series with `--include-root-refs`
> option and we can discuss on top of that.

Thanks.

By the way, I am not married to the "root refs" name, but

 - we do not want to say "all refs", as I expect refs from other
   worktrees are not included, and possibly the option when
   combined with explicit patterns, like refs/tags/, may further be
   used to limit the output;

 - we do not want to say "pseudo refs", as I expect we would want to
   show HEAD that is (unfortunately) classified outside "pseudoref"
   class.

