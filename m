Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AE47494
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011401; cv=none; b=J+7jY9fO+1oFUfotCSD2HkfK4h9+k5RVCWsZqqaVvH6Pzgv2oF9pEF0SZwtM5rGRc31Gd5l4flKTuooL5NnsQxBMpkpVBH1ElfNFyetP95Ov2se4rwHfCkB5zEwDDJ+dNdefgaUwKGiH6IHdo2qK1VoB/oJuDFGgj+8yl/yF3mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011401; c=relaxed/simple;
	bh=3Pfoo9fE0kY3BDt8M7kpM0HRQjh6jmlAeKFErVtRB5s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VVVzdvgA8xaSWxfgWHmKkXiQ357X7tZQ7z7xv14IrvjmfO4dy7cugfnedzKHJQheu+2pUv8WF7vj+GL/C1g2Bu0x+2CNvLayaHLIa31EAfTe96m9HMWTtjmoHTlxA20lT8uMn2VY8C7Ctk+7MVr6ygYnpwqQv88UFUmu1dCLRKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ju2ygDDV; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ju2ygDDV"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5C57434E75;
	Fri, 26 Jul 2024 12:29:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3Pfoo9fE0kY3BDt8M7kpM0HRQjh6jmlAeKFErV
	tRB5s=; b=ju2ygDDV2Fyw0vv+Bl3DnCHqaILM+BYqueHu3D9+J+zmPAM7qZjwl+
	e7G0eSXN7jiluHkjc3KD2yFWqWOWsS2Bse2ygcmIqHcif6oM6ot1wdUMZgGprx5f
	+NcJFsmlHUzJwjJ1/RP/+HgQzif77fdX37tEyjMqzLdY+IA5hwaJ8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 55FDB34E74;
	Fri, 26 Jul 2024 12:29:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D7EB034E73;
	Fri, 26 Jul 2024 12:29:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Ryan Hendrickson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Subject: Re: [PATCH] http: do not ignore proxy path
In-Reply-To: <pull.1767.git.1722009170590.gitgitgadget@gmail.com> (Ryan
	Hendrickson via GitGitGadget's message of "Fri, 26 Jul 2024 15:52:50
	+0000")
References: <pull.1767.git.1722009170590.gitgitgadget@gmail.com>
Date: Fri, 26 Jul 2024 09:29:54 -0700
Message-ID: <xmqqr0bgw1z1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4B05B3B2-4B6C-11EF-AA99-9625FCCAB05B-77302942!pb-smtp21.pobox.com

"Ryan Hendrickson via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
>
> The documentation for `http.proxy` describes that option, and the
> environment variables it overrides, as supporting "the syntax understood
> by curl". curl allows SOCKS proxies to use a path to a Unix domain
> socket, like `socks5h://localhost/path/to/socket.sock`. Git should
> therefore include, if present, the path part of the proxy URL in what it
> passes to libcurl.
>
> Signed-off-by: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
> ---
>     http: do not ignore proxy path
>     
>      * Documentation: do I need to add anything?

http.proxy documentation says

  The syntax thus is [protocol://][user[:password]@]proxyhost[:port].

but the updated code pays attention to what can come after the
"host[:post]" part, does it not?

> diff --git a/http.c b/http.c
> index 623ed234891..0cd75986a6b 100644
> --- a/http.c
> +++ b/http.c

I am unfamiliar with this code path, so let me follow along aloud.

> @@ -1265,7 +1265,13 @@ static CURL *get_curl_handle(void)
>  		if (!proxy_auth.host)
>  			die("Invalid proxy URL '%s'", curl_http_proxy);

We grabbed the value from the configuration variable (or various
environment variables like $http_proxy) in the curl_http_proxy
variable, and then passed it to credential_from_url() to parse parts
out of [protocol://][user[:password]@]proxyhost[:port][/p/a/t/h].
The parsed result is in proxy_auth struct and there is no hope it
can be usable if the .host member is missing.

> -		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);

We used to only use the .host member but the curl_http_proxy could
have had a path after it, held in the .path member.

> +		if (proxy_auth.path) {
> +			struct strbuf proxy = STRBUF_INIT;
> +			strbuf_addf(&proxy, "%s/%s", proxy_auth.host, proxy_auth.path);
> +			curl_easy_setopt(result, CURLOPT_PROXY, proxy.buf);
> +			strbuf_release(&proxy);
> +		} else
> +			curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);

Style.  If "if" side needs {braces} because it consists of multiple
statements, the corresponding "else" side should also have {braces}
around its body, even if it only has a single statement.

If you have the proxy strbuf in a bit wider scope, then the above becomes

	if (proxy_auth.path)
		strbuf_addf(&proxy, "%s/%s", proxy_auth.host, proxy_auth.path);
	else
		strbuf_addstr(&proxy, proxy_auth.host);
	curl_easy_setopt(result, CURLOPT_PROXY, proxy.buf);
	strbuf_release(&proxy);

which might (I am not decided) be easier to follow.

Could existing users have been taking advantage of the fact that the
extra /path at the end of http.proxy (and $http_proxy and friends)
are ignored?  For them, this change will appear as a regression.

Other than that (and the lack of any documentation and test
updates), looking good.

Thanks.
