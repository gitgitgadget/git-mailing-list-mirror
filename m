Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E715C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F34820890
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="pTX6pdZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgFRU76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:59:58 -0400
Received: from mout.web.de ([212.227.17.11]:60921 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgFRU74 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 16:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592513989;
        bh=SBgL1nXTzbW+7VbVb8t94UniJOXWmN8iUn/xU+WdX88=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=pTX6pdZgdK5xBmCB41NW6kJ4D2GhiBKsFDlqN8qjN8RYwwue8Kww9dRgi5W0VUyZr
         IYbMighbZfBXZ/r+3YkOoEC23CwSSZpQIs2zMa+UkMorxeJZ+YmeM8+Xm0nel10s5a
         zltLSX4C+krerdkeRFepdnv9sv0WbJDDTbSi7Kcc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwjFg-1iwfJH0Zkg-00y7tE; Thu, 18
 Jun 2020 22:59:49 +0200
Subject: Re: [PATCH 04/10] commit-slab: add a function to deep free entries on
 the slab
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, jnareb@gmail.com,
        peff@peff.net, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.650.git.1591362032.gitgitgadget@gmail.com>
 <32a6f11cc475f5292075093dcdc3b2a5c6d02ed0.1591362033.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1c982d57-a446-b655-af95-1e4aeabf30ef@web.de>
Date:   Thu, 18 Jun 2020 22:59:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <32a6f11cc475f5292075093dcdc3b2a5c6d02ed0.1591362033.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Olqq4VqxoHqufAjhCvuhDZcAdSsWwlEVLjwaGSudfKTIo/jXc0U
 2qE3H92jCa1Mi0pAQ48pufXSpVLtJcA8YW+lT7RfTX5UVBctXLijk5gFoNaKfN329MxAI3A
 bAFlInLJ2BZ5BLIjrjbD6iBwWFZI9YY8ZVaHAhjx6jVvOx5LkvgBseG4xWbqLexXBlCy5cL
 AIW30vJiROvzJYpigqrww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GqAAvpwxlTc=:xhkolcXfnHbtiNOpbMunc7
 dIFjso5VEQIwfXlV2fhRZHtvvHsSaOnLB8R1bbrkHYYEEt7aq0ZL3Si7RQOFHjTkaQQ/qcFmP
 xtpcRP3cvv+qB6f433z9vJQMmOsxt7e3gOsGK/6pV4AUFRHfP7IiH3ZWo36LllifgCXb9+HyX
 94HcxKkt/LQc7XNAb5jJv/8jy82KBft2RYynAUTI1peq14Vsz2/afj0bx6gnoca6wJB4iPHlQ
 tYcehbMQZiAbHS55TUQWA03WXb9wkY/OYVwluYV4PY7MVVPiswEMSbbZ6CqhL7s+lJy2x6/zG
 gMrqO1ruVKr3Qb4SATkwfeDI0aQnsr8AWlJau7qsrBF5qj/CfAq4YUGEKbtVxlaVMlKUGI3L6
 xtKg1muwWtC22BAWWkQV3hogpTkmoMMgzqIkwni7H5Zf+o1BXOxwBG7ypECwOlJ1Y1DjmmzK7
 Wz1K6ponar14EbDucD61o4rcOnRoQu/Ei1hsEgIWe+Sw7uuqgSx2FANu30dI/yKIFmlpUrlRu
 1SixLjyBflsyNeV0A6TD96ZHxkTNUC8Ub43pxxF1CIDDkFA/Zq5KrXQh9RTEY5f+9Zq0Q5WhS
 rzCgAJcqJMKsKx217bEWQarUT3coJCwihdKVxTb6EJDywGWflkgM3XutykmHtofgsApQATK+H
 TbCKo3pkx2DlLrfpLyyAInjFQJCgxYCZgBUx7314NI96yabl/sGFuu6tcyNRho3ArXwAx1h+L
 HoRMY/Etz9dqEMVZ2s4L2/NTgBfvxk8iXTx3qVBjFl85kzHjCooMXw79ZM0NebkOMi/nSCn27
 lHRJVlqaZS8q/AbapMhUZspaYAlH65JlCeP57BK/Azm2AB01joGm4MY2xVXabKuGR8XPHCBN9
 gsOXT/FaxcWqfQ1iVoiwcEGTfmlfpZRCCqtJHc8yDuQ9xCQt2AfWknyS1cyEj4qfREFTfcR3m
 aDbszddGoVuTZ7ZWA4fhuuhJEvRhX7P3wrtDW6zdyAORtYaz0+JQJRm4lK41EZ40zofp6k1zv
 GrXXKEXwP2W35BuKBR2CLWX3gEnD+NaL0lTfHGH80AUtBltglQhD3tutyHg0GhG7vaBmT23ly
 rC3sWcToL+fRu7PTMZY43+Mqr/2LweqUOM0SdH5vlE8TLSz61ThzFzxMHXlf29ZvW53ut/aW3
 DruMWjXTE3uBr9m3AUPfxNIYCZQEtpUS9sovnmicbavO5TyzygTn3D1JoJuAbZeOU3ha8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.06.20 um 15:00 schrieb SZEDER G=C3=A1bor via GitGitGadget:
> From: =3D?UTF-8?q?SZEDER=3D20G=3DC3=3DA1bor?=3D <szeder.dev@gmail.com>
>
> clear_##slabname() frees only the memory allocated for a commit slab
> itself, but entries in the commit slab might own additional memory
> outside the slab that should be freed as well.  We already have (at
> least) one such commit slab, and this patch series is about to add one
> more.
>
> To free all additional memory owned by entries on the commit slab the
> user of such a slab could iterate over all commits it knows about,
> peek whether there is a valid entry associated with each commit, and
> free the additional memory, if any.  Or it could rely on intimate
> knowledge about the internals of the commit slab implementation, and
> could itself iterate directly through all entries in the slab, and
> free the additional memory.  Or it could just leak the additional
> memory...
>
> Introduce deep_clear_##slabname() to allow releasing memory owned by
> commit slab entries by invoking the 'void free_fn(elemtype *ptr)'
> function specified as parameter for each entry in the slab.

Adding a new function instead of extending the existing ones makes
sense, as this is a rare requirement.

>
> Use it in get_shallow_commits() in 'shallow.c' to replace an
> open-coded iteration over a commit slab's entries.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-slab-decl.h |  1 +
>  commit-slab-impl.h | 13 +++++++++++++
>  commit-slab.h      | 10 ++++++++++
>  shallow.c          | 14 +++++---------
>  4 files changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/commit-slab-decl.h b/commit-slab-decl.h
> index adc7b46c83b..286164b7e27 100644
> --- a/commit-slab-decl.h
> +++ b/commit-slab-decl.h
> @@ -32,6 +32,7 @@ struct slabname {							\
>  void init_ ##slabname## _with_stride(struct slabname *s, unsigned strid=
e); \
>  void init_ ##slabname(struct slabname *s);				\
>  void clear_ ##slabname(struct slabname *s);				\
> +void deep_clear_ ##slabname(struct slabname *s, void (*free_fn)(elemtyp=
e *ptr)); \
>  elemtype *slabname## _at_peek(struct slabname *s, const struct commit *=
c, int add_if_missing); \
>  elemtype *slabname## _at(struct slabname *s, const struct commit *c);	\
>  elemtype *slabname## _peek(struct slabname *s, const struct commit *c)
> diff --git a/commit-slab-impl.h b/commit-slab-impl.h
> index 5c0eb91a5d1..557738df271 100644
> --- a/commit-slab-impl.h
> +++ b/commit-slab-impl.h
> @@ -38,6 +38,19 @@ scope void clear_ ##slabname(struct slabname *s)			\
>  	FREE_AND_NULL(s->slab);						\
>  }									\
>  									\
> +scope void deep_clear_ ##slabname(struct slabname *s, void (*free_fn)(e=
lemtype *)) \
> +{									\
> +	unsigned int i;							\
> +	for (i =3D 0; i < s->slab_count; i++) {				\
> +		unsigned int j;						\
> +		if (!s->slab[i])					\
> +			continue;					\
> +		for (j =3D 0; j < s->slab_size; j++)			\
> +			free_fn(&s->slab[i][j * s->stride]);		\
> +	}								\
> +	clear_ ##slabname(s);						> +}									\


Why pass an elemtype pointer to the callback function instead of
a plain elemtype?  Because it matches the return type of _at() and
_peek().  Consistency, good.  Handing it a pointer allows the
callback to pass it on to free(), though, which would be bad,
since we do that in clear_() as well.  Hmm.

> +									\
>  scope elemtype *slabname## _at_peek(struct slabname *s,			\
>  						  const struct commit *c, \
>  						  int add_if_missing)   \
> diff --git a/commit-slab.h b/commit-slab.h
> index 05b3f2804e7..8e72a305365 100644
> --- a/commit-slab.h
> +++ b/commit-slab.h
> @@ -47,6 +47,16 @@
>   *
>   *   Call this function before the slab falls out of scope to avoid
>   *   leaking memory.
> + *
> + * - void deep_clear_indegree(struct indegree *, void (*free_fn)(int*))
> + *
> + *   Empties the slab, similar to clear_indegree(), but in addition it
> + *   calls the given 'free_fn' for each slab entry to release any
> + *   additional memory that might be owned by the entry (but not the
> + *   entry itself!).
> + *   Note that 'free_fn' might be called even for entries for which no
> + *   indegree_at() call has been made; in this case 'free_fn' is invoke=
d
> + *   with a pointer to a zero-initialized location.
>   */
>
>  #define define_commit_slab(slabname, elemtype) \
> diff --git a/shallow.c b/shallow.c
> index 7fd04afed19..c4ac8a73273 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -84,6 +84,10 @@ int is_repository_shallow(struct repository *r)
>   * supports a "valid" flag.
>   */
>  define_commit_slab(commit_depth, int *);
> +static void free_depth_in_slab(int **ptr)
> +{
> +	FREE_AND_NULL(*ptr);
> +}

Why FREE_AND_NULL?  The original loop below called free().  The slabs
are all released by deep_clear_() immediately after the callbacks are
done anyway, so what's the point in zeroing these pointers?

>  struct commit_list *get_shallow_commits(struct object_array *heads, int=
 depth,
>  		int shallow_flag, int not_shallow_flag)
>  {
> @@ -150,15 +154,7 @@ struct commit_list *get_shallow_commits(struct obje=
ct_array *heads, int depth,
>  			}
>  		}
>  	}
> -	for (i =3D 0; i < depths.slab_count; i++) {
> -		int j;
> -
> -		if (!depths.slab[i])
> -			continue;
> -		for (j =3D 0; j < depths.slab_size; j++)
> -			free(depths.slab[i][j]);
> -	}
> -	clear_commit_depth(&depths);
> +	deep_clear_commit_depth(&depths, free_depth_in_slab);

What a relief!

>
>  	return result;
>  }
>

