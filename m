Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 638BC1F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 20:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731426AbfJIUjH (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 16:39:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:40547 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731145AbfJIUjH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 16:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570653537;
        bh=4AGC5ViOwvbB63MEwfB6KJFRzoWceq9dyb8b+7Z7P54=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=l0VMvryAHoMz3XAOxZfm06GZocVTYiTbasoLD5PQpQEmcYmBgWoGmh8Qd//77MxqJ
         B1Xoijvzxl/4bhhD0Wekhz6ud1JQlefym3hKGTkCSFp87UzsPH3Lvx1uHvKmM+eSfa
         VIbejl8sUnvsUcmnayKDjw4M01zyTHPVA556OWfI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4axg-1iGeJC3vsc-001kMo; Wed, 09
 Oct 2019 22:38:57 +0200
Date:   Wed, 9 Oct 2019 22:38:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v10 18/36] merge-recursive: add get_directory_renames()
In-Reply-To: <20180419175823.7946-19-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910092044590.46@tvgsbejvaqbjf.bet>
References: <20180419175823.7946-1-newren@gmail.com> <20180419175823.7946-19-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kt+548/kXji29zCyHWanKSY1ChLyBIa32brRAQgQ5+/2emsR87s
 F4Z+X3xzKX6iTkuIPaEZDCcYG5wh9/wHizficEMUcfzxpF+So9K47rphUgOP8xuxn9Vw2D2
 /ogS53rd1myIMtEICNH0iVXEjgZcXMIDsZejcbXiMqW5nyr4h1kgKxxZkXwpJXU48Huz37U
 tASq0C4xFJoOXqFOveLQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BFbFqxUcjvg=:TOwOhpfC0kWIFw3KzlVCCZ
 HRqevKF4yFBVpMAdHf7Bi2POLQTS2QT0wFAmxskQ68Gh12jzs6Rx+rgeKnZLVwqkdnoWgOURZ
 o19NQfCbciDAVzxmvOK5eRytdNYqUcdrihZ0kyUSwAB8Jd9YmAv2qsNomGw4LmqhTJK2q3v95
 slewnpM7pBW8tGnj3Y6S8L4sIWSulfdu387oEm2E4doMV8P4Lw5ryWVQZeTLcmZm7MEdNqXVN
 lOciLF4Vc6u6dUqs56/yWk3n7bt4rSXFZNzX2FjAKhXBI0ZTS7LGW7jpTb8/KjFkKhEDcmTQ3
 PHPXNmTidhAgGtVmd4UjMKmuRvVVjAeRIbVfBwiDJ7ikxnFZNKswEgct4XDp7yDis5l1jbjUo
 IKyMsUToAWCZd/1qXyL2ZMabIsFS+W6gZAOsVLUonEVu389Oul0EULSVUCsW47kJTEt3zyUL2
 +NE0OMAS8y8FzG1J0VMfwci3fHYSrFqk3hKDNtewOi0+Qyye8z+dAgZ43VOTgVc6LMCXoygCF
 jZbY8nH3ibIabakMRIiw9tpFs/C8zhzI/mZy2MoVOCwtZul6RqtZ/KjBI8MlvOb1HU+hzpsb2
 w2rSoslBy1Y8yF14qf/H0QuAQY2CWT5R1OoTcXSTNzwpW6lRW9D5bjU1izjWh7uEHj+LRS0OQ
 JiWUmJUSevKr8N77E+rXvovBUKbBHSjDfOCtYuUnjd3pNw44hioXf1fqdr68DXut8/IQvxyLX
 9I93BvZrMupbutWOGylqBnovccdn4w37yQU2rJMbSiPCTWbhj4A1bOJgVIJHDybAs+nFcz7rR
 nczo5wc/RBaVJiz2BkpZ13xcciV2Be3CyuULPnJIOF99xfH900+o6uEDU3aHOntWRVEqRV9Ku
 KFannBBNSJbgINmazvTsE9V4sBjRrKOxglJjpl4YFpDEPRsLCHTMAzadJa2AUlV7tunMtfHa9
 Xz0ELHS4FVDjFNj8GcnL8jh1uWIOBHURX+yTTWXp/jwFhtPmDgOFPRSuvfcWP+1j1fu7IubSI
 52Thwx22rypQDcxg/kG8Za2+7d6To3+5SfMopvfGqRDIeyYCRNzRy0jR2idRtTWqrMvv3I1Uw
 Mz8LIBprxxgsD7o8djvXYq1emkKmo/IuC7cnlHAQwNpvm07Z9knEZjW9AqzCltKruLSk2u0zL
 d3UVWBm9pF9Igv3whU58XT7rkB8sK1/KSaj3o4FJW/V3X57XO7DBsj+TKPkfW3LL163ZoSLll
 +G6AgJH6AsYwjU+G/pOtUpw8i9S2pDDMeinYCT7if2wHMJ6Xqo9sslSE2waI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

sorry about the blast from the past, but I just stumbled over something
I could not even find any discussion about:

On Thu, 19 Apr 2018, Elijah Newren wrote:

> This populates a set of directory renames for us.  The set of directory
> renames is not yet used, but will be in subsequent commits.
>
> Note that the use of a string_list for possible_new_dirs in the new
> dir_rename_entry struct implies an O(n^2) algorithm; however, in practic=
e
> I expect the number of distinct directories that files were renamed into
> from a single original directory to be O(1).  My guess is that n has a
> mode of 1 and a mean of less than 2, so, for now, string_list seems good
> enough for possible_new_dirs.
>
> Reviewed-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  merge-recursive.c | 224 +++++++++++++++++++++++++++++++++++++++++++++-
>  merge-recursive.h |  18 ++++
>  2 files changed, 239 insertions(+), 3 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 30894c1cc7..22c5e8e5c9 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> [...]
> @@ -1357,6 +1395,169 @@ static struct diff_queue_struct *get_diffpairs(s=
truct merge_options *o,
>  	return ret;
>  }
>
> +static void get_renamed_dir_portion(const char *old_path, const char *n=
ew_path,
> +				    char **old_dir, char **new_dir)
> +{
> +	char *end_of_old, *end_of_new;
> +	int old_len, new_len;
> +
> +	*old_dir =3D NULL;
> +	*new_dir =3D NULL;
> +
> +	/*
> +	 * For
> +	 *    "a/b/c/d/e/foo.c" -> "a/b/some/thing/else/e/foo.c"
> +	 * the "e/foo.c" part is the same, we just want to know that
> +	 *    "a/b/c/d" was renamed to "a/b/some/thing/else"
> +	 * so, for this example, this function returns "a/b/c/d" in
> +	 * *old_dir and "a/b/some/thing/else" in *new_dir.
> +	 *
> +	 * Also, if the basename of the file changed, we don't care.  We
> +	 * want to know which portion of the directory, if any, changed.
> +	 */
> +	end_of_old =3D strrchr(old_path, '/');
> +	end_of_new =3D strrchr(new_path, '/');
> +
> +	if (end_of_old =3D=3D NULL || end_of_new =3D=3D NULL)
> +		return;
> +	while (*--end_of_new =3D=3D *--end_of_old &&
> +	       end_of_old !=3D old_path &&
> +	       end_of_new !=3D new_path)
> +		; /* Do nothing; all in the while loop */
> +	/*
> +	 * We've found the first non-matching character in the directory
> +	 * paths.  That means the current directory we were comparing
> +	 * represents the rename.  Move end_of_old and end_of_new back
> +	 * to the full directory name.
> +	 */
> +	if (*end_of_old =3D=3D '/')
> +		end_of_old++;
> +	if (*end_of_old !=3D '/')
> +		end_of_new++;

Is this intentional? Even after thinking about it for fifteen minutes, I
think it was probable meant to test for `*end_of_new =3D=3D '/'` instead o=
f
`*end_of_old !=3D '/'`. And...

> +	end_of_old =3D strchr(end_of_old, '/');
> +	end_of_new =3D strchr(end_of_new, '/');

... while I satisfied myself that these calls cannot return `NULL` at
this point, it took quite a few minutes of reasoning.

So I think we might want to rewrite these past 6 lines, to make
everything quite a bit more obvious, like this:

	if (end_of_old !=3D old_path)
		while (*(++end_of_old) !=3D '/')
			; /* keep looking */
	if (end_of_new !=3D new_path)
		while (*(++end_of_new) !=3D '/')
			; /* keep looking */

There is _still_ one thing that makes this harder than trivial to reason
about: the case where one of `*end_of_old` and `*end_of_new` is a slash.
At this point, we assume that `*end_of_old !=3D *end_of_new` (more about
that assumption in the next paragraph), therefore only one of them can
be a slash, and we want to advance beyond it. But even if the pointer
does not point at a slash, we want to look for one, so we want to
advance beyond it.

I also think that we need an extra guard: we do not handle the case
`a/b/c` -> `a/b/d` well. As stated a few lines above, "if the basename
of the file changed, we don't care". So we start looking at the last
slash, then go backwards, and since everything matches, end up with
`end_of_old =3D=3D old_path` and `end_of_new =3D=3D new_path`. The current=
 code
will advance `end_of_new` (which I think is wrong) and then looks for
the next slash in both `end_of_new` and `end_of_old` (which is also
wrong).

Is my reading correct?

Ciao,
Dscho

> +
> +	/*
> +	 * It may have been the case that old_path and new_path were the same
> +	 * directory all along.  Don't claim a rename if they're the same.
> +	 */
> +	old_len =3D end_of_old - old_path;
> +	new_len =3D end_of_new - new_path;
> +
> +	if (old_len !=3D new_len || strncmp(old_path, new_path, old_len)) {
> +		*old_dir =3D xstrndup(old_path, old_len);
> +		*new_dir =3D xstrndup(new_path, new_len);
> +	}
> +}
> [...]
