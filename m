X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Shallow clone
Date: Wed, 08 Nov 2006 20:04:25 -0800
Message-ID: <7vac31p8om.fsf@assigned-by-dhcp.cox.net>
References: <7v8ximwrm3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611072009220.2601@qynat.qvtvafvgr.pbz>
	<45520872.3090506@gmail.com> <45521AE9.7050902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 9 Nov 2006 04:04:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <45521AE9.7050902@gmail.com> (Aneesh Kumar K. V.'s message of
	"Wed, 08 Nov 2006 23:29:05 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31180>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gi19S-0006hX-8d for gcvg-git@gmane.org; Thu, 09 Nov
 2006 05:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932426AbWKIEE1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 23:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWKIEE1
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 23:04:27 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:63648 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S932426AbWKIEE0
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 23:04:26 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061109040426.ITMO20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Wed, 8
 Nov 2006 23:04:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id kU4X1V0011kojtg0000000; Wed, 08 Nov 2006
 23:04:31 -0500
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Sender: git-owner@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@gmail.com> writes:

>> I am trying to test this feature. Is there a documentation
>> .git/shallow some where. Atleast what those entries
>> mean ? I know in the mail johannes mentioned only core git will
>> touch this file. But it should be ok to be descriptive like other
>> files. (FETCH_HEAD)
>
> diff --git a/Documentation/repository-layout.txt b/Documentation/repository-layout.txt
> index 275d18b..03a6f77 100644
> --- a/Documentation/repository-layout.txt
> +++ b/Documentation/repository-layout.txt
> @@ -141,3 +141,9 @@ logs/refs/heads/`name`::
>  
>  logs/refs/tags/`name`::
>  	Records all changes made to the tag named `name`.
> +
> +shallow::
> +	Records the sha1 of the commits which is marked to have no
> +	parents to represent a shallow repository.The commit object
> +	will have the parent information present. It carry one
> +	record per line.

I would drop the second sentence which is just confusing but
otherwise it is correct, I think (I just started trying it
out).

But it seems to need some more work.  I just tried to clone
git.git with --depth=1 and it cauterizes each branch with two
commits (I think that is what depth=1 means -- the latest and
one behind it), but it pulled almost the whole repository
anyway, and it turns out that "git log v1.4.3-rc1" gives me the
full history leading to it.

Subsequent "git fetch --depth 99999" makes the branches
connected to the root commit, and I am reasonably sure we do not
have that many commits, but .git/shallow did not become empty.

I haven't followed the code closely enough to tell if these are
just minor details needing more polish, or something more
fundamental in the design.


