Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F386C7619A
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 09:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjC0JZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 05:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjC0JZP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 05:25:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9C540DF
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 02:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1679909111; i=johannes.schindelin@gmx.de;
        bh=JGCQA3QoQxrt/vg1g9Fu/roEVnq8Rs+wpC2CIp6eOWo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cMeLiixnk27BS/BINmp6KvQWwLtMjopJ05te4zTR8HGPy0PL2xmGFoj6A3zhGoWG9
         9EEjn99mCcjfTos50Ubu0fjA2MMzW8JnvcYXHpH8+UcyyONITMI/A55/JKptaiyRpx
         BDhkzWdiHwVaPVMuIb3QpblnUQCveCoox2TLaox3RNbdbqDbxIT/3sdUzINMDhI7Uf
         wW9t+n7UP+O04xTiTjybpDiMrthqnTCSitvu3mhJHoGGcv3AGfAy01vADSRHOPQRj2
         kHuNx6uFJE2LBhXWHQib1HEc7MqBFpI7XtYiRScWjM+3rymN96szFH+AA5mgm16AhN
         iYsqgcQxjFkOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3lYB-1ph0Ld49b9-000qGV; Mon, 27
 Mar 2023 11:25:11 +0200
Date:   Mon, 27 Mar 2023 11:25:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH v4] mingw: prefer RtlGetVersion over GetVersion
In-Reply-To: <pull.1438.v4.git.git.1674331462560.gitgitgadget@gmail.com>
Message-ID: <8b236f96-4b1c-0784-3a25-becc20e3e806@gmx.de>
References: <pull.1438.v3.git.git.1674330625069.gitgitgadget@gmail.com> <pull.1438.v4.git.git.1674331462560.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OOA/J7HfnExdR50DR9MkiYxW+OOpLKkg2C8xjL7SgPHp8fupT8Q
 EhPoB5+pVmAbzB5UFhUkIPwerdGtrbkMaR/4VoieTzFmGyfG3x8qaY+NCghZBmwcavuGCbE
 fnvUh9fCtSMhr90uo67UTe1R8HMTDgW2jezEcZ8uR4mm35E6FNDNhOoeHdHwxYY0CN2WdB7
 NByvy5NL2CQkFstdixuFw==
UI-OutboundReport: notjunk:1;M01:P0:CF9v+30bQ/0=;rKhEKRlxbO9BDYDDXY2uBqJyl4Z
 gvAsHpRg6uhZKPx2gdHGjaCe1yev//2zGd517IFbJqZ6im3UqWcCpnNcMXHsvSpa35SadS1Z5
 wuOAkBGDWgbS06J6uS4K7vtOUhMjRaovd5zBibOybZcDlp0WuEE99lFeOtnqMBYVFpp6PGHeD
 ss0XXxpa878uyrNf5ybiOmMoI/ONTboGSNoqC/HD2TPdr9Y/1crsxKUsJ/0MD6UfgxPPkl3l1
 OTIXJbdpI/Rx5lo8BijKrJaDsy02JCkFuYMgSfJQ4UHQGHhY+ekZOYgpC4/zYjNXQu2oCdFcw
 FdOins/NWj16cjGk7TgfHjnRfc6GelX6lANQVlW8xK0USyrGccq9cyZ8Ea7n3jtcM731z5yFe
 TlVXvLKSHmqVJPe5P/HOQ3qpyorG6QrvRIHue8izBOq0MsELtY7SvFVnYKmLLN8/PwPTQSuYF
 BVDSJtw6EwsY4J6XmXLzd1uziBfaW9A1KIG4cECz/neSN1MBGlMaHBZo6z+a/kKrfrq22/Q0T
 Ogr1DBFjIWObG5CZLym/+QbvOc7qNSVL8L3YhD+t/ghUY/obre1fHwfRT1aGZy32xZcSBrrUk
 mNKG+wAwLr/QqjOYygmXa6dhbBbp5pKVQurGXN6qerLIlzdgmDETPAiHzlGXr2PXrT62nILD4
 4drCZYuKU10b3+EphRI4svkd9NZlrIIA3tVKIzcRz5ehLIFGj2iLviXTcg8tNYcImtcQQ7qZZ
 56XswKATo2DeQuTl1/i6ajS3fmfei1dBuKwfRo1zaPzjeAuoB1tnsistuke5ghTQCSgCvKNN1
 wpn38/jdtUWXoTHDdCRVbQmZnfZzFmVzVHioPQ/L5+adZShrzJumNRnDTR1WUszOGdAVeiT2H
 SyRJWYarameaCHY4EPe8hdCd7DgJnF53VqkrY4agBHJU5jMTrT3v1q7VgVs2EpcW/uojbg/HK
 1wXtSXqmpFUIpXQaTexDtkcK2tA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 21 Jan 2023, Rose via GitGitGadget wrote:

> From: Seija Kijin <doremylover123@gmail.com>
>
> The previous way is deprecated and returns

Let's always provide references for such claims (which would otherwise
risk suspicion for being taken out of thin air).
https://learn.microsoft.com/en-us/windows/win32/api/sysinfoapi/nf-sysinfoa=
pi-getversion
has this to say:

	*GetVersion* may be altered or unavailable for releases after
	Windows 8.1.

The suggestion is to switch to using version helpers, but those version
helpers do not get you a version number, they instead help you determine
which major version you're on, which is not what we need.

Please note that the documentation in no way or form suggests to switch to
using `RtlGetVersion()`.

> the wrong value in Windows 8 and up,
> returning the manifest Windows data
> as opposed to the actual Windows data.

This is correct only if you ignore the reality that
`compat/win32/git.manifest` contains the values required to make it work.

> RtlGetVersion is the correct way
> to get the Windows version now.

Here, we would need a reference to support that claim. Seeing as I failed
to find any, I suspect that the claim can safely be considered to be
refuted and therefore the patch must be taken into doubt.

Ciao,
Johannes

>
> Note: ntdll does not need to be
> manually loaded into the runtime,
> as this is the one special library
> that is automatically loaded upon launch.
>
> Signed-off-by: Seija Kijin <doremylover123@gmail.com>
> ---
>     mingw: prefer RtlGetVersion over GetVersion
>
>     GetVersion has its behavior changed in Windows 8 and above anyway, s=
o
>     this is the right way to do it now.
>
>     The previous way returns the wrong value in Windows 8 and up, return=
ing
>     the manifest Windows data as opposed to the actual Windows data.
>
>     Signed-off-by: Seija Kijin doremylover123@gmail.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-14=
38%2FAtariDreams%2Fmingw-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1438/=
AtariDreams/mingw-v4
> Pull-Request: https://github.com/git/git/pull/1438
>
> Range-diff vs v3:
>
>  1:  31f778a6b34 ! 1:  8293e868970 mingw: replace deprecated GetVersion =
with RtlGetVersion
>      @@ Metadata
>       Author: Seija Kijin <doremylover123@gmail.com>
>
>        ## Commit message ##
>      -    mingw: replace deprecated GetVersion with RtlGetVersion
>      +    mingw: prefer RtlGetVersion over GetVersion
>
>           The previous way is deprecated and returns
>           the wrong value in Windows 8 and up,
>
>
>  compat/mingw.c | 39 +++++++++++++++++++++++++++++++++------
>  1 file changed, 33 insertions(+), 6 deletions(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index af397e68a1d..b1d75c93cfe 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -3081,15 +3081,42 @@ int wmain(int argc, const wchar_t **wargv)
>  	return exit_status;
>  }
>
> +/*
> + * for RtlGetVersion in uname
> + */
> +
> +typedef NTSTATUS(WINAPI *RtlGetVersionPtr)(PRTL_OSVERSIONINFOW);
> +union winprocaddr {
> +	FARPROC procaddr;
> +	RtlGetVersionPtr procGetVersion;
> +};
> +
>  int uname(struct utsname *buf)
>  {
> -	unsigned v =3D (unsigned)GetVersion();
> +	union winprocaddr RtlGetVersionInternal;
> +	OSVERSIONINFOW version;
> +
> +	memset(&version, 0, sizeof(version));
> +	version.dwOSVersionInfoSize =3D sizeof(version);
> +
> +	/* RtlGetVersion always gets the true Windows version, even when runni=
ng
> +	 * under Windows's compatibility mode*/
> +	RtlGetVersionInternal.procaddr =3D
> +		GetProcAddress(GetModuleHandleW(L"ntdll.dll"), "RtlGetVersion");
> +
> +	if (RtlGetVersionInternal.procaddr) {
> +		RtlGetVersionInternal.procGetVersion((PRTL_OSVERSIONINFOW)&version);
> +	} else {
> +		/* Should not happen, but just in case, fallback to deprecated
> +		 * GetVersionExW */
> +		GetVersionExW(&version);
> +	}
> +
>  	memset(buf, 0, sizeof(*buf));
>  	xsnprintf(buf->sysname, sizeof(buf->sysname), "Windows");
> -	xsnprintf(buf->release, sizeof(buf->release),
> -		 "%u.%u", v & 0xff, (v >> 8) & 0xff);
> -	/* assuming NT variants only.. */
> -	xsnprintf(buf->version, sizeof(buf->version),
> -		  "%u", (v >> 16) & 0x7fff);
> +	xsnprintf(buf->release, sizeof(buf->release), "%lu.%lu",
> +		  version.dwMajorVersion, version.dwMinorVersion);
> +	xsnprintf(buf->version, sizeof(buf->version), "%lu",
> +		  version.dwBuildNumber);
>  	return 0;
>  }
>
> base-commit: 904d404274fef6695c78a6b055edd184b72e2f9b
> --
> gitgitgadget
>
