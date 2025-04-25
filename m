Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D171129A78
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 06:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745561993; cv=none; b=rzNPY16Qn/DLsVxemnK+loklIV3XixzAmxnXLytky88hZKqgW/kJRZxxd61BKUqR3xIIKgBskRPxqFo3IB6krSwlsH7jXbXAVj2ya54dYvNtS2RYh5FZMakShDdsVfoUZgTOePYMrVBTJJbkqCjEOfjl8Hs/O/UEO39ocMKjIpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745561993; c=relaxed/simple;
	bh=k8Hs+WKbsXD0EmsCesREpjwPOLO3QkmP9a4G8zAh8aY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=sXFKonCEGUW/ESDNV8UVy6Oz9pplphKRAn432pR9XKjFpoMbxOTP/03s6+B3khK8h11OELIoPovLcchs9yaOzf2oZHBRpwUwKkvGB8ontd8+YIx/gkbgt4JlogDB3NEtngiLZcUMADeBl3pXMM28D5j6h85++xMRmFymMq+sxG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swagemakers.org; spf=pass smtp.mailfrom=swagemakers.org; dkim=pass (1024-bit key) header.d=swagemakers.org header.i=@swagemakers.org header.b=kw+AVDI0; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swagemakers.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swagemakers.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swagemakers.org header.i=@swagemakers.org header.b="kw+AVDI0"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swagemakers.org;
	s=key1; t=1745561987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+DRJ7Nx7vcfDw/Fnr892a/fVyvrRNL2SECqVh5JrWQ=;
	b=kw+AVDI0ag2W1rxoEGmqT3+YWB3aXDAdGlPPPV2gaV7o5/Xr6LEr0AWyrIOUZM0izGap47
	Dudr7L7dU5uhz04FrOgmcRIejeO3bzonwG9X5qGrEbKijVlm5n066nTMFuBpgS6iFQG9zS
	5MwItnFMJQJ1wwk3MPv3sBo0MpsQoCo=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Apr 2025 08:19:32 +0200
Message-Id: <D9FI2S0NSC40.28VZMYOR6M8DO@swagemakers.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Julian Swagemakers" <julian@swagemakers.org>
To: "Aditya Garg" <gargaditya08@live.com>, "Erik Huelsmann"
 <ehuels@gmail.com>
Cc: <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>, "M
 Hickford" <mirth.hickford@gmail.com>, <sandals@crustytoothpaste.net>,
 "Shengyu Qu" <wiagn233@outlook.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 1/3] send-email: implement SMTP bearer authentication
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM> <PN0PR01MB95880D1DC65D0356F93B0C55B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM> <CACOoB6jE=DgpYYaudhqTVDRd2SCz++aog7QYwTQs6-MAD8dBuw@mail.gmail.com> <PN3PR01MB9597922F495805CA728A0B31B8852@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PN3PR01MB9597922F495805CA728A0B31B8852@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Migadu-Flow: FLOW_OUT

On Thu Apr 24, 2025 at 8:22 PM CEST, Aditya Garg wrote:
> I saw the code of perl-authen-sasl and I miserably failed in porting
> the logic used here to the repo.
>
> Perl is not something I am very strong at, so not really feasible for
> me to work ahead. I do was able to return the formatted base64 encoded
> string as per the logic, but still I got authentication issues.
> Currently I aim to have git-send-email working, and a review from an
> experienced person is needed.
>
> I would be happy to be able to test any proposed patch though.
>
> Julian, you might be interested here?

I fear I'm also a rookie when it comes to perl, but with your code and
the comment from Erik I managed to get it working. client_start and
client_step have to look like this:

sub client_start {
    my $self =3D shift;
    $self->{stage} =3D 0;
    # Generate the XOAUTH2 authentication string
    my $username =3D $self->_call('user');
    my $token    =3D $self->_call('pass'); # OAuth 2.0 access token
    my $auth_string =3D "user=3D$username\001auth=3DBearer $token\001\001";
    return $auth_string
}

sub client_step {
    my ($self, $challenge) =3D @_;

    my $stage =3D ++$self->{stage};

    if ($stage =3D=3D 1) {
        # Handle authentication failure by sending a dummy request
        return "\001"
    } else {
        return $self->set_error("Invalid sequence");
    }
}

Aditya, do you want to create a pull request on perl-authen-sasl, or
should I?

Regards Julian
