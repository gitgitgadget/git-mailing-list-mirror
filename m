Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8129716C450
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713978153; cv=none; b=h9bmOhqYnVKXAPps5h0ASzbX+CYCvNDIkdvEvYfsPOJZdsLfelqB1VR2rb1xFZI6zgP1tYNWyQ8Br77UliLv03xFx+vhF4z5WI9EB4CZ8eyXLnlEk8ese8xIb+du9jNeyk/AbABsFpiSGE9DjiJUs6wM8bm6WGyni7chRzQqlxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713978153; c=relaxed/simple;
	bh=J6grFtioy/9x0VLKRn3goFmZCNScMuPfO6WYSUR1Vxg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bff6X52URBYAQnn+CkGuWTzgrSbj8B1m2HohKz1J/CTAnaaCEx2d6TOnOdfgWusYPpEyrrZVj2AQmOihd0Np7LFjeXuLb0i3boN8qagt/xuPqG37H/h6sboAhzkxAysP0wTRhCV9nkKAkiSiBK0JXbgV7M10d9frGZb6HGOXRlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lo4nFm/Z; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lo4nFm/Z"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1FD491ADB8;
	Wed, 24 Apr 2024 13:02:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=J6grFtioy/9x0VLKRn3goFmZCNScMuPfO6WYSU
	R1Vxg=; b=lo4nFm/ZXzmWxfMvPEP6lvuC0mWl4zAWUYCxQCxByWdQ3GprAfFgvr
	b7+1175wzuCIr7TFXhoIubyfl9a3r/jPN3Xrk49sK23PZxfwjcwVgYgrHBseU7kA
	g9iKAOJmzrUzLP/yBsHT+WZKeU4Nti6nWRobGy+0y2cLJzsrRLLO0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 175141ADB7;
	Wed, 24 Apr 2024 13:02:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CBD901ADB6;
	Wed, 24 Apr 2024 13:02:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Patrick
 Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 1/2] for-each-repo: optionally keep going on an error
In-Reply-To: <39ee6386aab25f28d197a27010b2f80ccd45aab2.1713975300.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Wed, 24 Apr 2024
	16:14:58 +0000")
References: <pull.1719.v2.git.1713444783.gitgitgadget@gmail.com>
	<pull.1719.v3.git.1713975299.gitgitgadget@gmail.com>
	<39ee6386aab25f28d197a27010b2f80ccd45aab2.1713975300.git.gitgitgadget@gmail.com>
Date: Wed, 24 Apr 2024 10:02:21 -0700
Message-ID: <xmqqfrvazobm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6BAD1B04-025C-11EF-BBFC-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> @@ -55,8 +58,14 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
>  	else if (err)
>  		return 0;
>  
> -	for (i = 0; !result && i < values->nr; i++)
> -		result = run_command_on_repo(values->items[i].string, argc, argv);
> +	for (i = 0; i < values->nr; i++) {
> +		int ret = run_command_on_repo(values->items[i].string, argc, argv);
> +		if (ret) {
> +			if (!keep_going)
> +					return ret;
> +			result = 1;
> +		}
> +	}
>  
>  	return result;
>  }

Hmph, as I wish that more experienced folks to give a good structure
to the codebase from get-go so that future developers who may be
less experienced would avoid mistakes, with my maintainer's hat on,
I would have expected something more like:

	for (i = 0; i < values->nr; i++) {
		int ret = run_command_on_repo(...);
		if (!ret)
			continue;
		if (keep_going) {
                	result = 1;			
		} else {
                	result = ret;
                        break;
		}
	}

That way, clean-up actions, when they need to be added, can go
before the single "return result" without structural changes,
future-proofing the shape of the control flow.

The loop is simple enough that it is acceptable to leave as the
responsibility of future developers who wants to do something that
require resource allocation and release before returning, of course
;-).



