From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Completion must sort before using uniq
Date: Fri, 23 Nov 2012 09:21:43 +0100
Message-ID: <CAMP44s3qpr11JXi-znddAH2BWYbM_kp+nZnTa8CQgCzrBmfzmA@mail.gmail.com>
References: <1353557598-4820-1-git-send-email-marc.khouzam@gmail.com>
	<CAFj1UpF2wh0imcqW7Ez_J14R_07a_A1-YWESaGrHRNa7Nsv-xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Marc Khouzam <marc.khouzam@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 09:22:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TboWN-0001Kg-MC
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 09:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757771Ab2KWIVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 03:21:45 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60041 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149Ab2KWIVo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 03:21:44 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so8735083obb.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 00:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pfFNuL0czm35YBSI5VlUVvqmJCJYMH3X+ePJIsvkhcA=;
        b=HryFezFP+wyBlDhzPPfia0ufL1x1XG4cwAUB3ZcGk7lK4c8tpvN/3wGQLroCuhZmfQ
         13avTZGcH4iOQJj+3yhEOeZqWXmmy5X83tV0uLDGk4MbQBAiMnsYt51ymN/r8pcMGF1B
         kJFQYJYTUnLNXSZMerkIaMJL6OIXXoZcQw4KUXTm3ZPIKfEUp4fq6xmLKwg4Ka+Sa9fk
         YuQob/znhTAtQuXiEGzK1B9OUV0IKY1NChqNpxoKRp+tDpaDtz5U7TjHZcdy8h6JN+rb
         tzYMMJ/H8CEOlcj1y/X+SIfjWVEhEBFAquhvVAEq8VFpuXSkWDRMVxM+z3RKyGEftBK3
         LEGQ==
Received: by 10.60.169.173 with SMTP id af13mr2253792oec.97.1353658903968;
 Fri, 23 Nov 2012 00:21:43 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Fri, 23 Nov 2012 00:21:43 -0800 (PST)
In-Reply-To: <CAFj1UpF2wh0imcqW7Ez_J14R_07a_A1-YWESaGrHRNa7Nsv-xg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210245>

On Thu, Nov 22, 2012 at 5:16 AM, Marc Khouzam <marc.khouzam@gmail.com> wrote:
> The uniq program only works with sorted input.  The man page states
> "uniq prints the unique lines in a sorted file".
>
> When __git_refs use the guess heuristic employed by checkout for
> tracking branches it wants to consider remote branches but only if
> the branch name is unique.  To do that, it calls 'uniq -u'.  However
> the input given to 'uniq -u' is not sorted.
>
> For example if all available branches are:
>   master
>   remotes/GitHub/maint
>   remotes/GitHub/master
>   remotes/origin/maint
>   remotes/origin/master
>
> When performing completion on 'git checkout ma' the choices given are
>   maint
>   master
> but when performing completion on 'git checkout mai', no choices
> appear, which is obviously contradictory.
>
> The reason is that, when dealing with 'git checkout ma',
> "__git_refs '' 1" will find the following list:
>   master
>   maint
>   master
>   maint
>   master
> which, when passed to 'uniq -u' will remain the same.
> But when dealing with 'git checkout mai', the list will be:
>   maint
>   maint
> which happens to be sorted and will be emptied by 'uniq -u'.
>
> The solution is to first call 'sort' and then 'uniq -u'.

The solution to what? This seems to be the right thing indeed, but you
don't explain what is the actual problem that is being solved. What
does the user experience? What would (s)he experience after the patch?

-- 
Felipe Contreras
