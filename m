From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] Completion must sort before using uniq
Date: Fri, 23 Nov 2012 12:34:20 +0100
Message-ID: <CAMP44s2bMub6T1YcUfsYWPQFU1bY4iU1WfSf+jFa7jSXAKTNaw@mail.gmail.com>
References: <1353557598-4820-1-git-send-email-marc.khouzam@gmail.com>
	<CAFj1UpF2wh0imcqW7Ez_J14R_07a_A1-YWESaGrHRNa7Nsv-xg@mail.gmail.com>
	<CAMP44s3qpr11JXi-znddAH2BWYbM_kp+nZnTa8CQgCzrBmfzmA@mail.gmail.com>
	<CAFj1UpHAqrNvpF+HAxJUPiWAiHbCn=7r1GDw3iMKy8FDW_-D_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Marc Khouzam <marc.khouzam@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 12:34:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbrWq-0003FX-T8
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 12:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991Ab2KWLeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 06:34:24 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:54164 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755208Ab2KWLeV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 06:34:21 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so8794688oag.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 03:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JUv8PuKiUfYij7rYjLBh2kfqIr9/ZkbQPpmwZ9JAwUs=;
        b=DV9lkVre3og++skmj4fjj3r6beS5J+UPi3kwpMvnutLD5oBDi2lQhbcAXYgK1KTWsO
         Lkl++vjN1n7Ly5fU5fsFiJaYtM5QdILcYK9+R8au43q6oNePa/LhOQc8a9Fu7hImPaDe
         ZlPNclOi8iDkIyinZohra+8CrWkrEYRZ67yGeFh5E1ft4ohkaqC38dLljbt4JIAvO8QJ
         z6SOHQhk/WvF43QjWXdN+kd/codpdAKu8nebQ68IM5Ft497X31OmgW6piN5j2pQdWE8Z
         LgMYm6z2qXCgoW2f7pnoLWp6iFsNCuJGKL+QooXPlYs0b5xV8Ls1Ce3vLvwx44Ywb/DV
         He4A==
Received: by 10.182.17.72 with SMTP id m8mr2602490obd.55.1353670460949; Fri,
 23 Nov 2012 03:34:20 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Fri, 23 Nov 2012 03:34:20 -0800 (PST)
In-Reply-To: <CAFj1UpHAqrNvpF+HAxJUPiWAiHbCn=7r1GDw3iMKy8FDW_-D_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210252>

Hi,

Mostly cosmetic suggestions, but it looks OK to me.

On Fri, Nov 23, 2012 at 12:17 PM, Marc Khouzam <marc.khouzam@gmail.com> wrote:
> The user can be presented with invalid completion results
> when trying to complete a 'git checkout' command.  This can happen
> when using a branch name prefix that matches multiple remote branches.

Space here.

> For example if available branches are:

For example; <- separation

>   master
>   remotes/GitHub/maint
>   remotes/GitHub/master
>   remotes/origin/maint
>   remotes/origin/master
>
> When performing completion on 'git checkout ma' the user will be
> given the choices:
>   maint
>   master

Space.

> However, 'git checkout maint' will fail in this case, although
> completion previously said 'maint' was valid.

Space (or continue paragraph).

> Furthermore, when performing completion on 'git checkout mai',
> no choices will be suggested.  So, the user is first told that the
> branch name 'maint' is valid, but when trying to complete 'mai'
> into 'maint', that completion is no longer valid.
>
> The completion results should never propose 'maint' as a valid
> branch name, since 'git checkout' will refuse it.

With this explanation the patch looks good to me.

> The reason for this bug is that the uniq program only
> works with sorted input.  The man page states
> "uniq prints the unique lines in a sorted file".
>
> When __git_refs uses the guess heuristic employed by checkout for
> tracking branches it wants to consider remote branches but only if
> the branch name is unique.  To do that, it calls 'uniq -u'.  However
> the input given to 'uniq -u' is not sorted.
>
> Therefore, in the above example, when dealing with 'git checkout ma',
> "__git_refs '' 1" will find the following list:
>   master
>   maint
>   master
>   maint
>   master

Space.

> which, when passed to 'uniq -u' will remain the same.  Therefore
> 'maint' will be wrongly suggested as a valid option.

Space.

> When dealing with 'git checkout mai', the list will be:
>   maint
>   maint

Space.

> which happens to be sorted and will be emptied by 'uniq -u',
> properly ignoring 'maint'.
>
> A solution for preventing the completion script from suggesting
> such invalid branch names is to first call 'sort' and then 'uniq -u'.

Cheers.

-- 
Felipe Contreras
