Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED00C18C008
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731799103; cv=none; b=jv2mO3xJufaPVq8nuFHcfGF9GBnAGPQ8xOo1ZnEWy9Zk9G04xXgMy66PUkpWa37JlC4v5i9KZ9IKh/WrmqBKbbO9mj/1rs+546ptD8XOKdcfSyvtLfKQzv+6J4rjsoF/v/LFg6mUm3bFOwhvgytbcxfaMlLoFDsMK55RXHQl9NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731799103; c=relaxed/simple;
	bh=Xwuks+LSWQg4hyZ/V82e77DASpQbiPWMya/5LvvDCp0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uP7wF+SJVhaFDGzvukRqAH8sw5pcEO8SwAwQ+vSktGEGXu2eSaw89/Fs4CGOhOl7Y++kZBESpZL6fcg1an6taY3qiP+tulcy6kLFqqRNb0gy/H9pSZBT9ytfsWoe3dZ9E/C5D5UGGIbvAxH/1UwJvAM6d9l0fp5kUkzasXe82TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: git@vger.kernel.org
Subject: Build failure with -std=gnu23 (GCC 15 default)
Organization: Gentoo
User-Agent: mu4e 1.12.7; emacs 31.0.50
Date: Sat, 16 Nov 2024 23:18:17 +0000
Message-ID: <87ed3apy2u.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Upcoming GCC 15 defaults to -std=3Dgnu23. git-2.47.0 fails to build as
follows:
```
builtin/index-pack.c:97:8: error: expected =E2=80=98{=E2=80=99 before =E2=
=80=98thread_local=E2=80=99
   97 | struct thread_local {
      |        ^~~~~~~~~~~~
builtin/index-pack.c:120:15: error: expected =E2=80=98{=E2=80=99 before =E2=
=80=98thread_local=E2=80=99
  120 | static struct thread_local nothread_data;
      |               ^~~~~~~~~~~~
builtin/index-pack.c:151:15: error: expected =E2=80=98{=E2=80=99 before =E2=
=80=98thread_local=E2=80=99
  151 | static struct thread_local *thread_data;
      |               ^~~~~~~~~~~~
```

There may be more issues, but at the very least thread_local became a
proper keyword in C23, so that will need renaming.

It should be possible to reproduce these with older GCC (and Clang) with
-std=3Dgnu23 or -std=3Dc23 set manually.

thanks,
sam
