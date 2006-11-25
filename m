X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Wierd tag errors from current 'next'
Date: Sat, 25 Nov 2006 12:08:14 -0800
Message-ID: <7vu00n1e8h.fsf@assigned-by-dhcp.cox.net>
References: <456845E0.1050001@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 20:08:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <456845E0.1050001@shadowen.org> (Andy Whitcroft's message of
	"Sat, 25 Nov 2006 13:32:16 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32304>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Go3p1-0006tg-9M for gcvg-git@gmane.org; Sat, 25 Nov
 2006 21:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967153AbWKYUIQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 15:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967158AbWKYUIQ
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 15:08:16 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:23755 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S967153AbWKYUIQ
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 15:08:16 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061125200815.SCJQ4817.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Sat, 25
 Nov 2006 15:08:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id r87k1V00C1kojtg0000000; Sat, 25 Nov 2006
 15:07:44 -0500
To: Andy Whitcroft <apw@shadowen.org>
Sender: git-owner@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> writes:

> I just was fetching some updates from a repository which I sync from CVS
> into my development repository.  I got the following wierd errors about
> a tag during the fetch, it seemed to fix itself by the end ... hmmmm.
>
> apw@pinky$ git fetch
> error: refs/tags/v0_72_3 does not point to a valid object!
> error: refs/tags/v0_72_3 does not point to a valid object!
> remote: Generating pack...
> remote: Done counting 42 objects.
> remote: Result has 28 objects.
> remote: Deltifying 28 objects.
> remote:  100% (28/28) done
> remote: Total 28, written 28 (delta 20), reused 20 (delta 12)
> Unpacking 28 objects
>  100% (28/28) done

That sounds as if we are checking the refs/tags/v0_72_3 before
we get the object itself.  "does not point to a valid object!"
message comes from do_one_ref() in refs.c which means your
repository had $GIT_DIR/refs/tags/v0_72_3 before that object was
retrieved.

Which is _bad_.  Could you reproduce and bisect it?
