From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/5] Add a new option 'merges' to revision.c
Date: Sun, 22 Mar 2015 16:43:22 -0400
Message-ID: <CAPig+cRKc59804+yXtX8ZJagsJ4NVw-61Ru1kh1eBusGR1Ai_g@mail.gmail.com>
References: <1427048921-28677-1-git-send-email-koosha@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Sun Mar 22 21:43:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZmiW-0004XI-Hh
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 21:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbbCVUnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 16:43:24 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:33844 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbbCVUnX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 16:43:23 -0400
Received: by yhch68 with SMTP id h68so60308342yhc.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 13:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CX6BvYZyMF3BSaKIRPN/lkz0w10elRhSd/9cOneEmqM=;
        b=BRs79PBMSyRYtOEexmE9MAze8yElyEfwvAWdWBqAnUSdZ9SGD1d7uWeMnaS0r1Koug
         F7FZ1ccWo5HFf+gd+6jg0uOBpRuCvxiAgVkk0DyduYmN+ZyCnhHEOxjQF1U3axj23LHj
         6mXVilh0LG4FWa3a1K8YZBF6Z7yDzYg+rD+7fKYB0sHLg1ARkjLlSWhgwAAl5MqzUgh1
         6p08RBrwJvpEoaL82oDPKXGT6kiHRso8hORIzWxUUNBcXHuHsTQSU+puV5Z/hMNSxiw+
         3Xdmnpfd6gFN45IAhtmITrWjxG2Rmb4lAOatezOEWQKsLCptZLZnydZgr3SlO9pxfN1Y
         Qi9Q==
X-Received: by 10.236.202.98 with SMTP id c62mr12501866yho.166.1427057003025;
 Sun, 22 Mar 2015 13:43:23 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 22 Mar 2015 13:43:22 -0700 (PDT)
In-Reply-To: <1427048921-28677-1-git-send-email-koosha@posteo.de>
X-Google-Sender-Auth: kgxRkkP3w7YSJT0IwTmW224wTTA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266090>

On Sun, Mar 22, 2015 at 2:28 PM, Koosha Khajehmoogahi <koosha@posteo.de> wrote:
> Subject: Add a new option 'merges' to revision.c

For the subject, mention the area you're touching, followed by a
colon, followed by a short but meaningful summary of the change. Drop
capitalization.

    revision: add --merges={show|only|hide} option

> revision.c: add a new option 'merges' with

No need to mention "revision.c" here since the patch itself shows this clearly.

Considering that there is already a --merges option, it is somewhat
misleading and not terribly clear to say only that you're adding a new
"option 'merges'". Better would be to spell out --merges= explicitly.

> possible values of 'only', 'show' and 'hide'.
> The option is used when showing the list of commits.
> The value 'only' lists only merges. The value 'show'
> is the default behavior which shows the commits as well
> as merges and the value 'hide' makes it just list commit
> items.
>
> Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>

Considering that Junio actually wrote this patch[1], it would be more
correct and considerate to attribute it to him. You can do so by
ensuring that there is a "From:" header at the very top of the commit
message before mailing out the patch:

    From: Junio C Hamano <gitster@pobox.com>

The customary way to indicate that you wrote the commit message and
made a few small adjustments to Junio's patch would be with a
bracketed comment (starting with your initials) just before your
sign-off. Something like this:

    [kk: wrote commit message; added a couple missing
    {min|max}_parents assignments]

[1]: http://article.gmane.org/gmane.comp.version-control.git/265597

> ---
> diff --git a/revision.c b/revision.c
> index 66520c6..edb7bed 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1678,6 +1678,23 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
>         add_grep(revs, pattern, GREP_PATTERN_BODY);
>  }
>
> +int parse_merges_opt(struct rev_info *revs, const char *param)
> +{
> +       if (!strcmp(param, "show")) {
> +               revs->min_parents = 0;
> +               revs->max_parents = -1;
> +       } else if (!strcmp(param, "only")) {
> +               revs->min_parents = 2;
> +               revs->max_parents = -1;
> +       } else if (!strcmp(param, "hide")) {
> +               revs->min_parents = 0;
> +               revs->max_parents = 1;
> +       } else {
> +               return -1;
> +       }
> +       return 0;
> +}
> +
>  static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
>                                int *unkc, const char **unkv)
>  {
> @@ -1800,9 +1817,14 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>                 revs->show_all = 1;
>         } else if (!strcmp(arg, "--remove-empty")) {
>                 revs->remove_empty_trees = 1;
> +       } else if (starts_with(arg, "--merges=")) {
> +               if (parse_merges_opt(revs, arg + 9))
> +                       die("unknown option: %s", arg);
>         } else if (!strcmp(arg, "--merges")) {
> +               revs->max_parents = -1;
>                 revs->min_parents = 2;
>         } else if (!strcmp(arg, "--no-merges")) {
> +               revs->min_parents = 0;
>                 revs->max_parents = 1;
>         } else if (starts_with(arg, "--min-parents=")) {
>                 revs->min_parents = atoi(arg+14);
> diff --git a/revision.h b/revision.h
> index 0ea8b4e..f9df58c 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -240,6 +240,7 @@ extern int setup_revisions(int argc, const char **argv, struct rev_info *revs,
>  extern void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
>                                const struct option *options,
>                                const char * const usagestr[]);
> +extern int parse_merges_opt(struct rev_info *, const char *);
>  #define REVARG_CANNOT_BE_FILENAME 01
>  #define REVARG_COMMITTISH 02
>  extern int handle_revision_arg(const char *arg, struct rev_info *revs,
> --
> 2.3.3.263.g095251d.dirty
