From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-send-pack: broken handling of ref specs with wildcards
Date: Thu, 07 Jun 2007 23:33:59 -0700
Message-ID: <7v8xavlzu0.fsf@assigned-by-dhcp.cox.net>
References: <20070607225302.GA10633@steel.home>
	<Pine.LNX.4.64.0706072356220.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 08 08:34:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwY2u-0008Qx-QX
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 08:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695AbXFHGeC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 02:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755507AbXFHGeC
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 02:34:02 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:46378 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754695AbXFHGeA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 02:34:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070608063400.UBVF12556.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 8 Jun 2007 02:34:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8uZz1X0081kojtg0000000; Fri, 08 Jun 2007 02:34:00 -0400
cc: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0706072356220.4046@racer.site> (Johannes
	Schindelin's message of "Thu, 7 Jun 2007 23:56:56 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49438>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 8 Jun 2007, Alex Riesen wrote:
>
>> Try something like this:
>> 
>>     git-send-pack --remote=origin --thin /some/other/repo \
>>     'refs/heads/*:refs/remotes/child/*'
>> 
>> The result looks broken: the sent reference are created not in
>> refs/remotes/child/ but just in refs/heads/ of /some/other/repo.
>
> I had the impression that it was git-push, a porcelain, which handles 
> refspec wildcards, not send-pack, which is plumbing.

Well, I do not think it is wrong per-se if plumbing send-pack
starts understanding 'a/*:b/*'.  Earlier it only understood
concrete refspecs, and such a refspec that has asterisks cannot
be concrete, as '*' is an invalid char in a refname.  So there
is no risk of confusion.

That is, as long as it is done right, which was not true in this
case.
