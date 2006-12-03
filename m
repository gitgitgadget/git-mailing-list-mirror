X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Submodules in GIT
Date: Sun, 3 Dec 2006 01:55:08 +0100
Message-ID: <200612030155.09630.Josef.Weidendorfer@gmx.de>
References: <20061130170625.GH18810@admingilde.org> <200612020017.44275.Josef.Weidendorfer@gmx.de> <20061202202428.GT18810@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 3 Dec 2006 00:55:34 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, sf <sf@b-i-t.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <20061202202428.GT18810@admingilde.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33071>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqfde-0006Mh-Lh for gcvg-git@gmane.org; Sun, 03 Dec
 2006 01:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424814AbWLCAzO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 19:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424898AbWLCAzN
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 19:55:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:29620 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1424814AbWLCAzM (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 19:55:12 -0500
Received: (qmail invoked by alias); 03 Dec 2006 00:55:11 -0000
Received: from p5496B2C8.dip0.t-ipconnect.de (EHLO noname) [84.150.178.200]
 by mail.gmx.net (mp029) with SMTP; 03 Dec 2006 01:55:11 +0100
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

On Saturday 02 December 2006 21:24, Martin Waitz wrote:
> On Sat, Dec 02, 2006 at 12:17:44AM +0100, Josef Weidendorfer wrote:
> > After some thinking, a submodule namespace even is important for checking
> > out only parts of a supermodule, exactly because the root of a submodule
> > potentially can change at every commit.
> 
> have you ever thought about the idea that the location may be an
> important thing to consider for your decision.

Which decision, for what? Sorry, I do not understand.

Do you want to say that relative submodule root paths should be kept fix
the whole lifetime of a supermodule?
Ie. a submodule "identity" is bound to its relative path, and when we
move it, it should be seen as deleting at and creating a totally new,
different submodule?

That's fine.
But you have to handle submodule creation/deletion neverless. And while
you are at a commit which has a given submodule deleted, you have to
keep the submodule data somewhere - referencing it with a name.
I do not speak here about the object database, that could be combined;
but about all the other files in .git/ of the currently not checked out
submodule.

> Perhaps the submodule is now used for something else (this is why it was
> moved) and that now you'd like to keep it?

Can you give a usage szenario? What do you mean here?


> Anyway, you can just create several supermodules or implement generic
> partial tree support for git.  I do not see any reason to special case
> submodules here.

What should such a general partial tree support look like? I suppose you
want to configure paths which should not be checked out. As long as you
say that a given submodule always has to exist at a given path, you are
right: then, you can say: "Please, do not check out this submodule" which
is the same as "Do not check out this path". 

But I think it is quite restrictive to not allow to move submodules around.
When the supermodule upstream decides to move a submodule, your partial
tree config to not check out a submodule will be lost.
But more important, if you made changes to a given submodule, and pull from
upstream which changed the submodule position in-between, your changes will
be not taken over to the new position, as the move is seen as creation of
a totally independent submodule.

