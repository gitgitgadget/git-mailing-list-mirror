From: Stephen Morton <stephen.c.morton@gmail.com>
Subject: Re: Sample pre-push hook can crash
Date: Fri, 11 Mar 2016 09:33:58 -0500
Message-ID: <CAH8BJxFtHD6zq=EKb0XUsMu8uMDB6=J-F+TURha+XiWcq=V06A@mail.gmail.com>
References: <CAH8BJxHeyfpKsvjGfg5ZJ5YDQk6pzZp4ufHVEV=cFriL8j_4uw@mail.gmail.com>
	<xmqq37rydn6b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 15:34:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeO8j-0001Sg-6T
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 15:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbcCKOeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 09:34:01 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35277 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932102AbcCKOeA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 09:34:00 -0500
Received: by mail-wm0-f53.google.com with SMTP id l68so21301108wml.0
        for <git@vger.kernel.org>; Fri, 11 Mar 2016 06:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=HO1VQ/Hr1Axg2vRQoyff9z7Z023YC6yHD9YHdEX+8tc=;
        b=Rjcuo+1fBJ06kbq+DydtutwOuGGytZfWZ0qmijdLDE+UZK8tZNiTjBdyHW4XnpvxK1
         KScwww3nntG6C0YIBtE4dGrjMn7By9ONGqPErYxgUCpZiUJ0nfMCu2KnOuOO39GGCB04
         1XjHEGjvdgZr1TgmnTDcnQsUAAwQnVo8NZi2639CWCvKx3Um0fDaTUybGLiJhURMV1mt
         7MIbXMFWULjoDEjz9nwUseYfp9sBKOaXNJv0W3ErCmoaFlqeYLe6luCQX6qwOZGvYUUa
         jQSo63GOGu87f2Hv7OMQjIk2R+8nN0CfA4bPAXmYbbX+3z0bAjIoSaDKcxImBwiGsoQk
         yuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=HO1VQ/Hr1Axg2vRQoyff9z7Z023YC6yHD9YHdEX+8tc=;
        b=O0OQM6hnTvBzl+ih5qHq5h3f7d69epMqA0NZgbJe916/HTF0dVApbMbOAxJiJWKVU+
         nxzU6HBQ6+RJF5o+ZEXnx8kNNS4ulhcVFA1sui3hNmnKJjBLzpnpz08fsRajOPBJ5tyx
         SwZi6HtW1O9VQLD5IEPwXgcDm5V99s54qx04CgZhkLgkAZ9fMGU67VFNS02gkDvLCCzH
         93jd7YXM1ew4YH0QpyPOuydA/qHgAOl57FMHAuiRFXhgTdrwPaYPUQ0YZGrvHW06Y4Dd
         I/BOoOM4IaFoSL5WMLl0RNQv8kGDwI27cjTSfD0Z3onjN0geOrzmnjNKBAveM5/TvX+S
         8S1g==
X-Gm-Message-State: AD7BkJKlxcc0DAXL8P+U2Uy/lmrrYddT/XlqtBy9WG/YXBtnsPasMtWslw/VVtBZv4E0IJPmnNEmqMTlv0Bu2Q==
X-Received: by 10.28.126.131 with SMTP id z125mr3421742wmc.77.1457706838599;
 Fri, 11 Mar 2016 06:33:58 -0800 (PST)
Received: by 10.194.63.82 with HTTP; Fri, 11 Mar 2016 06:33:58 -0800 (PST)
In-Reply-To: <xmqq37rydn6b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288686>

That is interesting, so in the case of a non-ff push, there is no way
for a pre-push hook to know what is being pushed in order to run?

Steve


On Thu, Mar 10, 2016 at 4:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stephen Morton <stephen.c.morton@gmail.com> writes:
>
>> The sample pre-push hook provided with git [1] will crash if the local
>> repo is not up to date with the remote as $remote_sha is not present
>> in the local repo. I'm not sure if this patch is exactly correct, it's
>> just provided as an example.
>>
>> Given that people are likely crafting their own solutions based on the
>> examples, it's probably good to get right.
>
> It's probably good to get right, but I do not think use of @{u} is
> making it right, unfortunately.  You may not necessarily have @{u}
> configured, and you may not even pushing to the configured remote
> branch.
>
> The spirit of the sample hook, I think, is to validate the new
> commits you are publishing, so if you cannot even determine which
> ones are new and which ones are not, failing the "push" by exiting
> with non-zero status is the right behaviour for this sample.
>
> So perhaps something like this may be more appropriate as an
> example.
>
>  templates/hooks--pre-push.sample | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-push.sample
> index 6187dbf..7ef6780 100755
> --- a/templates/hooks--pre-push.sample
> +++ b/templates/hooks--pre-push.sample
> @@ -41,7 +41,12 @@ do
>                 fi
>
>                 # Check for WIP commit
> -               commit=`git rev-list -n 1 --grep '^WIP' "$range"`
> +               commit=`git rev-list -n 1 --grep '^WIP' "$range"` || {
> +                       # we do not even know about the range...
> +                       echo >&2 "Non-ff update to $remote_ref"
> +                       echo >&2 "fetch from there first"
> +                       exit 1
> +               }
>                 if [ -n "$commit" ]
>                 then
>                         echo >&2 "Found WIP commit in $local_ref, not pushing"
