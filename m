From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] ref-filter.c: don't stomp on memory
Date: Sat, 6 Feb 2016 22:16:11 -0500
Message-ID: <CAPig+cT=h49xNTb=nu7+xvbOXAFoC0gyOW8R5tb-oosapN2eiA@mail.gmail.com>
References: <56B68E73.2050303@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: karthik nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 04:16:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSFpk-00067r-QJ
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 04:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbcBGDQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 22:16:13 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:33791 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbcBGDQM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 22:16:12 -0500
Received: by mail-vk0-f49.google.com with SMTP id k196so11180121vka.0
        for <git@vger.kernel.org>; Sat, 06 Feb 2016 19:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=AEDEFt0JpXqXoEwQ9NaKi+XycByWzfGU6A6Yh7DEP7s=;
        b=Q/P4TH1muYBCAodd8bY3fCfwry9GMlZOenKsb73xe9HJvL1zI3cOwfnHQiHQ6VMZMH
         efynKCVTWMjTj3tRWxYxHg+hG5fJmkXtwPfvtZqU1A5N97wJqb/QLwcOHSxFHzGExlQR
         ZbJuy3/ssG+ShUyMue8TOPbw7me7mfuCgveyeuHv6EvHPvoL/BGG2Od3qOfoVn9K6Eba
         k0ByWLJh7fxK+x5ygxuR5wuQveLkmRdJReCD6RgY6ZTJgf3WM+qXSdUVy9lDwCFclMh3
         cjOC2r0aOryyfMKCEDi7kk9RnH2bF4/Cj+XQ54MxzDMw6nRTYnjctzm3JR5IVd4pg4Jp
         0l6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=AEDEFt0JpXqXoEwQ9NaKi+XycByWzfGU6A6Yh7DEP7s=;
        b=fnXqAjBWtdwfjXPj+ireRbWG+jLVKzMw2GRyXP3EQD5ilDlUw9YvegKyryJaJacjpv
         R0f+WJyhjH7hvxAtLaXq+EsElrFx3tW0sATnw/aa+fAjNTLdhrW30wi8FxF3haA5nbC+
         y93/Y4KU1/S6FJT/nBcD29m5Cnz57gckvYnGONoVld7XJVNHcRl0XBXNF059zXPeWZCi
         +vFdOoKNgRVnZka+QiphLiJ3DIt3LzD93OvPj3kwXFZUH2xD9v7pvuxVHOYCeG5flR4e
         NCoHpjWMlci9RaS9GWCKp7m/41Iip4UkTURuiz1j1/axb5t7LEJT71E4A0yvBs0mRJnR
         6rTg==
X-Gm-Message-State: AG10YOQlXffQC+CbM3Hvx87j1BUzc7yf13RKhZDETXLMEkCf45G8JH15Pw8aDORTz8H18jVnx8qQ2AN4WIRuXA==
X-Received: by 10.31.168.76 with SMTP id r73mr15157662vke.117.1454814971438;
 Sat, 06 Feb 2016 19:16:11 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 6 Feb 2016 19:16:11 -0800 (PST)
In-Reply-To: <56B68E73.2050303@ramsayjones.plus.com>
X-Google-Sender-Auth: 44Lf3cEgQZWSuiAC-ejWkG42S6s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285709>

On Sat, Feb 6, 2016 at 7:23 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
> If you need to re-roll your 'kn/ref-filter-atom-parsing' branch, could
> you please squash this (or something like it) into the relevant patch
> (commit 6613d5f1, "ref-filter: introduce parsing functions for each valid
> atom", 31-01-2016).
>
> This evening, (by mistake!) I built the pu branch with -fsanitize=address
> in my CFLAGS. This resulted in many test failures, which were all caused
> by the memcmp() call below stomping all over memory.
>
> Hmm, as I was writing this email, I had a vague recollection of another
> email on the list recently mentioning this code. So, if this has already
> been reported, sorry for the noise!

You're probably thinking of [1]. Interestingly, the two proposed fixes
differ... (more below)

[1]: http://git.661346.n2.nabble.com/PATCH-v4-00-12-ref-filter-use-parsing-functions-td7646877i20.html#a7647418

> diff --git a/ref-filter.c b/ref-filter.c
> @@ -260,7 +260,8 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>                  * table.
>                  */
>                 arg = memchr(sp, ':', ep - sp);
> -               if ((!arg || len == arg - sp) &&
> +               if ((( arg && len == arg - sp)  ||
> +                    (!arg && len == ep - sp )) &&
>                     !memcmp(valid_atom[i].name, sp, len))
>                         break;
>         }

Your fix is pretty easy to to read and seems correct. Karthik's fix
required several re-reads, and I *think* it may be correct, however,
it's difficult to grok due to its logic inversion.

Aside from the two proposed fixes, a fix patterned after the original
code which patch 5/12 replaced would be even easier to understand.
That is, something like this:

    arg = memchr(...);
    if (!arg)
        arg = ep;
    if (len == arg - sp && !memcmp(...))
        ...
