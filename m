Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1897A1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 12:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbeHMPYs (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 11:24:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:40913 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbeHMPYr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 11:24:47 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNw0t-1fnFQo2PRz-007X5E; Mon, 13
 Aug 2018 14:42:33 +0200
Date:   Mon, 13 Aug 2018 14:42:39 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 8/8] diff.c: rewrite emit_line_0 more understandably
In-Reply-To: <20180810223441.30428-9-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1808131429550.71@tvgsbejvaqbjf.bet>
References: <20180810223441.30428-1-sbeller@google.com> <20180810223441.30428-9-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:za4pJMNmmuXvxa7i5kWcuWsOEB+4Yj8JyuXtYow3u+QlMiMZZ+q
 SSEbUj6bWcCGyTlQCpUPlux4eC0+UZUkoCMmBNCxfPpkhlakgD6i50E5WkgRZ4+3Vz9KKg/
 wnO8kG8eujJ2fKvcA6Jzwu1sxNUbFpPG7COJq+KtR20Y+dgS5o7Ux7lyRI/qTOCOtnT9sQ7
 VxsPUAk4VXFDsiCfVDJwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BHw5zAuv4BY=:yDTk/lAso0AeSJawjXbEHY
 N/Rs0Z+wLOVVjW7QWZO5VrEKwpgBUYq0en9lJ7ihRBrwB7YflioQukC3anhKAlmymL74hhOq+
 Qo36Tr+0llRgjrH5btDjH4LlsedPx5Bu2p6GglpsbaeImd4q334X93G0xkyI7cMks8WZeN8QS
 tDPJvcYdB94l7nIm7sr/EFqi5UOGfy9StUKKJqUsNiEgGa+mnr91QPoHceNU1gRe0MwWG6Wgk
 2rOpYVcd9gGMBLaRmXv3zRXaQTvJ8QGL1JkOjbBGmDJWWIwmUuuZy5xl0tMl9GhIgdCwJL9Fs
 TCxBFk1T/Wk0ACX+7I7Br9QCJt1njMQIryV33TT4h3/8q0zXgcI9wofXzchxvQqAqg7TrNRNk
 T4QLi2/pRN0rr+vDS7Pxepsh6nxtDBZSz+UVMWOvHxPSaLTXAfyOi1NmJuSX/rd0BfK1fjsjN
 T1QXCtNVql1D3yrX7f4RksZn251d6q1anWEWPNnUOoZvZ9qh4qQ3tMhv+1ACD3SZ1c2Vv2UrW
 d/XhIzcVJDmimyOL1pBV2sjUvkbuk4Fr+1HA4W0xkjtle/juButnjjFD54ihFo8AjbbsagbBt
 WbA/d21YGGnc986ZtnRmd4wUkv7gzlFzN/YCvouAOYSKql4GK5OmpV1CPNLLZskZbpcn4YNib
 ObI4HF014levXVSHa3MWOVDl/CM4WruhCmIM3NaACriL26675WhsIu5bzfmjumDFYsDPIQ+su
 WQjSfKNDZofdxUJkr3++uKJbIyA5HNICtv5wELe243Gd15qJMFXtRsGYmdI+r6vHWIYTZNone
 Yx+ocgk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 10 Aug 2018, Stefan Beller wrote:

> emit_line_0 has no nested conditions, but puts out all its arguments
> (if set) in order.

Well, currently `emit_line_0()` *has* nested conditions: `first == '\n'`
inside `len == 0`.

And these nested conditions make things hard to read, so resolving that
to a simpler workflow makes a ton of sense. You can sell that better by
starting the commit message with something along the lines that you are
making the overly complex logic easier to follow.

> There is still a slight confusion with set and set_sign, but let's defer
> that to a later patch.

There is no later patch in this here patch series. I would therefore
appreciate it if you could spend the paragraph or two on explaining
yourself here.

> 'first' used be output always no matter if it was 0, but that got lost

s/used be/used to be/

> at "diff: add an internal option to dual-color diffs of diffs",
> 2018-07-21), as there we broadened the meaning of 'first' to also
> signal an early return.

Did we? I thought we introduced the possibility of passing *just* a first
character or *just* a "rest of the line". I might misremember, though.

> The change in 'emit_line' makes sure that 'first' is never content, but

<tongue-in-cheek>Awwww, you want to make 'first' sad all the time? That's
not nice of you...</tongue-in-cheek>

Seriously again, the adjective "content" has a different meaning than the
noun and this ambiguity made this sentence very hard for me to parse.

> always under our control, a sign or special character in the beginning
> of the line (or 0, in which case we ignore it).

It would be good to reword this paragraph to say that from now on, we will
only pass a diff marker as `first`, or 0.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  diff.c | 73 +++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 41 insertions(+), 32 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index e50cd312755..af9316c8f91 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -626,43 +626,52 @@ static void emit_line_0(struct diff_options *o,
>  			int first, const char *line, int len)
>  {
>  	int has_trailing_newline, has_trailing_carriage_return;
> -	int nofirst;
>  	int reverse = !!set && !!set_sign;
> +	int needs_reset = 0;
> +
>  	FILE *file = o->file;
>  
>  	fputs(diff_line_prefix(o), file);
>  
> -	if (len == 0) {
> -		has_trailing_newline = (first == '\n');
> -		has_trailing_carriage_return = (!has_trailing_newline &&
> -						(first == '\r'));
> -		nofirst = has_trailing_newline || has_trailing_carriage_return;
> -	} else {
> -		has_trailing_newline = (len > 0 && line[len-1] == '\n');
> -		if (has_trailing_newline)
> -			len--;
> -		has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
> -		if (has_trailing_carriage_return)
> -			len--;
> -		nofirst = 0;
> -	}
> -
> -	if (len || !nofirst) {
> -		if (reverse && want_color(o->use_color))
> -			fputs(GIT_COLOR_REVERSE, file);
> -		if (set_sign || set)
> -			fputs(set_sign ? set_sign : set, file);
> -		if (first && !nofirst)
> -			fputc(first, file);
> -		if (len) {
> -			if (set_sign && set && set != set_sign)
> -				fputs(reset, file);
> -			if (set)
> -				fputs(set, file);
> -			fwrite(line, len, 1, file);
> -		}
> -		fputs(reset, file);
> +	has_trailing_newline = (len > 0 && line[len-1] == '\n');
> +	if (has_trailing_newline)
> +		len--;
> +
> +	has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
> +	if (has_trailing_carriage_return)
> +		len--;
> +
> +	if (!len && !first)
> +		goto end_of_line;
> +
> +	if (reverse && want_color(o->use_color)) {

Since you implied `reverse` to mean that a non-`NULL` `set` *as well as*
`set_sign` were passed in, and since a non-`NULL` `set` *implies* that we
want color, you could drop that `want_color(o->use_color)` here.

But as I stated above, I am not a fan of having such unintuitive
implications in the code.

> +		fputs(GIT_COLOR_REVERSE, file);
> +		needs_reset = 1;
> +	}
> +
> +	if (set_sign || set) {
> +		fputs(set_sign ? set_sign : set, file);
> +		needs_reset = 1;
>  	}
> +
> +	if (first)
> +		fputc(first, file);
> +
> +	if (!len)
> +		goto end_of_line;
> +
> +	if (set) {
> +		if (set_sign && set != set_sign)
> +			fputs(reset, file);
> +		fputs(set, file);
> +		needs_reset = 1;
> +	}
> +	fwrite(line, len, 1, file);
> +	needs_reset |= len > 0;

First of all, this should be a `||=`, not a `|=`.

And then, this code is skipped by the `if (!len) goto end_of_line;` part
above, so `len > 0` is *always* 1 at this point.

But then, I wonder why we bother all that much. After all, we want to
reset whenever we used color. So why not simply initialize

	int need_reset = reverse || set_sign || set;

and be done with it?

Thanks,
Dscho

> +
> +end_of_line:
> +	if (needs_reset)
> +		fputs(reset, file);
>  	if (has_trailing_carriage_return)
>  		fputc('\r', file);
>  	if (has_trailing_newline)
> @@ -672,7 +681,7 @@ static void emit_line_0(struct diff_options *o,
>  static void emit_line(struct diff_options *o, const char *set, const char *reset,
>  		      const char *line, int len)
>  {
> -	emit_line_0(o, set, NULL, reset, line[0], line+1, len-1);
> +	emit_line_0(o, set, NULL, reset, 0, line, len);
>  }
>  
>  enum diff_symbol {
> -- 
> 2.18.0.865.gffc8e1a3cd6-goog
> 
> 
