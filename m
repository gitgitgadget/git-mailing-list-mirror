From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH] bisect--helper: `bisect_clean_state` shell function
 in C
Date: Mon, 30 May 2016 23:48:17 +0200
Message-ID: <CAP8UFD2wAKN2CsfndLNeCb1dAEH5H-wj_6spAm+d_AtBQDZfhQ@mail.gmail.com>
References: <20160530182148.18801-1-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 23:48:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7V32-000760-Bo
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 23:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162528AbcE3VsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 17:48:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35803 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162396AbcE3VsU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 17:48:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id e3so26462577wme.2
        for <git@vger.kernel.org>; Mon, 30 May 2016 14:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=2shcD9rs5g5jxJ2y6buQcWx9euNjN0xkwWuJ26BiIvs=;
        b=h+s5E4k/Gi3O/OQc9afkdp0hvo+l1Y3SlCv7hCa1TWBenlGuV+HnHxhxN0W9nTBnDN
         2NBC6ZBCiatxqVGKWkk+EjskUR1PXRheGxgiKFz8m1ybVf/v1IlRhBBEuh7spEFodigl
         bLltILo/lMcP0R4LR8ZXp9q/Uacn62xnsywWxTd2F8Q9If2CtrNLSf6/FO9xTY4I94Xu
         LgbSsnGfhtEK6G1pRn9R01wyCXI9UVL4cUSx6ENncrWWbZS1ZpKKpeQJ45DfLuOwxitb
         xK8NW9iaj33sbjJZmccUFS8BwjBkXnTWBRL503MpkD+zMCrfrN3d6NanaT/acFU1Ay80
         KBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=2shcD9rs5g5jxJ2y6buQcWx9euNjN0xkwWuJ26BiIvs=;
        b=VH9VzWY6uIhggSiAtYCNfE9sxLPY9zWzROcT3NeCjiJ9sahvifWD+qXxkwI9n3tURd
         WjkaCqfQoRhjnXznt6/ueJiT1qsahhPG+Vi0VSksMZWkvET+6GStQeTq2I0+SY1dXnFT
         0AvuU30doild4npTiKy8AiMO9Afq9HzpcgCbMSLaCLPa/Fkseuf9x+rJwnLfAz+v3dCN
         7eQ6Pzw1R/T8PMFUgOOGuxh8GAwn4SQ2CQ+PmFxCS+A1GOAtYzUbegDBUxll69251XxI
         yLomh9+2wseUChNPGokXZnevEOjH2mWweNwNurumZvxOQIVgMuzUHJBpVcbVKNh06ktt
         7Bsw==
X-Gm-Message-State: ALyK8tJiG9SbaEmD0GmvU0gH3f8b8epVgkybTCU4LaQ6mEqA0/My7PxIvbj8omcmXl7D4hulEKHOmMFsY9Hr5A==
X-Received: by 10.195.17.166 with SMTP id gf6mr28149697wjd.124.1464644897740;
 Mon, 30 May 2016 14:48:17 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Mon, 30 May 2016 14:48:17 -0700 (PDT)
In-Reply-To: <20160530182148.18801-1-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295933>

On Mon, May 30, 2016 at 8:21 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> ---
> This patch contains a bug. I have tried to identify the bug and I suppose it
> exists in do_for_each_entry_in_dir(). I have reproduced the debugging session
> at this link[1]. I have seen that some patches in mailing list regarding
> iterating over refs. Will those affect this? Or is this bug fixed in those
> patches?
>
> [1]: http://paste.ubuntu.com/16830752/

The debug session seems to use code source from a previous version of
this patch.
Also it is not cear in which context you run git under gdb. What have
you done before?
And we don't see a crash. Could you show the crash and run the "bt"
command in gdb to get a backtrace?

> @@ -79,11 +90,42 @@ int write_terms(const char *bad, const char *good)
>         strbuf_release(&content);
>         return (res < 0) ? -1 : 0;
>  }
> +
> +int remove_bisect_ref(const char *refname, const struct object_id *oid,
> +                      int flag, void *cb_data)
> +{
> +       char *ref;
> +       ref = xstrfmt("refs/bisect/%s", refname);

You could save one line by concatenating the 2 above lines.

> +       if (delete_ref(ref, oid->hash, flag))
> +               return error(_("couldn't delete the ref %s\n"), ref);
> +       return 0;

You need to free "ref".

> +}

Thanks,
Christian.
