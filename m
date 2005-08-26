From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Storing state in $GIT_DIR
Date: Fri, 26 Aug 2005 13:57:27 +1200
Message-ID: <46a038f905082518575b84bf66@mail.gmail.com>
References: <46a038f905082420323b025e3b@mail.gmail.com>
	 <Pine.LNX.4.58.0508251053000.3317@g5.osdl.org>
	 <7vwtm9u5jj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 04:55:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8TTW-0000KO-2j
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 03:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbVHZB53 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 21:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbVHZB53
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 21:57:29 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:55212 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965046AbVHZB52 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2005 21:57:28 -0400
Received: by rproxy.gmail.com with SMTP id i8so477294rne
        for <git@vger.kernel.org>; Thu, 25 Aug 2005 18:57:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KfqqE+aC3TkBqd1qgScayuOcUYWJfvMSrrlASYQSZvwRPQ0cTL8vmjPKjQ2tRO+ZNEJkPEAURIdOVc3rYpoyjt82u46TVXY8S757sDzcrDgwW3LPnYV1IrIMKRpzhNDe99XI0iIHCpda3GvHZFjn1bGt4EXVRcEX2tSijS0aOnU=
Received: by 10.38.92.14 with SMTP id p14mr1452764rnb;
        Thu, 25 Aug 2005 18:57:27 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Thu, 25 Aug 2005 18:57:27 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtm9u5jj.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7778>

On 8/26/05, Junio C Hamano <junkio@cox.net> wrote:
> If I am not mistaken, we have another foreign SCM import
> interface that can repeatedly slurp from the same foreign SCM to
> get updates.  Doesn't cvsimport have the same issue?  

Yes and no. 

cvsimport uses cvsps which uses in ~/.cvsps as a cache. Other than
that, all the info is transient - cvsimport doesn't need to know that
much about past commits -- when it sees BRANCH_A_A1 open from BRANCH_A
it opens a new head BRANCH_A_A1 with the parent in the _latest_
BRANCH_A.

This is a bug/limitation that only hits you when you are tracking an
evolving cvs project, because cvsps will otherwise mark the branching
point in order, right after the 'correct' commit. IOW cvsimport gets
it kind-of-right most of the time due to cvsps behaviour and sheer
luck, but doesn't do it strictly right either.

With Arch, we cannot even fake it. We see the branch in its own time,
and it can branch off any point in the source branch history. We have
the correct parent information -- it'd be silly to drop it. All we
have to do, is map the parents correctly...

cheers,


martin
