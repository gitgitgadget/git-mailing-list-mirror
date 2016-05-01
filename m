From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 55/83] builtin/apply: make parse_single_patch() return -1
 on error
Date: Sun, 1 May 2016 15:32:28 -0400
Message-ID: <CAPig+cSTf+9GJ9r4VZ9A98vQyyzqdGQFbihw2aAtB9sHM4tFCQ@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-56-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 01 21:32:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awx6e-0000bc-Qd
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 21:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbcEATca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 15:32:30 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:32953 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbcEATc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 15:32:29 -0400
Received: by mail-ig0-f195.google.com with SMTP id rc4so7668522igc.0
        for <git@vger.kernel.org>; Sun, 01 May 2016 12:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=yhMpAFra9wJd7xzVKChM0W/HSNZsRpODLy6/q3g0tR0=;
        b=m7KyToDldRNpMBGsu8/11+KN8LTON9GpKKOau7fq+EXUkREOYh4wOKe9XTfpU5L9w8
         iOIIqzZ+aCv6IzcL+Tb4zpNtZOutSm3O8otnjV4Od8zaDEr8vlSq4aEpNS29J9v+5+q9
         vWkBNk/KklT5CukeAR9/QpOJ2uSNjixAJFVQA4QIQOy4/4HowW0baLXsI7UH+87iOyPi
         M+9BVzbg1nWGppnnyRJcnYfQo5Ge/onLyRBBv/W7hm2hxLF8QP7qTlk00VR62v1mWyKR
         Ju9P8VVfa3rmYc4ekPfuarPbfyu8tzSMYqU/AUe2m60TuUKQXoABBIeZQU9h1q6R3uUS
         RXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=yhMpAFra9wJd7xzVKChM0W/HSNZsRpODLy6/q3g0tR0=;
        b=PA4dI6ATZ/g+ra/DhWAgZzrO7orDO3W6R9UApbFjzwsLkhBVWZKQYgAdPlKmYE0Vt6
         mRKcW4vb75mDdCSjT9s6yKDYlzd7rNq9RHM/7/Iq3+8bvqivXZWx63xERGkTgqtwor64
         IUj6Vh0y5hs4bVm+Ep9K7s5FUSN59GlOcXSyJGT0+QygailPTI+1aCPBpGPHcQCWDhn6
         wtJQYj6N5oL6LRDLgVzXJqQhh4c6AQ3FhoMASbT8ZLi509UxC/KrWHIY4fftQyfDQxqm
         lQNr9FEvG7OrwVzEpDyGS2kZc6AHOu2ImBUl+VWfxSOKnb/QZwktCfX6hfINu6AykUWT
         I8bg==
X-Gm-Message-State: AOPr4FWoisIoD1XCmIoszyItOy/RYrPm8heMEeusZUkfZAaEunHwyYBT4OdpPZkiAPc+6JrQraBGu9tJSWOJZg==
X-Received: by 10.50.224.148 with SMTP id rc20mr3024950igc.73.1462131148364;
 Sun, 01 May 2016 12:32:28 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 1 May 2016 12:32:28 -0700 (PDT)
In-Reply-To: <1461504863-15946-56-git-send-email-chriscool@tuxfamily.org>
X-Google-Sender-Auth: z6GRUpqLUTj34Bwp3dzBic2k-i4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293210>

On Sun, Apr 24, 2016 at 9:33 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/builtin/apply.c b/builtin/apply.c
> @@ -1802,8 +1806,10 @@ static int parse_single_patch(struct apply_state *state,
>                 fragment = xcalloc(1, sizeof(*fragment));
>                 fragment->linenr = state->linenr;
>                 len = parse_fragment(state, line, size, patch, fragment);
> -               if (len <= 0)
> -                       die(_("corrupt patch at line %d"), state->linenr);
> +               if (len <= 0) {
> +                       free(fragment);
> +                       return error(_("corrupt patch at line %d"), state->linenr);

No fragment leak here, okay.

> +               }
>                 fragment->patch = line;
>                 fragment->size = len;
>                 oldlines += fragment->oldlines;
> @@ -1839,9 +1845,9 @@ static int parse_single_patch(struct apply_state *state,
>                 patch->is_delete = 0;
>
>         if (0 < patch->is_new && oldlines)
> -               die(_("new file %s depends on old contents"), patch->new_name);
> +               return error(_("new file %s depends on old contents"), patch->new_name);
>         if (0 < patch->is_delete && newlines)
> -               die(_("deleted file %s still has contents"), patch->old_name);
> +               return error(_("deleted file %s still has contents"), patch->old_name);

These two return -1 and don't manually release the fragments, which
might seem like a leak, however...

>         if (!patch->is_delete && !newlines && context)
>                 fprintf_ln(stderr,
>                            _("** warning: "
> @@ -2143,6 +2149,9 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
>                                        size - offset - hdrsize,
>                                        patch);
>
> +       if (patchsize < 0)
> +               return -1;

This forwards -1 to its caller, and the caller, apply_patch() does
release the fragments when it sees -1, so there does not seem to be
any (new) leak. Good.
