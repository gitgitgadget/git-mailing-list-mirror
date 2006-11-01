X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Restore a single file in the index back to HEAD
Date: Wed, 01 Nov 2006 00:34:37 -0800
Message-ID: <7vvelz7eg2.fsf@assigned-by-dhcp.cox.net>
References: <200610261641.11239.andyparkins@gmail.com>
	<81b0412b0610260842x52413570k3971bcdc54b3ccb5@mail.gmail.com>
	<200610270827.17659.andyparkins@gmail.com>
	<20061027073834.GC29057@spearce.org> <4541BE8E.5050605@op5.se>
	<20061027081545.GF29057@spearce.org>
	<81b0412b0610270245w6c29b3c3va7967991f53db298@mail.gmail.com>
	<4541D670.6000900@op5.se> <7vac3igjpd.fsf@assigned-by-dhcp.cox.net>
	<fcaeb9bf0610312358g1176e4d8q8962b08c2e8ff2c6@mail.gmail.com>
	<7vpsc78ua3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 08:34:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vpsc78ua3.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 01 Nov 2006 00:07:16 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30621>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfBYa-0003JK-69 for gcvg-git@gmane.org; Wed, 01 Nov
 2006 09:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423853AbWKAIek (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 03:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423918AbWKAIek
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 03:34:40 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:47313 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1423853AbWKAIei
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 03:34:38 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061101083438.UYTB12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Wed, 1
 Nov 2006 03:34:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id hLaH1V0021kojtg0000000 Wed, 01 Nov 2006
 03:34:18 -0500
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

>> I would prefer "git update-index --reset frotz" or "git checkout
>> --index HEAD frotz". git ls-tree|git update-index is too cryptic for
>> me and too long for my fingers.
>
> Then perhaps you can use "git checkout HEAD frotz", which is the
> simplest?

Sorry, Oops.

One should never respond to a message in an ancient thread
unless one has enough time to revisit previous messages and
refresh one's memory.

The original topic was about updating the index entry without
touching working tree, so "co HEAD path" would not do what was
wanted.

I think at the UI level, the most appropriate place would be
"git reset".  Checkout is a Porcelainish that is primarily about
working tree and it updates the index as a side effect (from the
UI point of view); you can update the working tree without
modifying index or you can update both index and the working
tree, but updating only index and not working tree does not
belong there.

Given a commit that is different from the current HEAD, "reset"
moves the HEAD and depending on hardness of the reset it updates
the index and the working tree.  Currently the command does not
take paths limiters and means "the whole tree", but asking to
update only one would logically fall as a natural extension to
the current command line if we add paths limiters.

As an implementation detail of the new "reset", the ls-tree to
update-index pipe could be used.
