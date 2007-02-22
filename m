From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added "-kb" to all the entries lines sent to the client
Date: Thu, 22 Feb 2007 12:37:28 -0800
Message-ID: <7v4ppedj3r.fsf@assigned-by-dhcp.cox.net>
References: <200702221504.32848.andyparkins@gmail.com>
	<200702221606.42638.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 22 21:37:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKKh6-0005dm-90
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 21:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbXBVUha (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 15:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbXBVUha
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 15:37:30 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:37330 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbXBVUh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 15:37:29 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070222203728.IPVZ6078.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 22 Feb 2007 15:37:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SkdU1W00J1kojtg0000000; Thu, 22 Feb 2007 15:37:29 -0500
In-Reply-To: <200702221606.42638.andyparkins@gmail.com> (Andy Parkins's
	message of "Thu, 22 Feb 2007 16:06:42 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40383>

Andy Parkins <andyparkins@gmail.com> writes:

> Perhaps when the whole .gitattributes system has settled down that could be
> used to conditionally set -kb

Indeed.  And this patch is a great help by identifying where to
insert necessary '-kb'.

If the patch had a stub implementation to determine if -kb is
needed (and the stub always says "yes" for your purpose, or "no"
for backward compatibility for non-text files), it could be
applied to the mainline for wider testing.

sub path_is_binary {
        my ($filename) = @_;

	# If you do not mind LF lineendings and care more about
        # binary files, return true from here; otherwise you may
        # want to change this to return false.
        # We'll ask the much talked about .gitattributes
        # mechanism when it's ready.
        return 1;
}

sub req_add {
        ...
        $kb = path_is_binary($filename) ? "-kb" : "";
        print "Checked-in $dirpart\n";
        print "$filename\n";
        print "/$filepart/0//$kb/\n";

        $addcount++;
}
