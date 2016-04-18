From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] mv: allow moving nested submodules
Date: Mon, 18 Apr 2016 14:26:06 -0700
Message-ID: <CAGZ79kbVTUzKmSa9KjEJyDuRCtW5rygQmSYMpssLUKYoO1ooSw@mail.gmail.com>
References: <1460998489-2155-1-git-send-email-sbeller@google.com>
	<xmqqk2ju4ozy.fsf@gitster.mtv.corp.google.com>
	<xmqqfuui4o4e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?Q?Albin_Otterh=C3=A4ll?= <gmane@otterhall.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 23:26:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asGgQ-0000J3-16
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 23:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbcDRV0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 17:26:09 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35290 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbcDRV0H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 17:26:07 -0400
Received: by mail-io0-f175.google.com with SMTP id g185so116290ioa.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2016 14:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=gbcFnUrMtjbqSy0El8vASTtCqIg9ceJaC9FCCbXt6nA=;
        b=VO/yiI8wZr18GBI6QnZtN4CYE0G8Y3UiDpJHwkPrvssXc3rgM+j4mJtP8gGeNqP188
         52hvz+5aaRar9QZb2I43nZr008m4nD8GBj97dMEY/6MpHT+0LV+3rmm+P6brnOtNIACm
         siBBpfTyX/63xIQfEuaeS7pDKDN0MgsWnuGUwJWLBTv0HhB+8BqD/fXMik1ads823NxB
         FS2K62F8lirqF+4OXF4jK5pdxAAhAnI2SC8XATU1IIGV59kL+pqmhNwQ/INQs2ESSnsH
         rufFEfS+BiqzGraM1opgw1u4aLySFFYCYX6NFdssTlfljEQvBZj2TMPWb//6HP337/86
         3IHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=gbcFnUrMtjbqSy0El8vASTtCqIg9ceJaC9FCCbXt6nA=;
        b=VDf+4rdRWjzl5lj4L4rpCveY2q69xUTIBR9gOdd2/fDel2QUdEjaH/aPWu7yp2Fpep
         /Auc6dWtOo6P+LloTehFAgzr+w0sLn2HWZFrYn32LhGEL/YWPOLLGaE2peDSfFCKCmor
         wRgiNOOh7I5sSOGnti1/Fi/d+urnV07fCX/B7WYSr5KazqCinYziPaBn5MJUrlKyf7Dn
         NczSRXsTINmZBuKO9XeIRBN0DsNeHw5PDW1wxcUl2Yy9Rg/i4FJcFuyDJQTpRVD5FyDs
         4kYN+h7AmW6goZ+DWTYpw+l58VzHem4bWnb9Zw5jBrq54r/8ua0XY4K463YjR0eylBTW
         wrLQ==
X-Gm-Message-State: AOPr4FWnHP1ing+lXauDT4bxaeNtoOPrDfw8rjz17j4JzHYFyxHg7rSau0MtHoQosMb2H4t9BThKOf+1DoDFWmqH
X-Received: by 10.107.184.8 with SMTP id i8mr38395246iof.96.1461014766710;
 Mon, 18 Apr 2016 14:26:06 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Mon, 18 Apr 2016 14:26:06 -0700 (PDT)
In-Reply-To: <xmqqfuui4o4e.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291831>

On Mon, Apr 18, 2016 at 2:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> If ignore-errors is set and rename fails, this would fall through
>> and try to touch this codepath...
>>
>>>                      if (submodule_gitfile[i]) {
>>>                              if (submodule_gitfile[i] != SUBMODULE_WITH_GITDIR)
>>>                                      connect_work_tree_and_git_dir(dst, submodule_gitfile[i]);
>>
>> ... but I am not sure if this thing is prepared to cope with such a
>> case?  src should have been moved to dst but if rename() failed we
>> wouldn't see what we expect at dst, or would we?
>
> In other words, I was wondering if this part should read more like
> this:
>
>  builtin/mv.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index aeae855..37ed0fc 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -252,9 +252,14 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>                 int pos;
>                 if (show_only || verbose)
>                         printf(_("Renaming %s to %s\n"), src, dst);
> -               if (!show_only && mode != INDEX) {
> -                       if (rename(src, dst) < 0 && !ignore_errors)
> +               if (show_only)
> +                       ;
> +               else {
> +                       if (mode != INDEX && rename(src, dst) < 0) {

I agree until here.


> +                               if (ignore_errors)
> +                                       continue;
>                                 die_errno(_("renaming '%s' failed"), src);

This I thought would be better as:

    if (!ignore_errors)
        die_errno(...);

and not continue, but continuing is the right thing I would expect.

Speaking of which, connect_work_tree_and_git_dir as well as
update_path_in_gitmodules need to learn about the ignore_errors
flag, too.  You would expect them to not die at the faintest problem,
but rather honor the promise of "Skip move or rename actions which
would lead to an error condition."

Thanks for a starting pointer for a new patch!
Stefan

> +                       }
>                         if (submodule_gitfile[i]) {
>                                 if (submodule_gitfile[i] != SUBMODULE_WITH_GITDIR)
>                                         connect_work_tree_and_git_dir(dst, submodule_gitfile[i]);
