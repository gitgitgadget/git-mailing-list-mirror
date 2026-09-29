Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B78D4E0B99
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 21:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790718602; cv=none; b=qL+qYouZZamh0iN+4HqWYz57kLRO9Aq5N5vVuXK1jqZMTBtfbkCbDOb6c5RKGdCtYVw5qi+e6JH5Wty9gwkTFiBMTFC/6unORt+k1ZRhzrLoCT+Y/J58qvaThkL8InA7Oiwr1LoFuNECk1Y5kFvoUnahCEk3HZVXKDdM7CYSbuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790718602; c=relaxed/simple;
	bh=mUY0SE/Uc2k4sjwRvuS9tS08vYVeq2gYh1rT3eOkUK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjaZOjmxdfUUMObGwxRfvE8eZdpzqZ1r31FilC0qttSMyaLTw5zUdBxM0rzNyRWiNyPA/J2DJC18+LfWYzKDYCN8Dfk8mw0sUnD7pkeUBRzTXOd8jYMvJ1umVFc7ZUxpJtbvd0cOlQ+jnvwRMlFgqViPWk328WJW3PxqgiP655k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NYUNDg9+; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NYUNDg9+"
Received: (qmail 1530 invoked by uid 106); 29 Sep 2026 21:49:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=mUY0SE/Uc2k4sjwRvuS9tS08vYVeq2gYh1rT3eOkUK4=; b=NYUNDg9+OPnAh28o0gmCHvRyluBidOhbuLOee6i+v7vInXPpQOLYc8BOeZycnfC5d9/CUS578mAfgm3aUZmAa6NYqx3wOLFagaX0rNop+wwoFnGGnbc0q7BtqbfN817wc2GUtIidcKBpdgELbnDztNfuhSx7g/uh7G5ONq9eWg+C0RgoD1iSdZgoSiUIozOhtnyMKNADTtkQQtdTfnKmsIXCwYtrVcp5t9qHaisoHhcixDBxL9iLzuY7GKK8jemckblkp03SedGAiawtMZqCiwgd7BjMsIEIMUDViY8g4OYHmhSjlF2KUVYE3S276eziripQWRGyk9E9x4zPKuv6oA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Sep 2026 21:49:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4382 invoked by uid 111); 29 Sep 2026 21:49:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Sep 2026 17:49:44 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Sep 2026 17:49:43 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 7/5] merge-ll: report an error when reading external
 merge results fails
Message-ID: <20260929214943.GA1735259@coredump.intra.peff.net>
References: <20260929204157.GA1733321@coredump.intra.peff.net>
 <20260929204421.GB1734030@coredump.intra.peff.net>
 <xmqqv77neowx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv77neowx.fsf@gitster.g>

On Tue, Sep 29, 2026 at 02:19:26PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +test_expect_success SANITY 'rerere preserves conflicts when driver output is unreadable' '
> > +	test_create_repo unreadable-output &&
> > +	(
> 
> > +		cd unreadable-output &&
> > +		git config rerere.enabled true &&
> > +		git config rerere.autoupdate true &&
> > +		write_script merge-driver <<-\EOF &&
> > +		git merge-file "$@"
> > +		status=$?
> > +		if test -f fail-read
> > +		then
> > +			chmod 0 "$1" || exit 1
> > +		fi
> 
> Can we lose SANITY by "rm $1" instead of "chmod 0"?

Hmm, I guess we can. I was thinking for some reason that we need to fail
later in read_mmfile(). But I think I was just confusing that with the
earlier leak fix. With a stat failure, read_mmfile() will leave the
mmfile_t untouched, but we initialize it in ll_ext_merge() to NULL/0. So
the outcome should be the same from the caller's perspective.

And that's actually a more realistic example, I think. Instead of
simulating a racy read failure, we are considering a driver that
sometimes accidentally deletes the file while returning 0. Buggy, but a
plausible bug. ;)

Here's a resend of that final patch (not just a squash, because the
commit message mentioned the chmod).

-- >8 --
Subject: merge-ll: report an error when reading external merge results fails

If we can't read an external merge driver's output, ll_ext_merge()
leaves the result buffer as NULL but returns a status based only on the
driver's exit code. So a driver which exits successfully can cause us to
return LL_MERGE_OK without a result.

Most callers of ll_merge() check for a NULL buffer in addition to an
error return, so they're fine. But rerere's merge() checks only the
return value, and may write out the (incorrect) empty result as the
recorded resolution.

Let's return LL_MERGE_ERROR when read_mmfile() fails, regardless of the
driver's exit status, to make it clear that the returned value is not
valid.

Our test is a little funny; the bad case happens when reading back the
file happens to fail. That can happen due to system errors, but of
course we want it to be deterministic. We can make that happen by
removing the result file. But if we configure a driver that always does
that, we'd never record a rerere result in the first place! So we
instead create a driver that "breaks" the read only when we instruct it
to do so.

Signed-off-by: Jeff King <peff@peff.net>
---
 merge-ll.c        |  4 ++--
 t/t4200-rerere.sh | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/merge-ll.c b/merge-ll.c
index 4d82836bc5..3b5327e7df 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -248,8 +248,8 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 		/* died due to a signal: WTERMSIG(status) + 128 */
 		ret = LL_MERGE_ERROR;
 
-	/* We can ignore errors; result is left NULL/0 in that case. */
-	read_mmfile(result, temp[1]);
+	if (read_mmfile(result, temp[1]) < 0)
+		ret = LL_MERGE_ERROR;
 
 	for (i = 0; i < 3; i++)
 		unlink_or_warn(temp[i]);
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 7bb601e117..5be3f056f5 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -734,4 +734,55 @@ test_expect_success 'rerere does not crash with unmatched conflict marker' '
 	test_must_fail git rebase --continue
 '
 
+test_expect_success 'rerere preserves conflicts when driver output is unreadable' '
+	test_create_repo unreadable-output &&
+	(
+		cd unreadable-output &&
+		git config rerere.enabled true &&
+		git config rerere.autoupdate true &&
+		write_script merge-driver <<-\EOF &&
+		git merge-file "$@"
+		status=$?
+		if test -f fail-read
+		then
+			rm "$1" || exit 1
+		fi
+		exit "$status"
+		EOF
+		git config merge.unreadable.driver "./merge-driver %A %O %B" &&
+		echo "file merge=unreadable" >.gitattributes &&
+		test_commit base file base &&
+		git checkout -b one &&
+		test_commit --no-tag one file one &&
+		git checkout -b two base &&
+		test_commit --no-tag two file two &&
+
+		# Teach rerere a resolution while the driver works normally.
+		test_must_fail git merge one &&
+		echo resolved >file &&
+		git rerere &&
+		git merge --abort &&
+
+		# Recreate the conflict without replaying the resolution yet.
+		test_must_fail git -c rerere.enabled=false merge one &&
+
+		# We will expect the same conflicted content after rerere fails
+		# below.
+		cp file expect &&
+		git ls-files -u >expect-index &&
+		test_file_not_empty expect-index &&
+
+		# Now we try rerere again, but the merge driver will cause the
+		# read to fail.
+		>fail-read &&
+		git rerere 2>err &&
+		test_grep "Could not stat" err &&
+
+		# And we expect the conflicted state.
+		test_cmp expect file &&
+		git ls-files -u >actual-index &&
+		test_cmp expect-index actual-index
+	)
+'
+
 test_done
-- 
2.56.0.325.g545d7e68bc

