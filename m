Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7683803D3
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460695; cv=none; b=cI8zGaScvDycTyf84zvPqxIyJJv2LZx81EE4Gt380dG0+u/m4pVVFmFmsWKYk+cfdrgc8DsboC8w1XEIgIHI7FnHds7wPiwG4pUXO3AB694EYCydgU8GGM0zFCYeNvy/g6Yx5rroja8Lupzkz/VcNrbraNNimpJoZ3ZGgBfwFZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460695; c=relaxed/simple;
	bh=UFjd9S9UmDss8//fP/OrDBeMO3KB76qU5sgRzsro4Gk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PbOJrsAjzbjxkOP3Po3rUi7kzuNvsH12uGynPWU6OeaVEEdu7hRmYl/ZBJTSmkHEiPYmcOUaGkW0WguTv0yTNRpxdgDmvcrDVCHRGq3VM6WjtalVjA1g7N75O1XLj1oKhAH4EIbostOdB7DXHzwTjN3QZeUaF+8RlqliHASkOLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de; spf=pass smtp.mailfrom=ytausch.de; dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b=uG4x30pP; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ytausch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b="uG4x30pP"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hbSyn3p6kzKmK5;
	Thu, 03 Sep 2026 20:38:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ytausch.de; s=MBO0001;
	t=1788460689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1osno/DvbOAB2up2naqNhrX5kRPXzWp4jDFoD4eTmc=;
	b=uG4x30pPoLTd9eR8w2QDcLjPCjyuUdDMuyXLoLk7Omi27UMVBpirvHfCndfy1AreDcFfmn
	9Cbmx9znUVeZgEHozkIxfGXI3cJX+HhMsYTMoleQzY5xekb2Ow5d8aa2fe9llHEq8+EhlM
	WEtgIEmzl6N+9iQiP9JCmrEO0NXNpCnUqtn5aLafbkjkImeDVAWyEg7Tn8NgL7KN/1LCrM
	yApsaIpciRorNiDaWy7HNrHWJbzCd4l/lQ7mDP8lJ59XmAZYLGaRTF+s+F9FSJcO9lniwF
	WEiOCrsRRtu2B8J0VD6qm6lWnDhRkoJsNj1SzSnuuWbWgKiG0U6T2y4sqyG7iA==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: pathspec: match and original in pathspec_item are const
From: Yannik Tausch <dev@ytausch.de>
In-Reply-To: <xmqqy0dib3ue.fsf_-_@gitster.g>
Date: Thu, 3 Sep 2026 20:37:57 +0200
Cc: Junio C Hamano <gitster@pobox.com>,
 dc@diogocastro.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4439BA70-2C03-499D-B3CE-E43700C0A8DA@ytausch.de>
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
 <xmqqecfbk2eb.fsf@gitster.g>
 <81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
 <886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de>
 <27FF785F-F5D5-44EC-93C2-5BD67BD99147@ytausch.de>
 <xmqq4ig6cihc.fsf@gitster.g> <xmqqy0dib3ue.fsf_-_@gitster.g>
To: git@vger.kernel.org

> I just found [1], which is related to this patch series. I didn=E2=80=99=
t review the discussion in detail yet, will follow up.

I read this as you came to the same conclusion as me independently =
discovering the same issue in July. Perfect! I hope it=E2=80=99s fine =
that I took over the fix that way.

> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> This unfortunately triggers
>>=20
>> t/unit-tests/u-dir.c: In function =
'test_dir__common_prefix_skips_excluded_pathspec_items':
>> t/unit-tests/u-dir.c:53:34: error: initialization discards 'const' =
qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
>>   53 |                         .match =3D "unrelated/path",
>>      |                                  ^~~~~~~~~~~~~~~~
>>=20
>> Other than that, looking good.
>=20
> We may want a preparatory patch before this step.

Thanks, I will include your preparatory patch in v3.=20

