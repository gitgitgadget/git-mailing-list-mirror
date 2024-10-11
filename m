Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367D1218D72
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653008; cv=none; b=YNDJo8q52RzwBxYeig7TxB00AUtdi5e/LCLcvmDTOVfUDF99huB8iGfNHQMVaz1o7QQ4pOLGAwq0/AqjbRFAiicriQnvyGY/Bqt881T3/A9pPxsTIbj66JbwiNLZvS0kCczoiq05wCEoayhzCc/d4dyPhByvVOmBL2zlx90PBEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653008; c=relaxed/simple;
	bh=gQDL2DzV03/AMI+5kzSU3mZaF5KEP8ThDhTcLEFnRAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFYpTxfi+ol0EBi9zyh+U3rnTb9K1amseoiuuSKKt/Uhfl4XwFQwFRiu0xVrOoJ/OOjJ2HKrGLmu2apKD+3ibvquANqvutjj6NlA+3lNlNsK1mIx2dY4TXbeh9v6ChcWPSn+s3qGV8FkMGeEJiBJTNBqizXdyMtiwhAGLSeNg24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ID5M2Fg+; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ID5M2Fg+"
Received: from localhost (CASTLE-ON-A-CLOUD.MIT.EDU [18.9.64.24])
	(authenticated bits=0)
        (User authenticated as asedeno@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49BDN9ed028746;
	Fri, 11 Oct 2024 09:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1728652990; bh=x2K4EjKe2yNMKfmMnhcRR3PQRcqV0h5ijnEVT+1bCgk=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=ID5M2Fg+nHHIfRCKVukWcH2tVeWXokhP+nD19PRW2HpH8YGyTXrSjLpDLjITRyVHE
	 NyZA0fu88f5Yw+VdUufq0asILdlmA7n3+tv/plxHe+BO1u2MKrIuIlgDqonUlgf/gl
	 pxHrTXGTY8Za2cm3srFKJ/1r122uT4kLNlymkF0tNV2HyvJrG1UvZgpHB19Sy3JiIw
	 YuYfiWKXq9e9RJjANxbRP8Fh81U2LC84kWlA5KWcHZvcUQd1TwBiQvdqDGLG9CR3cP
	 v9sJHu/M2HKtcoW33Zt6gZ3UOH/LiOCUCeBHgkRNRxIApCQK8Vqh5DTRgfG8+eUlok
	 etmcnS4XYHI4A==
From: =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
To: sandals@crustytoothpaste.net
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH 00/13] Update versions of libcurl and Perl
Date: Fri, 11 Oct 2024 09:23:08 -0400
Message-ID: <20241011132308.2469679-1-asedeno@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010235621.738239-1-sandals@crustytoothpaste.net>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Oct 10, 2024 at 23:56:08 +0000, brian m. carlson wrote:
> The libcurl dependency changes come in incremental patches so that if we
> have people on unsupported systems, they can simply revert the patches
> that they'd like to omit.  It also makes the changes easier to review
> than one giant commit.
...
> brian m. carlson (13):
>   git-curl-compat: remove check for curl 7.21.5
>   git-curl-compat: remove check for curl 7.25.0
>   git-curl-compat: remove check for curl 7.34.0

Strictly speaking, the first three of these in the series can be
squashed, as support for libcurl older than 7.37.0 is already
broken. Reverting any subset of these patches will not achieve the
goal of allowing people to get back to a working build.

Personally, I'd still prefer to see support maintained, but on a more
philosophical level, I agree that this patch series a better course of
action.

-Alejandro
