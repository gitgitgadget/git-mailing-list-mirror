From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 05/19] mingw: prepare the TMPDIR environment variable for
 shell scripts
Date: Sun, 24 Jan 2016 21:11:39 -0500
Message-ID: <CAPig+cTF0r1Z_4wre57pZHvPXT00TvhYTKmdHfDfTBZzMwdo+A@mail.gmail.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
	<80795bee09974f4bec6bda75fe9cb17a4326bed1.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 03:11:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNWd6-0000ue-6e
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 03:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553AbcAYCLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 21:11:41 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:32786 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892AbcAYCLk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 21:11:40 -0500
Received: by mail-vk0-f67.google.com with SMTP id n1so5142772vkb.0
        for <git@vger.kernel.org>; Sun, 24 Jan 2016 18:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6VuqjHN75jZwLXEnnbSZ5sCfT82wqAgGOiRu9GDsNKY=;
        b=ML9KxfEqRrGTDqR4kRCVFqcTfC/c1CCM2D1g8MUwm7BWBWnFfYQWWLIZ2gyUKzcTnH
         XigsmQMKIzMBNyvxmaf+ut20IsGRZhRS4IHi1d8Z7CGwSPFAqFQiEPQPyjo/jQFH97c9
         nM4+MWnFqbqZqcXh5PAPAMPwR+GRPbyY6Mp8Ko30nTn/eOvJBAdC+4J1cXoRK4I61BNc
         Z7WvpcTrGp7fK0U2uJkNT1FXJIY4/LxmZPZcWfvpWvUq1HgMOsI9h3+YxA630g/DgxgX
         JrLgcjl6ODNbqFcJZTq30LM8b8HrKzxZj81yNWZFy/eb+wuMGY9QQvcJDBSJmCG1W47L
         xh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6VuqjHN75jZwLXEnnbSZ5sCfT82wqAgGOiRu9GDsNKY=;
        b=EOM3JlpUo1bNvDTDq3YLBq3O4GZtNM7HqzXs/f4wGqKDDdu7MmM+i62h7y8uZ+Tgci
         CJWOczbV0FVCQb2nya4+TIELED/RoUQYFOjqnlCsc85Ch66i0tSAz6TAl4t+ayvK9NTY
         d8PM9jCxVhVo3rtnbj0QhQUMya7f4a48jAFEdQWbTXpLxBfiOmDyIG3j+sH2XauSl/Ia
         DBorq0ZHiizs84TlcdDzbBy6afp7BXiWjJFD1Zis2iXrOjdi8tzn5Linnrl2Ly21OrqV
         iCN/hTiMv2+lVBdwjXP8tF1RXh34vA3HPxVoeS6DSuOeJsJT4/li8hVAKbh8AKAKsGK0
         9gIA==
X-Gm-Message-State: AG10YORluiLZR8wgMPM48Yk0HGGX7dtO1f0ahjilhsEXDuFXSlfvga8ExaCnT8qA3CyDZM8h51kjoDa7BmirEw==
X-Received: by 10.31.141.2 with SMTP id p2mr9485286vkd.37.1453687899147; Sun,
 24 Jan 2016 18:11:39 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 24 Jan 2016 18:11:39 -0800 (PST)
In-Reply-To: <80795bee09974f4bec6bda75fe9cb17a4326bed1.1453650173.git.johannes.schindelin@gmx.de>
X-Google-Sender-Auth: sqfSTu386PAY2xvFsDpbJqyyzZ8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284711>

On Sun, Jan 24, 2016 at 10:43 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> When shell scripts access a $TMPDIR variable containing backslashes,
> they will be mistaken for escape characters. Let's not let that happen
> by converting them to forward slashes.
>
> This partially fixes t7800 with MSYS2.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/compat/mingw.c b/compat/mingw.c
> @@ -2042,13 +2042,28 @@ int xwcstoutf(char *utf, const wchar_t *wcs, size_t utflen)
>  static void setup_windows_environment()
>  {
> +       char *tmp = getenv("TMPDIR");
> +
>         /* on Windows it is TMP and TEMP */
> -       if (!getenv("TMPDIR")) {
> -               const char *tmp = getenv("TMP");
> -               if (!tmp)
> +       if (tmp) {
> +               if (!(tmp = getenv("TMP")))
>                         tmp = getenv("TEMP");
> -               if (tmp)
> +               if (tmp) {
>                         setenv("TMPDIR", tmp, 1);
> +                       tmp = getenv("TMPDIR");
> +               }
> +       }

Let me see if I understand this...

In the original code, if TMPDIR was *not* set, it would assign the
value of TMP or TEMP to TEMPDIR.

The new code, however, checks TMP and TEMP only if TMPDIR is *already*
set. Am I reading this correctly? Is this revised behavior correct?

> +       if (tmp) {
> +               /*
> +                * Convert all dir separators to forward slashes,
> +                * to help shell commands called from the Git
> +                * executable (by not mistaking the dir separators
> +                * for escape characters).
> +                */
> +               for (; *tmp; tmp++)
> +                       if (*tmp == '\\')
> +                               *tmp = '/';

This transformation is performed on whatever memory was returned by
getenv(). It is also performed after setenv(), so presumably setenv()
isn't making a copy of the incoming string. Is that correct? Is it a
good idea to rely upon that detail of implementation (even if we
control the implementation, which I suppose is the case here)?

>         }
>
>         /* simulate TERM to enable auto-color (see color.c) */
> --
> 2.7.0.windows.1.7.g55a05c8
