From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] poll/select: prevent busy-waiting
Date: Mon, 28 Apr 2014 13:44:34 +0200
Message-ID: <CABPQNSbDkE+Vff=4MmPO9oMfjRay6Oin51zZRoZ8mOEhGoaD3Q@mail.gmail.com>
References: <20140428083931.GA10257@camelia.ucw.cz> <CABPQNSaC30p7TEOvc85u=+skjrFj17182vWWSL=QNVuvzVFE=w@mail.gmail.com>
 <20140428113815.GA10559@camelia.ucw.cz> <20140428114224.GA11186@camelia.ucw.cz>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Theodore Leblond <theodore.leblond@gmail.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Apr 28 13:45:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wejzv-0005YV-Fq
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 13:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbaD1LpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 07:45:17 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38834 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbaD1LpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 07:45:16 -0400
Received: by mail-ie0-f174.google.com with SMTP id ar20so1327219iec.5
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 04:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=jPnSpZUGxrEtSckSQy02GKnWFetSSjuG/yoP6D1nMXQ=;
        b=FjoREAqaysqg8Zz9r3Nx4rMIVuACNrfF2T3ZOjuQBi+DFRNLwUj3/f+ov2VxrbhbY+
         Cx8vVbKlN9e0aMYH8PHWtSTGlJg0asyn9hoNjRR887Ecd+bEMoKmFOwdfwdbr4SwvgBJ
         TnSbH87twT8IUq3wKCa4JFjh304p8tQ3P2YIhdt1CdZG3+HXECU1yr/4PEdcg36OpphL
         ar/Ll83gjq+tpMM6JixVzLTwBpKPq//hNCUYgwrgjNyPCRjLGvpmc85tZT91+dHi1mCh
         3ulA3gQylCOUVU8gjmnG/8nvo0KPdXTV3D6H+RJAkF+ZIfDGnTUGzbJJcVgs3/7LN/Xs
         sqwA==
X-Received: by 10.42.204.197 with SMTP id fn5mr152120icb.95.1398685515441;
 Mon, 28 Apr 2014 04:45:15 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 04:44:34 -0700 (PDT)
In-Reply-To: <20140428114224.GA11186@camelia.ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247303>

On Mon, Apr 28, 2014 at 1:42 PM, Stepan Kasal <kasal@ucw.cz> wrote:
> From: Paolo Bonzini <bonzini@gnu.org>
> Date: Mon, 21 May 2012 09:52:42 +0200
>
> Backported from Gnulib.
>
> 2012-05-21  Paolo Bonzini  <bonzini@gnu.org>
>
>         poll/select: prevent busy-waiting.  SwitchToThread() only gives away
>         the rest of the current time slice to another thread in the current
>         process. So if the thread that feeds the file decscriptor we're
>         polling is not in the current process, we get busy-waiting.
>         * lib/poll.c: Use SleepEx(1, TRUE) instead of SwitchToThread().
>         Patch from Theodore Leblond.
>         * lib/select.c: Split polling out of the loop that sets the output
>         fd_sets.  Check for zero result and loop if the wait timeout is
>         infinite.
>
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---
>  compat/poll/poll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/compat/poll/poll.c b/compat/poll/poll.c
> index 31163f2..a9b41d8 100644
> --- a/compat/poll/poll.c
> +++ b/compat/poll/poll.c
> @@ -605,7 +605,7 @@ restart:
>
>    if (!rc && timeout == INFTIM)
>      {
> -      SwitchToThread();
> +      SleepEx (1, TRUE);
>        goto restart;
>      }
>
> --
> 1.9.2.msysgit.0.158.g6070cee
>

Thanks for taking the effort!

Acked-by: Erik Faye-Lund <kusmabite@gmail.com>
