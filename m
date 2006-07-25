From: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
Subject: Re: [PATCH] cvsserver: suppress warnings
Date: Tue, 25 Jul 2006 23:06:38 +1200
Message-ID: <44C5FB3E.9020301@catalyst.net.nz>
References: <Pine.LNX.4.63.0607251247040.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jul 25 13:06:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5KkH-0007kM-Ky
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 13:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWGYLGe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 07:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWGYLGe
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 07:06:34 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:42433 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S932285AbWGYLGd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jul 2006 07:06:33 -0400
Received: from socrates.catalyst.net.nz ([202.78.240.34] helo=[127.0.0.1])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1G5Kk8-0003Eg-My; Tue, 25 Jul 2006 23:06:29 +1200
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607251247040.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24166>

Johannes Schindelin wrote:

> This patch defines $state->{prependdir} as the empty string, so that
> quite a few warnings are avoided.

Ack.

> 	I still get this warning:
> 
> 		closing dbh with active statement handles

Ack to that too. Perhaps an END block would help? A quick check of man 
DBI tells me that $dbh->CachedKids will be a hashref where the values 
are refs to the cached statement handles.

IMHO it's a DBI bug -- statement handles only referenced by 
$dbh->CachedKids should cleanup silently. prepare_cached() is a 
convenience method so that you _don't_ have to keep track of the handles 
manually. Forcing a manual cleanup throws a good part of the convenience 
out.

cheers,



martin
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224                              MOB: +64(21)364-017
       Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
