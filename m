Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A692D27E
	for <git@vger.kernel.org>; Wed, 29 May 2024 21:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717018910; cv=none; b=aUvVi+ENJBHVKz9dhCXe4GufspSph0JQzIVSOjIKAmD/vKofdEV36MmRUyjNkcCE1o2Uogdq6r3kRKoD2FDkTye4bjRJsbDzJgj1eGzyoln2yFHuEWUEHeQ1Ady20EbnihICljmPlRjd4dc5Si9Q38+tZWigFq8kRqIvp6W9HTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717018910; c=relaxed/simple;
	bh=mVZ5hW8jt66CyicNPYkanD5EK5wu9kJMPuHF1X68Qxk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K56dWsapmHP9pryOpIQGxiIYDpGk53fOZTE2AHqTqBs7hZnbHTTJlIoszyFWEU/l6PM6knR6Ewrue63cEekZ92FwIdbXbRx3XvrJAj033Zc1Ysa7SlkTIlYx99M5hWI/CGrFYqQzK+nUfhkeEcl9XhvH/KVIjch8CrSs4r1w8Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TDrk0ot9; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TDrk0ot9"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D4818253AA;
	Wed, 29 May 2024 17:41:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mVZ5hW8jt66CyicNPYkanD5EK5wu9kJMPuHF1X
	68Qxk=; b=TDrk0ot90siVdeSUeDfONzhTjEj2uW8xfLVWJOZul5KZTzWud8XvzD
	Ri6tCe0zU5oK0YqRqb9MichW2G6HCVylVUBW2Q1d4pGfXgHd3jgfnWcqn0ipmUT5
	7WfhCd6WZ2qGk/5Sx4Naqh+qd9zFB4Qe/jfUT6tzrEaTBWM/GJ2T0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CC2E4253A9;
	Wed, 29 May 2024 17:41:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 40DD4253A8;
	Wed, 29 May 2024 17:41:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,
  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH] t/: migrate helper/test-example-decorate to the
 unit testing framework
In-Reply-To: <20240528125837.31090-1-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Tue, 28 May 2024 18:28:25 +0530")
References: <20240528125837.31090-1-shyamthakkar001@gmail.com>
Date: Wed, 29 May 2024 14:41:46 -0700
Message-ID: <xmqq8qzsuwh1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3FEB3302-1E04-11EF-866D-6488940A682E-77302942!pb-smtp2.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> +struct test_vars {
> +	struct object *one, *two, *three;
> +	struct decoration n;
> +	int decoration_a, decoration_b;
> +};
> +
> +static void t_add(struct test_vars *vars)
> +{
> +	void *ret = add_decoration(&vars->n, vars->one, &vars->decoration_a);
> +
> +	if (!check(ret == NULL))
> +		test_msg("when adding a brand-new object, NULL should be returned");
> +	ret = add_decoration(&vars->n, vars->two, NULL);
> +	if (!check(ret == NULL))
> +		test_msg("when adding a brand-new object, NULL should be returned");
> +}
> +
> +static void t_readd(struct test_vars *vars)
> +{
> +	void *ret = add_decoration(&vars->n, vars->one, NULL);
> +
> +	if (!check(ret == &vars->decoration_a))
> +		test_msg("when readding an already existing object, existing decoration should be returned");
> +	ret = add_decoration(&vars->n, vars->two, &vars->decoration_b);
> +	if (!check(ret == NULL))
> +		test_msg("when readding an already existing object, existing decoration should be returned");
> +}
> +
> +static void t_lookup(struct test_vars *vars)
> +{
> +	void *ret = lookup_decoration(&vars->n, vars->one);
> +
> +	if (!check(ret == NULL))
> +		test_msg("lookup should return added declaration");
> +	ret = lookup_decoration(&vars->n, vars->two);
> +	if (!check(ret == &vars->decoration_b))
> +		test_msg("lookup should return added declaration");
> +	ret = lookup_decoration(&vars->n, vars->three);
> +	if (!check(ret == NULL))
> +		test_msg("lookup for unknown object should return NULL");
> +}
> +
> +static void t_loop(struct test_vars *vars)
> +{
> +	int i, objects_noticed = 0;
> +
> +	for (i = 0; i < vars->n.size; i++) {
> +		if (vars->n.entries[i].base)
> +			objects_noticed++;
> +	}
> +	if (!check_int(objects_noticed, ==, 2))
> +		test_msg("should have 2 objects");
> +}
> +
> +int cmd_main(int argc UNUSED, const char **argv UNUSED)
> +{
> +	struct object_id one_oid = { { 1 } }, two_oid = { { 2 } }, three_oid = { { 3 } };
> +	struct test_vars vars = { 0 };
> +
> +	vars.one = lookup_unknown_object(the_repository, &one_oid);
> +	vars.two = lookup_unknown_object(the_repository, &two_oid);
> +	vars.three = lookup_unknown_object(the_repository, &three_oid);
> +
> +	TEST(t_add(&vars),
> +	     "Add 2 objects, one with a non-NULL decoration and one with a NULL decoration.");
> +	TEST(t_readd(&vars),
> +	     "When re-adding an already existing object, the old decoration is returned.");
> +	TEST(t_lookup(&vars),
> +	     "Lookup returns the added declarations, or NULL if the object was never added.");
> +	TEST(t_loop(&vars), "The user can also loop through all entries.");

These tests as a whole look like a faithful copy of the original
done by cmd__example_decorate().

I do not understand the criteria used to split them into the four
separate helper functions.  It is not like they can be reused or
reordered---for example, t_readd() must be done after t_add() has
been done.

What benefit are you trying to get out of these split?  IOW, what
are we gaining by having four separate helper functions, instead of
testing all of these same things in a single helper function t_all
with something like

	TEST(t_all(&vars), "Do all decorate tests.");

in cmd_main()?  If there is a concrete benefit of having larger
number of smaller tests, would it make the result even better if we
split t_add() further into t_add_one() that adds one with deco_a and
t_add_two() that adds two with NULL?  The other helpers can of
course be further split into individual pieces the same way.  What
ere the criteria used to decide where to stop and use these four?

Thanks.



