From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 18/19] pull --rebase: error on no merge candidate cases
Date: Wed, 3 Jun 2015 10:38:13 -0700
Message-ID: <CAGZ79kZN=1fzjSv-dSgq38CtEKTDxLMoPY8ToNfiEA8QDh3Xpg@mail.gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-19-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 19:39:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0CcO-0001jR-F8
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 19:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755349AbbFCRiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 13:38:16 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34284 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754913AbbFCRiP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 13:38:15 -0400
Received: by qkoo18 with SMTP id o18so9774960qko.1
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 10:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TF5EevIsNzz9iziR7vOYGrGTQ8mDUZPlbDR3zelNx4I=;
        b=XIR6LGj2WcDWYhSFbZIYuheFWL5PRoxEZ7SvSrjtf5N9WF9IJgFGlMtewyvVIZL7u2
         7YLITA/kIE54vBxxkqy7lbjnfyfAsF1MaRnrsNbEFfYHAUcgphV6la/kS8MVnH9syCXK
         sNASuByYSQpQAH0z/jwGpGvr6brIE882mLfmdVNV8D5MJVCiiBy70l8frqtbycgPZXfv
         Pn440w0K+lW0pgrEy3spMIyXm5rlEZxiOFCJW7CzUGIvAR/Cm5S71Xa4lRS+adh59mZl
         43Ej3Y1T+YfTKVpn+E2RY0TkNcIdjIwwiGCzgGgylg4Dz8mCtLPDjBpH8YDHRSV4Ovze
         GyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TF5EevIsNzz9iziR7vOYGrGTQ8mDUZPlbDR3zelNx4I=;
        b=ilUSIIgwQhyTwvb3iSK/TZ7IyaXnGaeP1vog/YbI/xvk2s5mK1DfDtswne/r371LfZ
         bUViIdllhVEIA61gPpvsUzxy6BAQ0Y8gecn9gZCGcbxcZGpdTvNcgpvutJWNlXgeMuqZ
         B3LzInKBaXr0KvvpCj2VZFhu6h9x6JluVevSVeyry3UvEXG74/RG83mpS0315rWPaAFs
         mAeIivIRibggdc9YMFuql/atCmJnVWpxwEbCtcTcq1RiTSwvMjW1yTM2gM9KSyXK5VkL
         5+dOq3Ynl2aC8O08h6UZraC/AVuUn6IkUSQljQDmUvJx0UldObPXT9zxNCteB2Zbucf1
         k38w==
X-Gm-Message-State: ALoCoQn2Ug7HRVkL0RmQjo2uacSOoH++ojtv5Fdu9/1EmC1FrndspI/CmkoDPAvAh8YU+3X9p7yT
X-Received: by 10.55.42.82 with SMTP id q79mr61703041qkh.84.1433353094111;
 Wed, 03 Jun 2015 10:38:14 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Wed, 3 Jun 2015 10:38:13 -0700 (PDT)
In-Reply-To: <1433314143-4478-19-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270707>

On Tue, Jun 2, 2015 at 11:49 PM, Paul Tan <pyokagan@gmail.com> wrote:
> Tweak the error messages printed by die_no_merge_candidates() to take
> into account that we may be "rebasing against" rather than "merging
> with".
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>
> Notes:
>     v2
>
>     * Decided to use fprintf_ln() for the sake of code consistency, and for
>       the added trailing newline.
>
>  builtin/pull.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index f5d437a..4e1ab5b 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -439,7 +439,10 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
>         const char *remote = curr_branch ? curr_branch->remote_name : NULL;
>
>         if (*refspecs) {
> -               fprintf_ln(stderr, _("There are no candidates for merging among the refs that you just fetched."));
> +               if (opt_rebase)
> +                       fprintf_ln(stderr, _("There is no candidate for rebasing against among the refs that you just fetched."));
> +               else
> +                       fprintf_ln(stderr, _("There are no candidates for merging among the refs that you just fetched."));
>                 fprintf_ln(stderr, _("Generally this means that you provided a wildcard refspec which had no\n"
>                                         "matches on the remote end."));
>         } else if (repo && curr_branch && (!remote || strcmp(repo, remote))) {
> @@ -449,7 +452,10 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
>                         repo);
>         } else if (!curr_branch) {
>                 fprintf_ln(stderr, _("You are not currently on a branch."));
> -               fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
> +               if (opt_rebase)
> +                       fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
> +               else
> +                       fprintf_ln(stderr, _("Please specify which branch you want to merge with."));


Now that you're using fprintf you could make use of its formatting
capabilities, but then it occurred to me
it's translated strings, so it's most likely better to not make it
concise but rather easier for the translators
by having each sentence written out in full.

>                 fprintf_ln(stderr, _("See git-pull(1) for details."));
>                 fprintf(stderr, "\n");
>                 fprintf_ln(stderr, "    git pull <remote> <branch>");
> @@ -461,7 +467,10 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
>                         remote_name = "<remote>";
>
>                 fprintf_ln(stderr, _("There is no tracking information for the current branch."));
> -               fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
> +               if (opt_rebase)
> +                       fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
> +               else
> +                       fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
>                 fprintf_ln(stderr, _("See git-pull(1) for details."));
>                 fprintf(stderr, "\n");
>                 fprintf_ln(stderr, "    git pull <remote> <branch>");
> --
> 2.1.4
>
