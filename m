From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 08/24] Extract function should_expire_reflog_ent()
Date: Fri, 12 Dec 2014 12:02:09 -0800
Message-ID: <CAGZ79kYYoJL4oXzTq0w7rV-qVfdn0HnDGCua1ONd5MKD91PJ-Q@mail.gmail.com>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
	<1418374623-5566-9-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 12 21:02:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzWPo-0002RU-6A
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 21:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbaLLUCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 15:02:11 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:39889 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbaLLUCK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 15:02:10 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so3081340igb.4
        for <git@vger.kernel.org>; Fri, 12 Dec 2014 12:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=m3mL9zWYj8dBwH0/ZDLEHgPBJeLBJZlgwkEk3ZLQmoQ=;
        b=Fpmet6aJwWf5UDuCTDNHWQmrNo+y+O4AVsdbys21qdR+S2bJ+E7McBlhHVgrV6fSRa
         JRHNM7KCbsVFgWY66Tftp3EHeiSHS3KHoRbN+d+luofF+H/GDfho327Mf/Ty3eFo6sii
         ZAG7b9z4PCfQvlSBbVvGG9teZR+sCEklBdrgzQ+NtifT/Pj2ncqLia1/2EZqsecDZDci
         6F7anqJ6XpRwiOUrqCe8ekuPs7vYkSd8jXIzaS2RZPIzMrUROUADbc8r2NiGbavGO7zK
         xPychsVmE8LsseGPwIcvsHsd5NtBzIKQdagoYHh1QdKzYQFIiPTZgiUyG+Cj+wHDpcn1
         m3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=m3mL9zWYj8dBwH0/ZDLEHgPBJeLBJZlgwkEk3ZLQmoQ=;
        b=K+jZ4tZMgpP3YzF4BAAAkiJF0XJVIS0grVyPqhSbwND2Lrc/G3wazTjO4xHng0+1sx
         hqnT5aFIKKi2bN8KZgwktT0rRv6z7edy9NDpBEYT6fBUVm5bTHZK6FXf9ffo6FBTj5LM
         hQuC1NtJROIjfSM0kEQxCulDkjUkP+g56J4Mo+Z19SzRwQ0DQWVT0VmfEKGWFkfRMu49
         IJel6eYfqhlgEUtEwKzeosBHLL1o4BAWCe5ciUjlbZhQFAcVav9s22QNAJsdCQN2zjvl
         X/ptzBMC7IouS9U3g9vsVc3AcBfTX/ZoVciAseJYfiQMMgXIuIys+tGOODWnfKqIq2dj
         0gZw==
X-Gm-Message-State: ALoCoQlQRJJm9BayY5hiv/iTqbeSGvsCnBc7PhfIsfoNyDZvEDrhI6vBypPqLvu3P5/YdiPKYh4G
X-Received: by 10.107.25.74 with SMTP id 71mr10235146ioz.70.1418414529963;
 Fri, 12 Dec 2014 12:02:09 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Fri, 12 Dec 2014 12:02:09 -0800 (PST)
In-Reply-To: <1418374623-5566-9-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261365>

On Fri, Dec 12, 2014 at 12:56 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Extract from expire_reflog_ent() a function that is solely responsible
> for deciding whether a reflog entry should be expired. By separating
> this "business logic" from the mechanics of actually expiring entries,
> we are working towards the goal of encapsulating reflog expiry within
> the refs API, with policy decided by a callback function passed to it
> by its caller.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Reviewed-by: Stefan Beller <sbeller@google.com>

> ---
>  builtin/reflog.c | 70 +++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 42 insertions(+), 28 deletions(-)
>
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index ba5b3d3..06ce8b1 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -288,51 +288,65 @@ static int unreachable(struct expire_reflog_cb *cb, struct commit *commit, unsig
>         return !(commit->object.flags & REACHABLE);
>  }
>
> -static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
> -               const char *email, unsigned long timestamp, int tz,
> -               const char *message, void *cb_data)
> +/*
> + * Return true iff the specified reflog entry should be expired.
> + */
> +static int should_expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
> +                                   const char *email, unsigned long timestamp, int tz,
> +                                   const char *message, void *cb_data)
>  {
>         struct expire_reflog_cb *cb = cb_data;
>         struct commit *old, *new;
>
>         if (timestamp < cb->cmd->expire_total)
> -               goto prune;
> -
> -       if (cb->cmd->rewrite)
> -               osha1 = cb->last_kept_sha1;
> +               return 1;
>
>         old = new = NULL;
>         if (cb->cmd->stalefix &&
>             (!keep_entry(&old, osha1) || !keep_entry(&new, nsha1)))
> -               goto prune;
> +               return 1;
>
>         if (timestamp < cb->cmd->expire_unreachable) {
>                 if (cb->unreachable_expire_kind == UE_ALWAYS)
> -                       goto prune;
> +                       return 1;
>                 if (unreachable(cb, old, osha1) || unreachable(cb, new, nsha1))
> -                       goto prune;
> +                       return 1;
>         }
>
>         if (cb->cmd->recno && --(cb->cmd->recno) == 0)
> -               goto prune;
> -
> -       if (cb->newlog) {
> -               char sign = (tz < 0) ? '-' : '+';
> -               int zone = (tz < 0) ? (-tz) : tz;
> -               fprintf(cb->newlog, "%s %s %s %lu %c%04d\t%s",
> -                       sha1_to_hex(osha1), sha1_to_hex(nsha1),
> -                       email, timestamp, sign, zone,
> -                       message);
> -               hashcpy(cb->last_kept_sha1, nsha1);
> -       }
> -       if (cb->cmd->verbose)
> -               printf("keep %s", message);
> +               return 1;
> +
>         return 0;
> - prune:
> -       if (!cb->newlog)
> -               printf("would prune %s", message);
> -       else if (cb->cmd->verbose)
> -               printf("prune %s", message);
> +}
> +
> +static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
> +               const char *email, unsigned long timestamp, int tz,
> +               const char *message, void *cb_data)
> +{
> +       struct expire_reflog_cb *cb = cb_data;
> +
> +       if (cb->cmd->rewrite)
> +               osha1 = cb->last_kept_sha1;
> +
> +       if (should_expire_reflog_ent(osha1, nsha1, email, timestamp, tz,
> +                                    message, cb_data)) {
> +               if (!cb->newlog)
> +                       printf("would prune %s", message);
> +               else if (cb->cmd->verbose)
> +                       printf("prune %s", message);
> +       } else {
> +               if (cb->newlog) {
> +                       char sign = (tz < 0) ? '-' : '+';
> +                       int zone = (tz < 0) ? (-tz) : tz;
> +                       fprintf(cb->newlog, "%s %s %s %lu %c%04d\t%s",
> +                               sha1_to_hex(osha1), sha1_to_hex(nsha1),
> +                               email, timestamp, sign, zone,
> +                               message);
> +                       hashcpy(cb->last_kept_sha1, nsha1);
> +               }
> +               if (cb->cmd->verbose)
> +                       printf("keep %s", message);
> +       }
>         return 0;
>  }
>
> --
> 2.1.3
>
