From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] refs: introduce a "ref paranoia" flag
Date: Thu, 19 Mar 2015 13:13:13 -0700
Message-ID: <xmqqbnjoiw4m.fsf@gitster.dls.corp.google.com>
References: <20150317072750.GA22155@peff.net>
	<20150317072957.GB25191@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 21:13:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYgoi-000394-JW
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 21:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbbCSUNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 16:13:16 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57022 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750920AbbCSUNP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 16:13:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 10EE1406BC;
	Thu, 19 Mar 2015 16:13:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KbAOtvZ0fxWGU8HoLmbqm4DL+4I=; b=lP4UzO
	BQ6kAp1gGDdNtIgrtSrBI1zECLATMfMibIr/XBP1eEQAHczGOjx4PXyf2zpk50xH
	Na3Ko20m2k79GYhUqEUy93uAIuu4WzMAbEiZ4g1igtw5t/+HQqfLlYxwUzSwhbuB
	Pjy+Yt79Soyr9pqoBB8PaLtcqWnkZPGhmVKag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rSj9/h1UUuBWCwx5zSw/et71NoBXFLL0
	+MLO89AfNX8ucFOWeKw5ngk/k92scRj6G6JbJjhio4OWay9rKqI5gGpT/v4AS2KM
	HeqOppJ4Y0krofyLGSJ2zKqUgf/6zmXMxsx0PjF1lzs5UVmxg4cBMlyqDWBQ1z5y
	sYwoxYo0AYg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 08801406BB;
	Thu, 19 Mar 2015 16:13:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8468B406BA;
	Thu, 19 Mar 2015 16:13:14 -0400 (EDT)
In-Reply-To: <20150317072957.GB25191@peff.net> (Jeff King's message of "Tue,
	17 Mar 2015 03:29:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5FBAB0FC-CE74-11E4-B738-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265822>

Jeff King <peff@peff.net> writes:

> diff --git a/refs.c b/refs.c
> index e23542b..7f0e7be 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1934,6 +1934,11 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
>  	data.fn = fn;
>  	data.cb_data = cb_data;
>  
> +	if (ref_paranoia < 0)
> +		ref_paranoia = git_env_bool("GIT_REF_PARANOIA", 0);
> +	if (ref_paranoia)
> +		data.flags |= DO_FOR_EACH_INCLUDE_BROKEN;

I am not a big fan of proliferation of interfaces based on
environment variables, but hopefully this is isolated enough to
become an issue in the future.

> +
>  	return do_for_each_entry(refs, base, do_one_ref, &data);
>  }
