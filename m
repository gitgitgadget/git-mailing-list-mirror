From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [MONKEY PATCH] git-svn: allow two branch configurations
Date: Mon, 22 Jun 2009 10:50:44 -0400
Message-ID: <4A3F9A44.8070805@xiplink.com>
References: <4A3A4945.6050307@drmicha.warpmail.net> <1245335463-4488-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jun 22 17:01:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIl1a-0000Ca-KI
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 17:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755772AbZFVPBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 11:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756417AbZFVPBW
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 11:01:22 -0400
Received: from smtp242.iad.emailsrvr.com ([207.97.245.242]:60536 "EHLO
	smtp242.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbZFVPBV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 11:01:21 -0400
X-Greylist: delayed 627 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jun 2009 11:01:21 EDT
Received: from relay14.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay14.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 3F3F2229732
	for <git@vger.kernel.org>; Mon, 22 Jun 2009 10:50:55 -0400 (EDT)
Received: by relay14.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id F03EB228DA1;
	Mon, 22 Jun 2009 10:50:54 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
In-Reply-To: <1245335463-4488-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122044>

I tried this patch over the weekend, and it worked perfectly.

I've imported the head/, releng/, and stable/ FreeBSD branches, plus the release/ tags -- some 190,000 svn revisions.  The git repository is 720MB, compared to 4.6GB for the synsync'd mirror of the svn repo.

Michael J Gruber wrote:
> 
> I see two viable options for a real patch now:
> - Extend $remote->branches to be an array and use "config --get-all" to
>   read the config; do the same for tags.
> - Use one single array for branches as well as tags.
> 
> Eric, which way do you prefer? The first one is simpler and may be even
> doable for me. The second looks more complicated mainly because of "git
> svn branch -t" (which element of the combined array is tags?), even
> though it's more natural if one thinks about the way svn works.

I favor the first option, mainly because of its simplicity and because it seems natural to me to keep branches and tags separate, despite svn's mechanics.

With this capability, the 'git svn branch' command (and 'git svn tag') would need to be extended to allow the user to specify the location of the new branch (or tag).  I suggest a -d (for "destination") argument.  -d would be required if there's more than one branches (or tags, if -t is also specified) config option for the svn-remote.  The -d value must successfully glob against the LHS of one of the branches' (or tags') refspecs.

Thanks, Michael!  I'm going to start putting together some unit tests for this while the implementation details get sorted out.

		M.
