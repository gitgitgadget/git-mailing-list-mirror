From: Johan Herland <johan@herland.net>
Subject: Re: Git -> fossil bridging?
Date: Mon, 18 Nov 2013 08:17:32 +0100
Message-ID: <CALKQrgd9u3Oqrs8wbGqhq17=yFofFKpnFLtwfb-5A8JfVkrW7A@mail.gmail.com>
References: <20131117150010.675971d3@bigbox.christie.dr>
	<575D57DB-026F-484E-8068-E7965395E902@gmail.com>
	<20131117182650.1ba89a8b@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	"Kyle J. McKay" <mackyle@gmail.com>
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Mon Nov 18 08:17:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViJ5d-0004S6-3f
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 08:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051Ab3KRHRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 02:17:41 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:55620 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714Ab3KRHRj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 02:17:39 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1ViJ5V-0004kZ-Jn
	for git@vger.kernel.org; Mon, 18 Nov 2013 08:17:37 +0100
Received: from mail-pa0-f43.google.com ([209.85.220.43])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ViJ5U-000J4S-Ut
	for git@vger.kernel.org; Mon, 18 Nov 2013 08:17:37 +0100
Received: by mail-pa0-f43.google.com with SMTP id fa1so6344827pad.30
        for <git@vger.kernel.org>; Sun, 17 Nov 2013 23:17:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TvavMtqm4l9nsn628Xry8vy/0sK+HomptoDwgYDPDkg=;
        b=YUwbP04dYRpaSvfORRdKWqPTfF8FJAyGZZLJWsK+U2tBbUEIw+IpcSDIN/2QTGcxY7
         KSSsj+Uc0+ax7tvXAfnVWqgSH7pbb2RvVMtFtU9ar+SeIRkkG9a/o3gncOeKakhHOggo
         ZWtbSCMj2e0JAcuIUNhvvDkuDRGbiQDBzBzUxS1JoHTA/gfnisWasUQxngC13vwSrcfU
         /D6ZaRBnBj9HxG1gdBH0SbvJlmrc5vr+N5oi1QwQg8gdmx9zhKgqDfBLnE0tqW/BOEjq
         QOgVdjjk1gGPMNq1tYpFpTAwbk0tIrfQ+GwX7aOeIjuwCCPNid91zhvN8YG+lIe3JbS1
         6Bhw==
X-Received: by 10.66.123.5 with SMTP id lw5mr19564606pab.83.1384759052851;
 Sun, 17 Nov 2013 23:17:32 -0800 (PST)
Received: by 10.70.24.226 with HTTP; Sun, 17 Nov 2013 23:17:32 -0800 (PST)
In-Reply-To: <20131117182650.1ba89a8b@bigbox.christie.dr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237976>

On Mon, Nov 18, 2013 at 1:26 AM, Tim Chase <git@tim.thechases.com> wrote:
> On 2013-11-17 14:43, Kyle J. McKay wrote:
>> Sounds like you want to write a 'git-remote-fossil' helper so you
>> can do something like:
>>
>>    git clone fossil::http://sqlite.org/src
>
> Pretty much.  Or at least something akin to git-svn where one would do
>
>   git fossil clone http://some.fossil.url/path/to/repo.fossil
>   # hack hack
>   git commit
>   # possibly some git-branch, git-merge, git-rebase, git-cherry-pick
>   # lather, rinse, repeat
>   git fossil push # or git fossil dcommit
>
> I've not played with the git+hg or git+bzr bridges to see if they'd
> have a more useful interface that would better map to fossil.  If so,
> imagine that's what I typed above ;-)

If you're looking at implementing this, please look at "git help
remote-helpers" (or
https://www.kernel.org/pub/software/scm/git/docs/git-remote-helpers.html
) which describes an infrastructure (in addition to
fast-import/export) we have for interacting with foreign version
control systems. A remote helper for fossil repos would allow you to
consider the fossil repo as a git remote, and the usual git
clone/fetch/pull/push commands for interacting with remote repos would
Just Work against a fossil repo.

I understand how you might want to model this on "git svn", since that
is obviously the most popular interface between git and an other VCS,
but I believe git-svn is not the best example for how to write these
gateways nowadays. git-svn was written long before git remote-helpers
existed, but I hope/believe that if it was written again today, it
would use remote-helpers instead of implementing its own commands.

git-remote-bzr and git-remote-hg in contrib/remote-helpers/ is the
code that implements the git+bzr and git+hg bridges you mention above.
Those would be useful reference points when implementing a
git-remote-fossil helper. git-remote-mediawiki in contrib/mw-to-git/
might also be a useful example.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
