From: Jeff King <peff@peff.net>
Subject: Re: How to rewrite author history
Date: Sat, 22 Mar 2008 12:57:37 -0400
Message-ID: <20080322165737.GB7611@coredump.intra.peff.net>
References: <216e54900803210938q4981b5d1t535af419f5b15ad8@mail.gmail.com> <216e54900803210941i7fe345c2va850fa3ded8eabc8@mail.gmail.com> <2008-03-22-10-29-23+trackit+sam@rfc1149.net> <216e54900803220611v5aa5e9d5q86da249480be3c91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Samuel Tardieu <sam@rfc1149.net>, git@vger.kernel.org
To: Andrew Arnott <andrewarnott@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 22 17:58:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd730-0002kn-GF
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 17:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbYCVQ5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 12:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753231AbYCVQ5k
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 12:57:40 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4643 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753126AbYCVQ5k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 12:57:40 -0400
Received: (qmail 449 invoked by uid 111); 22 Mar 2008 16:57:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 22 Mar 2008 12:57:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Mar 2008 12:57:38 -0400
Content-Disposition: inline
In-Reply-To: <216e54900803220611v5aa5e9d5q86da249480be3c91@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77825>

On Sat, Mar 22, 2008 at 06:11:12AM -0700, Andrew Arnott wrote:

> git-filter-branch --env-filter '
> [...]
> And I did this for master, and my v1 and v0.1 branches.  I'm concerned
> though, that since I changed the names of all the objects by doing
> this, did I somehow make my branches incompatible with each other?
> Will there be any problems in the future sharing commits or merging
> across branches as a result?

There are two concerns, and I'm not sure which you have (I think number
1):

  1. Your branches within the repository will not connect anymore. I
     believe this is a non-issue with your filter, since the generated
     commit IDs are deterministic. Certainly a toy case worked for me
     with:

       for i in master branch; do
         git filter-branch --env-filter=... $i
       done

     You can also specify both to be done at the same time, which is
     more efficient:

       git filter-branch --env-filter=... master branch

     You can check the graph structure with "gitk master branch" which
     should show them connecting.

  2. Your branches are now a different, rewritten history compared to
     anyone who has cloned or fetched from you. This is unavoidable, and
     the answer is either "don't use filter-branch" or "tell everyone to
     rebase their work on the new history." So the best time to
     filter-branch is right after import, but before you start work.

-Peff
