X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 07:13:39 -0400
Message-ID: <20061026111338.GA15179@coredump.intra.peff.net>
References: <20061021130111.GL75501@over-yonder.net> <453F2FF8.2080903@op5.se> <200610251146.06116.jnareb@gmail.com> <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com> <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com> <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com> <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 11:13:53 +0000 (UTC)
Cc: James Henstridge <james@jamesh.id.au>,
	Junio C Hamano <junkio@cox.net>,
	bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <877iyne4dm.fsf@alplog.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30188>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd3BB-0001kB-7i for gcvg-git@gmane.org; Thu, 26 Oct
 2006 13:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752119AbWJZLNm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 07:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbWJZLNm
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 07:13:42 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:15510
 "HELO peff.net") by vger.kernel.org with SMTP id S1752119AbWJZLNl (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 07:13:41 -0400
Received: (qmail 12143 invoked from network); 26 Oct 2006 07:12:45 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 26 Oct 2006 07:12:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Oct
 2006 07:13:39 -0400
To: Vincent Ladeuil <v.ladeuil@alplog.fr>
Sender: git-owner@vger.kernel.org

On Thu, Oct 26, 2006 at 12:52:05PM +0200, Vincent Ladeuil wrote:

> Ok, so git make a distinction between the commit (code created by
> someone) and the tree (code only).

Yes (a commit is a tree, zero or more parents, commit message, and
author/committer info).

> Commits are defined by their parents.

Partially, yes.

> Trees are defined by their content only ?

Yes.

> Calculate a sha1 representing the content (or the content of the
> diff from parent) of all the files and dirs in the tree ?  Or
> from the sha1s of the files and dirs themselves recursively based
> on sha1s of the files and dirs they contain ?

Recursively. Each tree is an ordered list of 4-tuples: pathname, type,
sha1, mode. If the type is "blob" then the sha1 is the hash of the file
contents. If the type is "tree" then the sha1 is the id of a sub-tree.
The id of a tree is the sha1 hash of the data structure.

> I ask because the later seems to provide some nice effects
> similar to what makes BDD
> (http://en.wikipedia.org/wiki/Binary_decision_diagram) so
> efficient: you can compare graphs of any complexity or size in
> O(1) by just comparing their signatures.

Yes, if two trees' hashes compare equal, they contain the same data. I
believe we are not currently using this optimization to find merge
differences, but there was some discussion earlier this week about doing
so.

