From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Reencode committer info to utf-8 before formatting mail header
Date: Sat, 13 Jan 2007 14:18:20 -0800
Message-ID: <7vfyaek1ub.fsf@assigned-by-dhcp.cox.net>
References: <871wm08kcu.fsf@morpheus.local>
	<7vd55jrj38.fsf@assigned-by-dhcp.cox.net>
	<7vr6tzogp4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 13 23:18:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5rCr-0008V3-Pd
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 23:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422805AbXAMWSX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 17:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422806AbXAMWSX
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 17:18:23 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:45234 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422805AbXAMWSW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 17:18:22 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070113221821.FKMB97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Sat, 13 Jan 2007 17:18:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id AmJd1W00g1kojtg0000000; Sat, 13 Jan 2007 17:18:38 -0500
To: git@vger.kernel.org
In-Reply-To: <7vr6tzogp4.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 12 Jan 2007 17:31:35 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36777>

On this topic, along with the "format-patch" fix (which
automatically makes "rebase without --merge" do the right thing
because it is "format-patch piped to am" in essence), I have
another commit to make "cherry-pick", "rebase --merge" and
"commit -c/-C" do the right thing according to the
commitencoding specified in the repository the new commit is
being created.

The issue is that an existing commit might have come from a
different repository or from the past when this repository had
commitencoding that was different from the current value.
Running "cat-file commit" to extract the old commit log message
and feeding it directly to create the new commit would not work,
because the value of commitencoding in this repository may be
different.

This should not affect old encoding-unaware setup where people
use _only_ a legacy encoding and do not bother to specify any
commitencoding.  In such a case, both input and output are the
same and while we pretend both are UTF-8, we actually do not
trigger conversion.  To support such a configuration is one
reason I did not actually take Johannes's suggestion to error
out on an existing commit that does _not_ have encoding header
but the contents does not look like a valid UTF-8.

The series is currently sitting in 'next'.  If people do not see
problem with it, I think it should go in v1.5.0.
