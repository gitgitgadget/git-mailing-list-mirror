Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0B64690
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 06:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743489983; cv=none; b=U1geyzVBmuQkwLWfu4ENkBY/1q7Md+RFbbQXxFSeC+OUKtzOYdTvwft0bpN+eEY+vVX228eAKpxdAwiThKp7dcTGewbpuTwZPUg3vPeDYLh6jk/wXv2hzRu+8/BJ1zq3XxxEwhH7ZZKEnAj9X/Zdeqkp4fNCF1nu0LcUHpuaKcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743489983; c=relaxed/simple;
	bh=ydpGaY8QEjpHG7a1av/nFAyF3f3iuY9E6OYJdeBzKXI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hbl2cqL5DSrM2PGpWTDmfsMLcuoSH39ieDmojDLy4g6guKG989u7o+omL+l9KjCrQAEsCUhMmyo2qkXJIrRKqIMNdSKojheFlV8fDFGtflZ5sn/cY72pLItoSnaNLTCdghhuwkWlY3H6vpG11XcpvZa9Y/1/u7BvDhRputZtPTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akshay.is; spf=pass smtp.mailfrom=akshay.is; dkim=pass (2048-bit key) header.d=akshay.is header.i=@akshay.is header.b=cGhfRmtk; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akshay.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akshay.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akshay.is header.i=@akshay.is header.b="cGhfRmtk"
Date: Mon, 31 Mar 2025 23:46:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akshay.is; s=key1;
	t=1743489977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=j56aATHhasTSVnANrh6DkCbthdZEf1pTeHTmXazhiEU=;
	b=cGhfRmtkWO/rsDqFe4ZPgy7ORRm+I+9ZQgtsWOQf4bJytlhktD+XHkbrZArj3XP8Sf8g1X
	9OA8sN8/ZT57kJbGdL6V0Q0gRk7vH3nXKSdMOsIytBuehVBLdZgMorkaG1oeL8uw/xkAo+
	3QMT5q1PzRc8IESTmU57gv1zK5s2NPd+LHW34GLRlGJvZryuaQXV12OM0yGqoxxgY3vwVo
	jEzIM0u4U5Cf6sOm5mtdktyu1aMbPwutktpJzh5MO+zDM2z6djpj+8XIXKu/FcVhJvlAUN
	cliQKbl3g98luZPZoHD9PqqyIxAmghirCG6urNG1+H7VeLr3W2iazhc+MN5LGA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Akshay Hegde <lists+git@akshay.is>
To: git@vger.kernel.org
Subject: meson: Installing completions
Message-ID: <Z-uLqQd7QHZq-tB7@akshay.is>
Mail-Followup-To: git@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi there,

I found some extra time today so I thought I'd try moving my git
install over to using the new meson build system. Everything went
surprisingly smoothly, which I really appreciated, so thank you!

However, one thing that confused me was that the completions were never
installed automatically as part of `meson install`, even though
I specified them under the '-Dcontrib' option.

I just wanted to double check if I'm supposed to install them manually,
or if I missed enabling some options (I looked through the top-level
meson_options.txt and meson.build files and I don't think I did.)

I'm calling meson setup like so:

    meson setup meson-git-build --prefix=/opt/personal/git/versions/2.49.0 \
        --libdir=/opt/personal/git/versions/2.49.0/lib --buildtype=release \
        --wrap-mode=nofallback --backend=ninja \
        -Dmacos_use_homebrew_gettext=false -Dcontrib=completion,subtree

And I do see both subtree and completion modules being built in the
'meson compile' logs and indeed, I see that git-subtree was
automatically installed, as expected:

    Installing contrib/subtree/git-subtree to /opt/personal/git/versions/2.49.0/libexec/git-core

...So I would have expected the completion module to be automatically
installed as well, but this didn't happen. Rather, it merely got copied
to the internal build folder:

    [669/669] /opt/personal/meson/bin/meson --internal copy ../contrib/completion/git-completion.tcsh contrib/completion/git-completion.tcsh

Of course, I can manually install these to the appropriate locations,
but just checking to make sure I didn't miss anything.

Cheers,
-- 
	Akshay

