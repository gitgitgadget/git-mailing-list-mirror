Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC8313B5B9
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 21:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717710908; cv=none; b=uVOl58PFL3HJDjoyMNycS8bMvhCPY3iqg0YbW+1e9/Q6UXLHWcgg2uKlPklJasTZQSf/IAIMBAMyU4dJ/8ieIPcAwgnIc+Buy4kL7MMeHCCtpUDyJEPbtY34A+fkgtURb3pFbEwiRJ+pygEwjvCK1CUJf5JE1pKBWQKXs1X609A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717710908; c=relaxed/simple;
	bh=Kasls9kIPu4IerfqUcXYNA9D21AgXElMBNKONYnc0+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=blkageG4cYO+vLt9rMZWMdgquFNX4NZQVLNUET2FDrw07YUlCeld2SI4unQsdOycyZmeWhg5Kw9plyxOEWtMYjO9T1l/mnRqU9t7lkoA02ahUSRVhSQw5i1WgQPycjpYAOKTjoPVpyzaVHMI0CWEjStW5rLP/ORlpc30PTi0EiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hvbmE+9A; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hvbmE+9A"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F45B25F67;
	Thu,  6 Jun 2024 17:55:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Kasls9kIPu4IerfqUcXYNA9D21AgXElMBNKONY
	nc0+0=; b=hvbmE+9A5FOPzLKcc9mMPvFVc7WBO3ddcbtO6ZGckFgrU88twKMEAN
	fyX0NfCmJUa00FGFfINiD6L0w/cye3eodeZ6Axb1PolsbaQUGHDHrv7DnJ5mEcu5
	KReIQvPq/14IS5+mXbOsdtKddOOkL7BttYm+bZDZmEj5QH+C1T6SI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4788025F66;
	Thu,  6 Jun 2024 17:55:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5FA2D25F63;
	Thu,  6 Jun 2024 17:54:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  Christian Couder
 <chriscool@tuxfamily.org>,  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH] t/: migrate helper/test-oidtree.c to
 unit-tests/t-oidtree.c
In-Reply-To: <20240605134400.37309-1-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Wed, 5 Jun 2024 19:13:52 +0530")
References: <20240605134400.37309-1-shyamthakkar001@gmail.com>
Date: Thu, 06 Jun 2024 14:54:26 -0700
Message-ID: <xmqqo78dka99.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6A2C6DC4-244F-11EF-BE04-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> helper/test-oidtree.c along with t0069-oidtree.sh test the oidtree.h
> library, which is a wrapper around crit-bit tree. Migrate them to
> the unit testing framework for better debugging and runtime
> performance.
>
> To achieve this, introduce a new library called 'lib-oid.h'
> exclusively for the unit tests to use. It currently mainly includes
> utility to generate object_id from an arbitrary hex string
> (i.e. '12a' -> '12a0000000000000000000000000000000000000').
> This will also be helpful when we port other unit tests such
> as oid-array, oidset etc.

Perhaps.  With only a single user it is hard to judge if it is worth
doing, but once the code is written, it is not worth a code churn to
merge it into t-oidtree.c.

> +#define FILL_TREE(tree, ...)                                       \
> +	do {                                                       \
> +		const char *hexes[] = { __VA_ARGS__ };             \
> +		if (fill_tree_loc(tree, hexes, ARRAY_SIZE(hexes))) \
> +			return;                                    \
> +	} while (0)

Nice.

> +static enum cb_next check_each_cb(const struct object_id *oid, void *data)
> +{
> +	const char *hex = data;
> +	struct object_id expected;
> +
> +	if (!check_int(get_oid_arbitrary_hex(hex, &expected), ==, 0))
> +		return CB_CONTINUE;
> +	if (!check(oideq(oid, &expected)))
> +		test_msg("expected: %s\n       got: %s",
> +			 hash_to_hex(expected.hash), hash_to_hex(oid->hash));
> +	return CB_CONTINUE;
> +}

The control flow looks somewhat strange here.  I would have written:

	if (!check_int(..., ==, 0))
		; /* the data is bogus and cannot be used */
	else if (!check(oideq(...))
		test_msg(... expected and got differ ...);
	return CB_CONTINUE;

but OK.

> +static void check_each(struct oidtree *ot, char *hex, char *expected)
> +{
> +	struct object_id oid;
> +
> +	if (!check_int(get_oid_arbitrary_hex(hex, &oid), ==, 0))
> +		return;
> +	oidtree_each(ot, &oid, 40, check_each_cb, expected);
> +}
> +
> +static void setup(void (*f)(struct oidtree *ot))
> +{
> +	struct oidtree ot;
> +
> +	oidtree_init(&ot);
> +	f(&ot);
> +	oidtree_clear(&ot);
> +}
> +
> +static void t_contains(struct oidtree *ot)
> +{
> +	FILL_TREE(ot, "444", "1", "2", "3", "4", "5", "a", "b", "c", "d", "e");
> +	check_contains(ot, "44", 0);
> +	check_contains(ot, "441", 0);
> +	check_contains(ot, "440", 0);
> +	check_contains(ot, "444", 1);
> +	check_contains(ot, "4440", 1);
> +	check_contains(ot, "4444", 0);
> +}

OK.

Compared to the original, this makes the correspondence between the
input and the expected result slightly easier to see, which is good.

> +static void t_each(struct oidtree *ot)
> +{
> +	FILL_TREE(ot, "f", "9", "8", "123", "321", "a", "b", "c", "d", "e");
> +	check_each(ot, "12300", "123");
> +	check_each(ot, "3211", ""); /* should not reach callback */
> +	check_each(ot, "3210", "321");
> +	check_each(ot, "32100", "321");
> +}

Testing "each" with test data that yields only at most one response
smells iffy.  It is a problem in the original test, and not a
problem with the conversion, ...

BUT

... in the original, it is easy to do something like the attached to
demonstrate that "each" can yield all oid that the shares the query
prefix.  But the rewritten unit test bakes the assumption that we
will only try a query that yields at most one response into the test
helper functions.  Shouldn't we do a bit better, perhaps allowing the
check_each() helper to take variable number of parameters, e.g.

	check_each(ot, "12300", "123", NULL);
	check_each(ot, "32", "320", "321", NULL);

so the latter invocation asks "ot" trie "I have prefix 32, please
call me back with each element you have that match", and makes sure
that we get called back with "320" and then "321" and never after.

Come to think of it, how is your check_each_cb() ensuring that it is
only called once with "123" when queried with "12300"?  If the
callback is made with "123" 100 times with the single query with
"12300", would it even notice?  I would imagine that the original
would (simply because it dumps each and every callback to a file to
be compared with the golden copy).

 t/t0069-oidtree.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git c/t/t0069-oidtree.sh w/t/t0069-oidtree.sh
index 889db50818..40b836aff5 100755
--- c/t/t0069-oidtree.sh
+++ w/t/t0069-oidtree.sh
@@ -35,13 +35,14 @@ test_expect_success 'oidtree insert and contains' '
 '
 
 test_expect_success 'oidtree each' '
-	echoid "" 123 321 321 >expect &&
+	echoid "" 123 321 321 320 321 >expect &&
 	{
-		echoid insert f 9 8 123 321 a b c d e &&
+		echoid insert f 9 8 123 321 320 a b c d e &&
 		echo each 12300 &&
 		echo each 3211 &&
 		echo each 3210 &&
 		echo each 32100 &&
+		echo each 32 &&
 		echo clear
 	} | test-tool oidtree >actual &&
 	test_cmp expect actual
