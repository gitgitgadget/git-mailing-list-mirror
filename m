From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: hooks/post-receive-email bug?
Date: Tue, 07 Jul 2009 11:14:13 -0400
Message-ID: <4A536645.70307@xiplink.com>
References: <4A396C6E.2050600@xiplink.com> <4A520EFA.10309@xiplink.com> <4A534E9F.3010303@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jul 07 17:14:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOCNm-0005Vn-1h
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 17:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743AbZGGPOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 11:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754530AbZGGPOu
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 11:14:50 -0400
Received: from smtp122.iad.emailsrvr.com ([207.97.245.122]:40771 "EHLO
	smtp122.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138AbZGGPOt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 11:14:49 -0400
Received: from relay32.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay32.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id E07991B4074;
	Tue,  7 Jul 2009 11:14:47 -0400 (EDT)
Received: by relay32.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id C150A1B4047;
	Tue,  7 Jul 2009 11:14:47 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <4A534E9F.3010303@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122848>

Michael J Gruber wrote:
> 
> Why not read the hook script yourself... but see below.

Laziness, obviously!  :)

> I assume that by "pushing matching heads" you mean you did not create a
> topic branch on origin?

Right.  The push command pushed both merge commits to the origin, taking the topic commits along with them.

> The hook tries cleverly to avoid sending multiple commit mails for the
> same commit. The heuristics is not completely failsafe. It seems the
> hook thinks these commits have been dealt with already, which usually
> happens when they can be reached by other refs than the one being updated.

Thanks for confirming the issue.  Actually, I don't think the existence of a topic branch on the origin would've made a difference.  Like you say, the script ignores any commits reachable by any other branch.

It seems to me that the script might be able to keep track of which branches are being updated, and notice if two or more of them share commits.  But that may require a heavy rewrite...

One question: Is the reason the script sent two emails because git called it with two lines on stdin?  As in:
	C D master
	Y Z release

		M.
