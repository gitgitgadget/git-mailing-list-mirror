X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 01:14:42 +0100
Message-ID: <200612020114.42858.Josef.Weidendorfer@gmx.de>
References: <20061130170625.GH18810@admingilde.org> <200612012355.03493.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612011510290.3695@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 2 Dec 2006 00:14:58 +0000 (UTC)
Cc: sf <sf@b-i-t.de>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0612011510290.3695@woody.osdl.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32994>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqIWl-00049L-VS for gcvg-git@gmane.org; Sat, 02 Dec
 2006 01:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161966AbWLBAOp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 19:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161834AbWLBAOp
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 19:14:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:46480 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1161966AbWLBAOo (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 19:14:44 -0500
Received: (qmail invoked by alias); 02 Dec 2006 00:14:42 -0000
Received: from p5496B457.dip0.t-ipconnect.de (EHLO noname) [84.150.180.87] by
 mail.gmx.net (mp015) with SMTP; 02 Dec 2006 01:14:42 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Saturday 02 December 2006 00:30, Linus Torvalds wrote:
> On Fri, 1 Dec 2006, Josef Weidendorfer wrote:
> > 
> > What about my other argument for a submodule namespace:
> > You want to be able to move the relative root path of a submodule
> > inside of your supermodule, but yet want to have a unique name
> > for the submodule:
> > - to be able to just clone a submodule without having to know
> > the current position in HEAD
> 
> Umm? I don't get the issue. A submodule is a git repo in its own right, 
> and you clone it exactly like you'd clone any other repo. It _does_ have a 
> HEAD. It has it's own branches. It has everything.

I just thought about the case when you want to clone a submodule directly
out of the supermodule repository, at a given realive path. And that can
be changing.

Of course, every project which happens to be submodule of some supermodule,
also can have its own repository, as it is fully independent. And then,
you of course can clone from without any knowledge of its relative position
in the supermodule.

> In the trivial case where the submodule doesn't even _have_ any external 
> existence at all (ie it's always maintained as _just_ a submodule, it 
> would probably tend to have just one branch, and a clone would get 
> whatever that branch is), but that's just a degenerate special case of the 
> much richer "this submodule actually has a life of its own" case.

Yes.

> > - more practically, e.g. to be able to name a submodule
> > independent from any current commit you are on in the supermodule,
> > e.g. to be able to store some meta information about a submodule:
> 
> The current commit within the supermodule would be _totally_ invisible to 
> the submodule.

Of course.

Yet, you need some name to store meta information of submodules
into some config file of the supermodule, like whether you want to have
it checked out (see below).

In that case, such a name for a submodule does not have to be global in
the supermodule project...

> > - "Should git allow to commit rewind actions of this submodule
> >    in the supermodule?" (which, AFAICS, exactly has the same
> >    problems as publishing a rewound branch: you will get into
> >    merge hell when you want to pull upstream changes into the
> >    supermodule)
> 
> The only thing that a submodule must NOT be allowed to do on its own is 
> pruning (and it's distant cousin "git repack -d"). You must always prune 
> >from the supermodule, because the submodule cannot really know on its own 
> what references point into it.

Yes. I just gave an example of a policy some project may want for submodule
handling.

> > - "Should this submodule be checked out?"
> 
> This, I think, requires too much configuration to say separately for every 
> possible submodule, so I would suggest that the way to make that decision 
> is:
> 
>  - "git clone" by default will fetch and check out all submodules (and 
>    obviously they have to be described some way outside of the object 
>    database, just so that you don't have to parse the _whole_ history of 
>    the _whole_ supermodule just to find all possible submodules. So the 
>    supermodule _will_ need some "list of submodules and where to get them" 
>    in a config file or other).

Exactly. And in this list, you have to specify names.

The thing I wanted to discuss is whether such names would need to be globally
unique in the project containing submodles, or not.

If yes, it IMHO makes a lot of sense to introduce "submodule objects" which contain
these submodule names, and which are used as pointers to submodule commits in
supermodule trees.

