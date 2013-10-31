From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH 16/16] add: avoid yoda conditions
Date: Thu, 31 Oct 2013 12:48:57 -0700
Message-ID: <CANiSa6i5z8Z9HPzsUWTh8U2HXc9p6MPgQjJ7K6KSDw8FXtFyww@mail.gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-17-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 20:49:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbyEq-0005CQ-6q
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 20:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755484Ab3JaTtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 15:49:00 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:47940 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755481Ab3JaTs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 15:48:59 -0400
Received: by mail-wg0-f49.google.com with SMTP id x12so3168861wgg.28
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 12:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EKTqArNgPxF2nJQGtZBj39ZSRfzGTuWV9qyJR0hppCE=;
        b=LyQ9MLo6MlryTgUxFx2RICg35BjUq0XMayZr7Gtc/WhBwgt8IamQQEo7jxbtQt5xPe
         0/nyvxddxLeOc1xvE1HHCUugr7tjaWZp7xRC3+BUf7OyGS+asfRJc5vaJcrszUz+G7uC
         jtAQJxhiuwVTSR81rlWVMOjxb/zPOmjO0liZuNd3x3C+0bG0fi7kjD009yiZBHKZuan5
         nlcWqdP9CF4n0y8VmcEYRaq1TgoYqSm6xwamyUERiAFg6HY9jXuSM9xrKl/n7r+/XzEi
         5pK00DvTMYf9SJrJS03S77oJPNY+ehVE9pbJdxwk9xzG63MIJIZLZ3WsdPrcVSd1wEM9
         dFBg==
X-Received: by 10.180.36.242 with SMTP id t18mr957869wij.28.1383248937833;
 Thu, 31 Oct 2013 12:48:57 -0700 (PDT)
Received: by 10.180.106.201 with HTTP; Thu, 31 Oct 2013 12:48:57 -0700 (PDT)
In-Reply-To: <1383211547-9145-17-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237171>

I was recently confused by the yoda condition in this block of code from [1]

+ for (i = 0; i < revs.nr; i++)
+ if (&bases->item->object == &revs.commit[i]->object)
+ break; /* found */
+ if (revs.nr <= i)

I think I was particularly surprised because it came so soon after the
"i < revs.nr". I didn't bother commenting because it seemed too
subjective and the code base has tons of these. Something as simple as

  git grep '[0-9] [<>]' *.c

finds a bunch (probably with lots of false positives and negatives).

I guess what I'm trying to say is that either we accept them and get
used to reading them without being surprised, or we can change a bit
more than one at a time perhaps? I understand that this was an
occurrence you just happened to run into, and I'm not saying that a
patch has to deal with _all_ occurrences. I'm more just wondering if
we want mention our position, whatever it is, in CodingGuidelines.

Martin

[1] http://thread.gmane.org/gmane.comp.version-control.git/236252/focus=236716

On Thu, Oct 31, 2013 at 2:25 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/add.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 226f758..9b30356 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -429,7 +429,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>         argc--;
>         argv++;
>
> -       if (0 <= addremove_explicit)
> +       if (addremove_explicit >= 0)
>                 addremove = addremove_explicit;
>         else if (take_worktree_changes && ADDREMOVE_DEFAULT)
>                 addremove = 0; /* "-u" was given but not "-A" */
> --
> 1.8.4.2+fc1
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
