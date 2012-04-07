From: Steven Michalske <smichalske@gmail.com>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Sat, 7 Apr 2012 22:49:04 +0800
Message-ID: <DA8EB64A-CF66-47B2-A860-0B22F92B7301@gmail.com>
References: <201202042045.54114.jnareb@gmail.com> <201202061814.58346.jnareb@gmail.com> <CALKQrgcUdigB5zB_bqgpW8=o-TuGChs+q2nYoXu5YdyWu+oWZw@mail.gmail.com> <201202071531.08385.jnareb@gmail.com> <CALKQrge821x7OoSekkWw7vUjP642jhbE0D9oWPcCxuuTXOqQHA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 16:54:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGX26-00072p-H0
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 16:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681Ab2DGOy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 10:54:26 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:47080 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab2DGOyZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Apr 2012 10:54:25 -0400
Received: by dake40 with SMTP id e40so3720622dak.11
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 07:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=CmzuS708xoMzx0EIsUs8rqHd8OFMm477O+K4/i1cRRQ=;
        b=aYeSEeb3n0UDniH8Un70/kgM3tAR4eY6PAqzF/VFhA0Pb05rKDOmNWf8zB11p9FFEM
         AVzznOuD9y6MAc/dSz0S8OCaxrUxCva7aakHtlWLhpsGMlsB73jPPHuOQ2LnTPcldSrU
         sKDmL1Y2XtGpxAkc7aqfKnPCMX6SwdXw6Or6v+JW74mTBfGKpnixCK1qL/5p3XR9fyMF
         Z3EzhHhJH2uPKAhNbcw6aFl7FBpQfP9iGCVhLJS5KQbfDgn6dgslpIKyXzS5FsNZ34fr
         LqV7ZUUqCKsD2yHm0Ut2qPgmyV/LDS/4fc+emoe4IFWvh0TNqEtaU2td8VEvhJnJdRWk
         A1vA==
Received: by 10.68.239.233 with SMTP id vv9mr4482656pbc.75.1333810464751;
        Sat, 07 Apr 2012 07:54:24 -0700 (PDT)
Received: from [10.0.1.2] ([222.66.106.162])
        by mx.google.com with ESMTPS id ns1sm301790pbc.29.2012.04.07.07.54.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 Apr 2012 07:54:23 -0700 (PDT)
In-Reply-To: <CALKQrge821x7OoSekkWw7vUjP642jhbE0D9oWPcCxuuTXOqQHA@mail.gmail.com>
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194953>


On Feb 7, 2012, at 11:09 PM, Johan Herland wrote:

> (we are pretty much in violent agreement, so I will only comment where
> I find it necessary)
> 
> On Tue, Feb 7, 2012 at 15:31, Jakub Narebski <jnareb@gmail.com> wrote:
>> Also, when thinking about different scenarios of why one would like to
>> mark commit as 'secret', we might want to be able to mark commit as
>> secret / unpublishable with respect to _subset_ of remotes, so e.g.
>> I am prevented from accidentally publishing commits marked as 'secret'
>> to public repository, or to CI/QA repository, but I can push (perhaps
>> with warning) to group repository, together with 'secret'-ness state
>> of said commit...
>> 
>> ... though it wouldn't be as much 'secret' as 'confidential' ;-)
> 
> Another way to achieve this would be to have a config flag to control
> whether Git checks for the 'secret' flag before pushing. This config
> flag could be set at the system/user level (to enable/disable the
> feature as a whole), at the repo level (to enable/disable it in a
> given repo), at the remote level (to enable/disable it on a given
> repo), and finally at the branch level (to enable-disable it for a
> given branch (and its upstream)). Thus you could have a .git/config
> that looked like this:
> 
>  [core]
>  refusePushSecret = true
> 
>  [remote "foo"]
>  refusePushSecret = false
>  url = ...
>  fetch = ...
> 
>  [branch "baz"]
>  remote = foo
>  merge = refs/heads/baz
>  refusePushSecret = true
> 
> This config would:
> 
> - refuse to push 'secret' commits from branch 'baz'
> (branch.baz.refusePushSecret == true)
> 
> - but allow to push other branches with 'secret' commits to remote
> 'foo' (remote.foo.refusePushSecret == false)
> 
> - but refuse to push 'secret' commits to other remotes
> (core.refusePushSecret == true)
> 
> (The order of precedence would be: branch config > remote config >
> repo config > user config > system config > default when unset)
> 
> I am unsure whether the 'secret'-ness of a commit should follow across
> the push, but if you do (assuming we store the 'secret' flag using
> git-notes) this is simply a matter of synchronizing the
> refs/notes/secret to the same remote.
> 
I think this would allow teamwork on selected remotes!

Though after reading all the discussion on this thread I now feel that there are some different forms of secret.

Stuff you want to only exist on your repository, hacks, junk and stuff.
or
Material that should not go to your public facing repository.
or
A commit containing a file that is not for public consumption, but something you want tracked in the same repo.
This might be an incompatible concept; I cope with this by using a git submodule called internal in the code base, it works well.

> 
> Have fun! :)
> 
> ...Johan
> 
> -- 
> Johan Herland, <johan@herland.net>
> www.herland.net
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
