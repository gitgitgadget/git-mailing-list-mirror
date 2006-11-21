X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Some tips for doing a CVS importer
Date: Mon, 20 Nov 2006 20:53:15 -0500
Message-ID: <9e4733910611201753m392b5defpb3eb295a075be789@mail.gmail.com>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com>
	 <46a038f90611201503m6a63ec8ct347026c635190108@mail.gmail.com>
	 <9e4733910611201537h30b6c9f4oee9d8df75284c284@mail.gmail.com>
	 <46a038f90611201629o39f11f42ye07b86159360b66e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 21 Nov 2006 01:53:27 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BPQmEAXxB2276eAX1SbHmZs56Lqu6nLIu+eSFeSMjeKj5kfYSCtD8NOchv0XDkmVvZ7nb8kLFUCMdSsoD03oYrJ72rbQivlhduuC3Q3rYEZQZ0TjoVLG7vjZ3N8wwkVdy0bzCWOCdEh5XbX4yuUjK+7KaGvaN9c1WyICVlpULBc=
In-Reply-To: <46a038f90611201629o39f11f42ye07b86159360b66e@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31969>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmKp7-0007S4-53 for gcvg-git@gmane.org; Tue, 21 Nov
 2006 02:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030637AbWKUBxQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 20:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030651AbWKUBxQ
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 20:53:16 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:23183 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1030637AbWKUBxP
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 20:53:15 -0500
Received: by wx-out-0506.google.com with SMTP id s7so1998372wxc for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 17:53:15 -0800 (PST)
Received: by 10.90.80.8 with SMTP id d8mr4416172agb.1164073995172; Mon, 20
 Nov 2006 17:53:15 -0800 (PST)
Received: by 10.35.72.13 with HTTP; Mon, 20 Nov 2006 17:53:15 -0800 (PST)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org

On 11/20/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 11/21/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > > I gather this means that the cvs2svn track hasn't been as productive
> > > as expected. Any remaining/unsolvable issues with it? I have been
> > > chronically busy on my e-learning projects, but don't discard coming
> > > back to this when I have some time.
> >
> > Look in this thread
> > [Fwd: Re: What's in git.git]
> >
> > There is a message in there that explains a problem that the cvs2svn
> > people aren't going to fix and it kills git.
>
> I see - thanks for the pointer. Sorry to hear others in the Moz
> project weren't so keen on hearing about alternatives to SVN. Long
> term only something like GIT seems viable for such a large project (in
> terms of community, branches/subprojects and codebase).
>
> Two remaining questions
>  - Where can I get your latest code? :-)

I gave up on my cvs2git code, cvs2svn has been refactored so badly
that it was too much trouble tracking. It would be easier to write it
again. Most of the smarts from the import process is in the
git-fastimport code which Shawn has. cvs2svn underwent a major
algorithm change after I wrote the first version of git2svn.

I can probably find the code if you really want it, but it will be
leading you off in the wrong direction.

>  - I gather the moz cvs repo has some cases that require getting the
> symbol resolution right. Could this be performed as an extra pass /
> task?

Processing the symbols is integral to deciding how to build the change
sets. Right now cvs2svn ignores the symbol dependency information and
builds the change sets in a way that forces the mini-branches. That
causes 60% of the 2,000 symbols in Mozilla CVS to end up as little
branches. Look at the three commit example in the other thread to see
exactly what the problem is.

SVN hides the mini branch by creating a symbol like this:

Symbol XXX, change set 70
copy All from change set 50
copy file A from change set 55
copy file B,C from change set 60
copy file D from change set 61
copy file E,F,G from change set 63
copy file H from change set 67

It has to do all of those copies because the change sets weren't
constructed while taking symbol dependency information into account.

Symbol XXX can't copy from change set 69 because commits from after
the symbol was created are included in change sets 51-69.

> Eventually the Moz crowd will outgrow SVN - perhaps we should be
> parsing the SVN dump format instead ;-)
>
> cheers,
>
>
> martin
>


-- 
Jon Smirl
