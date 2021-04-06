Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE57C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 18:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D45C1613BE
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 18:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbhDFSep (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 14:34:45 -0400
Received: from mout.web.de ([212.227.17.12]:36581 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233673AbhDFSeo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 14:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1617734062;
        bh=nDetoD3ch+FBJksItsCcNXWTnyF0BdHvsWN16dxSmW0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=m0ZMP99FXKIh0qp1m+PNL0c6lMGaec8UyZdufjkaAp2PxeabB/L4+vLUzfMrf6Dyv
         cx5gNfuvvLf7fYsqEmY9GduZMwobxKRLdL384Pt0zwvfgpXaLa9PnVY/fKO0XR9kIL
         zImeDJgpIe1tBdho9gmtTPLtDdwcA+nc+TmZ5z2U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MI3p7-1lP9xZ2Fnj-00FBn2; Tue, 06 Apr 2021 20:34:22 +0200
Subject: Re: [PATCH] [GSOC] ref-filter: use single strbuf for all output
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.927.git.1617631280402.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c70a7c17-650a-ae4d-9a90-66c3511f8371@web.de>
Date:   Tue, 6 Apr 2021 20:34:21 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <pull.927.git.1617631280402.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qw7i0Ds1IG8RQEqOBLIASxe5BR7U/PRynMZXuBYceTjUlAWa/lC
 slWe4DoTmGwDmfE42B5AKmJQeGqyQzrImvO9VWGxHHcV//8oZOwiiA7co8iZO4/S31qFzfa
 TUpsubO9r4zq8QBR40w3r+iOCNq3UtoluU1JPZfX2NsbBkleKcJsnApMpHSf251wBykssuq
 6KnQZ3DATk29na4m0AipQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TltTxgmS358=:1T4NIWopbSKiw5RknIlaHZ
 IlaFscurqZ0J+mO84c6Hkaa8D9ggEvmhnFeyrDn/CC0wNMiGoce0KgVbtXrqe1R5Q0CMv5c05
 W3yuXCLXbEHQ2DpJJID33srAEZdqLMR79IB+smbiTIGZ5ka0QqlylWX9jAGnr1ULiW8d1VUeW
 lOTr2/xnbotdGmMwYXsJxiNt8MA0/J9SLudXgZP3aaDQOLu456Z2QD0/KiXkpUhhAN2Yr3kXC
 tGqFnzn/qtVspd/aOL2+91JEoNG0mEZ/8IqNkU3inLvm2xDFyDLEjT4ihhj9DwiT7F16Ps9ly
 TmCTWrTA2rgc/nnghPEErLp6qhZYCGlsHrrKfVg1FStM4VVEzq159SAXa9RL14LqsitkWdFri
 B2yugXZXmrIhiP0Y8/KiCz25J6zUyqC425q5gmoPuvMoEyJ6ltesBfLojsAuuHO5UDBU+rQ7P
 XXzmSxpQ9zUN3rgpliHjlOLD3qOphflkmGQ8DYg4ltkEeuLR79VHyiqjt9ZX8DzagwAeIMUaT
 hYCfTG/mbkFX6baz1jo/UY4hsJwK5BiQTEZE1DIQsGaDCoUpRIp3oAa5wGoKXo4WpB5rQ3n+6
 aWxFaSpuYY7ePOge8kRFvvcjIHNUkEkNLDFx+H/J0F6A0190GUZUbrcArTf+wH7Zt1BcDN5F+
 96MW20fsFvHE7Pj5DTMVatkFtAFo2myrNaiZztIFKIm6CP9Wa6Q3nvIWe2trdtJrdDLSaohha
 KF4fIEUGRvOueXy6gcIUECnWd0DZpVJzA/wgGgWPTpVwgFdPfYl61QVZ7JkvlwmzGjTWjUDr3
 YVJmENMSWiV+vAd10WEk5FAUUcEdwpnMh9OqCOWX+3hH2QQRfbTVr77jbt8fewDWyhlFXbmb/
 erIFY3ERjLv9hnU9qGWU1YTGphajm1hH/kcefl0A4mAL4DhOD2fDlPQEE6cLAWsufXaxRz8jF
 775clek2sSJHwQDRCMceuM6cenBxZy1ZoLXuEvyuyTez84mzKfA54nYW5JQSta67An8o2aBBe
 mpwOsPD+kfZxrCBfaWKVhxvUVIFacW8Y3GahIjLBxt0YnHKnoeeWNCXaJ23MYWRLnokSUSYQ+
 XxFqaujQnOBYtMxToGjCmmeNFoOKO7APIBesHDg11ijtfoyMF9fEUF5eDB8x+HnYD/9YAfVgD
 IaJlVV8SgEG95Q9nWP/fmxfqZCU19urNDkyjSQA7FjmGJHxeMfIDAFw/KMLPr66e6bANw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.04.21 um 16:01 schrieb ZheNing Hu via GitGitGadget:
> From: ZheNing Hu <adlternative@gmail.com>
>
> When we use `git for-each-ref`, every ref will call
> `show_ref_array_item()` and allocate its own final strbuf
> and error strbuf. Instead, we can provide two single strbuf:
> final_buf and error_buf that get reused for each output.
>
> When run it 100 times:
>
> $ git for-each-ref
>
> on git.git :
>
> 3.19s user
> 3.88s system
> 35% cpu
> 20.199 total
>
> to:
>
> 2.89s user
> 4.00s system
> 34% cpu
> 19.741 total
>
> The performance has been slightly improved.

I like to use hyperfine (https://github.com/sharkdp/hyperfine) to get
more stable benchmark numbers, incl. standard deviation.  With three
warmup runs I get the following results for running git for-each-ref on
Git's own repo with the current master (2e36527f23):

  Benchmark #1: ./git for-each-ref
    Time (mean =C2=B1 =CF=83):      18.8 ms =C2=B1   0.3 ms    [User: 12.7=
 ms, System: 5.6 ms]
    Range (min =E2=80=A6 max):    18.2 ms =E2=80=A6  19.8 ms    148 runs

With your patch on top I get this:

  Benchmark #1: ./git for-each-ref
    Time (mean =C2=B1 =CF=83):      18.5 ms =C2=B1   0.4 ms    [User: 12.3=
 ms, System: 5.6 ms]
    Range (min =E2=80=A6 max):    17.8 ms =E2=80=A6  19.6 ms    147 runs

So there seems to be a slight improvement here, but it is within the
noise.

I'm quite surprised how much longer this takes on your machine, however,
and (like Peff already mentioned) how much of the total time it spends
in system calls.  Is an antivirus program or similar interferring?  Or
some kind of emulator or similar, e.g. Valgrind?  Or has it been a long
time since you ran "git gc"?

The benchmark certainly depends on the number of local and remote
branches in the repo; my copy currently has 4304 according to
"git for-each-ref | wc -l".

>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     [GSOC] ref-filter: use single strbuf for all output
>
>     This patch learned Jeff King's optimization measures in git
>     cat-file(79ed0a5): using a single strbuf for all objects output Inst=
ead
>     of allocating a large number of small strbuf for every object.
>
>     So ref-filter can learn same thing: use single buffer: final_buf and
>     error_buf for all refs output.
>
>     Thanks.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-927%2F=
adlternative%2Fref-filter-single-buf-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-927/adlte=
rnative/ref-filter-single-buf-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/927
>
>  builtin/for-each-ref.c |  4 +++-
>  builtin/tag.c          |  4 +++-
>  ref-filter.c           | 21 ++++++++++++---------
>  ref-filter.h           |  5 ++++-
>  4 files changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index cb9c81a04606..9dc41f48bfa0 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -22,6 +22,8 @@ int cmd_for_each_ref(int argc, const char **argv, cons=
t char *prefix)
>  	struct ref_array array;
>  	struct ref_filter filter;
>  	struct ref_format format =3D REF_FORMAT_INIT;
> +	struct strbuf final_buf =3D STRBUF_INIT;
> +	struct strbuf error_buf =3D STRBUF_INIT;
>
>  	struct option opts[] =3D {
>  		OPT_BIT('s', "shell", &format.quote_style,
> @@ -81,7 +83,7 @@ int cmd_for_each_ref(int argc, const char **argv, cons=
t char *prefix)
>  	if (!maxcount || array.nr < maxcount)
>  		maxcount =3D array.nr;
>  	for (i =3D 0; i < maxcount; i++)
> -		show_ref_array_item(array.items[i], &format);
> +		show_ref_array_item(array.items[i], &format, &final_buf, &error_buf);

This user of show_ref_array_item() calls it in a loop on an array.

>  	ref_array_clear(&array);
>  	return 0;
>  }
> diff --git a/builtin/tag.c b/builtin/tag.c
> index d403417b5625..8a38b3e2de34 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -39,6 +39,8 @@ static int list_tags(struct ref_filter *filter, struct=
 ref_sorting *sorting,
>  		     struct ref_format *format)
>  {
>  	struct ref_array array;
> +	struct strbuf final_buf =3D STRBUF_INIT;
> +	struct strbuf error_buf =3D STRBUF_INIT;
>  	char *to_free =3D NULL;
>  	int i;
>
> @@ -64,7 +66,7 @@ static int list_tags(struct ref_filter *filter, struct=
 ref_sorting *sorting,
>  	ref_array_sort(sorting, &array);
>
>  	for (i =3D 0; i < array.nr; i++)
> -		show_ref_array_item(array.items[i], format);
> +		show_ref_array_item(array.items[i], format, &final_buf, &error_buf);

Dito.

>  	ref_array_clear(&array);
>  	free(to_free);
>
> diff --git a/ref-filter.c b/ref-filter.c
> index f0bd32f71416..51ff6af64ebc 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2436,16 +2436,16 @@ int format_ref_array_item(struct ref_array_item =
*info,
>  }
>
>  void show_ref_array_item(struct ref_array_item *info,
> -			 const struct ref_format *format)
> +			 const struct ref_format *format,
> +			 struct strbuf *final_buf,
> +			 struct strbuf *error_buf)
>  {
> -	struct strbuf final_buf =3D STRBUF_INIT;
> -	struct strbuf error_buf =3D STRBUF_INIT;
>
> -	if (format_ref_array_item(info, format, &final_buf, &error_buf))
> -		die("%s", error_buf.buf);
> -	fwrite(final_buf.buf, 1, final_buf.len, stdout);
> -	strbuf_release(&error_buf);
> -	strbuf_release(&final_buf);
> +	if (format_ref_array_item(info, format, final_buf, error_buf))
> +		die("%s", error_buf->buf);
> +	fwrite(final_buf->buf, 1, final_buf->len, stdout);
> +	strbuf_reset(error_buf);
> +	strbuf_reset(final_buf);
>  	putchar('\n');
>  }
>
> @@ -2453,9 +2453,12 @@ void pretty_print_ref(const char *name, const str=
uct object_id *oid,
>  		      const struct ref_format *format)
>  {
>  	struct ref_array_item *ref_item;
> +	struct strbuf final_buf =3D STRBUF_INIT;
> +	struct strbuf error_buf =3D STRBUF_INIT;
> +
>  	ref_item =3D new_ref_array_item(name, oid);
>  	ref_item->kind =3D ref_kind_from_refname(name);
> -	show_ref_array_item(ref_item, format);
> +	show_ref_array_item(ref_item, format, &final_buf, &error_buf);

This third and final caller works with a single item; there is no loop.

>  	free_array_item(ref_item);
>  }
>
> diff --git a/ref-filter.h b/ref-filter.h
> index 19ea4c413409..95498c9f4467 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -120,7 +120,10 @@ int format_ref_array_item(struct ref_array_item *in=
fo,
>  			  struct strbuf *final_buf,
>  			  struct strbuf *error_buf);
>  /*  Print the ref using the given format and quote_style */
> -void show_ref_array_item(struct ref_array_item *info, const struct ref_=
format *format);
> +void show_ref_array_item(struct ref_array_item *info,
> +			 const struct ref_format *format,
> +			 struct strbuf *final_buf,
> +			 struct strbuf *error_buf);

This bring-your-own-buffer approach pushes responsibilities back to
the callers, in exchange for improved performance.  The number of
users of this interface is low, so that's defensible.  But that added
effort is also non-trivial -- as you demonstrated by leaking the
allocated memory. ;-)

How about offering to do more instead?  In particular you could add
a count parameter and have show_ref_array_item() handle an array of
struct ref_array_item objects.  It could reuse the buffers internally
to get the same performance benefit, and would free callers from
having to iterate loops themselves.  Something like:

	void show_ref_array_items(struct ref_array_item **info,
				  size_t n,
				  const struct ref_format *format);

Callers that deal with a single element can pass n =3D 1.

Perhaps the "format" parameter should go first, like with printf.

The double reference in "**info" is a bit ugly, though (array of
pointers instead of a simple array of objects).  That's dictated
by struct ref_array_item containing a flexible array member, which
seems to be hard to change.

>  /*  Parse a single sort specifier and add it to the list */
>  void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *a=
tom);
>  /*  Callback function for parsing the sort option */
>
> base-commit: 2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48
>

