From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 0/3] mergetool/difftool cleanup
Date: Fri, 21 Nov 2014 16:20:00 -0800
Message-ID: <20141122001956.GA70804@gmail.com>
References: <1416532829-68662-1-git-send-email-davvid@gmail.com>
 <xmqqmw7kz73w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 22 01:20:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XryQv-0006M1-0s
	for gcvg-git-2@plane.gmane.org; Sat, 22 Nov 2014 01:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbaKVAUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 19:20:06 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:56495 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382AbaKVAUF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 19:20:05 -0500
Received: by mail-oi0-f49.google.com with SMTP id i138so4409298oig.36
        for <git@vger.kernel.org>; Fri, 21 Nov 2014 16:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=p4aAzIENQeofdHSMQzknnaBXLgNeGCn5yDEy7btYe1Y=;
        b=FAs+d1Lbn5MLolvSAbGpEdb3u21YbnwhD3PMrKPERbQPLh1ojFvvwHQtqnsWgddR1q
         qyE26KZfBWfL92CWo5zDx3eYtGAORCC/kjBJMZxOlohAexsS0CGcVAjOhrmQOP+UGMSg
         6kJZRFtux77+RpmoA0Bmst+oPl7qVl3VjeqwPlOiFC88x3pUi+hGXU8fLZTlLSSdaIFD
         LgpNf+dWfzF2TTyluZCkYmGvpbnW0/i6ZkRaZAUir1b4IIFJEcBJN5Briilnx4NF+wRl
         W9rcz3TyE1Gebd0B48WPcJOHDM+rfWrX63QW1cSBULvpO669RqVQUhdfXPkvNKh2im+p
         b/iA==
X-Received: by 10.202.232.213 with SMTP id f204mr4610119oih.51.1416615604585;
        Fri, 21 Nov 2014 16:20:04 -0800 (PST)
Received: from gmail.com ([32.145.178.174])
        by mx.google.com with ESMTPSA id wk3sm2786438obc.3.2014.11.21.16.20.03
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 21 Nov 2014 16:20:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqmw7kz73w.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 21, 2014 at 11:28:03AM -0800, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > This is a cleanup series to remove the use of the $status
> > global variable in mergetool/difftool.
> >
> > This should wait until after the current RC series is
> > over but figured I'd send it out.
> >
> > David Aguilar (3):
> >   mergetool--lib: remove use of $status global
> >   difftool--helper: add explicit exit statement
> >   mergetool: simplify conditionals
> >
> >  git-difftool--helper.sh |  2 ++
> >  git-mergetool--lib.sh   | 20 +++++---------------
> >  git-mergetool.sh        | 16 +++++-----------
> >  3 files changed, 12 insertions(+), 26 deletions(-)
> 
> Looked quite straight-forward from a cursory read.
> 
> I tentatively inserted the attached patch before 1/3.  If the series
> was done with that extra step as preliminary clean-up, I wouldn't
> have had to wonder if the hunk at "@@ -130,13" was correct.


That makes a lot of sense, please do insert this patch before
1/3 (actually 1/4 with the additional patch I sent after the
initial submission).

Thanks,
David

> 
> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Fri, 21 Nov 2014 11:17:57 -0800
> Subject: [PATCH] mergetool--lib: remove no-op assignment to $status from setup_user_tool
> 
> Even though setup_user_tool assigns the exit status from "eval
> $merge_tool_cmd" to $status, the variable is overwritten by the
> function it calls next, check_unchanged, without ever getting looked
> at by anybody.  And "return $status" at the end of this function
> returns the value check_unchanged assigned to it (which is the same
> as the value the function returns).  Which makes the assignment a
> no-op.
> 
> Remove it.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  git-mergetool--lib.sh | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 2b66351..3e06389 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -130,7 +130,6 @@ setup_user_tool () {
>  		then
>  			touch "$BACKUP"
>  			( eval $merge_tool_cmd )
> -			status=$?
>  			check_unchanged
>  		else
>  			( eval $merge_tool_cmd )
> -- 
> 2.2.0-rc2-128-ge2b5e8e
> 
