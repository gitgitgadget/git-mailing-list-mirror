From: Jon Seymour <jon.seymour@gmail.com>
Subject: Heads up on work in progress - was: [PATCH 2/2] Add support ... [rev 11]
Date: Sat, 11 Jun 2005 15:28:50 +1000
Message-ID: <2cfc4032050610222853a882b7@mail.gmail.com>
References: <20050610092343.3935.qmail@blackcubes.dyndns.org>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 11 07:24:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgyTu-00018f-6N
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 07:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVFKF2x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 01:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVFKF2x
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 01:28:53 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:15264 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261267AbVFKF2u convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 01:28:50 -0400
Received: by rproxy.gmail.com with SMTP id i8so374154rne
        for <git@vger.kernel.org>; Fri, 10 Jun 2005 22:28:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L9XmxrfbevkmH0fRKYcwtQpA8xivttxM0NvlyMycqL/h3y/9Do1GLg8ZJuPS4bhP83Kv0KlynvrUY506Jrg9zS+d9fMK4OEl7lYdIVH+89QERxdDVPEO6FL6aSrwkE80CNMVsWBswLH+Uc0EpN4DLpIPMqJAIAg66OdYyRvLoGw=
Received: by 10.38.65.4 with SMTP id n4mr16647rna;
        Fri, 10 Jun 2005 22:28:50 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Fri, 10 Jun 2005 22:28:50 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <20050610092343.3935.qmail@blackcubes.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Folks,

Thought I'd just give you a heads up that I am presently undertaking a
further substantial re factorisation and generalization of epoch.c.
The changes in this work we be largely limited to epoch.c and
epoch.c-related parts of rev-list.c.

The upcoming changes will not substantially change the existing tools
interfaces, so it would be safe to apply the [rev 11] to the git HEAD
provided there is agreement that the tools interfaces proposed in [rev
11] are acceptable.

However, if you want to perform a detailed review of epoch.c, it might
be better to hold off until my next batch of changes are ready. That
said, if you would like to provide feedback on what I have already
done, please feel welcome to.

In my forthcoming changes I intend to:

1. rename epoch.c to commit-graph.c
2. improve separation of concerns between rev-list.c and commit-graph.c
   * commit-graph.c will understand everything about incremental graph
traversals, including merge order search and "localized" perspectives
   * rev-list.c will be responsible for output limiting [ that is:
stopping the traversal according to user-defined (e.g. parameterised
criteria) ]
3. the epoch_methods structure in [rev11] will be generalized to a
per-traversal "traversal object" (struct graph_traversal) that will
have additional methods such as:
   * visit_edge - called on each edge
   * visit_commit - called on each visit to a commit
   * clean_commit - called to clean any resources allocated during a
call to visit_edge, visit_commit

I'll try to do the right thing and break the changes into a series of
small patches to rev11.

Please forgive me for my previous practice of submitting large changes
- I am quite new to the development-by-patch style of development, and
haven't quite got into the swing of it yet.

jon.
