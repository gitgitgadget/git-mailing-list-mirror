Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA33714295
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 22:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331094; cv=none; b=V8L2N4uKyygTs/88KF9teXYRC17wRA9dRGhil1Dwf8O4Sufwgzsjg7Sja0qxklK55v1GD/L+rpZF1onZimb7STLKleZt+bZOp2s3AtfBoTO2WUus6xwxBgAlubvcLmNm43U/NRwXLPW5lT+l4vc6J+XkTKHbI06XNZf9TtBJZAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331094; c=relaxed/simple;
	bh=3dmrHhirhbTYlzdPer+Z0CPhuqspvgKZXQDuFCEgc4E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fcs8YBqgbVaYCeQjwb9QDhHFlRLftDd0j1rUvo8XKk3ytY6qy5ZWs2/giONgTF0lAtUCdJzgyzaVOZnJh/GtBCPCbcyuQEayAFYnZAO5jY7wdR+vvids1nsVKFUl4wly0ANiNIdv9wCu8FNNnmUyq1s/v8/r0jUe7a+ZggAgsQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QFaS3eji; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QFaS3eji"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 083811FAF3;
	Fri,  1 Mar 2024 17:11:26 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3dmrHhirhbTYlzdPer+Z0CPhuqspvgKZXQDuFC
	Egc4E=; b=QFaS3eji0LyMiS9G+WJT7j8C86ZRiW99XVEUoh6How556e17+QobjC
	A9vxHjNviCkkDinw8ICKkOA3RV+ei/Fy+AXKn57wzCNBOhlvlIJrr09a1KajlOwa
	Ay1ZboRA6aqvSEI7hWsELTavbIjmC0sjC8UFGEd9pnkXv+/bBRezw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E75511FAF2;
	Fri,  1 Mar 2024 17:11:25 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EA6FB1FAF1;
	Fri,  1 Mar 2024 17:11:22 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org,  Aryan Gupta <garyan447@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH] test-lib-functions: simplify `test_file_not_empty`
 failure message
In-Reply-To: <20240301204922.40304-1-ericsunshine@charter.net> (Eric
	Sunshine's message of "Fri, 1 Mar 2024 15:49:22 -0500")
References: <20240301204922.40304-1-ericsunshine@charter.net>
Date: Fri, 01 Mar 2024 14:11:21 -0800
Message-ID: <xmqqsf194n7a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A38C4A54-D818-11EE-B0A3-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Eric Sunshine <ericsunshine@charter.net> writes:

> Note: Technically, the revised message is slightly less accurate since
> the function asserts both that the file exists and that it is non-empty,
> but the new message talks only about the emptiness of the file, not
> whether it exists.
>
> A more accurate message might be "'foo' is empty but
> should not be (or doesn't exist)", but that's unnecessarily long-winded
> and adds little information that the test author couldn't discover by
> noticing the file's absence.

Besides, that is way too confusing.  "<foo> is empty or it does not
exist" I may understand, but with your construct, I wouldn't be able
to tell how I am supposed to interpret the "(or doesn't exist)"
part.

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index b5eaf7fdc1..9e97b324c5 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -991,7 +991,7 @@ test_file_not_empty () {
>  	test "$#" = 2 && BUG "2 param"
>  	if ! test -s "$1"
>  	then
> -		echo "'$1' is not a non-empty file."
> +		echo "'$1' is empty but should not be"

The "adds little information" version may be

		echo "'$1' is either missing or empty, but should not be"

And avoiding "X is Y, but should  be ~Y" construct, perhaps

		echo "'$1' should be a file with non-empty contents"

would work better?  I dunno.
