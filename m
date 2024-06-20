Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9181AAE37
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880678; cv=none; b=Bm1BjeSIILHYsbHPHh6kWldp8jxxIlWP3Nl7y2TjM8pTCWnfjXcTQTqOMIPLZNOvRLYPTjGlJsRtI7+q1qjp3F2x5J0t4tZSoFQtyMJWKNGZMAt+hkkdN8agTB8kA/k/d3uWWQzTBNtK1NGlmXfTHKXK6p47yIV7bvfBhdtn9aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880678; c=relaxed/simple;
	bh=DC25NCc/xINKfRfwpN3mk5Ji8srTQELuHEcaqvM9SuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIcFXdPnNmbEvSxN4HLQUyBDm/XzhPBnOtLX+YI5hNJrRTZtkAOxX9HOYmDaV9Gq0eH6QGuUDa2MVyC+M209DU5g4PmN4JMpYAewVSuFiEDT4fFGHDWSeHRe1f+qW1I3VQKTcKBgmidxpnKV27wJ/hoIwzSsjZ3FzX/KHxLqRl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3418120-ipxg00d01tokaisakaetozai.aichi.ocn.ne.jp ([114.171.163.120] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1sKFNn-00DyCc-25;
	Thu, 20 Jun 2024 10:51:12 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1sKFNh-007j5f-2L;
	Thu, 20 Jun 2024 19:51:05 +0900
Date: Thu, 20 Jun 2024 19:51:05 +0900
From: Mike Hommey <mh@glandium.org>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] mingw: drop bogus (and unneeded) declaration of `_pgmptr`
Message-ID: <20240620105105.5xv2ywxzzye4wjtk@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <pull.1752.git.1718777398765.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1752.git.1718777398765.gitgitgadget@gmail.com>

On Wed, Jun 19, 2024 at 06:09:58AM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In 08809c09aa13 (mingw: add a helper function to attach GDB to the
> current process, 2020-02-13), I added a declaration that was not needed.
> Back then, that did not matter, but now that the declaration of that
> symbol was changed in mingw-w64's headers, it causes the following
> compile error:
> 
>       CC compat/mingw.o
>   compat/mingw.c: In function 'open_in_gdb':
>   compat/mingw.c:35:9: error: function declaration isn't a prototype [-Werror=strict-prototypes]
>      35 |         extern char *_pgmptr;
>         |         ^~~~~~
>   In file included from C:/git-sdk-64/usr/src/git/build-installers/mingw64/lib/gcc/x86_64-w64-mingw32/14.1.0/include/mm_malloc.h:27,
>                    from C:/git-sdk-64/usr/src/git/build-installers/mingw64/lib/gcc/x86_64-w64-mingw32/14.1.0/include/xmmintrin.h:34,
>                    from C:/git-sdk-64/usr/src/git/build-installers/mingw64/lib/gcc/x86_64-w64-mingw32/14.1.0/include/immintrin.h:31,
>                    from C:/git-sdk-64/usr/src/git/build-installers/mingw64/lib/gcc/x86_64-w64-mingw32/14.1.0/include/x86intrin.h:32,
>                    from C:/git-sdk-64/usr/src/git/build-installers/mingw64/include/winnt.h:1658,
>                    from C:/git-sdk-64/usr/src/git/build-installers/mingw64/include/minwindef.h:163,
>                    from C:/git-sdk-64/usr/src/git/build-installers/mingw64/include/windef.h:9,
>                    from C:/git-sdk-64/usr/src/git/build-installers/mingw64/include/windows.h:69,
>                    from C:/git-sdk-64/usr/src/git/build-installers/mingw64/include/winsock2.h:23,
>                    from compat/../git-compat-util.h:215,
>                    from compat/mingw.c:1:
>   compat/mingw.c:35:22: error: '__p__pgmptr' redeclared without dllimport attribute: previous dllimport ignored [-Werror=attributes]
>      35 |         extern char *_pgmptr;
>         |                      ^~~~~~~
> 
> Let's just drop the declaration and get rid of this compile error.

I can only suppose it gets rid of the compiler error with close to 100%
certainty because for some reason, it only happens intermittently for me
and I don't know whether I'm lucky or if the issue is fixed for real,
but what it absolutely sure is that it doesn't break anything.

Mike
