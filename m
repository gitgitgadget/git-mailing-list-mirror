From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] git-am: flag suspiciously old or futuristic commits
Date: Wed, 29 Jul 2015 15:20:46 -0700
Message-ID: <CAGZ79kY7i95cXE3o=1kr40uFYhwijNkOoOJs6wa7msqvW8xvzg@mail.gmail.com>
References: <1438207297-11686-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 00:21:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKZia-00079J-9B
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 00:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219AbbG2WUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 18:20:48 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36762 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbbG2WUr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 18:20:47 -0400
Received: by ykay190 with SMTP id y190so20215399yka.3
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 15:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6eA4W03jQNtgOm7Q2L5T4qE455gkqBKv3z4pW2obelY=;
        b=PQXJzNmB9aylq2PafcsE8emMXGIKMF9NFMXzn11PLAo/eLoFF1xpfxAOtQPVBslktl
         ixIPI0BAPnY92PXqOjzYTuCN+51CvCY/mUDn0jn1RNlMmelZ4K7a3FcXK6WnxBk0d/hf
         C6ChW+ZIwaU1AjobEXwmhgy1DVsUnvg7Tt5G9LAI34w8KUEbR19C8wI5iCMgU5XL8HYb
         zisbdKulWLY3os4lioL+b4hJKD/GoD2pn/K9e+zRru9y6GGr8EYQEJvpZKrAfY1ucaYZ
         AQ4sC/INNLY7BuNTlE7CgBGdLN3nPSgqzfNPq7v4w+jMn2j+ITKW7LVB0ZVMcC+1D3DS
         aZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6eA4W03jQNtgOm7Q2L5T4qE455gkqBKv3z4pW2obelY=;
        b=AJIjxYozq2/beWCTVjAOcSgHVtiM0zJq/Hr23wNzfsn0DfMkq43i7z9LUFXPiDyJmS
         gwQE8NrbvQ3fL1z2jyCKMN7dPTnb3Hpz3rQauyd4bk/uaSpcb8PMQa1EF3bqbUv+aWb9
         vk5vNSzJ/hPT8NrO3FyM1AuDAEFaUENCWEDbCx8PD8lk0pyOhN9BxdIky6BszK1XyCSZ
         TshpHHxICgAn/shE5Ed6F6eTI9VlVQ1PnLUcdwj9Y7+N+4YLrmRwxKl+VvCDpKlLkQG3
         C8D2a4A2IY3GROIYshNBoVRe+2a8x+MiHrsk52bFjSljlcQs0vJFhl/KD92Xy5qLTmqB
         nnVA==
X-Gm-Message-State: ALoCoQnsUd7MgJprFpmXag1PSecj3IYLK85ZlDDDuG9IxcRsOaANfbIYp8j4oeqP3VrLDCTsJEMa
X-Received: by 10.170.73.67 with SMTP id p64mr46966707ykp.101.1438208446263;
 Wed, 29 Jul 2015 15:20:46 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Wed, 29 Jul 2015 15:20:46 -0700 (PDT)
In-Reply-To: <1438207297-11686-1-git-send-email-paul.gortmaker@windriver.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274962>

On Wed, Jul 29, 2015 at 3:01 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> The linux kernel repository has some commits in it with dates from
> the year 1970 and also 2030 (and possibly others).  We probably shouldi
> warn people when the dates look suspect.
>
> For commits in the future,  note that a committer in Australia
> could commit on New Years Day, and send it to a maintainer in North
> America and that would trip the notification on the maintainer's
> New Years Eve.  But that is unlikely, and the note is still
> correct; that the commit is from a future year.
>
> For commits in the past, I chose a somewhat arbitrary 30 year
> limit, which will allow stuff from post 1985; the thought being
> that someone might want to import an old repo into git from some
> other SCM.  We could alternatively set it to 5, which would then
> catch computers with a dead CMOS battery, at the risk of pestering
> the hypothetical museum curator of old bits.
>
> Sample output:
>
> paul@builder:~/git/linux-head$ grep Date: *patch
> future.patch:Date: Sat, 18 Jul 2037 21:22:19 -0400
> past.patch:Date: Sat, 18 Jul 1977 21:22:19 -0400
>
> paul@builder:~/git/linux-head$ git am future.patch
> note: commit is from future year 2037.
> Applying: arch/sh: make heartbeat driver explicitly non-modular
> paul@builder:~/git/linux-head$ git reset --hard HEAD~ > /dev/null
> paul@builder:~/git/linux-head$ git am past.patch
> note: commit is from implausibly old year 1977.
> Applying: arch/sh: make heartbeat driver explicitly non-modular
> paul@builder:~/git/linux-head$
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  git-am.sh | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/git-am.sh b/git-am.sh

[+cc paul tan, who rewrote am in c as a GSoC project.]

> index 3af351ffaaf3..ff6deb8047a4 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -766,6 +766,21 @@ To restore the original branch and stop patching run \"\$cmdline --abort\"."
>                 stop_here $this
>         fi
>
> +       if test -n "$GIT_AUTHOR_DATE"
> +       then
> +               THIS_YEAR=`date +%Y`
> +               TOO_OLD=$(expr $THIS_YEAR - 30)
> +               TOO_NEW=$(expr $THIS_YEAR + 1)
> +               GIT_AUTHOR_YEAR=`date -d "$GIT_AUTHOR_DATE" +%Y`

Would it make sense to not operate on year but on unix time, so the problem
you mentioned in the commit message goes away?

Another thought:
Having this check in am seems a bit arbitrary to me (or rather
workflow adapted ;) as
we could also check in commit or pull (not sure if I actually mean the
fetch or merge thereof)

> +
> +               if [ "$GIT_AUTHOR_YEAR" -le "$TOO_OLD" ]; then
> +                       say "$(gettext "note: commit is from implausibly old year $GIT_AUTHOR_YEAR.")"
> +               fi
> +               if [ "$GIT_AUTHOR_YEAR" -ge "$TOO_NEW" ]; then
> +                       say "$(gettext "note: commit is from future year $GIT_AUTHOR_YEAR.")"
> +               fi
> +       fi
> +
>         export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
>
>         case "$resume" in
> --
> 2.5.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
