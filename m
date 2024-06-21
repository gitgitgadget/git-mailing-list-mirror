Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4552C40856
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718990839; cv=none; b=TGa1vNUfg4cJqUJnJ9I2g4M/pWDOFuMNC0gUwTLj+wdJpx3awOm6N3dcpjSVOjtdREF4vifDpJwmw2zb/ttUzVyYCJu3Qb4ZiUSZrIuvzNePZGw6a9OMkWWw5yWi4bEir8tQAhkhIenVJVrvJ2pn8zfnuqI5rwBtJ1/s1uGcF+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718990839; c=relaxed/simple;
	bh=MVo0fyZmY69Lkr7sot4rwhLa0IgxKm41tfAemNkBZDs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lpxba0e28mriqSqOhWTdcmLo7WnXQrdKFSAyZgkX99muQiKlfOB0+SP3rSf3IN4Tf0WYK4IzKKuhI0eTnrlw5IPK01oZGiDHVQgRrfGo8DXle+Af6/H+1DYYlcGtbGuR6owS7618fB2Dox/oFB2Tdn27NLDirCgALwyibE/1InI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BQclj3Ck; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BQclj3Ck"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1779437404;
	Fri, 21 Jun 2024 13:27:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MVo0fyZmY69L
	kr7sot4rwhLa0IgxKm41tfAemNkBZDs=; b=BQclj3Ckgurn9VRCmUOiez5Ehh/G
	ha8iapyT9EDQHUhWbRpvIdaZhkitZR55Fkv4z2bk3UqShMhANqLUtgMAS30tiEw3
	9EKc7QPp0vbnNOQsUwQC3UbH3DOOkkp0FFbIYvqHkVR3gWNldCg6HEcUZh8+Xw+9
	1RnvlDIahbKu4qw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1051637403;
	Fri, 21 Jun 2024 13:27:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A3B1337402;
	Fri, 21 Jun 2024 13:27:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Cs=C3=B3k=C3=A1s=2C_Bence?= <csokas.bence@prolan.hu>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH resend] git-send-email: Use sanitized address when
 reading mbox body
In-Reply-To: <20240621092721.2980939-2-csokas.bence@prolan.hu>
 (=?utf-8?B?IkNzw7Nrw6FzLA==?=
	Bence"'s message of "Fri, 21 Jun 2024 11:27:22 +0200")
References: <20240621092721.2980939-2-csokas.bence@prolan.hu>
Date: Fri, 21 Jun 2024 10:27:06 -0700
Message-ID: <xmqqr0cqmck5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 7C11A7AC-2FF3-11EF-9B92-C38742FD603B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

"Cs=C3=B3k=C3=A1s, Bence" <csokas.bence@prolan.hu> writes:

> Commas and other punctuation marks in 'Cc: ', 'Signed-off-by: '
> etc. lines mess with git-send-email. In parsing the mbox headers,
> this is handled by calling `sanitize_address()`. This function
> is called when parsing the message body as well, but was only
> used for comparing it to $author. Now we add it to @cc too.
>
> Signed-off-by: Cs=C3=B3k=C3=A1s, Bence <csokas.bence@prolan.hu>
> ---
>  git-send-email.perl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index f0be4b4560..72044e5ef3 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1847,9 +1847,9 @@ sub pre_process_file {
>  					$what, $_) unless $quiet;
>  				next;
>  			}
> -			push @cc, $c;
> +			push @cc, $sc;
>  			printf(__("(body) Adding cc: %s from line '%s'\n"),
> -				$c, $_) unless $quiet;
> +				$sc, $_) unless $quiet;
>  		}
>  	}

Hmph, there is this piece of code before the block:

			if ($c !~ /.+@.+|<.+>/) {
				printf("(body) Ignoring %s from line '%s'\n",
					$what, $_) unless $quiet;
				next;
			}

This is to reject strings that do not even look like an e-mail
address, but we called sanitize_address() call on $c way before this
check.  I wonder if we should move this block way up, even before
the call to santize_address()?

That was a relatively unrelated tangent.

In the same function, there is this snippet about Cc: (I didn't
check if the same issue is shared with other header fields):

			elsif (/^Cc:\s+(.*)$/i) {
				foreach my $addr (parse_address_line($1)) {
					my $qaddr =3D unquote_rfc2047($addr);
					my $saddr =3D sanitize_address($qaddr);
					if ($saddr eq $sender) {
						next if ($suppress_cc{'self'});
					} else {
						next if ($suppress_cc{'cc'});
					}
					printf(__("(mbox) Adding cc: %s from line '%s'\n"),
						$addr, $_) unless $quiet;
					push @cc, $addr;
				}
			}

We seem to use sanitized address only for the purpose of suppressing
Cc, and use the original address given in the input for e-mail
purposes (@cc is the same variable as the patch under discussion
sends the "fixed" address to, which holds the data to formulate the
Cc: header of the outgoing message, I presume?).  So in that way, we
seem to be very consistent.

Possibly we are being consistent in a broken way, but I am not yet
convinced that we are.

It looks to me that there are many other places that we try to be as
faithful to the original as possible.  In the same block as the one
that handles "Cc:" I quoted above, an address on "From:" is also
sent intact into @cc and addresses on "To:" are handled the same
way.

The patch under discussion singles out the addresses on the trailers
in the message body and treat them differently from others, which I
am not sure is what we want to do.
