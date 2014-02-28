From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] branch.c: delete size check of newly tracked branch names
Date: Fri, 28 Feb 2014 18:41:05 +0700
Message-ID: <CACsJy8A7jVM1wdU2BK-NyQ5HJoY_19oKhSXCKqV_7qNN+OA+mw@mail.gmail.com>
References: <1393585744-2569-1-git-send-email-jacopo.notarstefano@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Christian Couder <christian.couder@gmail.com>
To: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 12:41:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJLp0-0003oo-B5
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 12:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbaB1Llh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 06:41:37 -0500
Received: from mail-qc0-f171.google.com ([209.85.216.171]:54266 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbaB1Llg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 06:41:36 -0500
Received: by mail-qc0-f171.google.com with SMTP id x3so549039qcv.16
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 03:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yRtrjKtlCfLiVYn25/arwKxiDTUSiItdppKb/HPRco4=;
        b=cIsXrMofTZYA66Q9leGODeiekZji9SOf+W7w1CWPFdkiSfA7jWio7idilrZIZS33Sp
         c1xqqabU4N386S2ryNjpd8mBHkAc1CtRHIUAkW5yOuH3EjNMZl3HB1oX0LIR76dq0hrv
         5eKFvptXmR/jNUjviM1Se+gRxPkAzcdLPZO9ijzK8virrgth8fMAdRSzgT2+pc+mcBO6
         UIWMa1m+0ijGd7bx8TrkR3O2PZxG/I3eqk5oDUhLw2XfbHdqIjKQLiWgI3QXsHQHJAYa
         oOEEJHKTKH4lao35FQV69vIseRteFxrMoSj/XHWFl98EisbcW8KzH9iiSce44Rqu3IGz
         QtKA==
X-Received: by 10.224.26.71 with SMTP id d7mr2722220qac.89.1393587695569; Fri,
 28 Feb 2014 03:41:35 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 28 Feb 2014 03:41:05 -0800 (PST)
In-Reply-To: <1393585744-2569-1-git-send-email-jacopo.notarstefano@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242944>

On Fri, Feb 28, 2014 at 6:09 PM, Jacopo Notarstefano
<jacopo.notarstefano@gmail.com> wrote:
> Since commit 6f084a56 the length of a newly tracked branch name was limited
> to 1019 = 1024 - 7 - 7 - 1 characters, a bound derived by having to store
> this name in a char[1024] called key with two strings of length at most 7
> and a '\0' character.
>
> This was no longer necessary as of commit a9f2c136, which uses a strbuf
> (documented in Documentation/technical/api-strbuf.txt) to store this value.
>
> This patch removes this unneeded check and thus allows for branch names
> longer than 1019 characters.

Nice. new_ref is passed in install_branch_config() in latest code. I
guess you already made sure this function did not make any assumption
about new_ref's length?

>
> Signed-off-by: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
> ---
>
> Submitted as GSoC microproject #3.
>
>  branch.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 723a36b..05feaff 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -114,10 +114,6 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
>         struct tracking tracking;
>         int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
>
> -       if (strlen(new_ref) > 1024 - 7 - 7 - 1)
> -               return error(_("Tracking not set up: name too long: %s"),
> -                               new_ref);
> -
>         memset(&tracking, 0, sizeof(tracking));
>         tracking.spec.dst = (char *)orig_ref;
>         if (for_each_remote(find_tracked_branch, &tracking))
> --
> 1.9.0.1.g5abca64
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Duy
