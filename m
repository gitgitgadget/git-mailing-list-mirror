From: Junio C Hamano <junkio@cox.net>
Subject: Re: how to speed up "git log"?
Date: Sun, 11 Feb 2007 20:08:37 -0800
Message-ID: <7vmz3kaugq.fsf@assigned-by-dhcp.cox.net>
References: <200702111252.28393.bruno@clisp.org>
	<Pine.LNX.4.63.0702111745170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<200702120041.27419.bruno@clisp.org>
	<200702120059.17676.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bruno Haible <bruno@clisp.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 05:08:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGSUm-0001Js-Jn
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 05:08:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbXBLEIk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 23:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbXBLEIj
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 23:08:39 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:62636 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932577AbXBLEIj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 23:08:39 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070212040839.LYZA4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 11 Feb 2007 23:08:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NU8e1W0041kojtg0000000; Sun, 11 Feb 2007 23:08:38 -0500
In-Reply-To: <200702120059.17676.robin.rosenberg.lists@dewire.com> (Robin
	Rosenberg's message of "Mon, 12 Feb 2007 00:59:17 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39356>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

>> No, it became even worse: git-1.5.0-rc4 is twice as slow as git-1.4.4 for
>> this command:
>>   git-1.4.4: 25 seconds real time, 24 seconds of CPU time (12 user, 12 system)
>>   git-1.5.0: 50 seconds real time, 39 seconds of CPU time (20 user, 19 system)
>
> Could the UTF-8 stuff have anything to do with this?

I doubt it -- sliding mmap() in the current git, while is a good
change overall for handling really huge repos, would most likely
perform poorer than the fixed mmap() in 1.4.4 series on
platforms with slow mmap(), most notably on MacOS X.

It _might_ be possible that turning some sliding mmap() calls
into pread() makes it perform better on MacOS X.

I wonder what happens it git is compiled with NO_MMAP there...
