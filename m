Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB8FC433F5
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 08:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbhKUI7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 03:59:52 -0500
Received: from mout.web.de ([212.227.17.11]:40363 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237324AbhKUI7v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 03:59:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1637484997;
        bh=OLWuodaGuy2M6wEtjx4PSa+BscoJ1QLWjo0/7QRuTsc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=h9s2o+GDe5l7K29r2emCCCqIr2PgYUshlka3+XF/VKSwOxUd20epHj7nnKL0nHRYF
         WqBkKR0zG2No+8XVS+wR6fMMlQS/v8334EHK2Ysf288ve74lJXjv8GnO+ABFB8j1O6
         Su1+TVtGbTcyxmUXluL8efHvVpSdrV3b6dzozRzA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.20.171]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjgSv-1mM0gI1VsZ-00kmd7; Sun, 21
 Nov 2021 09:56:37 +0100
Message-ID: <150f9c88-f175-963d-2947-7ae9f3a2ef12@web.de>
Date:   Sun, 21 Nov 2021 09:56:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 5/8] symlinks: do not include current working directory in
 dir removal
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <8a69d2878c99e1b9321e57073d266cf797dc5630.1637455620.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <8a69d2878c99e1b9321e57073d266cf797dc5630.1637455620.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JJip2iUnG+7upO6Q3XPjn8BAsGKP636e6kyk2EP7RSQDnKKLNJy
 c4D3oL+MBkYLergIi0p8vjquhajanIIydfiD1Cu72TGlAx7pI+oEskmuXNO4fd4BGKwdAPr
 D7IBAO8h+sGl+HX8M+WpeQCqcSqzeaBdNbS8zPZ7oOvJXh05b4ClZ9YIlWCWQjQbwB1X0ll
 m2Mz4zaFY3NSdDSuf/MNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lKOOOoq2Z8Y=:FT2WFZfGTIHS62cPYJSSV3
 KM7ydxZyX7+mwzp/PdtgKukrx31FhgWVJf7RYnd1uL7zkFOKWmIkFKsaZRR9yLZTqCuEWTt01
 8E+vpwRwNtGgS91v/cJIdsmzAcoTCVEWGWoASaRY8xImrdQddcMUNcQKPRRtidIb3KNmIApax
 GVD2TE4hvx9t+ftVvdIko3vynuGsvVKPlCgQxQXMAu2f/Uv1sr2TMzaSZYVlH1k4OkCS6NV1n
 9oQWEqGPYQbl9ZMYln8ju6T1NRF+L233RjO6z5xA1NyQzKdlWyCpTF/uV8CvUeMONZ3wjT9sJ
 3ckgcilVKy7+vO+7TdUCl7DrZwsiEDh2oZmGSW7mLSQTwbP9smnz0SnLSHspOpSotJjBNkT/o
 8v+YahQmnVDfvzm0NG+anqg7NACHq8LyC5w4fs7KE1JKYLWsZl1k8cV9eguZWvSqwcftoHFC+
 6LZz4Q2aWs+0yw0VpETehgtS9csPkojwHM2vreUjqrSlicSoIW8wnEFyHaoXruoDo7FsuuQ/e
 kJfFUI5ntLz/j8q3Tj4/HC8XhvQc/iqzBtHi02BrKcYukvFxOW0q1mI8FWyJF5SBobRpa0v/A
 ywXBfdZo5QQSL/vyorY6u/ozps9teVNRduNS8+qS2iQ3cikB5BdapZAWXKi2v3B4qoI/5rEJ+
 HoosndcbsUyfkxGm4e+VqdTMTZPdfUivl0JD0p/X8cAtUZV6E9UitI/MMRc/Xv9hoP5OrR4MA
 /F0oylQBx0JuYWyMLyU97jMAxmQK9S4aeVS3GO9rrgDap6LByQYr2IO6tzb93YCNEwPbxCih1
 +c2LxpD7Zyy22P4kodh7KBAT2sn0ZNtuD3xLGbOpIPVa+4Z43qH8Cpb58VE2T9wmJi0mGkKqH
 SzlE9yLZacrW/onru4i1DCahBV8GiDBgyruSmW/GE9QrPDXZG8lk2quH85/V8qs+2epL2i0k4
 +vvLMrVdIvKHqZS8BhKV+xSNyJxkWUMfJzilDB+PGWxxJXqZKCjuiAYu5pbseJqpGFFj4V7kW
 HDh/BwejtFYKOH601rJomGpzeoIKV0hTd0J2iq3feyaxzdiSTSGTLKjJEorzl/am7Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.11.21 um 01:46 schrieb Elijah Newren via GitGitGadget:
> From: Elijah Newren <newren@gmail.com>
>
> symlinks has a pair of schedule_dir_for_removal() and
> remove_scheduled_dirs() functions that ensure that directories made
> empty by removing other files also themselves get removed.  However, we
> want to exclude the current working directory and leave it around so
> that subsequent git commands (and non-git commands) that the user runs
> afterwards don't cause the user to get confused.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  symlinks.c           | 12 +++++++++++-
>  t/t2501-cwd-empty.sh | 12 ++++++------
>  2 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/symlinks.c b/symlinks.c
> index 5232d02020c..84622bedcde 100644
> --- a/symlinks.c
> +++ b/symlinks.c
> @@ -275,11 +275,18 @@ static int threaded_has_dirs_only_path(struct cach=
e_def *cache, const char *name
>
>  static struct strbuf removal =3D STRBUF_INIT;
>
> +static int cant_remove(char *dirname)
> +{
> +	if (the_cwd && !strcmp(dirname, the_cwd))

Initializing the_cwd to an empty string would allow removing the NULL chec=
k
everywhere.

Is strcmp() sufficient or do we need fspathcmp() in these kinds of checks?
Do we need to worry about normalizing directory separators?

> +		return 1;
> +	return rmdir(dirname);
> +}

I wouldn't expect a function of that name to actually try to remove
the directory.  Or with that body to require a non-const dirname.
It's used only once, perhaps inline it?

> +
>  static void do_remove_scheduled_dirs(int new_len)
>  {
>  	while (removal.len > new_len) {
>  		removal.buf[removal.len] =3D '\0';
> -		if (rmdir(removal.buf))
> +		if (cant_remove(removal.buf))
>  			break;
>  		do {
>  			removal.len--;
> @@ -293,6 +300,9 @@ void schedule_dir_for_removal(const char *name, int =
len)
>  {
>  	int match_len, last_slash, i, previous_slash;
>
> +	if (the_cwd && !strcmp(name, the_cwd))
> +		return;	/* Do not remove the current working directory */
> +
>  	match_len =3D last_slash =3D i =3D
>  		longest_path_match(name, len, removal.buf, removal.len,
>  				   &previous_slash);
