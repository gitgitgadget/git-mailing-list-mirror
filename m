From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [RFC] Add --index to git-commit: just commit current index
Date: Fri, 16 Mar 2007 10:37:49 +0100
Message-ID: <81b0412b0703160237l90dd158x87646be6c2731886@mail.gmail.com>
References: <81b0412b0703150243h6a5f036aye8f115d82e11e883@mail.gmail.com>
	 <7vird2yr1w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 16 10:37:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS8sk-0005dO-TE
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 10:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933271AbXCPJhw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 05:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933265AbXCPJhv
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 05:37:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:37157 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933262AbXCPJhu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 05:37:50 -0400
Received: by nf-out-0910.google.com with SMTP id o25so178742nfa
        for <git@vger.kernel.org>; Fri, 16 Mar 2007 02:37:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jX7VoLITdCn6LoMZL+n49Nt9yUj6dML+bru/svfH/RaXbaQV54TnGOMEK3shz8RklqrsNWu86xFj//vZsaLIKuf9yd9ug7jBkT/EECamQCXuYmo/gohiIfoh8P+3u144WYsq2raQnfqdM95UZldWxRRhuh3TRSTwQi3S1BWZ7qI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dWOdB2USPg/ta5dmobY7aUa6VWsUOevuCF1i/ztssIkBUsFdpgnh2LfQdbq0Pxh0+2w1QBZtH5iaYexEN4U/1w+vF3gtedQyj5OObbZWn8yiQkef+yblw39undD0Yie/Me0BM/GJnxEywlGUIfmDZ5UMDdvYgS1rW75dbkDVx08=
Received: by 10.78.180.18 with SMTP id c18mr849366huf.1174037869343;
        Fri, 16 Mar 2007 02:37:49 -0700 (PDT)
Received: by 10.78.138.5 with HTTP; Fri, 16 Mar 2007 02:37:49 -0700 (PDT)
In-Reply-To: <7vird2yr1w.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42340>

On 3/16/07, Junio C Hamano <junkio@cox.net> wrote:
>
> > First use of new --quiet :)
>
> You do not need to say --exit-code if you use --quiet.

Just forgot it in

> > Refreshing index takes a long time on big repositories with
> > many files, especially if the developer was unlucky enough to
> > stick to a slow filesystem or a broken OS. In this situation
> > explicit git-update-index with git-commit --index will speedup
> > the workflow.
>
> Does it?

IFF you use git-update-index, yes

> A typical workflow would go something like this:
>
>         - repeat from here
>         - "edit foo"
>         - "edit bar"
>         - "git diff" to help me see what I changed
>         - "git add foo" as the change is sane
>         - test and see breakage
>         - "git diff HEAD" to help me see what I broke
>         - go back to 'here' to fix it up
>         - "git diff HEAD" to help me see what I changed
>         - "git add foo bar" to include what I changed
>         - "git commit"

- edit
- test
- edit
- test
- update-index (or add) file(s)
- git commit --index <--- this is faster than before
- repeat

> If I have a large project on a filesystem with slow lstat(2), I
> would imagine your development is slowed anyway because you
> would use diff far more often than commit.  I wonder if it may

I avoid using diff-files for the whole project. diff-index --cached is
fast always. It is ok even on windows

> be a better idea to use (and extend if needed) existing 'assume
> unchanged' on such a system, exactly because "diff" side would
> take more time than final "commit", and if you do use 'assume
> unchanged', then it also makes --refresh a no-op.

Forgot about it too. It didn't seem to work properly, the last time
I tried (for a long time, I admit). Besides, sometimes I want to do a
refresh, and having to switch the option on and off is annoying.

> In any case, I think your --index is a misnomer, as we do commit
> the current index.  If the sole purpose of your patch is to omit
> refreshing it, then it should be named as such.

--no-refresh?
