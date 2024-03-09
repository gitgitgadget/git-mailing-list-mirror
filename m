Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFA122F00
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 01:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709946889; cv=none; b=K3vVK2/Y8bAnGiXe2b7CBdXUVArUJJBbzFpavFp3FPjRKexuzCsIv6UuGI1X3fG2Kw1aYKNOrnwmS//eAs0k9CDeLuyTht2n8aCHNKJG/DRT/do7mfLT1aHMLplue+5XudVuewuH9+cEC4mdl1rPGjN8BF79taMryVfywX4d0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709946889; c=relaxed/simple;
	bh=5RDjlliHLygT6AMg6MAsf0IMcSlpypq1V+uw+zgnTNs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YsmdulVE0tktuYoGnNbUQCDrax3UgXIFrxIqv2eTjBLiDpRjCQNAmVt2SHjAEP+j2QkCVexIIxnhcTXMGhFLOxnhUGObzNujY1Z/R/W52735JLgpZq76WDLwmxc3VBNkjyHyQD5oC91sQgoOicUF5KFa4H/sQ5Rs+uxtYmuC0x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DYXwjc4Y; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DYXwjc4Y"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A7883CA3A;
	Fri,  8 Mar 2024 20:14:47 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5RDjlliHLygT6AMg6MAsf0IMcSlpypq1V+uw+z
	gnTNs=; b=DYXwjc4YiupHchIxUN9DeiIV2v6EMxmTV12pCQDMK+A9c41zs3b94u
	U/33NmVYlkkJW0DNi0y5qw4qgf2HtKS+h5xyuC1y8+zSecPlDXTd8hKtB0Dt3Ub7
	uZK+8S0JtRFLhM4l4kaLbf/KG0fo/u6nIGznmVTN082H4RD+6Eo2Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 52F123CA39;
	Fri,  8 Mar 2024 20:14:47 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C23873CA35;
	Fri,  8 Mar 2024 20:14:43 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] setup: make bareRepository=explicit work in GIT_DIR
 of a secondary worktree
In-Reply-To: <CAO_smVjD8DFcvveAg2iiWGhtNJGCT1ieAUzJbX3TNNJjm-5rMw@mail.gmail.com>
	(Kyle Lippincott's message of "Fri, 8 Mar 2024 16:12:07 -0800")
References: <xmqqv85zqniu.fsf@gitster.g>
	<20240308211957.3758770-1-gitster@pobox.com>
	<20240308211957.3758770-3-gitster@pobox.com>
	<CAO_smVjrKJeKr7QgQWryZRErStFk=Y+1T=dwrR_boXQD_X9_Mg@mail.gmail.com>
	<xmqqy1ase1vo.fsf@gitster.g>
	<CAO_smVjD8DFcvveAg2iiWGhtNJGCT1ieAUzJbX3TNNJjm-5rMw@mail.gmail.com>
Date: Fri, 08 Mar 2024 17:14:42 -0800
Message-ID: <xmqqttlgdx4t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6973064C-DDB2-11EE-B0EC-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Kyle Lippincott <spectral@google.com> writes:

>> > What loss of security do we have if we don't have as stringent of a
>> > check? i.e. if we just did `return !!strstr(path, "/.git/worktrees/)`?
>>
>> No loss of security.
>
> Then should we just do that?

I do not see what you mean.

> + /* Assumption: `path` points to the root of a $GIT_DIR. */
>  static int is_repo_with_working_tree(const char *path)
>  {
> -       return ends_with_path_components(path, ".git");
> +       /* $GIT_DIR immediately below the primary working tree */
> +       if (ends_with_path_components(path, ".git"))
> +               return 1;
> +
> +       /*
> +        * Also allow $GIT_DIRs in secondary worktrees.
> +        * These do not end in .git, but are still considered safe because
> +        * of the .git component in the path.
> +        */
> +       if (strstr(path, "/.git/worktrees/"))
> +               return 1;
> +
> +       return 0;
>  }

Ah, no.  I thought you were asking "goto out" vs "return", and my
answer was about these two.  Whether you leave with "goto out" or
"return", it does not change the security posture.  Direct return
will raise the risk of leaking resources after careless future
updates to the code.

I didn't get that you do not want to see the other two "sanity
check".

Losing these sanity checks may not lose "security" per-se, but it
may raise the risk of misidentification.  A healthy GIT_DIR of a
secondary worktree should satisfy these two extra conditions.
