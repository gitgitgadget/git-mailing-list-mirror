From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 53/83] builtin/apply: make find_header() return -1 instead
 of die()ing
Date: Wed, 27 Apr 2016 14:08:48 -0400
Message-ID: <CAPig+cRw7_6hbLZ7HfvCHwy7UcujnfOTToMSXaRbx30WTXvaQA@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-54-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Apr 27 20:09:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avTtV-0001nT-6x
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 20:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbcD0SIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 14:08:51 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33790 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839AbcD0SIt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 14:08:49 -0400
Received: by mail-io0-f194.google.com with SMTP id x35so7716350ioi.0
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 11:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=f8Pkx5GNhAviVSMX0Nq6oyR060J/aj/4nOsXzpQ5Wm8=;
        b=EAhdB45pi0iX+n7IG5aB8Not/90ajZ/y0zB0DlCvsBMcNl0TSyyetL8gBI4uTFdX8t
         wKn8H0T1uRRkrbeSZ0xH30tOWcAptT6WObMz73csHcm3wBNuPLVKBWEXUaw1fALODx+t
         yuF3Yy5DEj1bul6qTvo3LTMPD3ci0Z9TGsO4X4/GDA9r3/cJPxCX5yZ59LnaHOU8PLUF
         fn8/AbpfC8L84JBZTnOTBXCiUzJXLk2tVoDOCenbInQ9lu4igNiuvTW9ZQC+7QoyP1HO
         +dBuNdMezhtONsBytA+YSI9TxunbzWb683UuiHtkvVUe41CelCTnrL92GfsE2l7OvUaU
         AQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=f8Pkx5GNhAviVSMX0Nq6oyR060J/aj/4nOsXzpQ5Wm8=;
        b=TDK/nNCllG1pJeME/w5QGpUk4O7Imn6HF4VrwohkQZSNq6xbX7FG847BsVbs9D1Yfj
         z12fxvfxqhHBJqYxEZlv8N2CEPNe/ZKTCV4YNBd0jvs9IHo6U+EN31O5l9UpcijaaPzA
         HLfNRM+7NtYrNgRpMhNtX2uDVArucaLtGNFAqxnkkiVfKa3VN4XfdOS4sZh5A6Woxxe4
         nkP4+Q1nW7z9ZXqefhzPPjq6iykum5C+t+TFkXETduVTXFbcynM2o1Nn6P+CUTZAdm/0
         S+ExeEUTa5MqT4tyIChYiyhWOuNaWzkyPVGCIV1bChhWYXVPs7AOcGArdFG+WNdXiYvS
         HfyA==
X-Gm-Message-State: AOPr4FX1AFk7ShYU8v0iIM7FHVF7JpEhXTJ3Tx5I20+h4faweiYybmIhi3JxZA8TtoEgar2uqxSeTViEfKF9Cg==
X-Received: by 10.107.47.37 with SMTP id j37mr11570805ioo.168.1461780528274;
 Wed, 27 Apr 2016 11:08:48 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Wed, 27 Apr 2016 11:08:48 -0700 (PDT)
In-Reply-To: <1461504863-15946-54-git-send-email-chriscool@tuxfamily.org>
X-Google-Sender-Auth: swt_0CScYHvRgBqxEpBU7PgaZ88
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292780>

On Sun, Apr 24, 2016 at 9:33 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> To be compatible with the rest of the error handling in builtin/apply.c,
> find_header() should return -1 instead of calling die().
>
> Unfortunately find_header() already returns -1 when no header is found,
> so let's make it return -2 instead in this case.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/builtin/apply.c b/builtin/apply.c
> @@ -1588,18 +1596,18 @@ static int find_header(struct apply_state *state,
>                                 continue;
>                         if (!patch->old_name && !patch->new_name) {
>                                 if (!patch->def_name)
> -                                       die(Q_("git diff header lacks filename information when removing "
> -                                              "%d leading pathname component (line %d)",
> -                                              "git diff header lacks filename information when removing "
> -                                              "%d leading pathname components (line %d)",
> -                                              state->p_value),
> -                                           state->p_value, state->linenr);
> +                                       return error(Q_("git diff header lacks filename information when removing "
> +                                                       "%d leading pathname component (line %d)",
> +                                                       "git diff header lacks filename information when removing "
> +                                                       "%d leading pathname components (line %d)",
> +                                                       state->p_value),
> +                                                    state->p_value, state->linenr);
>                                 patch->old_name = xstrdup(patch->def_name);
>                                 patch->new_name = xstrdup(patch->def_name);
>                         }
>                         if (!patch->is_delete && !patch->new_name)
> -                               die("git diff header lacks filename information "
> -                                   "(line %d)", state->linenr);
> +                               return error("git diff header lacks filename information "
> +                                            "(line %d)", state->linenr);

I realize that the caller in this patch currently just die()'s, and I
haven't looked at subsequent patches yet, but is this new 'return'
going to cause the caller to start leaking patch->old_name and
patch->new_name which are xstrdup()'d just above?

>                         patch->is_toplevel_relative = 1;
>                         *hdrsize = git_hdr_len;
>                         return offset;
> @@ -2115,6 +2123,9 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
>         int hdrsize, patchsize;
>         int offset = find_header(state, buffer, size, &hdrsize, patch);
>
> +       if (offset == -1)
> +               exit(1);
> +
>         if (offset < 0)
>                 return offset;
