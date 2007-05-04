From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 04 May 2007 01:21:04 -0700
Message-ID: <7v7irpuhhr.fsf@assigned-by-dhcp.cox.net>
References: <463ADE51.2030108@gmail.com>
	<56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 10:21:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjt2O-0000vu-PN
	for gcvg-git@gmane.org; Fri, 04 May 2007 10:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767723AbXEDIVI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 04:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767733AbXEDIVI
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 04:21:08 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:52706 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767723AbXEDIVG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 04:21:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070504082104.KJCN13903.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 4 May 2007 04:21:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id uwM41W00C1kojtg0000000; Fri, 04 May 2007 04:21:05 -0400
In-Reply-To: <56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com>
	(Dana How's message of "Fri, 4 May 2007 00:22:28 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46144>

I do not think it is wrong per-se, to want to make this hold true:

	A=$(git rev-parse :somedir/file)
	B=$(cd somedir && git rev-parse :file)
        test "$A" = "$B"

One thing I am reasonably certain however is that this should
NOT be conditional to a config setting.  Doing so would force
scripts that take (or compute) path and commit and concatenate
them to make "${commit}:${path}" to name a blob (or tree) to
first inspect the current setting of core.relativepaths and undo
what the new code does by prefixing/subtracting the prefix
string depending on the config.

In other words, having that config is not really helping scripts
or compatibility.

I think the choices are:

 (1) we say it was a mistake that we did not make it relative to
     the current directory when we introduced the X:<path>
     syntax (X could be empty or :[0-3]: for index, or a commit
     or tree object name), and change the semantics in a future
     major release for everybody, apologizing for potentially
     breaking existing scripts; or

 (2) keep the current behaviour as is, and come up with a
     different syntax to use relative; or

 (3) do nothing.

My preference is (2), (3) and then (1), but I do not have
offhand a suggestion for a good metacharacter we could use.
