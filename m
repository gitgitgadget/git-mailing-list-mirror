From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/4] reset: add test cases for "--merge-dirty" option
Date: Fri, 11 Sep 2009 01:36:01 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909110120520.28290@iabervon.org>
References: <20090910200334.3722.20140.chriscool@tuxfamily.org> <20090910202333.3722.13214.chriscool@tuxfamily.org> <alpine.LNX.2.00.0909101757530.28290@iabervon.org> <200909110705.35083.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Sep 11 07:36:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlynt-0000vM-1k
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 07:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbZIKFgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 01:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbZIKFgE
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 01:36:04 -0400
Received: from iabervon.org ([66.92.72.58]:57898 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068AbZIKFgC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 01:36:02 -0400
Received: (qmail 29137 invoked by uid 1000); 11 Sep 2009 05:36:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Sep 2009 05:36:01 -0000
In-Reply-To: <200909110705.35083.chriscool@tuxfamily.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128176>

On Fri, 11 Sep 2009, Christian Couder wrote:

> On Friday 11 September 2009, Daniel Barkalow wrote:
> > On Thu, 10 Sep 2009, Christian Couder wrote:
> >
> >     This shows that with the "--merge-dirty" option,
> >
> >   changes that are both in the work tree and the index are kept
> >
> >     in the work tree after the reset (but discarded in the index). As
> > with the "--merge" option,
> >
> >   changes that are in both the work tree and the index are discarded
> >
> >     after the reset.
> >
> > I'm lost here.
> >
> > If you have:
> >
> >          working index HEAD target
> > version     B      B     A     A
> >
> > You get:
> >
> >          working index HEAD target
> > --m-d       B      A     A     A
> > --merge     A      A     A     A
> >
> > ?
> 
> Yes, files that are not different between HEAD and target are changed like 
> that. Thanks for explaining it better than I could!

I worked on the rules for merging way back when, so I've looked at tables 
of cases like that. If there are more cases to cover, it might work 
better to have a table like:

working index HEAD target         working index HEAD
   B      B     A     A   --m-d      B      A     A
                          --merge    A      A     A
   B      B     A     C   --m-d       (disallowed)
                          --merge    C      C     C

Are there other differences?

> > > ---
> > >  t/t7110-reset-merge.sh |   54
> > > +++++++++++++++++++++++++++++++++++++++++++---- 1 files changed, 49
> > > insertions(+), 5 deletions(-)
> > >
> > > diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
> > > index 45714ae..1e6d634 100755
> > > --- a/t/t7110-reset-merge.sh
> > > +++ b/t/t7110-reset-merge.sh
> > > @@ -19,7 +19,7 @@ test_expect_success 'creating initial files' '
> > >       git commit -m "Initial commit"
> > >  '
> > >
> > > -test_expect_success 'ok with changes in file not changed by reset' '
> > > +test_expect_success '--merge: ok if changes in file not touched by
> > > reset' '
> >
> > Should probably have the "--merge: " from the beginning, since you're
> > adding the test in this series anyway. That would make the diff come out
> > clearer.
> 
> Yeah, but I am not sure that patches 3/4 and 4/4 will get merged in the end.
> If they are not merged it will be better if there is no "--merge: ". 

Maybe write those lines to mention "reset --merge" naturally? Like:

'ok with changes in file not changed by reset --merge'

'reset --merge discards changes added to index 1'

	-Daniel
*This .sig left intentionally blank*
