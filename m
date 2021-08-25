Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4547DC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 13:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B9B61040
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 13:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240774AbhHYNv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 09:51:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:35785 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240646AbhHYNv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 09:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629899463;
        bh=auzpibZaznDgjQIlO1JiqV4Zdgi0HSZFkFOVBGB5SBQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dD80xCZe74ZW+wyTgkqHJuJr0wPAJT5FMDX1D7y5G55h/HTRCF1gnp69DXdg3LyAN
         9dIWRN6lBZoSBEd37Oqou49OKedQyTvHQCHE3FXEdhvno6X3ezrGJGk0DXWFKwdKFC
         sT0Z5vPy5o88uMVBdG8Yb3BBWYUtTk6ZQkn6QVLg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([89.1.214.7]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Kr-1mN22e2LFj-005GGT; Wed, 25
 Aug 2021 15:51:03 +0200
Date:   Wed, 25 Aug 2021 15:51:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Neeraj-Personal <nksingh85@gmail.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH 1/2] object-file: use futimes rather than utime
In-Reply-To: <2c1ddef6057157d85da74a7274e03eacf0374e45.1629856293.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108251530210.55@tvgsbejvaqbjf.bet>
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com> <2c1ddef6057157d85da74a7274e03eacf0374e45.1629856293.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:czM8n/cAc68d3o2MuaeY6hDppUKhYotBKxmOBcPVlLvinKb9iEx
 vC90GlzyaU5IZrdVzRexgxQ9KdDdyiZFR8I6V9YPBBAXHO+TJF//DrxWhEDT0AGGSL6fPcn
 ZLTHuUzWuFm/wjvTskVXPoZkxEaoho2Fck7gy66ho83fIVBfpoyQbWCte1OwBzcro3CSnv9
 VsKtZr0IMdl89Bp1x5Kww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/skkJcffujY=:VOaFtlazKaPEBqk2ToC6Mr
 ySugULM8jMxCngDYkI0H4EP3qowogJpLAqBIJR70HwFZor5kvweRaQ6Dyuak4yvfepkPcmLsK
 nhuB7iF92tKujjlm0pY8HISbdgcr1x2eF63viQ/wJ+YqdVVMzOJv9Bc7KFJvNYCAltqOVoGmd
 HFl+wqvHEthXUlszec9uYZt9MhZu+/PZsCQYSZ93hD7x3g9TB2PsJK18Tdhu1+PX/EhtzKFoz
 uJ3pJFXOX1XhcH63wEi28rkJ/jw2B6Dbk7I7OYjutgKkwvVqs7+ijNZHziK602nBEq2M0IlZl
 fjsQsZCB1sjpqMIBfNt2wuaKOU5WruBHvQRXjC1DtqDJU5BybQs5L2v23QfoeLbOorSp1NTB3
 fnxipFwmT0lFciBVdN6deNAc9Ss6urav49b/8V9pDAqj8SeQxr/pCDa5+VpB9yHHlNgE4b4AO
 VhqVrp6ImghAfCeeJgxgG2/yrIms9PMzukpZxam8KIgwGktyqICVs53oP+zmTfOCHZWV4hkaC
 9BASysHd5cw9xs8kXbMhfvKA+aXRL4rMfrUPIQRpPlpiNm/wwR04dexHc0YYR331Z8z98js1H
 MQqPig7GBYbZ6jO4OsLTzI9exNl1v2yOp2FelWmgY9/mxeHn0tmgGTPMIp7eaB/bZZCy1/qG3
 YH/ByPOqBkVJ57xHp+rb2p+BBTa7BCmTD/JAmIqk6qRL+J5H7lvg9MSyQoaF733hVK495xdEJ
 x0+oty0JzcdtvvxzuHLFWnIO3S4Y0uBsFqSjRTkPEXPQuI7jt90JcLn4+XZbD8O107QR+Yd0o
 AadhmuZrTt3GCKHJQ4BaPZAozQ+7jA/fF6Wi4eYUoO0RDGXf7D1CvARXwLesLQ/O0SQsugVka
 5O0pF7nAZqOPOaHbhJqJgCzF4N713ayY4zCzPpJNPWaDL5k+saGwOVC1K6Qx2wHW20/Rc7D+o
 Kw7mlZFx+dSVuqCHh2V4ZNF8u7pZC7uiNTct/liRTZVSEkFOr5XMz+B6TqTmJWLhkZ/JROFO2
 V0Sk/NgrmOWoraNGdbeV7cJ44lPqqKAV760ZV/MoffxIYDTgpGQ1xxcCOSlUZhl8xGSF7oFK8
 VZWo5LVtvjdU8Kz9FxAR5j0dNjjK2CJScRJYbjZARgB8WVFamwMYcr2Rg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Neeraj,

Thank you so much for this patch series! Overall, I am very happy with the
direction this is going.

I will offer a couple of suggestions below, inlined.

On Wed, 25 Aug 2021, Neeraj Singh via GitGitGadget wrote:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> Refactor the loose object file creation code and use the futimes(2) API
> rather than utime. This should be slightly faster given that we already
> have an FD to work with.

If I were you, I would spell out "file descriptor" here.

>
> Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> ---
>  compat/mingw.c | 42 +++++++++++++++++++++++++++++-------------
>  compat/mingw.h |  2 ++
>  object-file.c  | 17 ++++++++---------
>  3 files changed, 39 insertions(+), 22 deletions(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 9e0cd1e097f..948f4c3428b 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -949,19 +949,40 @@ int mingw_fstat(int fd, struct stat *buf)
>  	}
>  }
>
> -static inline void time_t_to_filetime(time_t t, FILETIME *ft)
> +static inline void timeval_to_filetime(const struct timeval *t, FILETIM=
E *ft)
>  {
> -	long long winTime =3D t * 10000000LL + 116444736000000000LL;
> +	long long winTime =3D t->tv_sec * 10000000LL + t->tv_usec * 10 + 11644=
4736000000000LL;

Technically, this is a change in behavior, right? We did not use to use
nanosecond precision. But I don't think that we actually make use of this
in this patch.

>  	ft->dwLowDateTime =3D winTime;
>  	ft->dwHighDateTime =3D winTime >> 32;
>  }
>
> -int mingw_utime (const char *file_name, const struct utimbuf *times)
> +int mingw_futimes(int fd, const struct timeval times[2])

At first, I wondered whether it would make sense to pass the access time
and the modified time separately, as pointers. I don't think that we pass
around arrays as function parameters in Git anywhere else.

But then I realized that `futimes()` is available in this precise form on
Linux and on the BSDs. Therefore, it is not up to us to decide the
function's signature.

However, now that I looked at the manual page, I noticed that this
function is not part of any POSIX standard.

Which makes me think that we will have to do a bit more than just define
it on Windows: we will have to introduce a `Makefile` knob (just like you
did with `HAVE_SYNC_FILE_RANGE` in patch 2/2) and set that specifically
for Linux and the BSDs, and use `futimes()` only if it is available
(otherwise fall back to `utime()`).

Then, as a separate patch, we should introduce this Windows-specific shim
and declare that it is available via `config.mak.uname`.

I am a _huge_ fan of patches that are so clear and obvious that bugs have
a hard time creeping in without being spotted immediately. And I think
that this organization would help achieve this goal.

>  {
>  	FILETIME mft, aft;
> +
> +	if (times) {
> +		timeval_to_filetime(&times[0], &aft);
> +		timeval_to_filetime(&times[1], &mft);
> +	} else {
> +		GetSystemTimeAsFileTime(&mft);
> +		aft =3D mft;
> +	}
> +
> +	if (!SetFileTime((HANDLE)_get_osfhandle(fd), NULL, &aft, &mft)) {
> +		errno =3D EINVAL;
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +int mingw_utime (const char *file_name, const struct utimbuf *times)

Please lose the space between the function name and the opening
parenthesis. I know, the preimage of this diff has it, but that was an
oversight and definitely disagrees with our current coding style.

> +{
>  	int fh, rc;
>  	DWORD attrs;
>  	wchar_t wfilename[MAX_PATH];
> +	struct timeval tvs[2];
> +
>  	if (xutftowcs_path(wfilename, file_name) < 0)
>  		return -1;
>
> @@ -979,17 +1000,12 @@ int mingw_utime (const char *file_name, const str=
uct utimbuf *times)
>  	}
>
>  	if (times) {
> -		time_t_to_filetime(times->modtime, &mft);
> -		time_t_to_filetime(times->actime, &aft);
> -	} else {
> -		GetSystemTimeAsFileTime(&mft);
> -		aft =3D mft;
> +		memset(tvs, 0, sizeof(tvs));
> +		tvs[0].tv_sec =3D times->actime;
> +		tvs[1].tv_sec =3D times->modtime;

It is too bad that we have to copy around those values just to convert
them, but I cannot think of any better way, either. And it's not like
we're in a hot loop: this code will be dominated by I/O anyways.

>  	}
> -	if (!SetFileTime((HANDLE)_get_osfhandle(fh), NULL, &aft, &mft)) {
> -		errno =3D EINVAL;
> -		rc =3D -1;
> -	} else
> -		rc =3D 0;
> +
> +	rc =3D mingw_futimes(fh, times ? tvs : NULL);
>  	close(fh);
>
>  revert_attrs:
> diff --git a/compat/mingw.h b/compat/mingw.h
> index c9a52ad64a6..1eb14edb2ed 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -398,6 +398,8 @@ int mingw_fstat(int fd, struct stat *buf);
>
>  int mingw_utime(const char *file_name, const struct utimbuf *times);
>  #define utime mingw_utime
> +int mingw_futimes(int fd, const struct timeval times[2]);
> +#define futimes mingw_futimes
>  size_t mingw_strftime(char *s, size_t max,
>  		   const char *format, const struct tm *tm);
>  #define strftime mingw_strftime
> diff --git a/object-file.c b/object-file.c
> index a8be8994814..607e9e2f80b 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1860,12 +1860,13 @@ int hash_object_file(const struct git_hash_algo =
*algo, const void *buf,
>  }
>
>  /* Finalize a file on disk, and close it. */
> -static void close_loose_object(int fd)
> +static int close_loose_object(int fd, const char *tmpfile, const char *=
filename)
>  {
>  	if (fsync_object_files)
>  		fsync_or_die(fd, "loose object file");
>  	if (close(fd) !=3D 0)
>  		die_errno(_("error when closing loose object file"));
> +	return finalize_object_file(tmpfile, filename);

While this is a clear change of behavior, this function has only one
caller, and that caller is adjusted accordingly.

Could you add this clarification of context to the commit message? I know
it will help me in the future, when I have to get up to speed again by
reading the commit history.

Thank you,
Johannes

>  }
>
>  /* Size of directory component, including the ending '/' */
> @@ -1973,17 +1974,15 @@ static int write_loose_object(const struct objec=
t_id *oid, char *hdr,
>  		die(_("confused by unstable object source data for %s"),
>  		    oid_to_hex(oid));
>
> -	close_loose_object(fd);
> -
>  	if (mtime) {
> -		struct utimbuf utb;
> -		utb.actime =3D mtime;
> -		utb.modtime =3D mtime;
> -		if (utime(tmp_file.buf, &utb) < 0)
> -			warning_errno(_("failed utime() on %s"), tmp_file.buf);
> +		struct timeval tvs[2] =3D {0};
> +		tvs[0].tv_sec =3D mtime;
> +		tvs[1].tv_sec =3D mtime;
> +		if (futimes(fd, tvs) < 0)
> +			warning_errno(_("failed futimes() on %s"), tmp_file.buf);
>  	}
>
> -	return finalize_object_file(tmp_file.buf, filename.buf);
> +	return close_loose_object(fd, tmp_file.buf, filename.buf);
>  }
>
>  static int freshen_loose_object(const struct object_id *oid)
> --
> gitgitgadget
>
>
