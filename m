Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B919E1822DF
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720024185; cv=none; b=O3+q8152yCNqrHjTEQtMJ4GLkLCrOcWaiG5tybnP9SRJRVAYxcFus4R+ZTyjcjnxGpi4Iuq1GFMGmvr4rg+yjpfmxxNuFy4JB6lM8Fw/54dbH8pHxlxffFHc/S0GN2Sz5A+x/OiOEKni5KSJQPDL1Vnm6wLbEwSsE3xkDUdkHTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720024185; c=relaxed/simple;
	bh=nT2/7iIu1b2d7bHRvLkDOo83uuMrhdMwG9dJAuUADaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVKf5RJ2my6o1yDZRnz1oj5/rfgqWLaXj2bSKWkf4pVJuGOMkaLa7b0M8lJNKWmEd5zwx60xyLji7hJ+2T93xEOLWoZ34iS0dk9AAzy8Uv5xwvWEifo535X+N0u7uYheXpeKnV4fhYXNLr0+xpUl/JUVAppHYRQe2e7Qf+yvk7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XfObCqoc; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XfObCqoc"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1EF823AA95;
	Wed,  3 Jul 2024 12:29:43 -0400 (EDT)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=nT2/7iIu1b2d7bHRvLkDOo83uuMrhdMwG9dJAuU
	ADaY=; b=XfObCqochJ+egkbeGSqvHsC+JkD7KeypJD1Aq32KyFYUEne/WSCEzYq
	mZHbe66DyGFsEmdqF5WfFihD3y0Md373wcCDdWRgYWGmiMiy5iGs8nF8WqxCJp9K
	r5Es+UZ78edgb7zSWZxPBTTHcxhXwc3rRJu6EbNHmO8v+ZDXHJUs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 16EAE3AA94;
	Wed,  3 Jul 2024 12:29:43 -0400 (EDT)
	(envelope-from tmz@pobox.com)
Received: from teonanacatl.net (unknown [71.254.194.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 840863AA93;
	Wed,  3 Jul 2024 12:29:38 -0400 (EDT)
	(envelope-from tmz@pobox.com)
Date: Wed, 3 Jul 2024 12:29:35 -0400
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Kousik Sanagavarapu <five231003@gmail.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 0/2] t/lib-gpg: ensure GNUPGHOME is created as needed
Message-ID: <ZoV8b2RvYxLOotSJ@teonanacatl.net>
References: <20240703153738.916469-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703153738.916469-1-tmz@pobox.com>
X-Pobox-Relay-ID:
 715270C0-3959-11EF-8717-DFF1FEA446E2-09356542!pb-smtp21.pobox.com

I wrote:
> 92 of the 202 tests in t1016-compatObjectFormat.sh are skipped due to
> the GNUPGHOME directory missing, e.g.:
> 
>     ok 5 # SKIP create a sha1 signed commit (missing GPG2)
>     ok 6 # SKIP create a sha1 signed tag (missing GPG2)
>     ok 8 # SKIP create another sha1 signed tag (missing GPG2)
>     ok 9 # SKIP merge the sha1 branches together (missing GPG2)
> 
> With these changes, they are all run (successfully). :)
> 
> I presume that they have been skipped in the Github CI runs as well,
> but I don't know that the logs show enough detail to confirm that.

D'oh!  I spoke too soon.  I'd run the test suite on several
different rpm-based hosts (Fedora 39 and Rocky 9).  Waiting
for the Github actions to run is what I should have done.

A number of these fail, e.g.:

https://github.com/tmzullinger/git/actions/runs/9780387020/job/27001952643#step:4:1871

    Error: failed: t1016.173 Verify commit signedcommit4's sha1 oid
    failure: t1016.173 Verify commit signedcommit4's sha1 oid 
	    git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} > ${name}_sha1 &&
	    test_cmp ${name}_sha1 ${name}_sha1_expected
      
      + git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 5d70155cc40e4c16515c89ad0b11d8c691436fc4a4d3ca246669a4c21f07e454
      + test_cmp signedcommit4_sha1 signedcommit4_sha1_expected
      + test 2 -ne 2
      + eval diff -u "$@"
      + diff -u signedcommit4_sha1 signedcommit4_sha1_expected
      --- signedcommit4_sha1	2024-07-03 15:11:05.597537579 +0000
      +++ signedcommit4_sha1_expected	2024-07-03 15:11:05.553537766 +0000
      @@ -1 +1 @@
      -9179ccc5b15588bc3a45c5cc75bdec380f8ccb86
      +c6c46f92bc2cfda57ad6bf7981fa654825376b24
      error: last command exited with $?=1
      not ok 173 - Verify commit signedcommit4's sha1 oid
      #	
      #		git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} > ${name}_sha1 &&
      #		test_cmp ${name}_sha1 ${name}_sha1_expected
      #	

This seems like it's just exposing a pre-existing failure,
as I can't imagine how creating GNUPGHOME would cause the
actual and expected SHA's to differ. :)

Perhaps the intended gpg wrapper script which sets
`--faked-system-time` isn't being used?

I'm not sure why that would differ in the Github actions
from my local builds, but I don't know what else differs in
the Ubuntu images and/or environment used by the actions.

-- 
Todd
