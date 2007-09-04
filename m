From: Jeff King <peff@peff.net>
Subject: Re: Git's database structure
Date: Tue, 4 Sep 2007 13:09:22 -0400
Message-ID: <20070904170921.GA31300@coredump.intra.peff.net>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com> <46DD7FE4.1060908@op5.se> <9e4733910709040919u3d252b91s2785ed4d20086c88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 19:13:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISbu5-0002gx-1G
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 19:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618AbXIDRJY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 13:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbXIDRJY
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 13:09:24 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4990 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776AbXIDRJY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 13:09:24 -0400
Received: (qmail 30362 invoked by uid 111); 4 Sep 2007 17:09:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 04 Sep 2007 13:09:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Sep 2007 13:09:22 -0400
Content-Disposition: inline
In-Reply-To: <9e4733910709040919u3d252b91s2785ed4d20086c88@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57617>

On Tue, Sep 04, 2007 at 12:19:33PM -0400, Jon Smirl wrote:

> By introducing tree nodes you have blended a specific indexing scheme
> into the data. There are many other ways the path names could be
> indexed hash tables, binary trees, etc.

That is correct. However, given that indexing scheme, many of the common
operations just "fall out" simply and efficiently, without the need to
keep separate indices. So yes, git is geared towards a particular set of
operations.

Your complaint seems to be two-fold:

 1. there is an inelegance in the blending of data and indexing. The
    problem with changing this is:
      a. we are all already using git, and it would require completely
         re-vamping the core data structure
      b. there is some feeling that the blending is necessary for
         performance. Given the difficulty of (a), I think you would
         have to provide compelling evidence (i.e., numbers) that a
         git-like system based around set theory with separate indices
         would perform as well.

 2. you want perform some operations to which the hierarchy is not
    well-suited. In this case, I think you can get by with the same
    solution you have proposed already: indices external to the data
    structure (in fact, this is exactly what Google is doing: taking
    hierarchical URLs and indexing them in different ways).

    Have you taken a look at the pack v4 work by Shawn and Nicolas? It
    is an attempt to build such indices at pack time (but keeping the
    core git data structure intact).

-Peff
