Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3471D5AC8
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727283772; cv=none; b=T7rIbTXTYhVyP2uUXASOt+t6SZqJ7a2tJSW3ZvHgq7Luu+7n+D9yynhZGjCUDzs7EO6le+HRqpDRjJQ49XcRIHPG4rqtfzlB7dyB1wPenJ9mDVRGv62nzbGV7BMeiLv9d6pq/yDttIgF2AggRmppVbh6U+A1lhq2HjQvaM5EAIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727283772; c=relaxed/simple;
	bh=JyXRr7DSv+taIf7R83wHYEu/kZAwMWA+hmDUwWsCydI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TXNJrPL72aHhk16ed4vEsgyY2Le2nU1slkiLENew54o1BNVnIFV1xvDngzwleqD8ZWSRGY6vXDKLZpVz3TLdqWn7jeo2b98qtBvqOWDSJUPBWf0/dufxumACO7PnF0tj/LGRseHMdsfag90oEyI0tCpfJVafswVczSVAvHeluxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OlYwGgUz; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OlYwGgUz"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 402DC2A113;
	Wed, 25 Sep 2024 13:02:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JyXRr7DSv+taIf7R83wHYEu/kZAwMWA+hmDUwW
	sCydI=; b=OlYwGgUzkTpsTkjFWiqjPqBaeCCUUU3fpj5FXWm5V8Zq2pgq/dQvG2
	L3ylC4LhRPndRcvOvcpwgcAkTEefNWJzD2X8/77LO+6vLGflTCL7HCZep0VCL2Vn
	VUJ6Zhxeq+WiQHGn3IriafYyVm5xrImzpnVS3EKkt8uKb+NDdHR6A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 380802A112;
	Wed, 25 Sep 2024 13:02:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 821B52A10F;
	Wed, 25 Sep 2024 13:02:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Elijah Newren <newren@gmail.com>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 1/8] finalize_object_file(): check for name collision
 before renaming
In-Reply-To: <6f1ee91fff315678fef39a54220eae91632d2df9.1727199118.git.me@ttaylorr.com>
	(Taylor Blau's message of "Tue, 24 Sep 2024 13:32:10 -0400")
References: <cover.1725206584.git.me@ttaylorr.com>
	<cover.1727199118.git.me@ttaylorr.com>
	<6f1ee91fff315678fef39a54220eae91632d2df9.1727199118.git.me@ttaylorr.com>
Date: Wed, 25 Sep 2024 10:02:47 -0700
Message-ID: <xmqq4j63psy0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FE036FA4-7B5F-11EF-9C04-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> ... But in practice it is
> expanding the definition of "what is already on disk" to be the point
> that the function is called.

Yeah, it is a reasonable argument for this additional protection.
It does not make things worse.  All it takes is for the attacker to
come a bit earlier to defeat the link/unlink dance, so doing it "the
right way" does not make it fundamentally safer.

I hope all TOCTOU races can be explained away this way ;-).

> Co-authored-by: Jeff King <peff@peff.net>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  object-file.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 968da27cd41..38407f468a9 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1937,6 +1937,7 @@ static void write_object_file_prepare_literally(const struct git_hash_algo *algo
>   */
>  int finalize_object_file(const char *tmpfile, const char *filename)
>  {
> +	struct stat st;
>  	int ret = 0;
>  
>  	if (object_creation_mode == OBJECT_CREATION_USES_RENAMES)
> @@ -1957,9 +1958,12 @@ int finalize_object_file(const char *tmpfile, const char *filename)
>  	 */
>  	if (ret && ret != EEXIST) {
>  	try_rename:
> -		if (!rename(tmpfile, filename))
> +		if (!stat(filename, &st))
> +			ret = EEXIST;
> +		else if (!rename(tmpfile, filename))
>  			goto out;
> -		ret = errno;
> +		else
> +			ret = errno;
>  	}
>  	unlink_or_warn(tmpfile);
>  	if (ret) {
