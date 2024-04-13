Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A15C205E03
	for <git@vger.kernel.org>; Sat, 13 Apr 2024 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713033196; cv=none; b=PbXheziSmPs3vjMu8Yqa9jN/dU0pmzdpAGgZY2ngdORgKEx61GfR1xhD+KV6XV4UYOLxNZzHAntIwPMyX9XDH4pvvW6B63xvS6HZu8PJIJLYSW/2PHh7YLSmBdlUgj0AmFr3RGUdrqUtRWapA3B9mbIs35B84FQeteocEePdHKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713033196; c=relaxed/simple;
	bh=G4zpUAkqZCOwhhlc9M66SYeSodJ9bzz/OMqOmaG6ne8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JmI1U8hqWsOjtgtZ3n05YEFIdsIsJ7s3SA+mjNUtrPbABgiP0nQTdbG59bA+CPRwZO8hwCNj9cng8ndc+274IddLqMXYTRyMlXIuCOrBebalA73jm2POq4FcBQIk/5pj6+uHJXoqN2Po+V3n4cE6jO+0GB2kwNFH3mOP+5byL5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KX2A4/mt; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KX2A4/mt"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 29F202225C;
	Sat, 13 Apr 2024 14:33:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=G4zpUAkqZCOw
	hhlc9M66SYeSodJ9bzz/OMqOmaG6ne8=; b=KX2A4/mt0b1qwBN2Rtfr6QfMEtU+
	zgqMPJSQ1ohuf2FYh0Ipj3JzBTQLa4plP5mN5M1De3DMMTj/HicSkU201kEEWRcO
	J20z0JBTrBNAE8oOu/ZWOkSu+tTnz6cTywkaj/I5H2imTrKRDedwJx7MLafWnjJj
	p8XuFh4Pw6H6pV0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 218D32225B;
	Sat, 13 Apr 2024 14:33:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 795142225A;
	Sat, 13 Apr 2024 14:33:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Chris Torek
 <chris.torek@gmail.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 1/8] fast-import: tighten path unquoting
In-Reply-To: <41A4023D-E468-4D63-9881-57392D06D852@archibald.dev> (Thalia
	Archibald's message of "Sat, 13 Apr 2024 00:07:38 +0000")
References: <20240322000304.76810-1-thalia@archibald.dev>
	<cover.1711960552.git.thalia@archibald.dev>
	<cover.1712741870.git.thalia@archibald.dev>
	<cover.1712907684.git.thalia@archibald.dev>
	<d6ea8aca465eaed4b18b546b5d484bc98fdaa377.1712907684.git.thalia@archibald.dev>
	<xmqqle5io7zf.fsf@gitster.g>
	<41A4023D-E468-4D63-9881-57392D06D852@archibald.dev>
Date: Sat, 13 Apr 2024 11:33:02 -0700
Message-ID: <xmqq34rpglk1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 44049D70-F9C4-11EE-A322-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Thalia Archibald <thalia@archibald.dev> writes:

> As to naming, `allow_spaces` and `include_spaces` are problematic for
> the reasons you both have pointed out. I think `stop_at_unquoted_space`
> is problematic, because that=E2=80=99s not where it stops when quoted, =
but
> rather at the close quote. I think that `include_unquoted_spaces` is
> good, because it describes that spaces are included in this field when
> it is an unquoted string. `allow_unquoted_spaces` implies that its an
> error to have a space, but no such error is raised here.

OK, so the bit tells the function if we are dealing with the last
field on the input line, because unquoted side needs to know when
to stop reading the path.

	static void parse_path(... int is_last_field ...)
	{
		if (*p =3D=3D '"') {
			... handling of a quoted path is unchanged
			... regardless of where on the line it apears
		} else {
			/*
			 * unless we know this is the last field,
			 * an unquoted SP is the end of this field.
			 */
			*endp =3D is_last_field=20
                              ? p + strlen(p)
			      : strchrnul(p, ' ');
		}
	}

Another way to look at it is that we are telling the function if a
space in an unquoted path is part of the path or not.

The distinction matters only if we require, in some record type, a
path field that is the last on the line to be quoted when it has a
SP in it, in which case, "is_last_field" is a wrong name, and we
need to say something like space_is_end_of_field_if_unquoted (or we
can reverse the polarity to say unquoted_space_is_part_of_the_path,
include_unqouted_space, etc.).  But if not, I find that "we normally
stop at SP when unquoted but the last field is a special case"
somewhat more natural.  I do not feel too strongly, though.

Thanks.


