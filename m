From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] Clean up work-tree handling
Date: Fri, 27 Jul 2007 17:42:17 -0700
Message-ID: <7vejitwe8m.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
	<Pine.LNX.4.64.0707271956420.14781@racer.site>
	<7vk5sly3h9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707280115370.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, matled@gmx.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 28 02:42:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEaNy-0006uC-Hq
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 02:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938070AbXG1AmU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 20:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932985AbXG1AmT
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 20:42:19 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:38484 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932380AbXG1AmT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 20:42:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070728004218.KVBQ7349.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 27 Jul 2007 20:42:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UoiH1X00V1kojtg0000000; Fri, 27 Jul 2007 20:42:18 -0400
In-Reply-To: <Pine.LNX.4.64.0707280115370.14781@racer.site> (Johannes
	Schindelin's message of "Sat, 28 Jul 2007 01:21:57 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53979>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> This changes semantics, I think.
>> 
>> It used to be relative "up" path when no funny work-tree stuff
>> is used, but get_git_work_tree() now seems to return absolute,
>> hence this option as well.  If it introduces regression to
>> existing callers is up to what the caller does to the resulting
>> path, though.  If it only is used to prefix other things
>> (i.e. path="$(git rev-parse --show-cdup)$1"), the caller would
>> be safe, but if the caller counted number of ../ in the return
>> value to see how deep it is, or if the caller expected to see
>> empty string in order to see if the process is at the toplevel,
>> this change would become a regression.
>
> I am somewhat negative on keeping _that_ much backwards compatibility.  
> Scripts which depend on show-cdup being a relative path _will_ be broken 
> by work-tree.  Is it worth it to detect those errors late?

Well, one of the conditions to accept the worktree stuff was not
to break anybody who never ever uses worktree.  So if we can
keep the UP-ness of cdup, it would be much better.
