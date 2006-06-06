From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Importing Mozilla CVS into git
Date: Wed, 7 Jun 2006 07:57:22 +1200
Message-ID: <46a038f90606061257v569aefackc4920a20f2970b0f@mail.gmail.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <1149204044.27695.38.camel@neko.keithp.com>
	 <9e4733910606011755n29a149f2m1409c5a23888f1c5@mail.gmail.com>
	 <9e4733910606022128h23ff94fbg3fcb4fa191254b5a@mail.gmail.com>
	 <46a038f90606052255s62cda81bt62d7442beb26658a@mail.gmail.com>
	 <9e4733910606060813r41037467u74235f7a9386c1e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 21:57:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnhgF-0002Wu-AI
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 21:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWFFT5Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 15:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWFFT5Z
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 15:57:25 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:50673 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751060AbWFFT5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 15:57:24 -0400
Received: by wr-out-0506.google.com with SMTP id i20so12895wra
        for <git@vger.kernel.org>; Tue, 06 Jun 2006 12:57:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S0lnwtq4anVBobobq9uvSU9qR8aTP0lejmK+mAhEp/1UeVXB9k8X8GKaieLIql0Tt7fOFKgsRZi6ojVv+EPUgL2xapZXD/KhkSDEEzk+1b45hmACeUm6LL8HuheEyl93eaRz6zWK6Y4/DJSm0czSSz1cr9Bc0bnAlxdIP3AZWNI=
Received: by 10.54.135.7 with SMTP id i7mr1173989wrd;
        Tue, 06 Jun 2006 12:57:22 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Tue, 6 Jun 2006 12:57:22 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606060813r41037467u74235f7a9386c1e0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21398>

On 6/7/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> Have you looked at the SVN CVS import tool? It imported Mozilla on the
> first try. If you download the source they have built about 40 test
> repositories with various errors. Those would make a good test suite
> for cvsps.  http://cvs2svn.tigris.org

Haven't yet, but I'll do. I'm currently quite busy at work, but I'm
running these imports (Moz, Gentoo) and trying to address issues
arising. Will look into SVN's tool it when I have a bit more time.

What I'll probably do is steal those test cases! ;-)

> I have been working on converting the svn tool to do git commands but
> my git knowledge is limited so it has been slow going. The last stage,
> pass 8, is very similar to what the git tools do. The svn commands
> just need to be swapped for git ones.

That would be interesting. And yet, I would have to evaluate how to
transition gateways running git-cvsimport incrementally to a different
importer.

Does it do incremental imports?

> If you get git-cvsimport working I'll use it instead. Will the cvsps
> process stay small enough to run on a 32b machine? The svn tools are

Currently not, but I do hope that the moz team has access to at least
one machine with more than 32MB ;-)

With the current code, you will want a 3GB machine to run the git-cvsimport

git-cvsimport has a memory leak that I've been chasing for a while and
I'll eventually fix, so it should fit in 32MB comfortably. cvsps is
memory bound, and will probably take quite a bit of work to fix that.
However, I suspect we can make it a lot more efficient.

> very RAM efficient since they use an external db. Can cvsps read from
> a local copy of the repository without using a CVS server?

> We are going to have to develop some kind of incremental mechanism for
> updating the new git tree. It can take up to two days to convert the
> repository, Mozilla development can't be shut down that long for a

You don't have to. Run an initial import, and then freeze development
and run an incremental -- which will take an hour at the most. And
then your mozilla.git repo is ready and up to date.

> transition. Git will also need to mirror the CVS repository (check-in
> still going to CVS) for a long time while we convince everyone on the
> merits of switching.

That's easy -- run git-cvsimport on a cronjob.

> My imported svn version of Mozilla has a lot of performance problems.
> One of the directories has over 200,000 files in it slowing downing
> the filesystem. The repository went from 3GB CVS to 8GB svn, probably
> due to svn using 1000s of tiny files. I'll look around and see if svn
> has a pack feature like git.

At least they got a good importer ;-)

cheers,


martin
