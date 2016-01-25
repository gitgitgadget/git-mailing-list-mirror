From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 10/15] ref-filter: introduce parse_align_position()
Date: Mon, 25 Jan 2016 16:49:03 -0500
Message-ID: <CAPig+cSUBQiW396qyiczcdPV9qU9o_8imuL89O6jLWLY8sX2-A@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
	<1451980994-26865-11-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 22:50:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNp21-0003g1-IQ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 22:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbcAYVuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 16:50:37 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36607 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbcAYVtE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 16:49:04 -0500
Received: by mail-vk0-f65.google.com with SMTP id e64so6393766vkg.3
        for <git@vger.kernel.org>; Mon, 25 Jan 2016 13:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Qft1UOHDKV2hRVNz5FMooStyxbihyvHDJ5+LT2GraLw=;
        b=IXaUM7vOFbYZSJ0rwGK/XVBP9IRZHln5WvMCnrVvd3vwVqoOb4G7ReWjC5VtQudksj
         UYocDsRVmFQqYRJedP8xI319PGalZykx9wROY+2WEK9yJDiC+Ucb8B+YYowuKe1Chiqs
         FxLdD1K+AU/B3Sc6uiIxllZjLZ+VFBVtjQRRAmQs3FqZ5cdQc8XeBzybWqdJfC2dTyTM
         cwjWWL+wA9LSCWNVVfACYTvvBPgsWd8Dm451gKDzNbfhYWOTgHH/Lo8Q7+LLN97hmGXY
         tJglE8Vgx0PRvHNekLw578NSnrUHF1AE6wt6TUn/G/IZtm7yjZGNQCW0t3AZfhC6dJ/B
         1ivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Qft1UOHDKV2hRVNz5FMooStyxbihyvHDJ5+LT2GraLw=;
        b=hNcKKusHssNeEPkptHCdpV3m7Iy6x9fWMtDtb6N+Cv2QihFd6CAmmRSHma9qvGLA5N
         x98BOj6gGunVRzzUrXWZsymI6fuRhei/g1QlXvjQbmHX84vgXoUJ6+mEK3X0Gy3Yx3uA
         d2j3UBQG01qnLoBZ5X/fQtCr9wRyx5bXrCykZ4T2mXQKCog1kPZyormaR507mTK6EP+C
         eXnIlehwvOfOLKBFx+RR+3xFsYhGuUWA/KEJEeJqL0XlgYzPjHfajZ+CL0L1VcRXFOB7
         Av0wOlIHiNFkGyLZED3rqhb3S8cpEHcmzIby3egQHie2BaGXiVAVTKBz3VTVTuEnn+lz
         Io1w==
X-Gm-Message-State: AG10YOTXax6hDjmCx9snDdgWsaJkQIjicu4+KvtFMwClBw+dmIXHjBm5rMpSswTk1zmuHg6+GsL1/LIeXkzJZg==
X-Received: by 10.31.41.20 with SMTP id p20mr5916642vkp.151.1453758543926;
 Mon, 25 Jan 2016 13:49:03 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 25 Jan 2016 13:49:03 -0800 (PST)
In-Reply-To: <1451980994-26865-11-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: tSWZtJOG_2qjalshKQDSImbSZKI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284759>

On Tue, Jan 5, 2016 at 3:03 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> From align_atom_parser() form parse_align_position() which given a
> string would give us the alignment position. This is a preparatory
> patch as to introduce prefixes for the %(align) atom and avoid
> redundancy in the code.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -74,6 +74,17 @@ static void color_atom_parser(struct used_atom *atom)
> +static align_type parse_align_position(const char *s)
> +{
> +       if (!strcmp(s, "right"))
> +               return ALIGN_RIGHT;
> +       else if (!strcmp(s, "middle"))
> +               return ALIGN_MIDDLE;
> +       else if (!strcmp(s, "left"))
> +               return ALIGN_LEFT;
> +       return -1;
> +}

This code was just moved in patch 9/15 and is being relocated again
here in patch 10/15. If you change the order of the patches so that
this preparatory refactoring is done first, the diff of the "introduce
align_atom_parser()" patch will become smaller and be a bit easier to
review. (Plus it just makes sense to do preparation first.)

>  static void align_atom_parser(struct used_atom *atom)
>  {
>         struct align *align = &atom->u.align;
> @@ -90,16 +101,13 @@ static void align_atom_parser(struct used_atom *atom)
>         align->position = ALIGN_LEFT;
>
>         while (*s) {
> +               int position;
>                 buf = s[0]->buf;
>
>                 if (!strtoul_ui(buf, 10, (unsigned int *)&width))
>                         ;
> -               else if (!strcmp(buf, "left"))
> -                       align->position = ALIGN_LEFT;
> -               else if (!strcmp(buf, "right"))
> -                       align->position = ALIGN_RIGHT;
> -               else if (!strcmp(buf, "middle"))
> -                       align->position = ALIGN_MIDDLE;
> +               else if ((position = parse_align_position(buf)) >= 0)
> +                       align->position = position;
>                 else
>                         die(_("unrecognized %%(align) argument: %s"), buf);
>                 s++;
> --
> 2.6.4
