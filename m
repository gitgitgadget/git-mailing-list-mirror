X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/5] allow cloning a repository "shallowly"
Date: Tue, 14 Nov 2006 09:46:57 -0800
Message-ID: <7vpsbpzzse.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0610302009160.26682@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4pt21oe9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611141145390.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 14 Nov 2006 17:47:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611141145390.13772@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 14 Nov 2006 11:49:55 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31356>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk2ND-0007sa-Ij for gcvg-git@gmane.org; Tue, 14 Nov
 2006 18:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966207AbWKNRrA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 12:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966220AbWKNRrA
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 12:47:00 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:42729 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S966207AbWKNRq7
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 12:46:59 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061114174658.NLIL18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Tue, 14
 Nov 2006 12:46:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id mhn41V00h1kojtg0000000; Tue, 14 Nov 2006
 12:47:05 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I understand "no need making it shallow", but I am not sure if a
>> non-NULL return from lookup_object() tells us that.
>
> You are probably right, how about has_sha1_file()?
>
>> I think register_shallow() can take commits that are already shallow() 
>> so maybe we can remove this "if() continue"?
>
> Yes, it can, but that is not necessarily correct: since .git/shallow is 
> constructed from the registered shallow commits, we would make a commit 
> shallow which is really not shallow.
>
> So, how about
>
>> > +				if (lookup_object(sha1) || has_sha1_file(sha1))
>> > +					continue;

If I understand the code correctly, this loop is reading what
the other side thinks your shallows should be (based on your
earlier "deepen" request or if this is initial fetch based on
your depth).  Even if we already have that object, if that
object _is_ shallow on our end, don't we need to keep it marked
as shallow?  Will we get ancestors of this commit from the other
end (and "shallow" lines for some of them to properly cauterize
the chain)?


