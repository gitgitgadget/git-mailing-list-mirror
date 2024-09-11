Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D9915442D
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093971; cv=none; b=TCkpU3yKyPhfsTjnAHZse7Adh3jTw8Rx8bzJuC7Rm9wF9DUnYePjQzHwscAmTaD4JoDIXVKXbZCROoC2M/lx+FA7if01iRAPDQrPozd/O2ULhM9wZQVaz9I3ELKpOLgY9RGPjsFlJi4KCMzPn2Rf3YyMUZ34JGkMobu8TmJ6ETU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093971; c=relaxed/simple;
	bh=97VgzdtNuuLPVD7psVX/z0Qr91fcbIYrpSJC7K4ayLs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RxkR57AJVLuzCsHp+TBPjc9vH2Mv+Dy9ttt5PjN8LELjgpuVN3H5kcWWs73q1H9xsY5iCPIMpJHvAL6MfAS+FG5cSvZ9yjPrGyO17SZj4MMPnSsA9r31u48hCMSCGuBZSAboWZs0seYoKER8IYVqaS0lLtA/1zc/biDEbSHywLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=huKX2e9B; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="huKX2e9B"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 68C9226390;
	Wed, 11 Sep 2024 18:32:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=97VgzdtNuuLPVD7psVX/z0Qr91fcbIYrpSJC7K
	4ayLs=; b=huKX2e9B3GiLMBkAPkXwwfJ5vDVj8tqERpo8mTIR/98bJjqxOWZe/p
	4hzcOkJ4Ld3bYRyWqDJQcVoCkCgBFFG7cVCYSlb7mqrW620wfeIpJj5gKMliVu1f
	lYFQn/l8aeGcT3dwN9BTaAOEHquZKjOVUtFQDlBo7UgrNIJ+Re8vA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 602872638F;
	Wed, 11 Sep 2024 18:32:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ACE2E2638E;
	Wed, 11 Sep 2024 18:32:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH] ci: remove 'Upload failed tests' directories' step from
 linux32 jobs
In-Reply-To: <xmqqy140o2kb.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	09 Sep 2024 16:00:20 -0700")
References: <xmqqy140o2kb.fsf@gitster.g>
Date: Wed, 11 Sep 2024 15:32:46 -0700
Message-ID: <xmqqv7z14y9d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C574BFC6-708D-11EF-9791-9B0F950A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Linux32 jobs seem to be getting:
>
>     Error: This request has been automatically failed because it uses a
>     deprecated version of `actions/upload-artifact: v1`. Learn more:
>     https://github.blog/changelog/2024-02-13-deprecation-notice-v1-and-v2-of-the-artifact-actions/
>
> before doing anything useful.  For now, disable the step.
>
> Ever since actions/upload-artifact@v1 got disabled, mentioning the
> offending version of it seems to stop anything from happening.  At
> least this should run the same build and test.
>
> See
>
>     https://github.com/git/git/actions/runs/10780030750/job/29894867249
>
> for example.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  .github/workflows/main.yml | 6 ------
>  1 file changed, 6 deletions(-)

I refrain from merging my own patches until somebody else at least
comments on them, but I'll make an exception and merge this to 'next',
as a few "container" jobs _always_ fail to start otherwise.  At least
with the step removed, a run without any test failures would tell us
that these container tasks are OK, which is much better.

If somebody finds a better solution (i.e., a way to extract trash
directories of failed tests', with actions/upload-artifact@v1), that
can be added later on top.

> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 1ee0433acc..97f9b06310 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -365,12 +365,6 @@ jobs:
>        with:
>          name: failed-tests-${{matrix.vector.jobname}}
>          path: ${{env.FAILED_TEST_ARTIFACTS}}
> -    - name: Upload failed tests' directories
> -      if: failure() && env.FAILED_TEST_ARTIFACTS != '' && matrix.vector.jobname == 'linux32'
> -      uses: actions/upload-artifact@v1 # cannot be upgraded because Node.js Actions aren't supported in this container
> -      with:
> -        name: failed-tests-${{matrix.vector.jobname}}
> -        path: ${{env.FAILED_TEST_ARTIFACTS}}
>    static-analysis:
>      needs: ci-config
>      if: needs.ci-config.outputs.enabled == 'yes'
