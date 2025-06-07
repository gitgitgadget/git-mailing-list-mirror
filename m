Received: from mythic.p10link.net (mythic.p10link.net [93.93.134.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D457153BED
	for <git@vger.kernel.org>; Sat,  7 Jun 2025 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.134.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749335781; cv=none; b=rq1uP9tDqMCWweXuf0Z2r9VDV+XwUz9y9gSSwBljobm8oXe6DYQxkXpd4gQY4VLJT2hbcISNFhXur/Dro3n1dktCKWpain/x8bEdLwSJ/m2O9PByBPIX33RbU5+fSEQBf1bHVZj5Sm+aKT2OoKKdMB4eCj2RtieLZ/kRmfFA3fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749335781; c=relaxed/simple;
	bh=NTtAvledTnMZsoIPJR3TFYoJH4cegsYSgIt3AGwbElQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=clUqJ+nZ43B8ODfoLTGb54gRpNrGqLxFjN9mf22IuRmTrd8Qzs/7MaYE+bMxSP4G/RGJjNe6s/RY6fzb5MqRkThn39d2WtFiqX1DN7TPK6xML+LkyFwc/yqHeRN0RHluBmCrSV2t9GuLva/aS1VOjsjguNAq6ihUgFSc0fhjeQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=93.93.134.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Received: from [192.168.2.108] (cust23-dsl91-135-10.idnet.net [91.135.10.23])
	by mythic.p10link.net (Postfix) with ESMTPSA id 4C21F171
	for <git@vger.kernel.org>; Sat,  7 Jun 2025 22:28:21 +0000 (UTC)
Message-ID: <07b6d5b3-7de5-db8c-5db0-c8c37dbf5364@debian.org>
Date: Sat, 7 Jun 2025 23:28:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From: Peter Michael Green <plugwash@debian.org>
Subject: git - passes wrong types to curl_easy_setopt
To: git@vger.kernel.org
Content-Language: en-US
Reply-To: 1107437@bugs.debian.org, plugwash@debian.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

When building against curl 8.14 git creates a whole bunch of compiler
warnings. We originally discovered this because of a package in Debian
that was using an embedded code copy of git and building it with
-Werror (see debian bug 1107412) but the issue is clearly visible
when rebuilding the git package in current sid.

> imap-send.c:1421:9: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>   1421 |         curl_easy_setopt(curl, CURLOPT_PORT, srvc->port);
> imap-send.c:1434:9: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>   1434 |         curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, srvc->ssl_verify);
> imap-send.c:1435:9: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>   1435 |         curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, srvc->ssl_verify);
> http-push.c:197:9: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>    197 |         curl_easy_setopt(curl, CURLOPT_HTTPGET, 1);
> http-push.c:197:9: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>    197 |         curl_easy_setopt(curl, CURLOPT_HTTPGET, 1);
> http-push.c:197:9: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>    197 |         curl_easy_setopt(curl, CURLOPT_HTTPGET, 1);
> http-push.c:197:9: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>    197 |         curl_easy_setopt(curl, CURLOPT_HTTPGET, 1);
> http-push.c:197:9: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>    197 |         curl_easy_setopt(curl, CURLOPT_HTTPGET, 1);
> http-push.c:197:9: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>    197 |         curl_easy_setopt(curl, CURLOPT_HTTPGET, 1);
> remote-curl.c:880:9: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>    880 |         curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
> remote-curl.c:881:9: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>    881 |         curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
> remote-curl.c:885:9: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>    885 |         curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, 4);
> http.c:1010:17: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>   1010 |                 curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 0);
> http.c:1011:17: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>   1011 |                 curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 0);
> http.c:1014:17: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>   1014 |                 curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 1);
> http.c:1016:17: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>   1016 |                 curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
> http.c:1048:17: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>   1048 |                 curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
> http.c:1108:9: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>   1108 |         curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
> http.c:1109:9: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>   1109 |         curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
> http.c:1142:17: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>   1142 |                 curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
> http.c:1183:25: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>   1183 |                         curl_easy_setopt(result,
> http.c:1186:25: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>   1186 |                         curl_easy_setopt(result,
> http.c:1189:25: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>   1189 |                         curl_easy_setopt(result,
> http.c:1192:25: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>   1192 |                         curl_easy_setopt(result,
> http.c:1195:25: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>   1195 |                         curl_easy_setopt(result, CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
> http.c:709:9: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>    709 |         curl_easy_setopt(c, CURLOPT_TCP_KEEPALIVE, 1);

While the compiler warnings appear to be new with curl 8.14
the underlying issue does not. curl_easy_setopt is a variadic
function whose parameter types depend on the option selected.

Passing a parameter of the wrong type to a variadic function
can have consequences that vary by architecture and the types
of the preceding parameters. It's possible that the right
thing will happen by "accident", either because the types
are in-fact the same size, or for example a 32-bit value
may be converted to a 64-bit value where the top bits are
garbage and the bottom bits are correct this may then be
converted back to a 32-bit value throwing away the garbage.

But it's equally possible the right thing will not happen,
that the variadic function will end up dealing with garabage
and will misbehave or crash

I think the fix here is just to add casts and literal suffixes
so the argument is passed as the correct type, but I'd
appreciate feedback from people more familiar with the codebase

