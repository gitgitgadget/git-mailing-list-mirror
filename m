Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4853D3B8
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 20:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087941; cv=none; b=RQr6ldtU96f9teEb8xAS1O+LjESVQQuDwXK4PLMRNv9IJgHWGqVVFE6WQQY1yqL822Y7i0KQy9YPabflFRJZ9TaueSJAfQ7IxPQLFBM1oXftG023yhf8rh0bquFQBfdeyHdm/Hk42cEBLn1sbQlSW46tuVmG3KwM4FODApZ62xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087941; c=relaxed/simple;
	bh=FW6k3lmVGEmnERnPvTlnVA3bVWap4nnLX4ERCWXkC9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f3hb0z2JePXsf/wCGKoor6sDz34geKYKZfH1n32LumXpDVxaB0x9JElZZBYIfdm66rJIvp3ITHq+RTVyCK5sHUM8VK7bslAO1RDPJcts6On+HWmqH8MsozzaRsPfcZW1hc8G+B2RJrJc/k8YnxWu1WvAAyIJ5vNwRhyKHGzqT50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uvc5909M; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uvc5909M"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 755FA1E20C;
	Wed, 11 Sep 2024 16:52:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FW6k3lmVGEmnERnPvTlnVA3bVWap4nnLX4ERCW
	XkC9s=; b=uvc5909M412e8xrMX7UMwIf7leSpjY4gRlq72BE7dG9YZ+b+AmQnre
	GATCZRD/U1g2VRH9RuUWz0yv20E08BICZj8MjLvWpV3XtW2rWRWprMSR9XznPPBK
	EU/8q1f4IssBm94DFfLfB/uCQrlTnBBbuzJLjvbbP06yKBcy0/OTQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DF351E20B;
	Wed, 11 Sep 2024 16:52:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBD9E1E20A;
	Wed, 11 Sep 2024 16:52:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Han Jiang <jhcarl0814@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/4] remote: print an error if refspec cannot be removed
In-Reply-To: <a8dfe403d0683aec4265bf920921e45d5b59cec3.1726067917.git.gitgitgadget@gmail.com>
	(Phillip Wood via GitGitGadget's message of "Wed, 11 Sep 2024 15:18:35
	+0000")
References: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
	<a8dfe403d0683aec4265bf920921e45d5b59cec3.1726067917.git.gitgitgadget@gmail.com>
Date: Wed, 11 Sep 2024 13:52:16 -0700
Message-ID: <xmqqseu56hhb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BB68E90C-707F-11EF-ABD3-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If the existing fetch refspecs cannot be removed when replacing the set
> of branches to fetch with "git remote set-branches" the command silently
> fails. Add an error message to tell the user what when wrong.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/remote.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 794396ba02f..4dbf7a4c506 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -1603,6 +1603,7 @@ static int set_remote_branches(const char *remotename, const char **branches,
>  	}
>  
>  	if (!add_mode && remove_all_fetch_refspecs(key.buf)) {
> +		error(_("could not remove existing fetch refspec"));
>  		strbuf_release(&key);
>  		return 1;
>  	}

It is a minor point, but would it help to say what we tried to
remove (e.g. "from remote X") or is it too obvious to the end user
in the context they get this error?

The reason why I had the above question was because inserting error()
before strbuf_release(&key) looked curious and I initially suspected
that it was because key was used in the error message somehow, but it
turns out that is not the case at all.

IOW, I would have expected something more like this:

 	if (!add_mode && remove_all_fetch_refspecs(key.buf)) {
 		strbuf_release(&key);
+		return error(_("failed to remove fetch refspec from '%s'"),
+				remotename);

 	}

