Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB363F9D4
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709059118; cv=none; b=b1FVOq28zVcCRvYtnlqPGucWTmAsojiAsMzZUVWBoczHyCy/dOuDuEq+nmCGLqrI2hGZipxB27f6g5dvsa+K7KS/DevRL4XnqO6uXETLvn3Jsc3yesIoaF5sddftvjIZDRA2GgNeCtrjlhURHHxr2WK3YVnopAHoi2znQA61JEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709059118; c=relaxed/simple;
	bh=LaQCk1YOSB+RNqqmsNhIVwd3bQOBDttT1EC+bdTHp/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ElbGoY+6PHiYxXkPckV5h+EKIHZIfpH1WOJD2BNl/Kxq+ZPHfQdTWaS/TNe+nvOHDW89jBM8eX+vQJQZnQzd3flzsXUs3IDRQL/323YmDY6ExWGK/gbJDnX9hJaGvZIxxVNUb3812mOjnY9Hf9mWnEBQezenVbu2TSQt2ThkOOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XGJZm+Jf; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XGJZm+Jf"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1426E1DD318;
	Tue, 27 Feb 2024 13:38:36 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LaQCk1YOSB+RNqqmsNhIVwd3bQOBDttT1EC+bd
	THp/4=; b=XGJZm+JfcqIHgyVvQgLwFxr34tNk48lCm1BxEY1tfg9aGajW1UGv0l
	kDNME5/nTlzzljglqh7gL63JJXyvDJ2iOUsuhP2P6ODJDRF00iGA5K7Nu5FYqbgr
	XSW5HK1CtXvN8u00jLuj0ahVyU5Awo2UGXpGiL/oQVXligM/y3f/8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AF641DD317;
	Tue, 27 Feb 2024 13:38:36 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B2871DD316;
	Tue, 27 Feb 2024 13:38:35 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: stop setting GIT_CHERRY_PICK_HELP
In-Reply-To: <pull.1678.git.1709042783847.gitgitgadget@gmail.com> (Phillip
	Wood via GitGitGadget's message of "Tue, 27 Feb 2024 14:06:23 +0000")
References: <pull.1678.git.1709042783847.gitgitgadget@gmail.com>
Date: Tue, 27 Feb 2024 10:38:34 -0800
Message-ID: <xmqqil29sqfp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6A469FEA-D59F-11EE-9AF8-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Note that we retain the changes in e4301f73fff (sequencer: unset
> GIT_CHERRY_PICK_HELP for 'exec' commands, 2024-02-02) just in case
> GIT_CHERRY_PICK_HELP is set in the environment when "git rebase" is
> run.

Is this comment about this part of the code?

> +	const char *msg;
> +
> +	if (is_rebase_i(opts))
> +		msg = rebase_resolvemsg;
> +	else
> +		msg = getenv("GIT_CHERRY_PICK_HELP");

Testing is_rebase_i() first means we ignore the environment
unconditionally and use our own message always in "rebase -i", no?

Not that I think we should honor the environment variable and let it
override our message.  I just found the description a bit confusing.

> diff --git a/sequencer.h b/sequencer.h
> index dcef7bb99c0..437eabd38af 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -14,6 +14,8 @@ const char *rebase_path_todo(void);
>  const char *rebase_path_todo_backup(void);
>  const char *rebase_path_dropped(void);
>  
> +extern const char *rebase_resolvemsg;

This is more library-ish part of the system than a random file in
the builtin/ directory.  This place as the final location for the
string makes sense to me.

Thanks.
