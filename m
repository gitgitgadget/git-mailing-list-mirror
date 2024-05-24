Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F0A12C485
	for <git@vger.kernel.org>; Fri, 24 May 2024 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716567070; cv=none; b=f/aQph17lxzpuTiE/u6YYSdPCAVE7CbLL/DQxwbraBcUwFaaK0ZxWiWOvFOXWm/BLrDNNd+XmmayZguON71JUVRNXlYATyebZj6WmOxKN4QdeQTW4NVqMffjZjrzhGubBynvTzpy3AxrzwKgVpp6ZINHOaiU3SSMWnPAnMuVodM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716567070; c=relaxed/simple;
	bh=VvaxTx4yNfqLEH0PCccbrO1Zh3YcH1NtkUCstwDnDVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WIg2HjSfNHYN6ALd1WD5qAvVTtISdYzfmDDREHyq0xar9GDgqZmji/2nuO7lAA8S6gHQ8lBuHIG73FIwh6/ndGIJpXHfXY/ju0LT9sKRk8Y/u5vMr7BAZXWLQUW2tZ+yyO9PQXB4fKZZf5M81WF19xco3hwzSAKrhAWGlzbYBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qgZLXfY1; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qgZLXfY1"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E49F825FE5;
	Fri, 24 May 2024 12:11:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VvaxTx4yNfqL
	EH0PCccbrO1Zh3YcH1NtkUCstwDnDVs=; b=qgZLXfY1aRwAQdmZ9I1GkBbralku
	KGhGyDVLVD2uOM83h/bToV+XxxrrLUp5CKa1ThJ9OVB3754c6vLgqVBCHZOoO322
	TM2MNJ7QpLqeWzwV/82uhipCxTnaAoq32rwirnwNeOf73rqTfASn3l9UlnvJN7OO
	+aThTYRM1PhGBh4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DD86125FE4;
	Fri, 24 May 2024 12:11:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 01F7725FE3;
	Fri, 24 May 2024 12:11:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 12/20] config: plug various memory leaks
In-Reply-To: <ZlA6jZmKomOu1p_S@tanuki> (Patrick Steinhardt's message of "Fri,
	24 May 2024 08:58:21 +0200")
References: <cover.1716465556.git.ps@pks.im>
	<b2f8878b55564c4bf4848642e419c44c1a9d9005.1716465556.git.ps@pks.im>
	<xmqq7cfkv4cr.fsf@gitster.g> <ZlA6jZmKomOu1p_S@tanuki>
Date: Fri, 24 May 2024 09:11:04 -0700
Message-ID: <xmqqcypbnqav.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 398A2BD2-19E8-11EF-A244-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

>> The "message" part in it says that it is encoded in iso-8859-1:
>>=20
>>     --ovDSRLSkA00eIgbN
>>     Content-Type: text/plain; charset=3Diso-8859-1
>>     Content-Disposition: inline
>>     Content-Transfer-Encoding: quoted-printable
>> ...
>>=20
>> But the source in t/t4210-log-i18n.sh actually is written in UTF-8.
>> The thing is, the "-u" option (recode into utf-8" is supposed to be
>> the default for "git am", and it is passed down to the underlying
>> mailinfo machinery in builtin/am.c:parse_mail().
>>=20
>> But apparently that is not working correctly.  I see in the patch an
>> unrecoded byte E9 in the resulting patch file that is fed to the
>> underlying "git apply" machinery, failing the application.
>
> Hm. I'll double check mail headers before sending out the next iteratio=
n.

Just to make sure there is no misunderstanding, I am not saying that
sending =3DE9 in a part that is marked as charset=3Diso-8859-1 using
quoted-printable to express the letter =C3=A9 in a context line of a file
that is encoded in UTF-8.  In other words, I am not saying that your
e-mail setup is suspect.  Instead, I am saying that the behaviour on
the receiving end of "git am" that eventually calls "git mailinfo" is
suspicious.

Thanks.
