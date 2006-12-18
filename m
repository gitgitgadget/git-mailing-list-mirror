X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Subprojects tasks
Date: Mon, 18 Dec 2006 11:30:18 +0100
Message-ID: <200612181130.18652.Josef.Weidendorfer@gmx.de>
References: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net> <200612180023.45815.Josef.Weidendorfer@gmx.de> <20061218074441.GJ12411@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 18 Dec 2006 10:30:44 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <20061218074441.GJ12411@admingilde.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34736>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwFlU-0007sT-0Q for gcvg-git@gmane.org; Mon, 18 Dec
 2006 11:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753741AbWLRKad (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 05:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753744AbWLRKac
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 05:30:32 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:45339 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S1753741AbWLRKac (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006 05:30:32 -0500
Received: from dhcp-2s-25.lrr.in.tum.de (dhcp-2s-25.lrr.in.tum.de
 [131.159.35.25]) by mail.in.tum.de (Postfix) with ESMTP id 7CB2B2875; Mon, 18
 Dec 2006 11:30:30 +0100 (MET)
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

On Monday 18 December 2006 08:44, Martin Waitz wrote:
> On Mon, Dec 18, 2006 at 12:23:45AM +0100, Josef Weidendorfer wrote:
> > I see that you always use "refs/heads/master" in the submodule.
> > What happens if you do development in the submodule, create a new commit
> > there, and want to switch supermodule branch afterwards?
> > Wouldn't you lose your new work, as "refs/heads/master" has to be reset
> > to another commit when you switch the supermodule branch?
> 
> It should behave the same as for files:
> Refuse to update the working directory if files (or the submodule here)
> are dirty.  I guess this is not yet handled correctly by my prototype,
> but it should not be hard to do.

Ah, I see.
Yes, this is consistent with other dirty files.


> > IMHO it would be nice to have refs in the submodule matching all the
> > branches/tags of the supermodule.
> > Meaning: "this is the commit which is used by branch/tag XYZ in the
> > supermodule". This can be valuable information, and a "gitk --all" in
> > the submodule would show you all the uses of your subproject in the
> > scope of the given superproject.
> 
> I like the idea.  Perhaps make them available similiar to the remotes
> information in refs/tracked/{heads,tags} or something.

Yes.
However, you want to do development on these branches. And
"refs/tracked/..." is read-only. However, taking the whole local
refs namespace is not good, as you perhaps want branches independent
of the supermodule, which could give name conflicts.
What about using "refs/{heads,tags}/supermodule/..."? This could
be a compromise.

> > When switching branches in the supermodule, it simply would switch
> > to the same name in submodules.
> 
> Nice idea, but I don't yet know how it really works out.
> It may be confusing to the user if he manually switches the branch in
> the submodule to another branch of the supermodule.  Then he really is
> using one tracked branch, but not the currently tracked branch.

But you already have the same problem with your current approach, don't
you?

Actually, the most expected thing for the user really would be to use
HEAD in supermodule commits. Every other behavior can get confusing for
the user: (S)He simply expects the state of the checkout to be committed.
Any branch switching in submodules should be temporary.

Actually, you can be on a temporary branch in a submodule and still switch
branches in the supermodule. It is the same as with dirty files: The
modifications can be carried over to other branches and back, as long as
there are no conflicts. 

However, I think it is important to check that you are back on the
right branch when committing. With warning or even error.

