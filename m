Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD7B2E338B
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742080649; cv=none; b=TtWqYqqMv40dpOyciVTEE0VaZt+cD8iexuduocuEP1HknDtEyHX9KDAZq38HPlhPEl+Y5hSZER9dSI+gn70JCZbwtXFJ75jkkDCOEESyDrQylBMWDzDaxQvOGDHNsK7xHI8s268gG77U7v++nLOREn3ZwZjnzdSubaL7qbyFquM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742080649; c=relaxed/simple;
	bh=sI5M8bxo9A+8be6LTYHXAG7x/mVJm5UIrxX/of+61Kk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GMe4PvVpNN6glTJIxKebYXgbbd9GBno9NUJsKt2RnRkcuZ/pF3wQhh1bqKkJFpWBHQVlcOzjUUnExfIh40lR7VUHWh5aWLyO9kFLfGmB1BtZvYQy2rYxrKUvBIlU84D2rUB+gC0CAEeGzr0evT7PLGbZqzKSsPXwmb7Ime3I6rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=oSDfHJMq; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="oSDfHJMq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742080643; x=1742685443;
	i=johannes.schindelin@gmx.de;
	bh=PPtcYs0Sfj7WQjc5BGMxg15yzmdj6aNrXOvc3qSpJRE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oSDfHJMq2sXbsN5+GrE+oRC26TEJx/l2uAPU+rVMKcFUZAiZv61Yb7+EuV5vokHX
	 KxuXTB2KAe3vsld5+VMjStZS0UGtVX9t+3SIHibGVkwF89heU5eBl03TVeCKV43pF
	 x+dcwwh4C4f7rGkDqec9oKqrARWwIiQBEO6JF4wRLWk8eM0ILy2anECrfcB6CWOKP
	 nU2fI6nppHOaQUfF4oJyOCN5R6AphAiX7QbplQxzKeBXi6N8m8R3PAKgnhMx09IAy
	 V9BIqQIguCnpLU2W0e1oSLc1vXrBrzX+TNC2Ue36hc2vW1WAo3dlTOr4jGxt2HqqS
	 KUy89ykiYtdXrEXIMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.73]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDNf-1tPnnI2nXD-00eICv; Sun, 16
 Mar 2025 00:17:23 +0100
Date: Sun, 16 Mar 2025 00:17:23 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Christian Reich <Zottelbart@t-online.de>, 
    Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] reftable: ignore file-in-use errors when unlink(3p)
 fails on Windows
In-Reply-To: <20250206-b4-pks-reftable-win32-in-use-errors-v2-1-56985a4f6186@pks.im>
Message-ID: <920228d0-5906-27f9-d42d-d92631909fd8@gmx.de>
References: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im> <20250206-b4-pks-reftable-win32-in-use-errors-v2-1-56985a4f6186@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:c+UTAuyxRkK/MpXU7sT3KtjinV7Ef06R0kxAkJ/SSZ98S5bHegZ
 wLfrrn+OuT7Kh/R1+0Ohb0h7Gh4mKoFDCcoO/uZqhPAvkclmRuUBidJrJxDmLkxzPiSJJSb
 +SsmH3BG+NRTCppt+dUyLdiqtJmzRC4V3EgNGOW1vILa7RUiZk9zPEGBhmtXpPzbCgywaBd
 WQaMl3Xd4jrNXJWKlwGyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C4/CjCvCGtg=;t8easSCtGMHiRPm9qnzrgXFxjBy
 6Fy3QTzlNCPHit7yODTIjzbuPKS9tZq1WW8RjJcQPgU0e7L1N7xVOnBSjkN1ft4UdOPRqkMzw
 SZXPO0uib4+2Jg5+VHAbRlULaFLUDYIUw4gdHL91otYnFVKBJfVlgfkNjgELl6ymDm9DqWmIV
 D4DiLCedVh8d1PCEQs9eC8MPBa36b4nlXglq49MJhSCRwycuncK7zorBJhFX0QD/dKkq72Srq
 yW9VDNX8y+NVGNvl3Jd9DNv3nF5E1c+PcTRLGTNI4xoDAo3kTTC1JVYPvFkNV4UK9VVOBygwI
 6tJ7Y49CnLcyHAn7L0AsxZKqbJBvVC775StPoKooN/M2LGjJgXfdRqfB4W6Cq5fCElfhPPtIL
 +oA9omiFbW7eyh1k7ffnVH64ufEyuMW43Wa21+Dph3nQq4500y/vOacdf/ssgMd91rQdXBoiW
 ahzKfXKTJLkS0h5dgt0AhpRwRb2LDvGZwZM8Ztp/yAbHy+24TfHauDqDoEM5Wy1y4uqjk1gor
 bp/X8Rnl7nD0AD9/MgCa092WIG4/SpTUF0a2lWXWueUP90hpsW9Ea4o5a1t7GHCPy9Rm3Rz26
 /31vwB3pOFqkGqkiTHDpzlc/x3haAq9/QyLo+IV1m+FZX/TuKzguq3go8mXIA/4QvbOPxfOJd
 P6DR25FzJY1SXcxV4tsTrJCxLHdVp2aALP+dQg2TsD2snB49AySWxeR8PwTTqoOe0fNLP5YzN
 JbHSrjUiYamgjMZpL9mmWBDky+FUtZNiH6BZ1d9CapjhqE2ymTmuhsFBaKgrKpTuxpJh99kuy
 xzDknjOYyQqG4sFl4tLZLCf48bWtj1Oq4T7plw86icqtXN/a4mQb1zk1av+hemS3tirXITrBM
 Yl0yjQSOEhyn90tsJSBeATqDSL0IzHekzjmQXtw6MCM73sY1WSEAB32zEcH4iMa1ARQzIr40G
 11eRsI8YJvzcLbrbv22qeUwMm+bSQ/6U+w5prL/VmFEazY/FsrW97kHQn2Iq9hAh3WaTEjFy+
 M/zkc+p2JgY3og2Tf+X0uK1uD4HyjU/ap3/zttZjP17ZmzheEN8PvE2S1UqgeczdxO7WPJKmc
 axeykHLpyiaOLE1rsc3OTAUqwLFICMzazW9iVoYW7pwF/TVWZZwu+4vURVB9Fz6n3GS95E1zQ
 Gne75ofJfvVDD0JkCsLxTGarEokcd0y6M+7iSyEG4A+ev0xmGQ4M8XrzfJ5fjl2xZPacyGpEc
 D32fPVlyFATOUma/UT/u4s7tJxXC7jLIBPjRPKR6430jNjs10fCXDz+g0goUnOurY5CzcKQqH
 XEjeXXGApje8gOwJpRv7TOUvmY82HuyJRD+O54+DK4/Gk4Wzi40qJUpCLQumyogTG8sjI2qBE
 R7UHZY0ElkB85IakzopW4e+0nrNow3pwNfD7pW+eHW0CNsrCGgkV8eA+bAQH3fVfgrJhMQSzo
 HFgQqO45e+zzoVuO7M6Y6+XlmKyNOSlZ+ngmk/qeg4T5GQ35g
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Thu, 6 Feb 2025, Patrick Steinhardt wrote:

> Unlinking a file may fail on Windows systems when the file is still held
> open by another process. This is incompatible with POSIX semantics and
> by extension with Git's assumed semantics when unlinking files, which
> is that files can be unlinked regardless of whether they are still open
> or not. To counteract this incompatibility, we have some custom error
> handling in the `mingw_unlink()` wrapper that first retries the deletion
> with some delay, and then asks the user whether we should continue to
> retry.
>
> While this logic might be sensible in many callsites throughout Git, it
> is less when used in the reftable library. We only use unlink(3) there
> to delete tables which aren't referenced anymore, and the code is very
> aware of the limitations on Windows. As such, all calls to unlink(3p)
> don't perform any error checking at all and are fine with the call
> failing.
>
> Instead, the library provides the `reftable_stack_clean()` function,
> which Git knows to execute in git-pack-refs(1) after compacting a stack.
> The effect of this function is that all stale tables will eventually get
> deleted once they aren't kept open anymore.
>
> So while we're fine with unlink(3p) failing, the Windows-emulation of
> that function will still perform several sleeps and ultimately end up
> asking the user:
>
>     $ git pack-refs
>     Unlink of file 'C:/temp/jgittest/jgit/.git/reftable/0x000000000002-0=
x000000000004-50486d0e.ref' failed. Should I try again? (y/n) n
>     Unlink of file 'C:/temp/jgittest/jgit/.git/reftable/0x000000000002-0=
x000000000004-50486d0e.ref' failed. Should I try again? (y/n) n
>     Unlink of file 'C:/temp/jgittest/jgit/.git/reftable/0x000000000002-0=
x000000000004-50486d0e.ref' failed. Should I try again? (y/n) n
>
> It even asks multiple times, which is doubly annoying and puzzling to
> the user:
>
>   1. It asks when trying to delete the old file after having written the
>      compacted stack.
>
>   2. It asks when reloading the stack, where it will try to unlink
>      now-unreferenced tables.
>
>   3. It asks when calling `reftable_stack_clean()`, where it will try to
>      unlink now-stale tables.
>
> Fix the issue by making it possible to disable this behaviour with a
> preprocessor define. As "git-compat-util.h" is only included from
> "system.h", and given that "system.h" is only ever included by headers
> and code that are internal to the reftable library, we can set that
> macro in this header without impacting anything else but the reftable
> library.
>
> Reported-by: Christian Reich <Zottelbart@t-online.de>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
>
> This patch fixes the issue reported in [1].
>
> Changes in v2:
>   - Rebased the patch on top of ps/reftable-sans-compat-util at
>     3f172f1391 (Makefile: skip reftable library for Coccinelle,
>     2025-02-03). This is done to fix a semantic merge conflict.
>   - Link to v1: https://lore.kernel.org/r/20250125-b4-pks-reftable-win32=
-in-use-errors-v1-1-356dbc783b4f@pks.im
>
> Thanks!
>
> Patrick
>
> [1]: <d7fd0b1c-98fe-4cc3-b657-c2c3d0bc5c47@t-online.de>
> ---
>  compat/mingw/compat-util.c | 5 ++++-
>  compat/mingw/posix.h       | 8 ++++++--
>  reftable/system.h          | 1 +
>  3 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/compat/mingw/compat-util.c b/compat/mingw/compat-util.c
> index 1d5b211b54..0e4b6a70a4 100644
> --- a/compat/mingw/compat-util.c
> +++ b/compat/mingw/compat-util.c
> @@ -302,7 +302,7 @@ static wchar_t *normalize_ntpath(wchar_t *wbuf)
>  	return wbuf;
>  }
>
> -int mingw_unlink(const char *pathname)
> +int mingw_unlink(const char *pathname, int handle_in_use_error)
>  {
>  	int ret, tries =3D 0;
>  	wchar_t wpathname[MAX_PATH];
> @@ -317,6 +317,9 @@ int mingw_unlink(const char *pathname)
>  	while ((ret =3D _wunlink(wpathname)) =3D=3D -1 && tries < ARRAY_SIZE(d=
elay)) {
>  		if (!is_file_in_use_error(GetLastError()))
>  			break;
> +		if (!handle_in_use_error)
> +			return ret;
> +
>  		/*
>  		 * We assume that some other process had the source or
>  		 * destination file open at the wrong moment and retry.
> diff --git a/compat/mingw/posix.h b/compat/mingw/posix.h
> index 8dddfa818d..88e0cf9292 100644
> --- a/compat/mingw/posix.h
> +++ b/compat/mingw/posix.h
> @@ -201,8 +201,12 @@ int uname(struct utsname *buf);
>   * replacements of existing functions
>   */
>
> -int mingw_unlink(const char *pathname);
> -#define unlink mingw_unlink
> +int mingw_unlink(const char *pathname, int handle_in_use_error);
> +#ifdef MINGW_DONT_HANDLE_IN_USE_ERROR
> +# define unlink(path) mingw_unlink(path, 0)
> +#else
> +# define unlink(path) mingw_unlink(path, 1)
> +#endif
>
>  int mingw_rmdir(const char *path);
>  #define rmdir mingw_rmdir
> diff --git a/reftable/system.h b/reftable/system.h
> index dccdf11f76..1492bf6d70 100644
> --- a/reftable/system.h
> +++ b/reftable/system.h
> @@ -11,6 +11,7 @@ license that can be found in the LICENSE file or at
>
>  /* This header glues the reftable library to the rest of Git */
>
> +#define MINGW_DONT_HANDLE_IN_USE_ERROR
>  #include "../compat/posix.h"
>  #include <zlib.h>

It's the pragmatic thing to do.

A cleaner fix would be to introduce a proper function that says in its
name that it tries to delete a file on a best-effort basis but won't
insist if that's not possible at the time.

As I have communicated with you on similar issues in the past, my
perspective is that Git fails to abstract operating system-specific
functionality correctly, and instead (ab-)uses POSIX/libc functions trying
to do so. This is one of the things Subversion still does better. That's
why we now have the unfortunate need to change the function signature of
`mingw_unlink()` to something distinctly unlike `unlink()` (which
`mingw_unlink()` originally clearly tried to emulate in an effort to
pretend to Git that it's okay to assume that every operating system
behaves like Linux).

What strikes me as even less desirable is to _still_ keep the function
signature of `unlink()` the same, changing instead the behavior per-file
via that macro definition.

Unfortunately, the cleaner fix would require to undo years of working
around the lack of a proper platform abstraction layer, which would not
only be a huge amount of effort, but once again cause a lot of downstream
pain in Git for Windows, therefore I would actually oppose such an effort.

tl;dr I will live with this patch.

Ciao,
Johannes

>
>
> ---
> base-commit: 0fb5c2116049c665c6550d7e0419971a277af345
> change-id: 20250124-b4-pks-reftable-win32-in-use-errors-969494f2fdf7
>
>
