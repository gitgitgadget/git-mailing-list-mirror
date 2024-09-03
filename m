Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BDB18F2F6
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388295; cv=none; b=eOruszZMtm+R3mE0y78+w5bwK0uaHWT4ceMlvivbPXarVNKGgm6Ma1WGi7iOFWzTOaXjja+d3BI9sVjEEf06Ty6zI1LRcO8Zte8+Nkp/D27SEctPLRp0EcRcTEgVhkj1O2G1LCrJ3TKBjFvHQnWxrSiaAKuBbThpccec+4i8gwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388295; c=relaxed/simple;
	bh=byND/De8UIeMdw7+bJsEnUvpnj/6OuO87vZ2lXoFWZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MssIx0kIQrj+yCP23EweXr9qsItai0p07tkzmInrbCGZFXx8vH9WILcfts3ffrZKrdYSUIEozikIpZS9VyBz84xcbj4/24GRXDpJ30dBIfYIvPo6H8Jr+/aoVhMU6aSk4z7t/3bY/SD6+zKf3fxAuabxLQQaWGfF6gqV9hUtmBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=k/oWUTaj; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k/oWUTaj"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09D8B2802F;
	Tue,  3 Sep 2024 14:31:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=byND/De8UIeMdw7+bJsEnUvpnj/6OuO87vZ2lX
	oFWZ8=; b=k/oWUTajynVe1wxF+pVQOXcjOAoztLwYwgWrnYkCfvtPQizzmCKBLI
	4HjQ4/k7N9dCM8pvJUlsxkCDVvVQFXyvscwAas7KEBtbyrIwpilhIK6UNziQSn13
	blSh9i95Q9egiz8N8Fi0kc1eo/IVkp0PAP7vIeBqRv/zNH8nid5bI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F274A2802E;
	Tue,  3 Sep 2024 14:31:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55EBD2802D;
	Tue,  3 Sep 2024 14:31:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH] Documentation/BreakingChanges: announce removal of
 git-pack-redundant(1)
In-Reply-To: <a6be9f5e9eb1f426b1a17b89e3db1bc7532758b5.1725264748.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 2 Sep 2024 10:13:00 +0200")
References: <a6be9f5e9eb1f426b1a17b89e3db1bc7532758b5.1725264748.git.ps@pks.im>
Date: Tue, 03 Sep 2024 11:31:31 -0700
Message-ID: <xmqqy148k2rg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BE2A8186-6A22-11EF-8CD9-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The git-pack-redundant(1) command is already in the process of being
> phased out and dies unless the user passes the `--i-still-use-this` flag
> since 4406522b76 (pack-redundant: escalate deprecation warning to an
> error, 2023-03-23). We haven't heard any complaints, so let's announce
> the removal of this command in Git 3.0 in our breaking changes document.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/BreakingChanges.txt | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)


Finally ;-)

The "--i-still-use-this" (unless major distros have stripped it out)
was a good approach to allow us do this.

Will queue.  Thanks.


> diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChanges.txt
> index 0532bfcf7f9..2b64665694f 100644
> --- a/Documentation/BreakingChanges.txt
> +++ b/Documentation/BreakingChanges.txt
> @@ -115,6 +115,26 @@ info/grafts as outdated, 2014-03-05) and will be removed.
>  +
>  Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
>  
> +* The git-pack-redundant(1) command can be used to remove redundant pack files.
> +  The subcommand is unusably slow and the reason why nobody reports it as a
> +  performance bug is suspected to be the absense of users. We have nominated
> +  the command for removal and have started to emit a user-visible warning in
> +  c3b58472be (pack-redundant: gauge the usage before proposing its removal,
> +  2020-08-25) whenever the command is executed.
> ++
> +So far there was a single complaint about somebody still using the command, but
> +that complaint did not cause us to reverse course. On the contrary, we have
> +doubled down on the deprecation and starting with 4406522b76 (pack-redundant:
> +escalate deprecation warning to an error, 2023-03-23), the command dies unless
> +the user passes the `--i-still-use-this` option.
> ++
> +There have not been any subsequent complaints, so this command will finally be
> +removed.
> ++
> +Cf. <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>,
> +    <CAKvOHKAFXQwt4D8yUCCkf_TQL79mYaJ=KAKhtpDNTvHJFuX1NA@mail.gmail.com>,
> +    <20230323204047.GA9290@coredump.intra.peff.net>,
> +
>  == Superseded features that will not be deprecated
>  
>  Some features have gained newer replacements that aim to improve the design in
