Received: from 12.mo582.mail-out.ovh.net (12.mo582.mail-out.ovh.net [178.32.125.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10E7947A
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 04:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.32.125.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707106976; cv=none; b=rF6DrXXWpkR4lFe7snHvdvcMKc09BB9E2m8eWcEnXsU8vjjrCiR+2US0f+qASQ7h0dFsesDzXC2C0+0mn6EW1yicYq5G0KA5R2OrpbAey5Z/Xs/kKHeBdFJL+WbvkeljwQXrU6+UBEtclpQTNJYCXYsPWYaVaAAAUByxgdiEz0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707106976; c=relaxed/simple;
	bh=eJ80Y/VlQ/J3z0kkc4mBQqyAtkWm6CRGK3F0nyjRRqI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=E8dA7IwA0SKAeR/nTzmHzEIlDg6zOHNj1Qt6vuYDK6SxTeBIi6JM0JfuUCCreApCshzYGWtgthRrIZzEmOcN0PkI/ECZkyBQ3KzpQo+jKPPaPkZ4PT46z3eOcGSX12kmSJU3GL5ZLJBd/kyto17Q7Jb/3oYw9ml9rchAqE0lvyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devyard.org; spf=pass smtp.mailfrom=devyard.org; arc=none smtp.client-ip=178.32.125.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devyard.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devyard.org
Received: from director3.ghost.mail-out.ovh.net (unknown [10.108.2.89])
	by mo582.mail-out.ovh.net (Postfix) with ESMTP id 69AE427072
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 03:03:35 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-sfnj2 (unknown [10.110.178.72])
	by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 2158D1FE4D;
	Mon,  5 Feb 2024 03:03:35 +0000 (UTC)
Received: from devyard.org ([37.59.142.101])
	by ghost-submission-6684bf9d7b-sfnj2 with ESMTPSA
	id VQ1zAQdQwGWIRQAA0Qe3pw
	(envelope-from <ypsah@devyard.org>); Mon, 05 Feb 2024 03:03:35 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-101G004fcf42b7b-1d6c-4395-b2dd-20ee1db32855,
                    2E889AE26219FFD1BF1F9309EC37D53C5121073E) smtp.auth=ashpy@devyard.org
X-OVh-ClientIp:213.10.167.74
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Feb 2024 04:03:23 +0100
Message-Id: <CYWT85QZ5IBD.3CWNWYQTUMTDJ@devyard.org>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] http: only reject basic auth credentials once they
 have been tried
From: "Quentin Bouget" <ypsah@devyard.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-Mailer: aerc 0.15.2
References: <20240204185427.39664-1-ypsah@devyard.org>
 <20240204185427.39664-2-ypsah@devyard.org> <xmqqfry7onhf.fsf@gitster.g>
In-Reply-To: <xmqqfry7onhf.fsf@gitster.g>
X-Ovh-Tracer-Id: 5766577848507217403
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduledgheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdfsuhgvnhhtihhnuceuohhughgvthdfuceohihpshgrhhesuggvvhihrghrugdrohhrgheqnecuggftrfgrthhtvghrnhepgeektefhudelveekkeejledtgfevfedvffefjedtgeeufedvgeefgfeuleegffdunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepuddvjedrtddrtddruddpvddufedruddtrdduieejrdejgedpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoeihphhsrghhseguvghvhigrrhgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedvpdhmohguvgepshhmthhpohhuth

On Sun Feb 4, 2024 at 11:47 PM CET, Junio C Hamano wrote:
> Quentin Bouget <ypsah@devyard.org> writes:
>
> >  	else if (results->http_code =3D=3D 401) {
> > -		if (http_auth.username && http_auth.password) {
> > -			credential_reject(&http_auth);
> > -			return HTTP_NOAUTH;
> > -		} else {
> > +		if ((http_auth_methods & CURLAUTH_GSSNEGOTIATE) =3D=3D CURLAUTH_GSSN=
EGOTIATE) {
> >  			http_auth_methods &=3D ~CURLAUTH_GSSNEGOTIATE;
> >  			if (results->auth_avail) {
> >  				http_auth_methods &=3D results->auth_avail;
> >				http_auth_methods_restricted =3D 1;
> >			}
> >			return HTTP_REAUTH;
> >		}
> > +		if (http_auth.username && http_auth.password)
> > +			credential_reject(&http_auth);
> > +		return HTTP_NOAUTH;
>
> A few comments and questions.
>
>  * GSSNEGOTIATE is a synonym for NEGOTIATE since cURL 7.38.0
>    (released in Sep 2014); currently the earliest version we claim
>    to support is 7.19.5 (released May 2009) without imap-send, and
>    we require 7.34.0 (released Dec 2013) with imap-send, so for now,
>    it is prudent that this patch uses GSSNEGOTIATE.

Agreed

>  * Is it something that the client code of libcURL can rely on that
>    these CURLAUTH_FOO macros are bitmasks [*]?  If so, wouldn't
>
> 	if ((http_auth_methods & CURLAUTH_GSSNEGOTIATE))
>
>    be clear enough (and less risk of making typo)?
>
> [References]
>
>  * https://github.com/curl/curl/blob/b8c003832d730bb2f4b9de4204675ca5d9f7=
a903/include/curl/curl.h#L787C4-L787C64

I had not considered the risk of typos, fair enough. Will change.

>  * When we see 401, the first thing we do in the new code is to see
>    if GSS is enabled in auth_methods, and if so we drop it from
>    auth_methods (to prevent us from trying it again) and say REAUTH.
>
>    - What assures us that the presense of GSS bit in auth_methods
>      mean we tried GSS to get this 401?  Could it be that we tried
>      basic and seeing 401 from that, but we haven't tried GSS and we
>      could retry with GSS now?  Is it commonly known that GSS is
>      always tried first before Basic/Digest when both are availble,
>      or something like that?

libcurl's documentation on CURLOPT_HTTPAUTH says:

	If more than one bit is set, libcurl first queries the host to
	see which authentication methods it supports and then picks the
	best one you allow it to use.

And then:

	CURLAUTH_NEGOTIATE

		HTTP Negotiate (SPNEGO) authentication. Negotiate
		authentication is defined in RFC 4559 and is the most
		secure way to perform authentication over HTTP.=20

Which hints at CURLAUTH_NEGOTIATE (aka. GSSNEGOTIATE as you pointed out)
being the prefered auth method.

The current implementation confirms this. [1]

>    - When auth_avail was given by the cURL library, we further limit
>      the auth_methods (after dropping GSS) and say REAUTH.  This is
>      not a new to the updated code, but can it happen that the
>      resulting restricted auth_methods bitmap becomes empty (i.e.
>      REAUTH would be useless)?

I am not familiar enough with SPNEGO to say. Seems plausible.
Should I instead do:

	return (http_auth_methods & CURLAUTH_ANY) ? HTTP_REAUTH : HTTP_NOAUTH;

Thanks,
Quentin

[1] https://github.com/curl/curl/blob/b8c003832d730bb2f4b9de4204675ca5d9f7a=
903/lib/http.c#L373
