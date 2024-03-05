Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54D318E29
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677475; cv=none; b=J0W1II+RqXJtlJI9yPl0CY4JgbbotuqaThVCmyl55DXsD0Fz/679Qdwa3tjB1Gxlf1xUrHq5Cb4MOXZdUdYOigROijpTh9GBBQKlygXrSz0LWpydmqPz+POvDDgl9JoZbsvkcTgTDMDAmLWpqWNA8dGVRQxlsYj3QF7ZBHytYi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677475; c=relaxed/simple;
	bh=Lknt5F7NZByL+oGSx5sjuw88dPVWQw1tdU35zxYQgIM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BliblnF8YLaT8Xlnl5U+WFiEDPJXUSQ9/KRGg5Cy55+77KfkdXtDuErTz3C69FHbjb8ogKJKWkqHJy5LclTiglqIpNQwtJWGzllmHnW+/x9mvS+MhYZqD6yWb5Q9eMJAbwkqNnm/b1dBtgqfedxgGsqfFMApbK4p19Kefw3AfHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DCAs6dVJ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DCAs6dVJ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C91871DC4CF;
	Tue,  5 Mar 2024 17:24:32 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Lknt5F7NZByL+oGSx5sjuw88dPVWQw1tdU35zx
	YQgIM=; b=DCAs6dVJ6wLOODKpdB3FBNSrjWMRBLE3GZ3WZUJtuSZijBev1qULc6
	HNKS28ma51GJq+nl6LsSMt+TUkOqAiznvubV5ND8rFY+NeA2dqYqi/M0aXlDIPrA
	buRwy6zrpVPvY++71SQH6H/2T+nfr8sexcUIsPBJoVPLaAP6/lZDs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BFCF11DC4CE;
	Tue,  5 Mar 2024 17:24:32 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 28C331DC4CD;
	Tue,  5 Mar 2024 17:24:32 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Beat Bolli" <bb@drbeat.li>
Cc: git@vger.kernel.org,  Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH 01/22] doc: avoid redundant use of cat
In-Reply-To: <20240305212533.12947-2-dev+git@drbeat.li> (Beat Bolli's message
	of "Tue, 5 Mar 2024 22:25:00 +0100")
References: <20240305212533.12947-1-dev+git@drbeat.li>
	<20240305212533.12947-2-dev+git@drbeat.li>
Date: Tue, 05 Mar 2024 14:24:30 -0800
Message-ID: <xmqq34t4z59d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 239AE380-DB3F-11EE-9F19-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Beat Bolli" <bb@drbeat.li> writes:

> The update-hook-example.txt script uses this anti-pattern twice. Call grep
> with the input file name directy. While at it, merge the two consecutive
> grep calls.

OK.  

While at it, we could also place $allowed_users_file inside a pair
of double quotes, as the "test -f" before the part we are touching
is prepared to have $IFS whitespace in it (perhaps inside $GIT_DIR),
but I am OK to leave it as a #leftoverbit outside this topic.



> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  Documentation/howto/update-hook-example.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/howto/update-hook-example.txt b/Documentation/howto/update-hook-example.txt
> index 151ee84cebce..4e727deedd21 100644
> --- a/Documentation/howto/update-hook-example.txt
> +++ b/Documentation/howto/update-hook-example.txt
> @@ -100,7 +100,7 @@ info "The user is: '$username'"
>  
>  if test -f "$allowed_users_file"
>  then
> -  rc=$(cat $allowed_users_file | grep -v '^#' | grep -v '^$' |
> +  rc=$(grep -Ev '^(#|$)' $allowed_users_file |
>      while read heads user_patterns
>      do
>        # does this rule apply to us?
> @@ -138,7 +138,7 @@ info "'$groups'"
>  
>  if test -f "$allowed_groups_file"
>  then
> -  rc=$(cat $allowed_groups_file | grep -v '^#' | grep -v '^$' |
> +  rc=$(grep -Ev '^(#|$)' $allowed_groups_file |
>      while read heads group_patterns
>      do
>        # does this rule apply to us?
