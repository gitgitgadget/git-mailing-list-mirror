X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [Fwd: Re: What's in git.git]
Date: Sun, 19 Nov 2006 14:11:53 -0500
Message-ID: <9e4733910611191111q65424631j875f444c9bb367f7@mail.gmail.com>
References: <20061119171135.GA13054@spearce.org>
	 <9e4733910611190940y147992b8mbdfac5a51f42e0fe@mail.gmail.com>
	 <20061119174902.GW7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 19 Nov 2006 19:12:01 +0000 (UTC)
Cc: "Shawn Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iff9mscPDzsW6RxPrScYqOPy/ri197gDOlmALS8Nbj3cyFi8Qw+iy2iJ+gxhEfXPSxg6P6o9tiO1uCsrMnwPMRKskDAK3T3Rtfv5H2FKmm0RzRhEuPsijM2Tt/JzYdW/rEixFVXkZD6iXgiY4XROu+8dnduzBaVWGhe2vv+DXn0=
In-Reply-To: <20061119174902.GW7201@pasky.or.cz>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31856>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gls58-0000bN-1j for gcvg-git@gmane.org; Sun, 19 Nov
 2006 20:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933016AbWKSTLz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 14:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933038AbWKSTLy
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 14:11:54 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:37793 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S933016AbWKSTLx
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 14:11:53 -0500
Received: by py-out-1112.google.com with SMTP id a29so849540pyi for
 <git@vger.kernel.org>; Sun, 19 Nov 2006 11:11:53 -0800 (PST)
Received: by 10.35.20.14 with SMTP id x14mr2326pyi.1163963513271; Sun, 19 Nov
 2006 11:11:53 -0800 (PST)
Received: by 10.35.72.13 with HTTP; Sun, 19 Nov 2006 11:11:53 -0800 (PST)
To: "Petr Baudis" <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

On 11/19/06, Petr Baudis <pasky@suse.cz> wrote:
> On Sun, Nov 19, 2006 at 06:40:06PM CET, Jon Smirl wrote:
> > Brendan told me that he would not consider Mozilla moving to git until
> > a native Windows version is released so I just dropped the whole
> > thing. It is too much effort and they don't even really want it. They
> > are probably going to switch to SVN.  I told him that SVN would end up
> > being a disaster and he got mad at me. That's when I stopped working
> > on cvs2svn/git.
>
> I see. :-(
>
> Could you please publish cvs2git in whatever state you have it so that
> someone else possibly interested could pick it up and finish the missing
> bits? It would be shame if the already done work would end up wasted.

Working on cvs2git is the wrong direction. cvs2svn has been
specifically tuned for importing into SVN and they aren't interested
in making the architectural changes that git needs.

There is a core problem in the way cvs2svn handles CVS symbols.

> I posted a three commit example of the problem.
>
> FileA has rev 1.1 and rev 1.2
> FileB has rev 1.1
> A symbol is created between A 1.1/1.2 and after B 1.1
>
> cvs2svn generated two change sets
> 1) FileA 1.1
> 2) FileB 1.1, FileA 1.2
>
> With these two change sets it is impossible to base the symbol simply,
> there is no solution without copying. cvs2svn generates the symbol
> based on #1 and copies FileB 1.1 from #2.
>
> The alternative is to output three change sets which is also a valid
> representation of the same data.
> 1) FileA 1.1
> 2) FileB 1.1
> 3) FileA 1.2
>
> Now there is a solution for the symbol, base is on change set #2. No
> copies needed.
>
> By introducing symbol dependencies (which cvs2svn does not do) you can
> force the second change set sequence to be generated.

SVN allows a label to be made by picking a commit from six months ago
with 80% of the right files in it. They then link to revisions from
later commits to build up the file set needed for the label. Doing it
this way turns every symbol into a little branch. It is fixing the
symptoms rather than fixing the problem of figuring out the correct
construction of the change sets. The SVN people seem to be perfectly
happy with these little branches and they aren't going to change
cvs2svn.

cvs2svn is a nice piece of code and a good thing to look at for
reference. It includes some excellent test cases. The author is a
Python expert and uses every last feature of the language which makes
to code hard to understand at times. He also loves to refactor things
and does so continuously. This is a major problem for any long lived
patches. If you do choose to work on cvs2svn, just fork it until you
are done developing, don't try to track the refactorings.

There are several other choices. Monotone is getting a pretty good
importer and the author is aware of the problem described above and is
writing his code to avoid it. Monotone is in C++ and make heavy use of
the Boost C++ template library. Because of this I can't tell what
their code does, it doesn't look like C++ anymore.

git is in C and has high code quality standards. I would just start
from scratch and write the importer over while referencing the
existing code. If anyone is interested in doing this I will be happy
to explain what I know about doing the import accurately and quickly.
With the right algorithms it is possible to import Mozilla CVS with
2GB memory in under an hour on a desktop machine.

Shawn has written git-fastimport. fastimport takes an input stream of
a simple language and then creates the git repository. The CVS
importer just needs to generate these commands.

With the current knowledge of issues around doing CVS import this
problem is not as hard as it used to be. Dozens of attempts have been
made at this problem, Shawn and I have looked at all of these and know
where the algorithmic mistakes are. The only big outstanding problem I
know of with import is the issue described above which no one has
coded a solution for yet.

Once a solution has been found for this problem the next problem is
detecting when a branch gets merged back into the trunk. After that I
think the problem is fully solved.

-- 
Jon Smirl
