Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F26219EB
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268931; cv=none; b=KT7qrFSQABLwRygd2mMMbVV171x9PyeOJsl5+cDyJYJjTm+zqDayHGG7WqfquGaDaI0i2rbdRVvrS7C+IH6GpE2oU3P4T2C56/YYYok+FTvAL9PvyW4uxmm+SknOW2pqGlVx5/Z9/1pem/btQDEaHbdpOWk47BjfxXjdBgQLZWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268931; c=relaxed/simple;
	bh=iYZoMUgJzqV18Gj5tfsQ/ISefwZ7vFw6QYk5ly6+QNQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=e2S7P7JFfNmXgnGbk4iT260ATi6ySJPGEbtv7m8zKF9hLszUNKxGSZ04R30nsCV3dRBIjxprET7qp1G9AUlQ5+iU19lP7smLRR9l9/Rt6LsZMVMmtRpO7+U75pG/IewR2Avs8aVAHZvmlc+8Y564lXwVbn+e8oSzRSfYV/JEVo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 507GtLmt1547778
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 16:55:21 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, "'Patrick Steinhardt'" <ps@pks.im>
Cc: "'Christian Couder'" <christian.couder@gmail.com>, <git@vger.kernel.org>,
        "'D. Ben Knoble'" <ben.knoble@gmail.com>
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>	<20250106-pks-remote-branches-deprecation-v2-5-2ce87c053536@pks.im>	<CAP8UFD0Lzazxyq9nnT-vwN=MijKAsYySFC2dvDEj33cS7VB0kA@mail.gmail.com>	<xmqq34hw0whh.fsf@gitster.g> <Z30hnx43mEwjWqzA@pks.im>	<xmqq8qrmvap5.fsf@gitster.g> <xmqq4j2avaam.fsf@gitster.g>
In-Reply-To: <xmqq4j2avaam.fsf@gitster.g>
Subject: RE: [PATCH v2 5/5] remote: announce removal of "branches/" and "remotes/"
Date: Tue, 7 Jan 2025 11:55:16 -0500
Organization: Nexbridge Inc.
Message-ID: <006701db6124$f16f9420$d44ebc60$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGWFAHXZ5Gr1fXnURfQ1C05S4s8pADP4r5EAbd8D5wCYrV2GQJhvqjdAiWw0lICfaos+bM2qA6Q
Content-Language: en-ca
X-Antivirus: Norton (VPS 250107-2, 1/7/2025), Outbound message
X-Antivirus-Status: Clean

On January 7, 2025 11:50 AM, Junio C Hamano wrote:
>Junio C Hamano <gitster@pobox.com> writes:
>
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>>> Makes sense indeed. We can easily add for something like below diff.
>>> I'll roll that into the next version, thanks!
>>
>> It is a good start, but is probably a bit too noisy.  Can we make them
>> appear ONLY when the definitions read from these older sources are
>> actually USED?
>>
>> Thanks.
>
>Something along this line is what I had in mind.  Not even compile tested,
and I am
>not claiming that all the uses of remote will go thourgh the code paths to
use it with
>a transport, but you hopefully got the idea.
>
> remote.c    | 20 ++++++++++++++++++++
> remote.h    |  2 ++
> transport.c |  2 ++
> 3 files changed, 24 insertions(+)
>
>diff --git c/remote.c w/remote.c
>index f43cf5e7a4..1cca98215d 100644
>--- c/remote.c
>+++ w/remote.c
>@@ -2904,3 +2904,23 @@ char *relative_url(const char *remote_url, const
char
>*url,
> 	free(out);
> 	return strbuf_detach(&sb, NULL);
> }
>+
>+void remote_stale_warning(const struct remote *remote) {
>+	const char *msg;
>+
>+	switch (remote->origin) {
>+	case REMOTE_REMOTES:
>+		msg = N_("Using remote '%s' read from the .git/remotes, "
>+			 "whose support will be removed");
>+		break;
>+	case REMOTE_BRANCHES:
>+		msg = N_("Using remote '%s' read from the .git/branches, "
>+			 "whose support will be removed");
>+		break;
>+	default:
>+		return;
>+	}
>+
>+	warning(_(msg), remote->name);
>+}
>diff --git c/remote.h w/remote.h
>index b901b56746..e29ceef3e4 100644
>--- c/remote.h
>+++ w/remote.h
>@@ -445,4 +445,6 @@ void apply_push_cas(struct push_cas_option *, struct
>remote *, struct ref *);  char *relative_url(const char *remote_url, const
char *url,
> 		   const char *up_path);
>
>+void remote_stale_warning(const struct remote *remote);
>+
> #endif
>diff --git c/transport.c w/transport.c
>index 12cc5b4d96..c153be9100 100644
>--- c/transport.c
>+++ w/transport.c
>@@ -1131,6 +1131,8 @@ struct transport *transport_get(struct remote
*remote,
>const char *url)
> 	ret->remote = remote;
> 	helper = remote->foreign_vcs;
>
>+	remote_stale_warning(remote);
>+
> 	if (!url)
> 		url = remote->url.v[0];
> 	ret->url = url;

I like this but wonder whether there might be some way to inhibit the
warnings
one a user gets it and decides they will act but do not want to see the
warnings
any longer? I have had requests like this on other products. Just a thought.

