Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6E422093
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316444; cv=none; b=GKUA8q+ltFou0TrZBONw3o4fTyy0dr4ETC6v6NcGiQSJpb76Gus7I6DcnJXwU7Whnh8sTMNXqUBpbvops0zAVmwxfdnefyvHp5Pn3OOt7f1T2Qt9zg5v99uWKADLyTMq6exN/jYS8sCZaQn0p1t2CsVmXyzetFjAeBL/NfSA46c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316444; c=relaxed/simple;
	bh=BaM7Nk4TJq+fgJpuDotEL7cpt6DZxtVZo3rJmHU+W6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E4AB+ttbdrJkJpEBx0vDAhhfPROqAooKi6LU5F6foOHCxlZ+WpBgrAFMKdVAw9AHrSBX9YxgziUQ4vtfMh1AurAgxxZNrxNaSVoFLFfn3CeIZVHkUdwnc/tVeLcQl9HJvB08fv7q9EKY52lCPT17DCSiphkb9bAeMQ2v4lhREpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eqzNhXn9; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eqzNhXn9"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 348121DB417;
	Fri,  1 Mar 2024 13:07:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BaM7Nk4TJq+f
	gJpuDotEL7cpt6DZxtVZo3rJmHU+W6g=; b=eqzNhXn9nviDEkfjqUF4yNjlvo/N
	i+QMY8WH8pC7ArE2+YfGHRc4k1DLDrDED8r9J95EUx2wnGjd5COvRonMCxCmoYdt
	xBl4PBgux4pDD0m0dcoMC/RTUfknS2JQOJLmYBd0csOvUIzvTdOoCdDABbcsai5l
	hZINGK48L+8+nXY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 29BB71DB416;
	Fri,  1 Mar 2024 13:07:22 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 803E71DB415;
	Fri,  1 Mar 2024 13:07:21 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>
Cc: Sergey Organov <sorganov@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] clean: improve -n and -f implementation and documentation
In-Reply-To: <51a196c0-ea57-4ec5-99ea-c3f09cd90962@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
	Avila"'s message of "Fri, 1 Mar 2024 14:20:47 +0100")
References: <xmqq34v6gswv.fsf@gitster.g> <875xy76qe1.fsf@osv.gnss.ru>
	<51a196c0-ea57-4ec5-99ea-c3f09cd90962@gmail.com>
Date: Fri, 01 Mar 2024 10:07:20 -0800
Message-ID: <xmqqmsrh6d2f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 8C928146-D7F6-11EE-A4C6-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Jean-No=C3=ABl Avila <avila.jn@gmail.com> writes:

>> +	/* Dry run won't remove anything, so requiring force makes no sense =
*/
>> +	if(dry_run)
>> +		require_force =3D 0;

Style.  "if (dry_run)".

Getting rid of "config_set", which was an extra variable that kept
track of where "force" came from, does make the logic cleaner, I
guess.  What we want to happen is that one of -i/-n/-f is required
when clean.requireForce is *not* unset (i.e. 0 <=3D require_force).

>> +	if (!force && !interactive) {

The require-force takes effect only when neither force or
interactive is given, so the new code structure puts the above
obvious conditional around "do we complain due to requireForce?"
logic.  Sensible.

>> +		if (require_force > 0)
>> +			die(_("clean.requireForce set to true and neither -f, nor -i given=
; "
>> +				  "refusing to clean"));

If it is explicitly set, we get this message.  And ...

>> +		else if (require_force < 0)
>> +			die(_("clean.requireForce defaults to true and neither -f, nor -i =
given; "
>>  				  "refusing to clean"));

... if it is set due to default (in other words, if it is not unset), we
get this message.

As you said, I do not think it matters too much either way to the
end-users where the truth setting of clean.requireForce came from,
either due to the default or the user explicitly configuring.  So
unifying to a single message may be helpful to both readers and
translators.

	clean.requireForce is true; unless interactive, -f is required

might be a bit shorter and more to the point.

> The last two cases can be coalesced into a single case (the last one),
> because the difference in the messages does not bring more information
> to the user.

Yeah.

Thanks.

