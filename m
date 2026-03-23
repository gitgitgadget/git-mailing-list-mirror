Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D5E40DFC3
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 06:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774245702; cv=none; b=geFFkFiTuAHoCi48/p8AcHV9QQKPBNOshX1kabCJ4v2ize8O30NIY5ADf/PmEZB9yVvVYTXeVTw+KUxKvNZCe1GMwOEbQoM0YqSVhojea77pGnhJPz0tfmOwp6fd5qP4ESY66vRm37Wu2PAFPql4gNKm9FRw+DVFiHLVyiPiFpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774245702; c=relaxed/simple;
	bh=VL3C+lDG6/628WnKwQnlHSlJVOTjMRYmgPd0Gr46J54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9LKv6A/Tww5gHZxBR+Mh9aAkIHwk8T58IpX4LLVdXxhG0k3sqSC+pFp/pyAEVqf3a+ZCxhwY9XN5XVckf+orXX1HGIQ5MPCxoDrGmPyZGlYobCxct+P0NDK0G8iLXmYkEy35fb+XY4cAkMQc4rHzdsqzj6BKzOasiFiGA6e1xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JKONBmAM; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JKONBmAM"
Received: (qmail 110145 invoked by uid 106); 23 Mar 2026 06:01:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VL3C+lDG6/628WnKwQnlHSlJVOTjMRYmgPd0Gr46J54=; b=JKONBmAM5YtSnOpKFD/y33BftyXagZT0a6wo9g9h16T1Xq+BL+7gsQnTMqQCHgVg+GS3D45TEZDbIioOMhZvYoTq2QU3gxPbs9HYuMJksqX7Fa/K9x32FptxgQTv5kFc3P9s4O3Ctsu2kzrwvS/ucWm9877XumCA/ki6D5A1rJS3hBG9nQD/JnPTUeBbNaLdORnHQaSSB/6kgHlwP5rXgQ3LQepQESc79EX9cQE3TvusKr4oV2IjdA6Saus/kiCUq1+GJ6dT4HCoFOQ8pgfroikVXIhD0Y2DHAcXMSDIpxW9p3a0yKmhAj3fLyo16TXnBXGyd/Y/7zYMiF2ujtEXDg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Mar 2026 06:01:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 146963 invoked by uid 111); 23 Mar 2026 06:01:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Mar 2026 02:01:39 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Mar 2026 02:01:39 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Tian Yuchen <a3205153416@gmail.com>, Scott Baker <scott@perturb.org>
Subject: [PATCH v2 0/8] some diff-highlight tweaks
Message-ID: <20260323060139.GA10215@coredump.intra.peff.net>
References: <20260320004138.GA3653623@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320004138.GA3653623@coredump.intra.peff.net>

Here's a re-roll based on the review from Yuchen. The two changes are:

  1. Added a missing &&-chain in patch 3 (which cascades into patch 6).

  2. Avoid length(undef), since old perl versions will warn about it.

Patch list and range diff below.

 1:  c59dd0aac9 =  1:  c59dd0aac9 contrib/diff-highlight: do not highlight identical pairs
 2:  16aa04fc6d =  2:  16aa04fc6d diff-highlight: mention build instructions
 3:  55788fac3a =  3:  55788fac3a diff-highlight: drop perl version dependency back to 5.8
 4:  7c2af2348b !  4:  1101c94f65 diff-highlight: check diff-highlight exit status in tests
    @@ contrib/diff-highlight/t/t9400-diff-highlight.sh: dh_test () {
     -	"$DIFF_HIGHLIGHT" <diff.raw | test_strip_patch_header >diff.act &&
     -	"$DIFF_HIGHLIGHT" <commit.raw | test_strip_patch_header >commit.act &&
     +	"$DIFF_HIGHLIGHT" <diff.raw >diff.hi &&
    -+	test_strip_patch_header <diff.hi >diff.act
    ++	test_strip_patch_header <diff.hi >diff.act &&
     +	"$DIFF_HIGHLIGHT" <commit.raw >commit.hi &&
     +	test_strip_patch_header <commit.hi >commit.act &&
      	test_cmp patch.exp diff.act &&
 5:  52f0358329 =  5:  65420b8b79 t: add matching negative attributes to test_decode_color
 6:  0f1aacf264 !  6:  60977c32f6 diff-highlight: use test_decode_color in tests
    @@ contrib/diff-highlight/t/t9400-diff-highlight.sh: dh_test () {
      	} >/dev/null &&
      
      	"$DIFF_HIGHLIGHT" <diff.raw >diff.hi &&
    --	test_strip_patch_header <diff.hi >diff.act
    -+	test_strip_patch_header <diff.hi | test_decode_color >diff.act
    +-	test_strip_patch_header <diff.hi >diff.act &&
    ++	test_strip_patch_header <diff.hi | test_decode_color >diff.act &&
      	"$DIFF_HIGHLIGHT" <commit.raw >commit.hi &&
     -	test_strip_patch_header <commit.hi >commit.act &&
     +	test_strip_patch_header <commit.hi | test_decode_color >commit.act &&
 7:  8bad893f09 =  7:  bf33329640 diff-highlight: test color config
 8:  179f83d791 =  8:  ea71a8b648 diff-highlight: allow module callers to pass in color config
 9:  b8ff37b193 !  9:  aab7912ca2 diff-highlight: fetch all config with one process
    @@ contrib/diff-highlight/DiffHighlight.pm: sub highlight_stdin {
     +	our $cached_config;
      	my ($key, $default) = @_;
     -	my $s = `git config --get-color $key 2>$NULL`;
    +-	return length($s) ? $s : $default;
     +
     +	if (!defined $cached_config) {
     +		$cached_config = {};
    @@ contrib/diff-highlight/DiffHighlight.pm: sub highlight_stdin {
     +	}
     +
     +	my $s = $cached_config->{$key};
    - 	return length($s) ? $s : $default;
    ++	return defined($s) ? $s : $default;
      }
      
    + sub show_hunk {
     @@ contrib/diff-highlight/DiffHighlight.pm: sub load_color_config {
      	# always be set if you want highlighting to do anything.
      	if (!defined $OLD_HIGHLIGHT[1]) {

  [1/8]: diff-highlight: mention build instructions
  [2/8]: diff-highlight: drop perl version dependency back to 5.8
  [3/8]: diff-highlight: check diff-highlight exit status in tests
  [4/8]: t: add matching negative attributes to test_decode_color
  [5/8]: diff-highlight: use test_decode_color in tests
  [6/8]: diff-highlight: test color config
  [7/8]: diff-highlight: allow module callers to pass in color config
  [8/8]: diff-highlight: fetch all config with one process

 contrib/diff-highlight/DiffHighlight.pm       | 59 +++++++++++-----
 contrib/diff-highlight/README                 | 19 +++++-
 .../diff-highlight/t/t9400-diff-highlight.sh  | 67 +++++++++++++------
 t/test-lib-functions.sh                       |  3 +
 4 files changed, 112 insertions(+), 36 deletions(-)

