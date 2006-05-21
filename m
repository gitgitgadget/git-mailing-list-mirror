From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: synchronizing incremental git changes to cvs
Date: Sun, 21 May 2006 12:09:19 +1200
Message-ID: <46a038f90605201709n3a840fd9n7e85a289f49a3c5f@mail.gmail.com>
References: <87mzdcjqey.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 02:09:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhbVb-0005bz-91
	for gcvg-git@gmane.org; Sun, 21 May 2006 02:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWEUAJU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 20:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWEUAJU
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 20:09:20 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:46314 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932219AbWEUAJU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 20:09:20 -0400
Received: by wr-out-0506.google.com with SMTP id i30so884307wra
        for <git@vger.kernel.org>; Sat, 20 May 2006 17:09:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SOahP2yIic+Sj1EkLI1stQm6lS9AGR5VOANLpd9KKChvyggvMynEV+++gBoMlcXBVWtvLYWMxXqdYIv30Ag+ULxAa7+lekkhBlyi83Q2SItAnliqhQOQwXAtq6NGbDBtbqTYVmvI9lVLMY7Eoi7Zun7Oy3BQziS2UBIxWFcLwsg=
Received: by 10.54.139.3 with SMTP id m3mr2511071wrd;
        Sat, 20 May 2006 17:09:19 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Sat, 20 May 2006 17:09:19 -0700 (PDT)
To: "Jim Meyering" <jim@meyering.net>
In-Reply-To: <87mzdcjqey.fsf@rho.meyering.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20410>

On 5/21/06, Jim Meyering <jim@meyering.net> wrote:
> Can anyone point me at code to mirror a git repository to cvs?

Ive thought a couple of times about writing an exporter that would
replay things into a true CVS repo, but it's truly not worth it. We've
already got git-cvsserver that does all that -- better for me to focus
on that codebase.

> I've experimented with git-cvsexportcommit, and found a few bugs (it
> couldn't handle simple things, like adding a file in a new directory --
> fixed that, along with a few other minor problems), adding an empty file
> in git still gets a patch application error on the cvs side, but I can
> live with that for now.  More seriously, making a change on a git branch
> mistakenly tries to apply the delta on the cvs trunk.

cvsexportcommit is clearly for manual usage, not for automagic usage.
It is a bit rough, (and I'd like to see your patches to it!) but it
wants to be driven by a smarter script to, for instance, know what
branch you want things in.

> Why am I interested?  I want to switch the development of GNU coreutils
> from cvs to git.  I would also like to continue making the repository
> available via cvs, for the sake of continuity.  At worst, I can always
> cut the CVS cord, but that's a last resort.

git-cvsserver is the word. It currently tracks the git repo itself
pretty well (perfectly, AFAICS) and it also tracks a git tree that is
actually imported daily from CVS -- doing

    CVSrepo ->cvsimport -> GIT -> cvsserver -> CVS checkout

git-cvsserver works great for anon cvs access (does pserver) and
TortoiseCVS and cli cvs work great with it. Eclipse works well, but it
has been quite hard to get 'right'. Optionally, it can support users
with commit rights via ssh. It does track git 'heads' but they don't
show up as branches, they show up as different modules. So you to get
a checkout of the master branch, you do:

    cvs -d pserver:anonymouys@foo.com:/var/foo.git co master

hope that helps!




martin
