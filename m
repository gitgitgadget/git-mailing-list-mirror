From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Diff format in packs
Date: Mon, 31 Jul 2006 21:13:13 -0400
Message-ID: <9e4733910607311813l78791e40l1234cf0e458db66f@mail.gmail.com>
References: <9e4733910607311408i10e17dse776920de7c5076a@mail.gmail.com>
	 <ealruh$sq9$1@sea.gmane.org>
	 <9e4733910607311420n8537b76lbde4d60062195403@mail.gmail.com>
	 <46a038f90607311747j947c786s6af2fe637dbde89d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 03:13:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7iow-0001Ua-Dr
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 03:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbWHABNP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 21:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbWHABNP
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 21:13:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:47846 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030379AbWHABNP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 21:13:15 -0400
Received: by nf-out-0910.google.com with SMTP id x30so87325nfb
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 18:13:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CmxxlG/wTHUubug3bU7R60LLzjAUdsJ1gR/1HVbQCYXu8xoN7P2J6Wo3goTWum01xuj8tuFt8+pbVV4LpS2TjpUyP6c42qdQIBvUmvzZVFDywvMOF86SXqrRUH3oF25mYVUrQUWNteDUgXBRYCKvIoF0rKoryuW1Ir7Qbu/tu8I=
Received: by 10.78.117.10 with SMTP id p10mr88160huc;
        Mon, 31 Jul 2006 18:13:13 -0700 (PDT)
Received: by 10.78.149.8 with HTTP; Mon, 31 Jul 2006 18:13:13 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90607311747j947c786s6af2fe637dbde89d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24561>

On 7/31/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> Jon,
>
> just get all the file versions out of the ,v file and into the GIT
> repo, then do find .git/objects/ -type f | git-pack-objects. You don't
> have to even think of generating the packfile yourself.

Moz CVS expands into over 1M files and 12GB in size. I keep getting
concerned about algorithms that take days to complete and need 4GB to
run.

> On 8/1/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > I am working on combining cvs2svn, parsecvs and cvsps into something
> > that can handle Mozilla CVS.
>
> If you publish your WIP somewhere, I might be able to jump in and help
> a bit. I've seen your "challenge" email earlier, but haven't been able
> to get started yet -- lots of work on other foss fronts.

I haven't got anything useful yet, I keep switching in and out of
working on this. I am still trying to work out a viable transition
strategy that I can attempt to sell the Mozilla developers on. So far
I don't have one.

The requirements I have so far:
1) the conversion needs to be reproducible so that Moz staff can do it
internally without a lot of hassle. They need to verify that nothing
has been lost.
2) It shouldn't need a monster machine to run it and it can't take
days to finish
3) It has to have incremental support so that it can be run in
parallel with CVS with commits still going to CVS.
4) nothing can be lost out of existing CVS
5) a bonus feature would be a partial repository to avoid the initial
700MB git download.

cvsps meets these requirements except for not losing anything out of
the existing CVS. cvsps is throwing away some items it finds
confusing. So far the only algorithm that appears to successfully
convert all branches into change sets is the algorithm in cvs2svn.
http://cvs2svn.tigris.org/source/browse/cvs2svn/trunk/design-notes.txt?rev=2536&view=markup

I've spent more time looking at parsecvs than cvsps, is it reasonable
to convert cvsps to the algorithm described above? Another strategy
would be to use cvs2svn to build the changeset database and then use
cvsps to simply read the changesets out of it and build the git
repository.

Parsecvs never finishes the conversion it always hits an error or GPF
after 4-5 hours, probably a wild pointer somewhere.

-- 
Jon Smirl
jonsmirl@gmail.com
