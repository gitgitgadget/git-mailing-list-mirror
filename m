X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Question on rerere
Date: Tue, 19 Dec 2006 17:29:45 -0800
Message-ID: <7vy7p3mk1i.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0612200045490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vk60no0ua.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 01:30:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vk60no0ua.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 19 Dec 2006 16:41:33 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34886>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwqHQ-0002j6-HN for gcvg-git@gmane.org; Wed, 20 Dec
 2006 02:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964784AbWLTB3u (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 20:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932904AbWLTB3s
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 20:29:48 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:62168 "EHLO
 fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932918AbWLTB3r (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 20:29:47 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220012946.FKTV15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Tue, 19
 Dec 2006 20:29:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 0pV41W00T1kojtg0000000; Tue, 19 Dec 2006
 20:29:04 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> IIUC then each conflict hunk is handled _separately_ like this: the 
>> lexicographically smaller between the two file sections is displayed 
>> first, regardless if a previous hunk had a different order. Not that it 
>> matters most of the time, but isn't this dangerous?
>
> You are probably right.  Probably the right thing would be to
> use the first hunk to determine the flipping order and stick to
> that for the rest.
>
> Not that I've seen problems with the current behaviour, though.

Well, come to think of it, I think the current behaviour makes
more sense.

Suppose you start from an original file "OO".  You have two
branches that change it to "AO" and "BO", and another pair of
branches that change it to "OC" and "OD".  Let's call these
branches A, B, C, and D.

By merging A and C, you will get "AC"; you can get "AD", "BC"
and "BD" the same way.

Now suppose you are on "AC" and merged "BD".  You would get
"<A=B><C=D>".

If you were on "BD" and merged "AC" you would get "<B=A><D=C>".
If you were on "AD" and merged "BC" you would get "<A=B><D=C>".

You got the idea?





