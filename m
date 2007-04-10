From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Tue, 10 Apr 2007 13:19:17 -0700
Message-ID: <7vwt0kugmy.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	<200704101828.37453.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.64.0704101122510.6730@woody.linux-foundation.org>
	<200704102004.08329.andyparkins@gmail.com>
	<Pine.LNX.4.64.0704101219280.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 07:06:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbMoE-0000EE-EU
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 22:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbXDJUTT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 16:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753846AbXDJUTT
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 16:19:19 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:57529 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845AbXDJUTS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 16:19:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070410201917.JABC1271.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Apr 2007 16:19:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id lYKH1W00W1kojtg0000000; Tue, 10 Apr 2007 16:19:18 -0400
In-Reply-To: <Pine.LNX.4.64.0704101219280.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 10 Apr 2007 12:20:24 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44182>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 10 Apr 2007, Andy Parkins wrote:
>> 
>> Would it be nicer if .gitmodules were line-based to aid in merging?
>
> I seriously doubt you'll ever be merging or changing this a lot. So I 
> don't think it's a huge concern.

I think Andy's comment comes from our earlier discussion on the
other in-tree configuration, .gitattributes file.

We were talking about using in-tree .gitattributes for deciding
if we apply crlf to each paths and other things like which 3-way
file-level merge backend to apply, and need to make the system
gracefully degrade even when in-tree .gitattributes have
conflict markers during a merge.  And for that purpose, it is
certainly easier to arrange "pick each line, while ignoring <<<
or === or >>>, and if there are conflicting duplicates do
something sensible about them", if the file is line oriented.

But I do not think the .gitmodules thing needs that.  If we have
conflicting (or non-conflicting for that matter) submodule
moves, that's a _MAJOR_ project re-organization, and I do not
think we would even want to automatically descend into
submodules for merging or checking-out when we have such a
situation in the higher level project.
