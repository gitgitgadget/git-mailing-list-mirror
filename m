From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?"] Implement better chunk heuristics.
Date: Thu, 14 Apr 2016 17:26:52 -0700
Message-ID: <CA+P7+xqEPq=G_PMA-=h6jzWaUP=6hmWXcLzxbogs2PyuAZcn4g@mail.gmail.com>
References: <CAGZ79ka8pgPNZKaVWnsa_S07esxkN9nJfhcMZvCfd5U6MtsrYQ@mail.gmail.com>
 <20160415000730.26446-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Davide Libenzi <davidel@xmailserver.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 02:27:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqrbR-0005SE-PJ
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 02:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbcDOA1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 20:27:13 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:32880 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489AbcDOA1N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 20:27:13 -0400
Received: by mail-ig0-f171.google.com with SMTP id kb1so4887945igb.0
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 17:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=brcWLArEzqxPXJtapIrgU2jo4e5sPnedLje/pJlvRos=;
        b=TSdhEDHnySPhyZnA3BXZh0tpCaO6SBD3b9xlIKaOCJdHClMAq3ctOnPj8nxosB6ipI
         lcgflD+SiUPVvVa2JgY5AZY0D7zRW7WfQI85IT44/HFieSG22TIacowwkU+bREJ8zgUJ
         1ZtbsWFLjJtAbstnzkB7YlWvFA8XsBl7DB9/ecgjzgItXK+RAwRsbAA5mlQkgyDzJSU5
         FFw9jEX26Rs0Yd9Dm3vFWfRF284BhU2/8hqn0a9gyUa8uOBsQNwIbD3W/HGPfnQOSDUd
         vp4led1jgJWAFC+1bACCJ9+rL4WJnzaof80as+W2Zr0Hu0nC4eLUbugf5MTwNLxRzA9b
         A9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=brcWLArEzqxPXJtapIrgU2jo4e5sPnedLje/pJlvRos=;
        b=Cn3IZ0SFPHF2aaTytmY9UK7Ud14AYrGUnrAzOyXeyc8+g2UYXiC8ehbh1n0hwg6E+e
         hH90ByIH3MXWv3DDnhkkqiG5vo56vC6015NOlIofmh15K4N54H1E9gOK0Q6e1hQE8dND
         n5c3sJpZ5rbYsk+glUB0WVFRtyuoygTl1oEJg67QET1LSStD153uBikQ55wzviWG38gk
         2mEwzKbSdkxFCthA2q2Jp7DXqWYSbU6GIJNqT+Lj0CpDaWAARS0CuI72qvNrK+SJZsJB
         uiZV3swWgsz2j+xrkzLaPZ5eoPUCDCGfrtWg8VsWAShlfOAPIMXLKty0m6tuTDHvq2l7
         yhjg==
X-Gm-Message-State: AOPr4FWuEk35LOXWAkD++l1WjCcpp4UvUe71VqNAPmDZYdfJ0IWzxFSLSe3yOYNw4d+AsdgK+hLzBsNt3oUF1Q==
X-Received: by 10.50.97.70 with SMTP id dy6mr1422918igb.73.1460680031695; Thu,
 14 Apr 2016 17:27:11 -0700 (PDT)
Received: by 10.107.59.78 with HTTP; Thu, 14 Apr 2016 17:26:52 -0700 (PDT)
In-Reply-To: <20160415000730.26446-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291584>

On Thu, Apr 14, 2016 at 5:07 PM, Stefan Beller <sbeller@google.com> wrote:
> TODO(sbeller):
> * describe the discussion on why this is better
> * see if this can be tested?
>

Thanks for taking time to do this! It looks like a few things are
still missing, CRLF obviously, and making it a configuration option.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  xdiff/xdiffi.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 2358a2d..24eb9a0 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -400,9 +400,16 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
>  }
>
>
> +static int starts_with_emptyline(const char *recs)
> +{
> +       return recs[0] == '\n'; /* CRLF not covered here */
> +}
> +
> +
>  int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>         long ix, ixo, ixs, ixref, grpsiz, nrec = xdf->nrec;
>         char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
> +       unsigned char has_emptyline;
>         xrecord_t **recs = xdf->recs;
>
>         /*
> @@ -436,6 +443,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>
>                 do {
>                         grpsiz = ix - ixs;
> +                       has_emptyline = 0;
>
>                         /*
>                          * If the line before the current change group, is equal to
> @@ -447,6 +455,8 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>                                 rchg[--ixs] = 1;
>                                 rchg[--ix] = 0;
>
> +                               has_emptyline |=
> +                                       starts_with_emptyline(recs[ix]->ptr);

I assume you're doing |= so that we don't overwrite the empty line
setting each loop here to 0 when it's false? That's a bit subtle, and
it took me a moment to figure out, since I am used to thinking of it
as bitwise | and not a boolean or like we're intending here (though
obviously we're using bitwise to perform that intended behavior).

>                                 /*
>                                  * This change might have joined two change groups,
>                                  * so we try to take this scenario in account by moving
> @@ -475,6 +485,9 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>                                 rchg[ixs++] = 0;
>                                 rchg[ix++] = 1;
>
> +                               has_emptyline |=
> +                                       starts_with_emptyline(recs[ix]->ptr);
> +
>                                 /*
>                                  * This change might have joined two change groups,
>                                  * so we try to take this scenario in account by moving
> @@ -498,6 +511,32 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>                         rchg[--ix] = 0;
>                         while (rchgo[--ixo]);
>                 }
> +
> +               /*
> +                * If a group can be moved back and forth, see if there is an
> +                * empty line in the moving space. If there is an empty line,
> +                * make sure the last empty line is the end of the group.
> +                *
> +                * As we shifted the group forward as far as possible, we only
> +                * need to shift it back if at all.
> +                */
> +               if (has_emptyline) {
> +                       while (ixs > 0 && recs[ixs - 1]->ha == recs[ix - 1]->ha &&
> +                              xdl_recmatch(recs[ixs - 1]->ptr, recs[ixs - 1]->size, recs[ix - 1]->ptr, recs[ix - 1]->size, flags) &&
> +                              !starts_with_emptyline(recs[ix - 1]->ptr)) {
> +                               rchg[--ixs] = 1;
> +                               rchg[--ix] = 0;
> +
> +                               /*
> +                                * This change did not join two change groups,
> +                                * as we did that before already, so there is no
> +                                * need to adapt the other-file, i.e.
> +                                * running
> +                                *     for (; rchg[ixs - 1]; ixs--);
> +                                *     while (rchgo[--ixo]);
> +                                */
> +                       }
> +               }
>         }

And this was the more difficult part which I wasn't able to fully
understand how to do. It seems pretty reasonable. I think we can make
it configurable by using a new XDIFF flag similar to how we handle
various diff options like the different diff algorithms, and then we
could add tests specific to ensure that the flag enables the behavior
we want on some known test cases.

I am not really sure how to thoroughly test it beyond that though.

Regards,
Jake

>
>         return 0;
> --
> 2.8.1.474.gffdc890.dirty
>
