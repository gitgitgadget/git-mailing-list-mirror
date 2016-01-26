From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 13/15] ref-filter: introduce remote_ref_atom_parser()
Date: Mon, 25 Jan 2016 19:28:32 -0500
Message-ID: <CAPig+cTLxhrh3d0ouGLGq+ke8mzFKqCz0ABAECSA4vS+=epv9Q@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
	<1451980994-26865-14-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 01:28:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNrUs-0000iO-00
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 01:28:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899AbcAZA2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 19:28:35 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34191 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbcAZA2d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 19:28:33 -0500
Received: by mail-vk0-f68.google.com with SMTP id e6so6362012vkh.1
        for <git@vger.kernel.org>; Mon, 25 Jan 2016 16:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=fKhndKl5LViZefWAqsVmuqzsfFtT52eH3m2u+K0KR1A=;
        b=gfQLywaYQeWg1UDwiiwr1q8vL97xmXFF/FNlLXGOJd4mtV1HJNScy2beoMEIfy6G91
         zkB5eejPT3usC4xmmtZPLqvZf1knTVNcwjpIC6veqaMBwukW92nBUxywgEqTfXVnU02M
         ku30wMkYdikJXlFYvKEKG0UzqBw/dp0Q9+N85PuBonMcL2g4+buo+ODRTQLL1DEPpG6g
         SOJQ3g9k36ggqBYe8DlcBvUg7ziAWCvwJMaDio7tsIClM2ekhtiyhjOOfIMCdsZSHWAK
         gvNuJQ0zWEunB4H7VCGEpWuZYdkCjTB298D6lixsdEsYYOa+qRvFj4RjrJnqrL/kM7bG
         +OQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=fKhndKl5LViZefWAqsVmuqzsfFtT52eH3m2u+K0KR1A=;
        b=mFgAu0fzf3XA9ZLtzgGkA3u5ZRXjJutaiFpHcPkMu4UUq5DutfFKRbbMIqBUXvJLkb
         pOhy24QfHcJKKjaR1o2ywDniM+SST/Lw5VmgvqNWZkS/OiVIchlp2nRZHu6KCdcDAJjn
         v0tHXvZpp9Ok9jZFpLMGJ42tG3k5ZcIAzUanrTmmnKSRd7/DIAAFP8ZJBTalD1lKiDzj
         L2Xx1ZlEciEtyMx/qS5/2gD7wBl3hjgX+QeXfnntQzwWW1KLpgRm/2NerRMuhoB6Nf4W
         hIYngD53cM3EPw/G7G/btQZbLaVpqxr8lfj/tP1zXHNaEwCgV3D5MKU3gDZ1cA0R0lMs
         nAJA==
X-Gm-Message-State: AG10YORrUedi5S0Msiq0eLQSP/X8Q6nxIZHNKt+jrDuQlq7aC8EFxkrIR77ZNz9Wb8zAM3ca6BiqTeFENATy8w==
X-Received: by 10.31.182.143 with SMTP id g137mr12298436vkf.45.1453768112654;
 Mon, 25 Jan 2016 16:28:32 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 25 Jan 2016 16:28:32 -0800 (PST)
In-Reply-To: <1451980994-26865-14-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: Vt47iqCFMb89mUqywFIIkoYjaAI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284771>

On Tue, Jan 5, 2016 at 3:03 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce remote_ref_atom_parser() which will parse the '%(upstream)'
> and '%(push)' atoms and store information into the 'used_atom'
> structure based on the modifiers used along with the corresponding
> atom.
>
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -841,6 +863,43 @@ static inline char *copy_advance(char *dst, const char *src)
> +static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
> +                                   struct branch *branch, const char **s)
> +{
> +       int num_ours, num_theirs;
> +       if (atom->u.remote_ref == RR_SHORTEN)
> +               *s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
> +       else if (atom->u.remote_ref == RR_TRACK) {
> +               if (stat_tracking_info(branch, &num_ours,
> +                                      &num_theirs, NULL))
> +                       return;
> +
> +               if (!num_ours && !num_theirs)
> +                       *s = "";
> +               else if (!num_ours)
> +                       *s = xstrfmt("[behind %d]", num_theirs);
> +               else if (!num_theirs)
> +                       *s = xstrfmt("[ahead %d]", num_ours);
> +               else
> +                       *s = xstrfmt("[ahead %d, behind %d]",
> +                                    num_ours, num_theirs);
> +       } else if (atom->u.remote_ref == RR_TRACKSHORT) {
> +               if (stat_tracking_info(branch, &num_ours,
> +                                      &num_theirs, NULL))
> +                       return;
> +
> +               if (!num_ours && !num_theirs)
> +                       *s = "=";
> +               else if (!num_ours)
> +                       *s = "<";
> +               else if (!num_theirs)
> +                       *s = ">";
> +               else
> +                       *s = "<>";
> +       } else if (atom->u.remote_ref == RR_NORMAL)
> +               *s = refname;

I think I mentioned this in a previous review: If the code falls past
this final 'else if' for some reason (programmer error), then *s won't
get assigned at all, which is probably undesirable. To protect against
such a case, you might want either to add a final 'else':

    else
        die("BUG: ...");

or just consider RR_NORMAL the catchall case, and turn the final 'else
if' into a plain 'else':

    else /* RR_NORMAL */
        *s = refname;

> +}
> @@ -894,6 +953,8 @@ static void populate_value(struct ref_array_item *ref)
>                         refname = branch_get_upstream(branch, NULL);
>                         if (!refname)
>                                 continue;
> +                       fill_remote_ref_details(atom, refname, branch, &v->s);
> +                       continue;

There are now two 'continue' statements very close together here. Have
you considered this instead?

    if (refname)
        fill_remote_ref_details(...);
    continue;

It might make the code a bit more straightforward. (Genuine question;
I don't feel too strongly about it.)

>                 } else if (starts_with(name, "push")) {
>                         const char *branch_name;
>                         if (!skip_prefix(ref->refname, "refs/heads/",
> @@ -904,6 +965,8 @@ static void populate_value(struct ref_array_item *ref)
>                         refname = branch_get_push(branch, NULL);
>                         if (!refname)
>                                 continue;
> +                       fill_remote_ref_details(atom, refname, branch, &v->s);
> +                       continue;

Ditto.

>                 } else if (starts_with(name, "color:")) {
>                         v->s = atom->u.color;
>                         continue;
