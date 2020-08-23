Return-Path: <SRS0=2KbR=CB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEE8C433E1
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 06:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CAD42074D
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 06:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="P0ZjnD4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgHWG00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Aug 2020 02:26:26 -0400
Received: from mout.web.de ([212.227.17.12]:51023 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHWG0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Aug 2020 02:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1598163979;
        bh=w1WtxTuCA4nrn5hWN9qmsOdtGWf2foQHOo7wCiSjX7w=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=P0ZjnD4++wnCMJbvHgk5o0nxGlYtgkoggx7Wq2Iij2NVroH6gg9U5hti7oW7K7a6z
         Eoxo/chE9zinpVMNbEU4j2YtO7M2DEPHX7upNmxTLEBEJWn93dbG5C10lA59zZFXD2
         1xnZXyMCQey3tLXF8WXOIw76dYGv5QcQPspbNtvM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ldn6l-1krd853Vsh-00izTk; Sun, 23
 Aug 2020 08:26:18 +0200
Subject: Re: [PATCH] Avoid infinite loop in malformed packfiles
To:     Ori Bernstein <ori@eigenstate.org>, git@vger.kernel.org
References: <20200823005236.10386-1-ori@eigenstate.org>
 <20200823031151.10985-1-ori@eigenstate.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <672843a1-b98c-7567-a078-a2dacd4b7074@web.de>
Date:   Sun, 23 Aug 2020 08:26:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200823031151.10985-1-ori@eigenstate.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:siibj9iixGH1JDcPREdXnL/IHlQijROoBrq2cmkJ0sDlSf9IjPS
 DYZrh7agqovwVygfgqM5OudkOn82ZZvkYATeLEsn7QSaOZWR9fvFR8ZsTa9/4/7ARgMu9Pk
 Dx7oC5c/85DIX/edfIx06/Oqhs62xeF+s2/nL2l8xuBo06nJ0x8gwiS6L7mhAz49+J7pAtU
 FgrbcVIFCnikasiimTDbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qKJYkWTQ/0A=:5NrNDvuBeBHKZjwO12u0mL
 sazzg57ZWf+7lDZ4xLJ2zsh0XuweF6X6ryBiISIkWQl0OY6cV1QcAkap/cGmcKem+H2Fe3flN
 pj3gXsYS/WePWvky+udeD+OqGLO11Kqi6xnVsvgOVdZaRsYMlyGEJ6HQ9Mc47P915KCK2hzUE
 QcqfwuoGFClj/M61G99OWRrKzDzYq8hagyXxFWYFZaGk7Lg4+chBNpHtxW9MoR//bY3vOPRzo
 4WW/1iz64UDmMijHXNebpnUmCjwmJC0gF/GuRKBUSto9pZr8yettSd9ba3yTkwOvhC0m0Y/i0
 BtoV+RhVwfvXNTNBZ4fZwnmNlHEt6h2HsSGeNWRnuolijkRPr1PuyACUZGTZ5wIDA25c5cilz
 rKcFOFnq39w3qQerE0/kFe9u+KEphRdVCl585enMVdlJSJnUmiW7XNJkVRN2a78quWz436pGg
 5MWuK1+XO2NtnjrEbpMGTWDoE2z4KMGra3Mzm610PXJn0cHJNFTimVX1SzOJdb2Nojt2x6RmM
 vm6kPQIFxpmrY6ID5A4QvY4xzKl07o7UqYEISkAYpkCBY+Qaaoe4W3d1J/mMcnt20mpipI5TC
 41W4radsXCI/fyO7bnkEDcvytFK313hvl3uWl1rd9RrLg2wUrEFDo7tgxxcnWZ9qGuPRB0B4A
 AM1oEbjLi776kfAwZYHzkyEnBU6lajBhmJZRSkNLrYJlvfH8Rb9DaHcVAbCGGYCoMpPeiposC
 IR4CW+mpVjntUN09jmD16U1HamC1Md5juk5DB1ieZjpIor9uUUDTvbibTHq+EUicduLKdUI7z
 fJNwXoQa9JOZFkdYS/32s4ODWANj017v3g0pnyyXKDTZvLG850fFoDkHlKzepHhwuh8lmDDQ3
 7MRsc+jsZKEADCMf2xXtOtuZLvQZY87a1zECSMspUVaFlSAVG4Cjbix+qRj/3+jFWpZlh7j6c
 uSHvUcAZl7IMizMZgSIj2ZlgZTmB+eMb8QLtGUU9rOIiYnjNCDbn/HMRdMcfmelqlSOtKgovz
 e5mb1FsKzs19YNI6rhw+VZJxBHaqv4hEqGxgNVliXDZg9Sic2jbS1Ek+6jhlE6NpodZwmQKS9
 RlRWvTdwE8QnG1rVlDkrANWYP8r+NAGVFdH0wUyGAN107/LStVjoyUvlrj+m7KFF6RxeVE53O
 +QapVo9cdgu444wo4E/kpEztwouOMjKJLt34Yr4Bg9pvvUbwl8iQ5DC7SpSK6HONlfPQrJ5xG
 cEmZaNK6Gcwsk28O6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.08.20 um 05:11 schrieb Ori Bernstein:
> In packfile.c:1680, there's an infinite loop that tries to get
> to the base of a packfile. With offset deltas, the offset needs
> to be greater than 0, so it's always walking backwards, and the
> search is guaranteed to terminate.
>
> With reference deltas, there's no check for a cycle in the
> references, so a cyclic reference will cause git to loop
> infinitely, growing the delta_stack infinitely, which will
> cause it to consume all available memory as as a full CPU
> core.

"as as"?  Perhaps "and"?

> This change puts an arbitrary limit of 10,000 on the number
> of iterations we make when chasing down a base commit, to
> prevent looping forever, using all available memory growing
> the delta stack.
>
> Signed-off-by: Ori Bernstein <ori@eigenstate.org>
> ---
>  packfile.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/packfile.c b/packfile.c
> index 6ab5233613..321e002c50 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1633,6 +1633,7 @@ static void write_pack_access_log(struct packed_gi=
t *p, off_t obj_offset)
>
>  int do_check_packed_object_crc;
>
> +#define UNPACK_ENTRY_STACK_LIMIT 10000

b5c0cbd8083 (pack-objects: use bitfield for object_entry::depth,
2018-04-14) limited the delta depth for new packs to 4095, so 10000
seems reasonable.  Users with unreasonable packs would need to repack
them with an older version of Git, though.  Not sure if that would
affect anyone in practice.

>  #define UNPACK_ENTRY_STACK_PREALLOC 64

Hmm, setting a hard limit may allow to allocate the whole stack on the,
ehm, stack.  That would get rid of the hybrid stack/heap allocation and
thus simplify the code a bit.  10000 entries with 24 bytes each would be
quite big, though, but that might be OK without recursion.  (And not in
this patch anyway, of course.)

>  struct unpack_entry_stack_ent {
>  	off_t obj_offset;
> @@ -1715,6 +1716,12 @@ void *unpack_entry(struct repository *r, struct p=
acked_git *p, off_t obj_offset,
>  			break;
>  		}
>
> +		if (delta_stack_nr > UNPACK_ENTRY_STACK_LIMIT) {
> +			error("overlong delta chain at offset %jd from %s",
> +			      (uintmax_t)curpos, p->pack_name);
> +			goto out;
> +		}

Other error handlers in this loop set data to NULL.  That's actually
unnecessary because it's NULL to begin with and the loop is exited after
setting it to some other value.  So not doing it here is fine.  (And a
separate cleanup patch could remove the dead stores in the other
handlers.)

> +
>  		/* push object, proceed to base */
>  		if (delta_stack_nr >=3D delta_stack_alloc
>  		    && delta_stack =3D=3D small_delta_stack) {
>

