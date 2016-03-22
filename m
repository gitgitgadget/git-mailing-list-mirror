From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] bisect--helper: convert a function in shell to C
Date: Mon, 21 Mar 2016 17:28:56 -0700
Message-ID: <CAGZ79kZveu07h_vERFpJekp4ayJwytwoNVG0LbhiaCnt4u-jRw@mail.gmail.com>
References: <010201539a8d2b8a-9f168d7a-d4c6-4c23-a61f-1ef6ee22f774-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 01:29:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiABx-0008Ib-OJ
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 01:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbcCVA26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 20:28:58 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36528 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbcCVA25 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 20:28:57 -0400
Received: by mail-ig0-f171.google.com with SMTP id nk17so83995969igb.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 17:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=gagsA7BSjeASj12VBmnPKZm1dWs/ZyKuJAFq3iHAVKg=;
        b=DyID7eU4eRgew8Dl66cbVXddfYJdfgcENAgd5TNw1zvQ8b12Lcdcffgx4hU/5wrSU9
         EEm9bFWhlli06YBvD0CN0hgbOmnBro2VJVdTA1fcdaxBionOXavnrMJN0PWNRgf0guMH
         MweXzVmY3V2uo+pIz5yTU7xjusD/F4Gkui4ApFKEcYD/sJEA4xi6KjCfm6MkFJZd3u3A
         cjhwwDdleFXEAxg+e5JfvzXt3H6JjdiopHewmtNT+kfE9TtYci7zdtn/zliJZJEjPzfy
         eOaBy3724E/hskkTrLviLk4mh6AiNmOxG3DJ4l4vYHucHKwS+E/NaxWnBw+1Dlm/ye5N
         lVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=gagsA7BSjeASj12VBmnPKZm1dWs/ZyKuJAFq3iHAVKg=;
        b=XU5yEauZovElgYM8htPGn0X6lw++45Ak1vtLaO5x1TI3visl5LZvct3AJ6WehPYAW+
         rEsxziwt2pLxRedZ6qaDTt6OaSaQx0sDDw8MpSM4jg4yskKBuOkAk5+nQ/ri5puxciWm
         NDnj0yl1j3p6BiA9go3qeQTAtlacMITcU0L8Go00Ho5JzAq+Uio9vleNJCNz56tOG9A+
         ibTFOGM1ClTsgOUZohcqLJgDLDa1qCZb+cCUi6M1go/mjS9nellGblm0igHQnihisjDM
         Dg6A06Fm1XscmKOH1U0dxMz9B2orbtCJ9ow+tZNLNt/M9M1eFYJattuLhcNZJgiK/d8n
         06uA==
X-Gm-Message-State: AD7BkJK6B8mgZyjOUocbXjUkxv7n+MHmTveRN0E0w1jdlFhFNbrPbURGOJe5GqkVRtNCC8kGSKic6PuvTaE1/9O+
X-Received: by 10.50.13.34 with SMTP id e2mr9351752igc.85.1458606536883; Mon,
 21 Mar 2016 17:28:56 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Mon, 21 Mar 2016 17:28:56 -0700 (PDT)
In-Reply-To: <010201539a8d2b8a-9f168d7a-d4c6-4c23-a61f-1ef6ee22f774-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289477>

On Mon, Mar 21, 2016 at 12:00 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Convert the code literally without changing its design even though it
> seems that its obscure as to the use of comparing revision to different bisect
> arguments which seems like a problem in shell because of the way
> function arguments are handled.

How would I use the C version instead of the shell version now?
I'd imagine you'd want to change calls in git-bisect.sh from
    check_term_format <term> <bad/new>
to be:
    git bisect--helper check_term_format <term> <bad/new>
and "git bisect--helper" would then call the new static method?
Once you have the C version working (do we need additional tests
or can we rely on the test suite being enough for now?),
you can also delete the shell version.

Thanks,
Stefan

>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
>  builtin/bisect--helper.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 3324229..61abe68 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -2,12 +2,35 @@
>  #include "cache.h"
>  #include "parse-options.h"
>  #include "bisect.h"
> +#include "refs.h"
>
>  static const char * const git_bisect_helper_usage[] = {
>         N_("git bisect--helper --next-all [--no-checkout]"),
>         NULL
>  };
>
> +static int check_term_format(const char *term, const char *revision, int flag) {
> +       if (check_refname_format(term, flag))
> +               die("'%s' is not a valid term", term);
> +
> +       if (!strcmp(term, "help") || !strcmp(term, "start") ||
> +               !strcmp(term, "skip") || !strcmp(term, "next") ||
> +               !strcmp(term, "reset") || !strcmp(term, "visualize") ||
> +               !strcmp(term, "replay") || !strcmp(term, "log") ||
> +               !strcmp(term, "run"))
> +               die("can't use the builtin command '%s' as a term", term);

"terms" is missing?

eval_gettext would translate into C as
    die (_("translatable message"));


> +
> +       if (!strcmp(term, "bad") || !strcmp(term, "new"))
> +               if(strcmp(revision, "bad"))
> +                       die("can't change the meaning of term '%s'", term);
> +
> +       if (!strcmp(term, "good") || !strcmp(term, "old"))
> +               if (strcmp(revision, "good"))
> +                       die("can't change the meaning of term '%s'", term);
> +
> +       return 1;

Why 1? Usually we use 0 for success in C. die(...) returns with non zero,
so having 0 here would help us in the shell code to see if the C version
died (or not).

> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>         int next_all = 0;
>
> --
> https://github.com/git/git/pull/216
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
