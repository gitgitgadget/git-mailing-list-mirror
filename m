From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Storing state in $GIT_DIR
Date: Fri, 26 Aug 2005 13:30:46 +1200
Message-ID: <46a038f905082518306e9d7d2a@mail.gmail.com>
References: <46a038f905082420323b025e3b@mail.gmail.com>
	 <Pine.LNX.4.58.0508251053000.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: GIT <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 04:30:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8T3u-0005i6-Qa
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 03:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbVHZBau (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 21:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbVHZBau
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 21:30:50 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:51827 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965042AbVHZBat convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2005 21:30:49 -0400
Received: by rproxy.gmail.com with SMTP id i8so473411rne
        for <git@vger.kernel.org>; Thu, 25 Aug 2005 18:30:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uNLjIHdyhCg5VHuXRUDLMVCuJAnshmca8XSVFVJt3z+tVrY4AeSql6Ys1CPhxU37k+h9i5zT7gZsOZ3uwwdvJYIJtUJP5cjM48pQpNshee6DdND/Rw/wI7+ws/jxOPVLfAcejeV7qj0ocAAglpsRnpd+mfz0g7WcEyCqqHU+0ro=
Received: by 10.39.3.42 with SMTP id f42mr1440401rni;
        Thu, 25 Aug 2005 18:30:46 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Thu, 25 Aug 2005 18:30:46 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508251053000.3317@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7777>

Linus, 

I like the solution you are suggesting, but I suspect it will create
more problems that it will solve, and while the coolness factor is
drawing me in.... we ain't gonna need it, as the xp people say.

More below...

On 8/26/05, Linus Torvalds <torvalds@osdl.org> wrote:
> Git won't care, so it will work, but things like clone/pull etc also won't
> actually ever look there, so it will only work for that one repo.

Storing things there _works_ in the sense that it will be ignored, and
that is fine with me. So I could just be lazy and have it strictly
tied to the repo. In practice, if you are tracking an external Arch
repo, you really have it scripted, and use a dedicated git repo for
that.

Not using a dedicated repo is quite... messy. If you do other things
in that particular repo, the import script may find it dirty, and mess
things up on import. And after the import, you'll probably run
git-push-script --all because it's bringing a dynamically growing
forest of heads from the arch repo. That's another reason why your
private branches should be elsewhere.

OTOH, storing the metadata in a branch will allow us to run the import
in alternating repositories. But as Junio points out, unless I can
guarantee that the metadata and the tree are in sync, I cannot
trivially resume the import cycle from a new repo.

> The git solution to this (which nobody has ever _used_, but which
> technically is wonderful) is to have a "side branch" that does not share
> any commits (or files, for that matter) in common with the "real branch",
> and which is used to track any metadata. In fact, you can obviously have
> any number of side branches.

A couple of days ago, playing with the import, I realised that the git
repo can hold unrelated projects, too, if you just commit orphan trees
as new heads. I mean - it was a bug in my script but I thought it was
cool. ;)

> The way to maintain a metadata branch is to have not only a different
> branch name (obviously), but also use a totally different index file, so
> that you can index both branches in parallell, and you don't actually need
> to check out one or the other.

Hmmm. Now that's voodoo magic! I was thinking of reading the file by
asking directly for the object by its sha, or doing a checkout in a
tmpdir. Interesting.

cheers,


martin
