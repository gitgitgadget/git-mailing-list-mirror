Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0080101C2
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 17:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nE9UfH/J"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5167B1B79B7;
	Thu, 28 Dec 2023 12:15:31 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hHe7EPg8p7KXPWaGkxMdNzNot916saF5I4N6KF
	1h1Tk=; b=nE9UfH/Jztk9hubXVqkBTULO55Kwdg9CblMvPzpF/rbyjF3hanJFEx
	jg5F1l/oLp999xwz129cAahjo11bHOkaeTO+/xCVTfEoFUM5/kGKEDGqE6CJrYB0
	Djjh5JIKrw/ilOyw+HSg1Ac0IKy+YxtjM53lA6RRz1DRLduPp8EJ4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4998A1B79B6;
	Thu, 28 Dec 2023 12:15:31 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF09E1B79B5;
	Thu, 28 Dec 2023 12:15:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/12] setup: start tracking ref storage format when
In-Reply-To: <ZY04OlTNUEZs5T-T@tanuki> (Patrick Steinhardt's message of "Thu,
	28 Dec 2023 09:56:26 +0100")
References: <cover.1703067989.git.ps@pks.im>
	<6564659d403de098799ddb8101b74c2803a655d4.1703067989.git.ps@pks.im>
	<xmqqv88ssp4r.fsf@gitster.g> <ZY04OlTNUEZs5T-T@tanuki>
Date: Thu, 28 Dec 2023 09:15:29 -0800
Message-ID: <xmqqplyqgsem.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B3F3100E-A5A4-11EE-8487-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Makes me wonder whether we should then also add the following diff to
> "setup: set repository's format on init" when both topics are being
> merged together:
>
> diff --git a/setup.c b/setup.c
> index 3d980814bc..3d35c78c68 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2210,6 +2210,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
>  	 * format we can update the repository's settings accordingly.
>  	 */
>  	repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
> +	repo_set_compat_hash_algo(the_repository, repo_fmt.compat_hash_algo);
>  	repo_set_ref_storage_format(the_repository, repo_fmt.ref_storage_format);
>  
>  	if (!(flags & INIT_DB_SKIP_REFDB))

Shouldn't that come from the series that wants .compat_hash_algo in
the repo_fmt structure, whichever it is, not added by an evil merge?
