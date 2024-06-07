Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C5518732F
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773690; cv=none; b=GwvcfvTt4Eyla4ZA9FKn68CcOqnuzNND87pJZfaSkFIK9+7Xa+vV+cWErp/+/QdaGw3hHg6L4Kv/mvOW7BWgsLDXo6CtOUYTfuTwZzFK8yazQrDE/NmyNhCrIS4NuUjvAiRi3H4PBEUbc0ajJY2FSOlT0H4ywT6ZE+KnfDBZtk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773690; c=relaxed/simple;
	bh=g1sR5dXQH0kTE4UJLyQYex2tstVt/V06HV2882kn2gg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MSOX0bUIrF7DOmFzc6gMoT8A7KPwFNW0Wr4i6XwL3A7x3YaBcOvHBHz1OW72BBXaisZfkCSdesasrU7N+M/ptIbyIT1LX7tr/GnhCreGZPPrZxFgb7PcXYjZRGW494DByYsuNVkRZSH4gVrsHCqDWfX9rAipvB9FH3sb1sjHfwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=egRHMF6h; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="egRHMF6h"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DC3836ED9;
	Fri,  7 Jun 2024 11:21:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=g1sR5dXQH0kTE4UJLyQYex2tstVt/V06HV2882
	kn2gg=; b=egRHMF6hwsg1czb1iwh1vU3L8rqCrbeYexJ1U0Rdz6EFJ/MISoMQWy
	X0Zya+rubjmD/GSZgRvAS+4r6ceEhXG233/MGaQd6+dhC0lA52absXmgbgoij/Xa
	jOe+SrRHhBrzkpHXR6ueG3o7nRhXfjWBVtdsxqSbrpbv0j8dQ/Amg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 53E2136ED8;
	Fri,  7 Jun 2024 11:21:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BCA4B36ED7;
	Fri,  7 Jun 2024 11:21:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: John Cai <johncai86@gmail.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff King <peff@peff.net>,
  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <avila.jn@gmail.com>
Subject: Re: [PATCH 1/4] refs: add referent parameter to
 refs_resolve_ref_unsafe
In-Reply-To: <7FC6AD35-0DF4-4228-8708-790470D4B0EA@gmail.com> (John Cai's
	message of "Fri, 07 Jun 2024 09:43:46 -0400")
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
	<011c10f488610b0a795a843bff66723477783761.1717694801.git.gitgitgadget@gmail.com>
	<xmqq34pqlyou.fsf@gitster.g> <xmqqv82mkk15.fsf@gitster.g>
	<7FC6AD35-0DF4-4228-8708-790470D4B0EA@gmail.com>
Date: Fri, 07 Jun 2024 08:21:19 -0700
Message-ID: <xmqqfrtohj80.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9894C822-24E1-11EF-A5A9-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

John Cai <johncai86@gmail.com> writes:

> Yes, so for 3/4 I was exploring doing the same thing. However, each_repo_fn goes
> pretty deep in the callstack and to provide an alternate set of functions that
> use something like each_repo_referent_fn would still lead to a relatively large
> blast radius, eg, something like:

Hmph.  You only care about teaching referent to calls to
refs_for_each_ref_in() and friends in apply_ref_filter()
and nowhere else.  So for example, to preserve the current
calling pattern for this pair of caller/callback (and you have
dozens more exactly like this one you touch in [3/4]):

	static int register_ref(const char *refname,
                                const struct object_id *oid,
				int flags,
				void *cb_data);

	static int read_bisect_refs(void)
	{
		return refs_for_each_ref_in(get_main_ref_store(the_repository),
					    "refs/bisect", register_ref, NULL);
	}

you could arrange your _new_ API the way you want, e.g.,

	typedef int each_ref_with_referent_fn(const char *refname,
	                                      const char *referent,
                                              const struct object_id *oid,
					      int flags,
					      void *cb_data);

	int refs_for_each_ref_with_referent_in(struct ref_store *refs,
					       const char *prefix,
                                               each_ref_with_referent_fn fn,
					       void *cb_data);

to help the single caller, i.e., apply_ref_filter(), and rebuild the
existing API on top as a thin wrapper, e.g.

	/* This cannot change without butchering existing callers */
	typedef int each_ref_fn(const char *refname,
                                const struct object_id *oid,
				int flags,
				void *cb_data);

	/* Hence we introduce an adapter */
	struct each_ref_fn_adapter_cbdata {
		each_ref_fn user_each_ref_fn;
		void *user_cb_data;
	};

	/* This is designed to work as an each_ref_with_referent_fn */
	static int each_ref_adapter_fn(const char *refname,
				       const char *referent,
                                       const struct object_id *oid,
				       int flags,
				       void *cb_data)
	{
		struct each_ref_fn_adapter_cbdata *adapter_cbdata = cbdata;

		/* the callers have no need for referent */
                return adapter_cbdata->user_each_ref_fn(refname, oid, flags,
					                adapter_cbdata->user_cbdata);
	}

	/*
         * The function signature must stay the same to help existing,
         * callers, but the implementation is now a thin wrapper.
	 */
	int refs_for_each_ref_in(struct ref_store *refs,
				 const char *prefix,
                                 each_ref_fn fn,
				 void *cb_data)
        {
		struct each_ref_fn_adapter_cbdata adapter_cbdata = {
                	.user_each_ref_fn = fn,
			.user_cb_data = cb_data,
		};
		return refs_for_each_ref_with_referetnt_in(refs, prefix,
							   each_ref_adapter_fn,
                                                           &adapter_cbdata);
	}

no?

You'd need to pass through the new parameter "referent" through the
code paths that implement refs_for_each_ref_in() and friends to
update them to refs_for_each_ref_with_referent_in() and friends no
matter what, but there are limited number of the top-level
refs_for_each_ref_in() and friends that are unaware of the
"referent", and each of them would need the above ~20 lines (couting
the comment) adapter function that all can share the single
each_ref_adapter_fn() callback function.

Or am I missing some other intricacy in the existing for-each-* API?
