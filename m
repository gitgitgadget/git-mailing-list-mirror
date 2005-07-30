From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix interesting git-rev-list corner case
Date: Fri, 29 Jul 2005 18:20:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507291816060.29650@g5.osdl.org>
References: <Pine.LNX.4.58.0507291542060.29650@g5.osdl.org>
 <20050730001158.GF32263@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 30 03:24:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dyg4v-0006Gg-Ar
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 03:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262875AbVG3BXi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 21:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbVG3BVY
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 21:21:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59020 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262865AbVG3BU7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 21:20:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6U1KnjA032223
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 29 Jul 2005 18:20:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6U1KmOW002066;
	Fri, 29 Jul 2005 18:20:48 -0700
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050730001158.GF32263@mythryan2.michonline.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 29 Jul 2005, Ryan Anderson wrote:
> 
> Maybe it'd make sense to have the commits refuse to add a commit when it
> would be younger than one of it's parents?

No, the git-rev-list thing really was a bug, it was just that I hadn't 
thought things through when I wrote it, and the "normal" case (ie the ones 
I had tested) just happened to work because it's a common one.

In other words - I had taken a shortcut without thinking it through.

The date really isn't important - the algorithm I had works fine even if 
dates are totally screwed up, it just had a stupid bug.

And trying to make the date more important than it is will just inevitably 
lead to _worse_ problems down the road. 

So the date is a good heuristic (we have to traverse the commits in _some_
order, and the date order just happens to be one that ends up giving the
minimum number of commits "usually"), but any time we _depend_ on dates
one way or the other that would be a good.

		Linus
