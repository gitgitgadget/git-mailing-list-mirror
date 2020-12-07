Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE91C19437
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 17:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E869238E9
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 17:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgLGRWC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 12:22:02 -0500
Received: from mout.web.de ([212.227.15.14]:52837 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgLGRWC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 12:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1607361602;
        bh=CTlKbzU26XZRz1Y4QnqJ7ykripsdFTjEqNpktDTqbI4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FkkpdehyfmPlR02M2HdT0qHirHkmJXHChOGSSOzNIkVpsIZctkhA0Tv+Tqf5Kn4Zu
         Krymsv6unTMcv50PT8xjKW0BGZXekknS8LbAocMad3wV+wGdBZIa9g+33vmdI5drJz
         G+89K9AFrx7knJhWtBFFaCEWTTT/RaVIF5KAa6bo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MYefK-1khI6C2uZe-00VP4N; Mon, 07
 Dec 2020 18:20:02 +0100
Subject: Re: [PATCH v4 1/2] abspath: add a function to resolve paths with
 missing components
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20201206225349.3392790-1-sandals@crustytoothpaste.net>
 <20201206225349.3392790-2-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c1d1fe44-6a7d-3578-cd89-9aea59c4637a@web.de>
Date:   Mon, 7 Dec 2020 18:19:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201206225349.3392790-2-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1o7+zBUZG/9qEw0xwC19HSXsDcrUceEEYG82rDRsbkSR9QPiEma
 4JWl00YOgjettb8HzKLnLI5h9Zv2JxWYnJ5i6wcOMkSLFqlE99DYHw9arQwWVe4goSSroZ9
 h7KfLBQwkRfy91SRALsYgJj89pHiGSIFvDLafQO5EhNn0Wf1k8QpqZxzLGPRnZ/7v8M3K2n
 EXfyZNsWOWw5MS1Xz3/Jg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iILMjKFMH1o=:6oScrUxwB1LFxedUwLCjQV
 jbIxCBspnw8ETPMAzVHZrDr8SysA2XHzHVmwGSG5kihwvk61M38XGgTKzQUOWv98mu/rqX0j9
 DvuSoim7TEas02b44ea7gtanBGjnk1XYsR+UOXRNsiPRa/j7Tc6UdRlPDiZMqyNFc1ZyqFSyy
 qxWxOFY3kgq/EZf2h637cgsQH6vhNl8FX3PCDMDezPZh0GEESkolJyVKGmmfFd/dciCPvqB4T
 X1rQnubzb+RRibfw0znSJnSu9zBECcmcgBYVvr827kqpBgS9RvS2PNPWvX0q6Nu2hwVrbB7rY
 a8da8mqxDkFZMgSEHcuMvbr7EnSh0/UujDAIXu5qCem3T5UdcuZnhv/e7NDUojMC5AuWHJQh8
 GiIZODc5Tr3v+kA8fZzXOmqDGbwePWMK9QIzz9NUCSltEnTz0OBASD6RDAQtohLurlBGlFWFq
 3uhlfBsM1QAd14Pr0/nHCsOta09BEDttgDaGNOmLtQWrVBMHLH/yDxpN4jYZRNKNwjqkT8LjG
 Jj++XJZd8s6uVMHEzhw2+8eCCeYP2UH5mjblO33fRCAUtYlNcgbqJKBULKXysq6wqW3c6vnDM
 RPv2grtHQ3riTFJ6f8z6z6GSoihTaWamFMOISo/t7zrfYTYoYPH9HPosQiHCJyfDKVglNZ/lx
 XIeINt/dq3iOugZkkeS/WNNtsLnRwZ3vfvlJTa6lFKazEt6MyII/pEv60cop63K/oOQrUfp20
 A9XhdjNN2GljgfaE/JBmijPgEhlqhsiQJ+XhMIR4BGaNR16cM6mrNv7i2pD2/Q39pm/gLfqDY
 E9kxAzeRVnPXJUsUjrzA+QY+6MkS0ChQ6lRG1kpAf3DtG7yMO/xm4I9333h5wUA70p0aEC9An
 B5pEu9ESCsg7AR/6a6Yw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.12.20 um 23:53 schrieb brian m. carlson:
> We'd like to canonicalize paths such that we can preserve any number of
> trailing components that may be missing.  Let's add a function to do
> that, allowing either one or an unlimited number of components to
> canonicalize, and make strbuf_realpath a wrapper around it that allows
> just one component.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  abspath.c | 13 ++++++++++++-
>  cache.h   |  2 ++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/abspath.c b/abspath.c
> index 6f15a418bb..e6630b3618 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -80,6 +80,17 @@ static void get_root_part(struct strbuf *resolved, st=
ruct strbuf *remaining)
>   */
>  char *strbuf_realpath(struct strbuf *resolved, const char *path,
>  		      int die_on_error)
> +{
> +	return strbuf_realpath_missing(resolved, path, 0, die_on_error);
> +}
> +
> +/*
> + * Just like strbuf_realpath, but allows specifying how many missing co=
mponents
> + * are permitted.  If many_missing is true, an arbitrary number of path
> + * components may be missing; otherwise, only the last component may be=
 missing.
> + */
> +char *strbuf_realpath_missing(struct strbuf *resolved, const char *path=
,
> +			      int many_missing, int die_on_error)

So this uses two 32-bit values to pass two bits.  Hmm.

I find the concept of a "real" path with imaginary components strangely
amusing.  But perhaps a name like strbuf_resolve_path() would fit better?

>  {
>  	struct strbuf remaining =3D STRBUF_INIT;
>  	struct strbuf next =3D STRBUF_INIT;
> @@ -129,7 +140,7 @@ char *strbuf_realpath(struct strbuf *resolved, const=
 char *path,
>
>  		if (lstat(resolved->buf, &st)) {
>  			/* error out unless this was the last component */
> -			if (errno !=3D ENOENT || remaining.len) {
> +			if (errno !=3D ENOENT || (!many_missing && remaining.len)) {
>  				if (die_on_error)
>  					die_errno("Invalid path '%s'",
>  						  resolved->buf);

So the original code errors out if there is a real error
(errno !=3D ENOENT).  It also errors out if any component except the last
one is missing (errno =3D=3D ENOENT && remaining.len); that's what the
comment is about.  This patch adds the ability to ignore ENOENT for all
components.

Perhaps convert many_missing and die_on_error into a single flags
parameter and implement the flags DIE_ON_ERR and REQUIRE_BASENAME or
similar?  Callers would be easier to read because such an interface is
self-documenting -- provided we find good flag names.

> diff --git a/cache.h b/cache.h
> index e986cf4ea9..a1386235fc 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1320,6 +1320,8 @@ static inline int is_absolute_path(const char *pat=
h)
>  int is_directory(const char *);
>  char *strbuf_realpath(struct strbuf *resolved, const char *path,
>  		      int die_on_error);
> +char *strbuf_realpath_missing(struct strbuf *resolved, const char *path=
,
> +			      int missing_components, int die_on_error);
>  char *real_pathdup(const char *path, int die_on_error);
>  const char *absolute_path(const char *path);
>  char *absolute_pathdup(const char *path);
>

