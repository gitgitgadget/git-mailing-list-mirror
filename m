From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: can we prevent reflog deletion when branch is deleted?
Date: Sat, 1 Jun 2013 23:26:11 +0530
Message-ID: <CALkWK0=SqCh-82F4ud+AxuzzEezyMWqMvc6HAPoxOk32vUND7A@mail.gmail.com>
References: <CAMK1S_jY1tDCkyOamX8XNW9g8Dzf6yN9znwN6he-EVcOkBM1fQ@mail.gmail.com>
 <51A963B7.6060002@alum.mit.edu> <20130601050355.GA23408@sigill.intra.peff.net>
 <CALkWK0kcJH0t4i0BAPmMkNWwNzeJNdmg_wbt3ao-=R31kJ5noA@mail.gmail.com>
 <20130601090934.GA13904@sigill.intra.peff.net> <CALkWK0mwAc0bFon7B7nw1Nbvcwdf8m2_531qtrN-r28r9F+70Q@mail.gmail.com>
 <CAMK1S_hPups3SCwxhHRYWBJzpPreNVUfNdx1+_Hjy2_d0MMpaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Elijah Newren <newren@gmail.com>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 01 19:57:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uiq38-0002HG-5e
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 19:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881Ab3FAR4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 13:56:54 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33786 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab3FAR4x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 13:56:53 -0400
Received: by mail-ie0-f180.google.com with SMTP id b11so6834506iee.39
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 10:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kpcmvTX1d6ri89lx5PvtkLCH+njRYY+8rsvbsWi4Cao=;
        b=RctKRlJyacHZkjf44RHuDYBcsM//M9LQPh6TUJYuExdXpDHRZOOk2QQXe9VKXw2TAo
         zc0cBaPCy29tV6iMDZwelMyCjtX13v7D14Xh/dteii+zlIe3fb+1PS1TMlGZxv24nRpm
         pdi43qODjkWvsQG2NYqQVSwlDFsXqgsFbMyySOkALubvy5A2kiNP7C6Q/a5Ve5MvZQED
         1ErIBjkLvuj7lji4SgmHqPm+ZKXCMYjUJU0qyvBPEPUgquaJESRJl5bR8MtQ0D4VJ5Vm
         lgLBrGeQDZ8a/DvIyuTh1RruuSx1/ENs5vlr7Wg+s9xkDdRRdo5J2Z0WwBjL+c7n/hlE
         T2jQ==
X-Received: by 10.50.41.99 with SMTP id e3mr4193074igl.104.1370109411689; Sat,
 01 Jun 2013 10:56:51 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Sat, 1 Jun 2013 10:56:11 -0700 (PDT)
In-Reply-To: <CAMK1S_hPups3SCwxhHRYWBJzpPreNVUfNdx1+_Hjy2_d0MMpaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226144>

Sitaram Chamarty wrote:
> I think I'd have to be playing with *several* branches simultaneously
> before I got to the point of forgetting the branch name!

Yeah, I work on lots of small unrelated things: the patch-series I
send in are usually the result of few hours of work (upto a few days).
 I keep the branch around until I've rewritten it for enough re-rolls
and am sufficiently sure that it'll hit master.

> More to the point, your use case may be relevant for a non-bare repo
> where "work" is being done, but for a bare repo on a server, I think
> the branch name *does* have significance, because it's what people are
> collaborating on.
>
> (Imagine someone accidentally nukes a branch, and then someone else
> tries to "git pull" and finds it gone.  Any recovery at that point
> must necessarily use the branch name).

Ah, you're mostly talking about central workflows.  I'm on the other
end of the spectrum: I want triangular workflows (and git.git is
slowly getting there).  However, I might have a (vague) thought on
server-side safety in general: I think the harsh dichotomy in ff-only
versus non-ff branches is very inelegant.  Imposing ff-only feels like
a hammer solution, because what happens in practice is different: the
`master` does not need to be rewritten most of the time, but I think
it's useful to allow some "safe" rewrites to undo the mistake of
checking in an private key or something [*1*].  By safety, I mean that
git should give the user easy access to recent dangling objects by
annotating it with enough information: sort of like a general-purpose
"pretty" reflog that is gc-safe (configurable trunc_length?).  It's a
serves more usecases than just the branch-removal problem.

Ofcourse, the standard disclaimer applies: there's a high likelihood
that I'm saying nonsense, because I've never worked in a central
environment.

[Footnotes]

*1* It turns out that this is not uncommon:
https://github.com/search?q=path%3A.ssh%2Fid_rsa&type=Code&ref=searchresults
