Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B345C3E47E
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 06:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709187004; cv=none; b=uOC2+tVReb8AS1H2QhlTIewIlkoD3LZWUPSQssTNDbbAUDwqTQwM07qiMabJNqeDDqo3/ZAXcTM7cvm2kupAUUkUsg0dYSf3tfr+NqcVVRSRTDKmkYJgBkh6N+Nv9xv/2Sn14wnzNGwanHsaOolIO7JNd6KZdHcwFc36oW2idmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709187004; c=relaxed/simple;
	bh=izIwa3qteZbsNFC8L418zBO0fShPI7gqWyh0VqTNk+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uazQrEXYv5nnbgQZNbrHC1FMyfpCINzkA9BmM5iHcHa5B5HRAZpxWcBrhW2mqcXgp3hsQR0mKLUY7/dyS2BWge8nbi2QfVp5yNSd8VMwMuYRDORKW1Zz5R2EjsXau5N3rJc1iiH0h2WjBwfpKlelbN+RqyTVNjRSQqq+SW4UIvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org; spf=pass smtp.mailfrom=joshtriplett.org; dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b=OA63+Eq8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nbo4C4UQ; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b="OA63+Eq8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nbo4C4UQ"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 974F518000A0;
	Thu, 29 Feb 2024 01:10:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 29 Feb 2024 01:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	joshtriplett.org; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709187000;
	 x=1709273400; bh=Q9MLl3kajQnvcrinbmXvzt0kxmLJcVBdoiACd+a095E=; b=
	OA63+Eq87nJxcgFn/SMLs3e3akt5Vt1ewiJqR8cMY9OUSdPpcBveLDIUPb3nYuXX
	vdqvCxf8drluyMeNuK5JPbHfulDawfDe4sm5SGR6JR72E4EgH/1LcqezNUG2hb2M
	SzrvWTiTumTNwXn7k7sfD/I+/lfUA1j+4REoaDYgHhcpCnS3VUWAsImNf+eFIk71
	kueFNRNEPaG/thBtxCSA82qTopk+qbF6THnHciFzbIgiPI0j3dBIwKvt8BLGRBj0
	PlcTq29Fg4v5d//O78G5lCEPiEULPJIkK0h77snZ6oEOmWqbTqMZQcV6hkTmOvjW
	0sUIj0cmDw8Py6Y5dj40vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709187000; x=1709273400; bh=Q9MLl3kajQnvcrinbmXvzt0kxmLJ
	cVBdoiACd+a095E=; b=nbo4C4UQ7caeduRWnWiBW9mg4K5f4kQB2ZqM47qMP6ex
	yyEECaQT1dAJtEVHQ0k3olt0EvB0iuLSoC+78DIKpxrPTAbBtc6wMgcFZyiPHolz
	0Ks8S+hzQORW8bAuIk60dhjshCrMURyubDAy6hCAxlZAKsMTkvLomangbrFRo+RQ
	s1xYedVIyInm2uxoyB5r/XR7s4OJ3zLwvouGg5F9enddNGvM/kKlJIzjvRjfTFkH
	+gzlG2zH5xryYfKHo+8N4ExTWBH2FVr5Gy4Ud8H54mmqQ3Ile+NVP4L2YgQ11FJQ
	Q4zlrlo/bdQ4jRO6TZ8mTzkBQZzhMZXQS04FzdAkQg==
X-ME-Sender: <xms:tx_gZZ0-coFFkgNgNkhFmuBtX6TG2iJDNRCmmMOapV4c7P88q9T93g>
    <xme:tx_gZQHTl-hXQ0N6hM67eEoLgZs2TTb_ulQP_y8fRMm2pbKtuwfW6HjdLgu0Fly1j
    yuUYbQL49vduVRADhQ>
X-ME-Received: <xmr:tx_gZZ4VhMqWo3J-IgmYTwbQ6aZfmCDZwM0r8fDZilbmsXp2SuRlpZZ9nQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeekgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtro
    dttddtvdenucfhrhhomheplfhoshhhucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhh
    thhrihhplhgvthhtrdhorhhgqeenucggtffrrghtthgvrhhnpeehieduvedtvdehieegje
    fhffevhfehheefgeehieeutdeiffejveegfeejtdefudenucffohhmrghinhepkhgvrhhn
    vghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgh
X-ME-Proxy: <xmx:tx_gZW2UNBwUp_Z8-sT-wOwAk-nnpajms-j9cZbWNxJwSQ8JOAyn3g>
    <xmx:tx_gZcHkfNZrhZJ70Kl3XjCYgOkZW38AeOAAqOmk0ytaWkXbmduiOQ>
    <xmx:tx_gZX9ohUkP9xU-ZtT0a1gFUeEQ73XxsYfpg-yIl7GtVsZwsuldRw>
    <xmx:uB_gZRRp3eNQNs1YBybUHAenhhJ_MNLSR5GjO9KG_Dsp_EMDbQgZe2ywq7M>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Feb 2024 01:09:59 -0500 (EST)
Date: Wed, 28 Feb 2024 22:09:58 -0800
From: Josh Triplett <josh@joshtriplett.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] commit: Avoid redundant scissor line with
 --cleanup=scissors -v
Message-ID: <ZeAftoPPRsltswbS@localhost>
References: <9c09cea2679e14258720ee63e932e3b9459dbd8c.1708921369.git.josh@joshtriplett.org>
 <xmqqbk83nlw5.fsf@gitster.g>
 <Zd2eLxPelxvP8FDk@localhost>
 <4f97933f173220544a5be2bf05c2bee2b044d2b1.1709024540.git.josh@joshtriplett.org>
 <xmqqjzmpu7k6.fsf@gitster.g>
 <ZeAFutaddf4M2wjM@localhost>
 <xmqqttlrj08t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqttlrj08t.fsf@gitster.g>

On Wed, Feb 28, 2024 at 09:41:22PM -0800, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> > If you do end up needing a resend of any of them, I'm happy to do so.
>
> I do not think there is need for resending, but I think you promised
> to add some tests earlier, so an updated patch may be in order ;-)

I did add a test; v2 that you replied to has this:
> Add a test for this.
[...]
>  t/t7502-commit-porcelain.sh |  5 +++++
[...]
> diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
> index a87c211d0b..b37e2018a7 100755
> --- a/t/t7502-commit-porcelain.sh
> +++ b/t/t7502-commit-porcelain.sh
> @@ -736,6 +736,11 @@ test_expect_success 'message shows date when it is explicitly set' '
>         .git/COMMIT_EDITMSG
>  '
>  
> +test_expect_success 'message does not have multiple scissors lines' '
> +     git commit --cleanup=scissors -v --allow-empty -e -m foo &&
> +     test $(grep -c -e "--- >8 ---" .git/COMMIT_EDITMSG) -eq 1
> +'
> +
>  test_expect_success AUTOIDENT 'message shows committer when it is automatic' '
>  
>       echo >>negative &&

https://lore.kernel.org/git/xmqqedcxvnn8.fsf@gitster.g/T/#Z2e.:..:4f97933f173220544a5be2bf05c2bee2b044d2b1.1709024540.git.josh::40joshtriplett.org:1t:t7502-commit-porcelain.sh
