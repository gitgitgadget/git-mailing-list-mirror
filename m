From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] revision traversal: retire BOUNDARY_SHOW
Date: Tue, 06 Mar 2007 03:34:32 -0800
Message-ID: <7vd53mppvb.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
	<7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0703051130090.3998@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703051145210.3998@woody.linux-foundation.org>
	<Pine.LNX.4.63.0703060016020.13683@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vk5xvw6mg.fsf@assigned-by-dhcp.cox.net>
	<7vzm6rurst.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703060253140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4pozuncr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703060322270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Santi =?utf-8?Q?B?= =?utf-8?Q?=C3=A9jar?= <sbejar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 06 12:34:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOXwN-0006Wo-2Z
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 12:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965852AbXCFLef (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 06:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965865AbXCFLef
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 06:34:35 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:62709 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964980AbXCFLed (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 06:34:33 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306113433.JBRQ2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 6 Mar 2007 06:34:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XPaY1W00A1kojtg0000000; Tue, 06 Mar 2007 06:34:33 -0500
In-Reply-To: <Pine.LNX.4.63.0703060322270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 6 Mar 2007 03:29:38 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41579>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > This should help performance, as not all reachable commits are traversed 
>> > any more.
>> 
>> You prevented that with "while (i &&" part already, didn't you?
>
> Well, yes. I also wanted to prevent going down all paths, though.

If we wanted to bundle "-8 A B", I think we would make 'x' and
'y' prereqs, as they are the direct parents commits that are
shown, and that themselves are not shown.

         .---*---*---*---*---* A
        /
    ---x---y---*---*---* B

If we say upon hitting prereq (x and y) we stop traversal by
marking the parent UNINTERESTING, I suspected that we may not
find out 'x' with get_revision() loop, and that was why I chose
not to.  Instead the loop stops by finding y and then x (and by
saying "ok I needed to find two and now I have two".

But this probably needs more optimization.
