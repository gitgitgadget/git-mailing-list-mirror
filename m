Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9826E12DD86
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708654; cv=none; b=ejP3UDxyGAyBV1rpaFHmtzgKPvBkfzrRla8m8eBVV/R3MAhaA3UZvunXbHnyerynJDVZlnFB6W/HiajyWVFKq71rqy41zVPUAtiUX/Mon8gPXkABvEIqm0k2aQIm0T47LA20IrpOYz2vryyUX4ilzUFcpwO5Y4qpy2pIKPoefrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708654; c=relaxed/simple;
	bh=lhNk1a+IXx9GGHK/MAfXLTrisgV7rZQj7U2wzY8Ql0c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rwp2RMhtIBKrz4PIE06xwbwom9pD5AwsyOMIC2M13Yh3cunlL4bg5ayf83MWCEGj8cb1aLcWkuOz9eWxC81eDylPuXk1LhmvdDTnz4oX2qPtHDuyZfwAP8cLrTGhgbZyw4uW19imo5FGscGQgfE/2sKf892K7cBlZU2IOJcVCug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xhzZ2+dM; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xhzZ2+dM"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3FBEB260F1;
	Fri, 23 Feb 2024 12:17:26 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lhNk1a+IXx9G
	GHK/MAfXLTrisgV7rZQj7U2wzY8Ql0c=; b=xhzZ2+dMCnktA2ucstPNs1MQda6Q
	9E+ZLvM+D3KFGC+qdHDuks6952so2mRGDTOtW1OHYsfsiyJ69tJ2U5QlrCj0eval
	UaLiAMxpwtsqHkzJSlGiV29OmUZARlRvUetWVVIg8aQ+lfJxG066A6pb3QdMaz7+
	Vo4hrOpAP9uP6oA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 382E6260F0;
	Fri, 23 Feb 2024 12:17:26 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 652F4260EF;
	Fri, 23 Feb 2024 12:17:22 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/5] Always check `parse_tree*()`'s return value
In-Reply-To: <883087b8-b013-7b30-5485-719a1c310608@gmx.de> (Johannes
	Schindelin's message of "Fri, 23 Feb 2024 09:33:38 +0100 (CET)")
References: <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
	<pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
	<9e4dc94ef036882c3ce27208ca9fa545d018f199.1708612605.git.gitgitgadget@gmail.com>
	<xmqqplwoe5yv.fsf@gitster.g>
	<883087b8-b013-7b30-5485-719a1c310608@gmx.de>
Date: Fri, 23 Feb 2024 09:17:20 -0800
Message-ID: <xmqq4jdzw15r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 68121A52-D26F-11EE-8175-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Right. I had used
>
>   $ git grep 'unable to read tree .*%s' | sed -n 's/.*_("\([^"]*\).*/\1=
/p' | sort | uniq -c
>        11 unable to read tree %s
>         3 unable to read tree (%s)
>
> only to realize that the 11 were the ones I added.=F0=9F=A4=A6 Re-runni=
ng the same
> command on v2.43.0 reports only the 3 parenthesized ones.

I think we probably should discuss what format is the easiest to
understand and most logical to readers, and unify to such a format,
not necessarily the current majority, in the longer term.  But for
now, let's pick one that costs less to unify to.

We may also want to cast a wider net to make things consistent.  For
example, we learn that the parenthesized one is not necessarily more
prevalent in a larger picture.

Let me annotate the output from this command:

    $ git grep -h -E \
      -e '(unable to|not) (read|find|acccess) (blob|tree|commit|tag) .*%s=
' master po/ |
      sort -u

1. msgid "cannot find commit %s (%s)"

   The first one is a textual refname, the next one is oid-to-hex.

2. msgid "cannot read blob %s for path %s"

   The first one is oid-to-hex, the other is a pathname.

3. msgid "could not find commit %s"

   oid-to-hex (in commit-graph.c)

4. msgid "could not read commit message of %s"

   oid-to-hex (in sequencer.c)

5. msgid "could not read commit message: %s"

   This is irrelevant to the topic, as %s is for strerror().

6. msgid "unable to access commit %s"

   oid-to-hex (in builtin/pull.c)

7. msgid "unable to read commit message from '%s'"

   This message is in po/ but it seems that it no longer is used
   anywhere in the source.

8. msgid "unable to read tree %s"
9. msgid "unable to read tree (%s)"

   We know about these two already.

We seem to just use unadorned %s for many messages when talking
about commit objects, some are inside a pair of 'single quotes',
When we are giving a long hexadecimal string, especially without
doing any abbreviation, I personally think it is a waste to enclose
it in any punctuation pair, so if I were to vote today, I would
probably support standardizing on "tree %s", "blob %s", etc., but I
think that is just a personal preference (not even a "taste" thing).

In any case, all of the above is clearly outside the scope of this
series.
