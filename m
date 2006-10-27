X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Improve git-prune -n output
Date: Fri, 27 Oct 2006 02:09:04 -0700
Message-ID: <7vslhagm6n.fsf@assigned-by-dhcp.cox.net>
References: <200610261138.24761.andyparkins@gmail.com>
	<4540F16F.4060604@shadowen.org>
	<200610270920.06064.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 09:09:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610270920.06064.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 27 Oct 2006 09:19:51 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30314>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdNiK-0003J8-KP for gcvg-git@gmane.org; Fri, 27 Oct
 2006 11:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946254AbWJ0JJH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 05:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946255AbWJ0JJG
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 05:09:06 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:43926 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1946254AbWJ0JJF
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 05:09:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061027090905.ILNP6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Fri, 27
 Oct 2006 05:09:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id fM991V0011kojtg0000000 Fri, 27 Oct 2006
 05:09:09 -0400
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> The only problem with that is that the type string is of
> variable width, while the hash is fixed; hence <hash> <type>
> is more visually appealing than <type> <hash>.
>
> Does it really matter anyway?

I would rather question if the alignment really matters.  You
could always printf("%10s %s\n", type, hex) if you really cared,
though.

> ... Some sort of processing would have to happen 
> before using git-prune output as git-cat-file parameters...
>
> git-prune -n |
> while read hash type
> do
>  git-cat-file $type $hash
> done

which is probably not the way in which the command output is
going to be used.  I'd expect a sequence more like:

	$ git prune -n
	blob deadbeefdeadbeef...
        commit deadbeefdeadbeef...
        ...

The user would not just pipe all of the output to cat-file, but
would pick ones that are meaningful to be cat'ed (commit and
perhaps blob but definitely not tree).  And the cue to pick
which ones would likely to be the object type not hash, so in
that sense type-then-hash might be easier to read.

Having said that, a potentially useful application would be "a
backup before prune" which can be done more easily if you use
hash-then-type: "git prune -n | git pack-objects backup"

So while I do not think it matters that much, I slightly prefer
hash-then-type better than type-then-hash.




