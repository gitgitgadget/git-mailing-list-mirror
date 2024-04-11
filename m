Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704FA17C95
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712865218; cv=none; b=CRKHMS/MC8l/dySNzhqO96rBYkuxl1ApJzBSSnIa6688UDHDU8c15ikYrNcE/rOIg7MFPVao8iK3/Y2su5w5ZqS1I3Ao+514P+HWVWg57wFbvHLaDcz1dwnySYQk7v6CMIwAlXSOLy+SGr5Su8atHbJqennu2E+1kEIzPBLpka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712865218; c=relaxed/simple;
	bh=bFdzwpykUXM0e86DhKvdMjzssIPWyhxKDi32U1itZJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l0ScINXoLJI9YddZiUvAeRn7QjromIcx6feEkW3eW3IvXxe4mYina8OuqzAw0nBtG6vqQ+lbxXdcGjU1gOjr2p5vUrxgcML79U8+n+R1zA7ZxTNdL8H8NQTDZK8EMHjnPv0rAOXU9LLs2jzb/udmuLMEfovcbz+EfRFe9F5OCHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Nw34zWts; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nw34zWts"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E025639BA0;
	Thu, 11 Apr 2024 15:53:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bFdzwpykUXM0e86DhKvdMjzssIPWyhxKDi32U1
	itZJ8=; b=Nw34zWtsfcd6O925AED2olG+HdF38AgaFiHyvy7oIdhmUZQAO5IvOn
	5EGoENljxRn9fUmSa6VSiNqRgUWrGT0pS0LbzwIIDeCDjo0/6/yNDAsFhelvDt7F
	dTcpztAKBbPfMSyS5NfQsy1HNcf5qQ0KKPosHjpV+Vy52nfwsYHoc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D90C239B9F;
	Thu, 11 Apr 2024 15:53:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7E89539B9B;
	Thu, 11 Apr 2024 15:53:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Chris Torek
 <chris.torek@gmail.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 4/8] fast-import: remove dead strbuf
In-Reply-To: <1cef05e59a806069cc921511329dea67eee80dba.1712741871.git.thalia@archibald.dev>
	(Thalia Archibald's message of "Wed, 10 Apr 2024 09:55:49 +0000")
References: <20240322000304.76810-1-thalia@archibald.dev>
	<cover.1711960552.git.thalia@archibald.dev>
	<cover.1712741870.git.thalia@archibald.dev>
	<1cef05e59a806069cc921511329dea67eee80dba.1712741871.git.thalia@archibald.dev>
Date: Thu, 11 Apr 2024 12:53:32 -0700
Message-ID: <xmqq1q7bu14z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2D836DF2-F83D-11EE-BA71-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Thalia Archibald <thalia@archibald.dev> writes:

> The strbuf in `note_change_n` is to copy the remainder of `p` before
> potentially invalidating it when reading the next line. However, `p` is
> not used after that point. It has been unused since the function was
> created in a8dd2e7d2b (fast-import: Add support for importing commit
> notes, 2009-10-09) and looks to be a fossil from adapting
> `file_change_m`. Remove it.
>
> Signed-off-by: Thalia Archibald <thalia@archibald.dev>
> ---
>  builtin/fast-import.c | 5 -----
>  1 file changed, 5 deletions(-)

Losing code that is not used is always good ;-)


> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 0da7e8a5a5..7a398dc975 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -2444,7 +2444,6 @@ static void file_change_cr(const char *p, struct branch *b, int rename)
>  
>  static void note_change_n(const char *p, struct branch *b, unsigned char *old_fanout)
>  {
> -	static struct strbuf uq = STRBUF_INIT;
>  	struct object_entry *oe;
>  	struct branch *s;
>  	struct object_id oid, commit_oid;
> @@ -2509,10 +2508,6 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
>  		die("Invalid ref name or SHA1 expression: %s", p);
>  
>  	if (inline_data) {
> -		if (p != uq.buf) {
> -			strbuf_addstr(&uq, p);
> -			p = uq.buf;
> -		}
>  		read_next_command();
>  		parse_and_store_blob(&last_blob, &oid, 0);
>  	} else if (oe) {
