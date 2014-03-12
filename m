From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] SoC 2014 MicroProject No.8:change multiple if-else
 statement to table-driven approach
Date: Wed, 12 Mar 2014 05:21:06 -0400
Message-ID: <CAPig+cQu7D3AUghOSUOZBwf5+iHCPkxPbY1WuQmPJk1muCk7tQ@mail.gmail.com>
References: <zhaox383@umn.edu>
	<1394596049-8767-1-git-send-email-zhaox383@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Yao Zhao <zhaox383@umn.edu>
X-From: git-owner@vger.kernel.org Wed Mar 12 10:21:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNfLh-0000cm-Ev
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 10:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbaCLJVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 05:21:08 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:41326 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbaCLJVH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 05:21:07 -0400
Received: by mail-yh0-f48.google.com with SMTP id z6so9809786yhz.21
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 02:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SbARFm3Au8YOfN/PuLYFcwlNmkwt/UM/5vYfg/C7rus=;
        b=NDw3g7XvZ3RdFHZCifjdIvF+QUQ8K+8hnbe7ElUTcmmIwrARjkA5ORszUVNH3Mlxsn
         ivLXeV0WkyaCQQAcxfVcSSQMLCkv97SDm6OvsvDJJWHS5igPCTzioPSEfYb76Sd0hUqK
         6850CeIt9uhIvCib5Tk2xFKPfWmEc/r2K3WRL5Qpss36vFQbcJT4PydmGK3axVuExya+
         Sqsza+fhJusjfUk66UoIfEamYM99h3VbhOCqVOcxW6qLMyFKgD7Wy7rZC77NLDnAid6f
         6eMeJ3V2k7xnPeYEL3NlghgFeQCN8nyzFUy2bySnqiHQN4GSlcrfA3ftLCPEVNop6ide
         gx4w==
X-Received: by 10.236.152.36 with SMTP id c24mr951610yhk.118.1394616066215;
 Wed, 12 Mar 2014 02:21:06 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Wed, 12 Mar 2014 02:21:06 -0700 (PDT)
In-Reply-To: <1394596049-8767-1-git-send-email-zhaox383@umn.edu>
X-Google-Sender-Auth: V3vwX4tOuHy4UZrb0yLCBl1OtNw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243928>

Thanks for the submission. Comments below to give you a taste of the
Git review process...

On Tue, Mar 11, 2014 at 11:47 PM, Yao Zhao <zhaox383@umn.edu> wrote:
> Subject: SoC 2014 MicroProject No.8:change multiple if-else statement to table-driven approach

The email subject is extracted automatically by "git am" as the first
line of the patch's commit message so it should contain only text
which is relevant to the commit message. In this case, everything
before "changes" is merely commentary for readers of the email, and
not relevant to the commit message.

It is indeed a good idea to let reviewers know that this submission is
for GSoC, and you can indicate this as such:

    Subject: [PATCH GSoC] change multiple if-else statements to be table-driven

> Signed-off-by: Yao Zhao <zhaox383@umn.edu>
> ---

The additional information that this is GSoC microproject #8 would go
in the "commentary" area right here after the "---" following your
sign-off.

>  branch.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 53 insertions(+), 2 deletions(-)

The patch is rife with style violations. I'll point out the first
instance of each violation, but do be sure to fix all remaining ones
when you resubmit. See Documentation/CodingGuidelines for details.

> diff --git a/branch.c b/branch.c
> index 723a36b..6432e27 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -53,7 +53,20 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>         int remote_is_branch = starts_with(remote, "refs/heads/");
>         struct strbuf key = STRBUF_INIT;
>         int rebasing = should_setup_rebase(origin);
> -
> +       char** print_list = malloc(8 * sizeof(char*));

Style: char **print_list

Why allocate 'print_list' on the heap? An automatic variable 'char
const *print_list[]' would be more idiomatic and less likely to be
leaked.

In fact, your heap-allocated 'print_list' _is_ being leaked a few
lines down when the function returns early after warning that a branch
can not be its own upstream.

> +       char* arg1=NULL;
> +       char* arg2=NULL;
> +       char* arg3=NULL;

Style: char *var
Style: whitespace: var = NULL

> +       int index=0;
> +
> +       print_list[7] = _("Branch %s set up to track remote branch %s from %s by rebasing.");
> +       print_list[6] = _("Branch %s set up to track remote branch %s from %s.");
> +       print_list[5] = _("Branch %s set up to track local branch %s by rebasing.");
> +       print_list[4] = _("Branch %s set up to track local branch %s.");
> +       print_list[3] = _("Branch %s set up to track remote ref %s by rebasing.");
> +       print_list[2] = _("Branch %s set up to track remote ref %s.");
> +       print_list[1] = _("Branch %s set up to track local ref %s by rebasing.");
> +       print_list[0] = _("Branch %s set up to track local ref %s.");

If you make print_list[] an automatic variable, then you can declare
and populate it via a simple initializer. No need for this manual
approach.

>         if (remote_is_branch
>             && !strcmp(local, shortname)
>             && !origin) {
> @@ -77,7 +90,44 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>         strbuf_release(&key);
>
>         if (flag & BRANCH_CONFIG_VERBOSE) {
> -               if (remote_is_branch && origin)
> +               if(remote_is_branch)

Style: whitespace: if (...)

> +                               index += 4;
> +               if(origin)
> +                               index += 2;
> +               if(rebasing)
> +                               index += 1;
> +
> +               if(index < 0 || index > 7)
> +               {
> +                       die("BUG: impossible combination of %d and %p",
> +                           remote_is_branch, origin);
> +               }
> +
> +               if(index <= 4) {
> +                       arg1 = local;
> +                       arg2 = remote;
> +               }
> +               else if(index > 6) {

Style: } else if (...) {

> +                       arg1 = local;
> +                       arg2 = shortname;
> +                       arg3 = origin;
> +               }
> +               else {
> +                       arg1 = local;
> +                       arg2 = shortname;
> +               }
> +
> +               if(!arg3) {
> +                       printf_ln(print_list[index],arg1,arg2);

Style: whitespace: printf_ln(x, y, z)

> +               }
> +               else {
> +                       printf_ln(print_list[index],arg1,arg2,arg3);
> +               }

Unfortunately, this is quite a bit more verbose and complex than the
original code, and all the magic numbers (4, 2, 1, 0, 7, 4, 6) place a
higher cognitive load on the reader, so this change probably is a net
loss as far as clarity is concerned.

Take a step back and consider again the GSoC miniproject: It talks
about making the code table-driven. Certainly, you have moved the
strings into a table, but all the complex logic is still in the code,
and not in a table, hence it's not table-driven. To make this
table-driven, you should try to figure out how most or all of this
logic can be moved into a table.

> +               free(print_list);
> +
> +
> +/*             if (remote_is_branch && origin)
>                         printf_ln(rebasing ?
>                                   _("Branch %s set up to track remote branch %s from %s by rebasing.") :
>                                   _("Branch %s set up to track remote branch %s from %s."),
> @@ -100,6 +150,7 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>                 else
>                         die("BUG: impossible combination of %d and %p",
>                             remote_is_branch, origin);
> +*/

The code you wrote is meant to replace the old code, so your patch
should actually remove the old code, not just comment it out.

>         }
>  }
>
> --
> 1.8.3.2
