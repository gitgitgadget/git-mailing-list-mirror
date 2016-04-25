From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 61/83] builtin/apply: libify check_apply_state()
Date: Mon, 25 Apr 2016 20:26:37 +0700
Message-ID: <CACsJy8AVVNOPfuAqSKKP-V2hTxHM-iYagXXa3j88GsEt3t7Ckw@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org> <1461504863-15946-62-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 15:27:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1augXm-0001wr-JN
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 15:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbcDYN1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 09:27:12 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34878 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932599AbcDYN1J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 09:27:09 -0400
Received: by mail-lf0-f53.google.com with SMTP id c126so116902400lfb.2
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W+xSeuq0dyjcq1bGxJEGiNsVInp7iF2pRWug7Lq1kk0=;
        b=IdQCZM8tst6fGRu0EOMGCipPG5NmQdtcrXVZBSgMvvndMYYixBhhNVG+91V8OYAhBX
         7pzeL/kqiSQkPH8+NX7GGP8qQdhgBTeZrqfueSiKZw5mFIAxC0vb8p3RHq1rJrBtJjN5
         Im9mmS8y2/JHAlJ0op5pOfQkidPH9Tus1Xw0EQHCP2nIngcbtzDhYhKbWc0mKLNIA4hk
         5OtiMrr3vhTWa8YLtbMUMk8FryPVfzquH6xKCWoKaOBVfWb7bAqUfqyIFKx8ONYQxf9g
         b23ze3uql56wF9sLGaHIyc3s/+gzXFusddzZy7+hciBfTE+TLvmM6pRAm7pJTc5uose/
         vV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W+xSeuq0dyjcq1bGxJEGiNsVInp7iF2pRWug7Lq1kk0=;
        b=PX9JGVkx654eAyX03f0ZsD3+5QM2pO7tNlbB+wG6HUU0SA/pSdmsnU3fOpIHWHumu5
         ceyON+cQ1J4k372OXQVr0wvBX9OjSOqfAwLE5FyX6p6FPtXv1415s2uDqZLzdsPWcDsH
         xRCZ5L7Xtkzx40Uge0+iRPNHbK7mrIEYWsH09jX5rT3WLnekDPAv3WtbyVxS/sx53mV1
         ypNTabnJyWHBF26Wqn7h/sic2jOcKQpQcOlwdqV7HKqwl/N6oHGkI1lj3nW52gjEZuZQ
         cKfAeV8CTcTiRwz84N1U5d8hTiWiWSbXKetMlIffo1/eP57pJwGlRVSnFPJQWkL78980
         7SoA==
X-Gm-Message-State: AOPr4FXy9kjM4E2PJ03uF/d2CqXJZ4eYjtrWoCPmlXJ9HaLX5chO8Jk1qhLSt+dujsunVPzuusgF1y6ervGc6g==
X-Received: by 10.25.211.75 with SMTP id k72mr13827672lfg.45.1461590827537;
 Mon, 25 Apr 2016 06:27:07 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Mon, 25 Apr 2016 06:26:37 -0700 (PDT)
In-Reply-To: <1461504863-15946-62-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292475>

On Sun, Apr 24, 2016 at 8:34 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/apply.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index e3ee199..7576ec5 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -4534,17 +4534,17 @@ static int option_parse_directory(const struct option *opt,
>         return 0;
>  }
>
> -static void check_apply_state(struct apply_state *state, int force_apply)
> +static int check_apply_state(struct apply_state *state, int force_apply)
>  {
>         int is_not_gitdir = !startup_info->have_repository;
>
>         if (state->apply_with_reject && state->threeway)
> -               die("--reject and --3way cannot be used together.");
> +               return error("--reject and --3way cannot be used together.");
>         if (state->cached && state->threeway)
> -               die("--cached and --3way cannot be used together.");
> +               return error("--cached and --3way cannot be used together.");

Sweet opportunity to _() these messages since it clear shows in this
patch that other messages of the same category are _()'d in this
function. Could be done as a separate patch. But I'm also ok if you
say "no".

>         if (state->threeway) {
>                 if (is_not_gitdir)
> -                       die(_("--3way outside a repository"));
> +                       return error(_("--3way outside a repository"));
>                 state->check_index = 1;
>         }
>         if (state->apply_with_reject)
> @@ -4552,14 +4552,15 @@ static void check_apply_state(struct apply_state *state, int force_apply)
>         if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
>                 state->apply = 0;
>         if (state->check_index && is_not_gitdir)
> -               die(_("--index outside a repository"));
> +               return error(_("--index outside a repository"));
>         if (state->cached) {
>                 if (is_not_gitdir)
> -                       die(_("--cached outside a repository"));
> +                       return error(_("--cached outside a repository"));
>                 state->check_index = 1;
>         }
>         if (state->check_index)
>                 state->unsafe_paths = 0;
> +       return 0;
>  }
-- 
Duy
