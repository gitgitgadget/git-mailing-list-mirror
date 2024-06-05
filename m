Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C01364BE
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610503; cv=none; b=HvLgXMq7J7FJ8aUGAp7Q+c0f6WqVmqsPbJENaRGZ5ll7+k601fHp7Yayi0RZsiqoGlgo1RBbx53tdw+DNlweagQDm33frZ5X5THrfXd6Ved33XXY8ZOmuxlttbt94Fp29YW193y+b+RkxMhhvlSlt03GzkepcB/f6CuM6OyGr9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610503; c=relaxed/simple;
	bh=HOce+IkfBEFKNFdebYX1pAmokWUslQoqtvlsqSayL0c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Aen4PjbiyEFITYqPivz5XVQJ+ucbcqDIE4DOThDyjseGe0FT8BDJD/hVF0yFNKzqzIFY5sqJAST6H5Mad00scoDW2Uw5Msu4fvf4sUk+upAvRP38KXqHx9uiVa1CKPM58o867d5swZli3HZpMp9yuU16MG2CLkhF+eEThiInVk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TFpStnUh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TFpStnUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56185C2BD11;
	Wed,  5 Jun 2024 18:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717610502;
	bh=HOce+IkfBEFKNFdebYX1pAmokWUslQoqtvlsqSayL0c=;
	h=Date:From:To:Subject:From;
	b=TFpStnUheVSf3zi5dGp0X9J/BlTLc38wZi8/MYPvzqcnpa0MIz9HVWGsWBg/4Cyci
	 p8xYh+P76NVd+6l7356tVYQpmC109lvft4jf6g0iWBKEU3jjhK8EYxf+EQgVZbVvCw
	 1jM55SrmHwXwjXwvKRq443kryAWohJMJb16DK8dY=
Date: Wed, 5 Jun 2024 14:01:38 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: git@vger.kernel.org
Subject: RFC: indicating diff strategy in format-patch message headers
Message-ID: <20240605-hilarious-dramatic-mushroom-7fd941@lemur>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

When developing tooling that attempts to map commits to patches, we often
don't have more than just the git-patch-id to go by. The problem is, there is
any number of ways to generate patches from commits:

- using a different strategy (--histogram, --patience, etc)
- using a different number of context lines (-U5)

Without knowing what options were used by the original author, we cannot be
certain that we'll create a patch with the same git-patch-id, even if it's
from the exact same commit.

Would it make sense to have git-format-patch (and friends) include an
additional header hinting at the options used to generate the patch? E.g.:

    X-git-diff-options: algo=myers; context=3;

It won't help for all cases where we need to make a match (e.g. when we match
from git commits to a patch query), but it will help matching the other way.

Any thoughts?

-K

