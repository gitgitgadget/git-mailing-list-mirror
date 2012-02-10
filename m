From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: nested git repos (not submodules)
Date: Fri, 10 Feb 2012 16:30:57 -0600
Message-ID: <4F359AA1.2000901@gmail.com>
References: <jh1vo3$7af$1@dough.gmane.org> <7vd39ns4py.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 23:31:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvyzl-0006tH-Pe
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 23:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760289Ab2BJWbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 17:31:03 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49472 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab2BJWbC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 17:31:02 -0500
Received: by ghrr11 with SMTP id r11so1766742ghr.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 14:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=v65ce0KKlWbPHYOXlqEoh+AwvT48hhOfOBHkBFPBYOE=;
        b=c+2YdRHOVkiPjzFk0kUR+PsyJJt62bABY9p8fagmAvGQ4ltf/DESkfHz0T+6YemqeC
         0L5nkOnoJBltc+cwvh0AtZ8k9QNjYZA60TKIH7pUmbJx2tlzEDP9uBupc8atv5PD3YUS
         6M6njKBJ++n3JxO+vFT5pBro3VaLTbfmmn79s=
Received: by 10.236.193.41 with SMTP id j29mr11649873yhn.12.1328913061625;
        Fri, 10 Feb 2012 14:31:01 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id o61sm11807364yhk.10.2012.02.10.14.31.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 14:31:00 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.26) Gecko/20120129 Thunderbird/3.1.18
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vd39ns4py.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190471>

On 2/9/2012 10:16 PM, Junio C Hamano wrote:
>
> The repository controlled by worktree/.git should behave as if subdir/
> does not exist, except that obviously the project cannot have a regular
> file "subdir" in it.  When you chdir to worktree/subdir, everything in
> there should behave as if worktree/.git directory does not exist.
>
> At least that is the design, and it indeed is how I arrange my primary
> working tree (I have two "clones" at /git/git.git/ and /git/git.git/Meta,
> and the latter has a checkout of the "todo" branch), so I would make
> noises about any breakage for such a layout.
>
I now see that most of the concept of "a repo worktree path with an o/s 
subdir containing another repo" is valid provided that the repo is 
ignoring the worktree of the subdir repo.

> I do not know offhand if an attempt to add files inside subdir to the
> repository controlled by worktree/.git is always correctly prohibited by
> the code, though, as our code often forgets to error out "stupid user
> mistakes", and running "git add subdir/bar" when in worktree/ falls into
> that category.
>
In my situation, WORKTREE/.git is tracking the worktree of 
WORKTREE/SUBDIR/.git.  Before WORKTREE/SUBDIR/.git was created, 
WORKTREE/SUBDIR/ was already being tracked by WORKTREE/.git because 
WORKTREE/SUBDIR/. directly correlates to the rest of WORKTREE/., 
WORKTREE/SUBDIR2/., etc.  Now that I know that having "a repo tracking 
the worktree of a nested repo" is not a sound model, I can advise 
against it on a go-forward basis without being concerned that I am not 
open to new ideas.

> And the use of that layout predates the submodules by a large margin.
> In fact, when people suggest use of submodules when the toplevel and the
> sublevel do not even need tight version dependencies, some of their use
> cases might be better supported by using the simply-nested layout without
> even letting the toplevel be aware of the sublevel.

I will keep this in mind when adding submodules.

Thanks!

v/r,
neal
