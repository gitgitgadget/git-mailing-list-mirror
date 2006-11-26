X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Marko Macek <marko.macek@gmx.net>
Subject: Re: Some tips for doing a CVS importer
Date: Sun, 26 Nov 2006 11:18:02 +0100
Message-ID: <456969DA.6090702@gmx.net>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com>	 <46a038f90611201503m6a63ec8ct347026c635190108@mail.gmail.com>	 <9e4733910611201537h30b6c9f4oee9d8df75284c284@mail.gmail.com>	 <46a038f90611201629o39f11f42ye07b86159360b66e@mail.gmail.com> <9e4733910611201753m392b5defpb3eb295a075be789@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 26 Nov 2006 10:21:26 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #420190
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <9e4733910611201753m392b5defpb3eb295a075be789@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32341>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoH8R-0001WI-1o for gcvg-git@gmane.org; Sun, 26 Nov
 2006 11:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935316AbWKZKVO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 05:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935317AbWKZKVO
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 05:21:14 -0500
Received: from mail.gmx.de ([213.165.64.20]:54967 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S935316AbWKZKVN (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 05:21:13 -0500
Received: (qmail invoked by alias); 26 Nov 2006 10:21:11 -0000
Received: from BSN-77-45-79.dial-up.dsl.siol.net (EHLO [192.168.2.7])
 [193.77.45.79] by mail.gmx.net (mp007) with SMTP; 26 Nov 2006 11:21:11 +0100
To: jonsmirl@gmail.com
Sender: git-owner@vger.kernel.org

Jon Smirl wrote:

> 
> SVN hides the mini branch by creating a symbol like this:
> 
> Symbol XXX, change set 70
> copy All from change set 50
> copy file A from change set 55
> copy file B,C from change set 60
> copy file D from change set 61
> copy file E,F,G from change set 63
> copy file H from change set 67
> 
> It has to do all of those copies because the change sets weren't
> constructed while taking symbol dependency information into account.
> 
> Symbol XXX can't copy from change set 69 because commits from after
> the symbol was created are included in change sets 51-69.

Sometimes it is not actually possible to have a 'simple' symbol, even 
by following proper symbol dependencies. 

Some situations:
- tags on some files are readjusted later, or tagged separately with an older
 version
- tag is created with a -D "date" and the file times are not in sync
- tag is created from a mixed-revision working copy

While in the cases of 'time warp' the revision sequence should be 
considered more important than timestamps, this is not necessarily
true for tags, since it's easily possible to create them on mixed 
revisions.

cvs2svn also has a problem with vendor branches because it creates
tags/branches that contain files from vendor branch by copying some
files from the trunk and other files from the vendor branch.
If the vendor branch/tag was only used for the initial import, 
it's IMO best to skip them in the conversion (this needs a patch).
There are however problems because keyword expansion causes file
differences.

It seems that mozilla CVS repository has vendor branches/imports in
some parts of the tree.

Mark
