From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Mon, 12 Feb 2007 19:59:50 -0500
Message-ID: <45D10D86.3030508@verizon.net>
References: <45CFA30C.6030202@verizon.net> <20070212042425.GB18010@thunk.org>
 <Pine.LNX.4.64.0702120839490.8424@woody.linux-foundation.org>
 <7vps8f6l81.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702130020450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy9b6iyt.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702130046450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 13 02:00:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGm1j-0002Dk-2K
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 02:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965445AbXBMBAH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 20:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965448AbXBMBAH
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 20:00:07 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:40142 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965445AbXBMA7y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 19:59:54 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDD00DM5MRM40PC@vms046.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 12 Feb 2007 18:59:49 -0600 (CST)
In-reply-to: <Pine.LNX.4.63.0702130046450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39470>

Johannes Schindelin wrote:
> However, since this is all post-1.5.0 (right? Right?) why not go with more 
> of Ted's proposal, and make this whole mess also usable for other things 
> than just crlf issues
Whatever is done, it needs to be robust to the notion that people will 
fail to set the correct file type somewhere. Current cvsnt is fairly 
good at autodetecting and setting text vs binary file type, and enforces 
this across all platforms, so things don't go awry too often. It is in 
my experience more reliable than subversion, which basically relies upon 
file extensions mapping to mime types to identify content. All of which 
is a very much too low standard of accuracy for a version control 
system: I lost many files per year due to the above nonsense, so I worry 
about trying to create a very general transform solution and not making 
it really, really failsafe. Having projects define individual globbing 
patterns is good, double checking the content for sanity is an absolute 
must, but I don't think that is enough. I suspect the solution should 
include round-trip conversion when creating blobs to assure that the 
input can be exactly reconstructed by the inverse transformation (and 
therefore possibly rejecting input with mixed line endings). A similar 
check could be applied on checkout.

Perhaps I'm too paranoid, but I've been burnt way too many times by 
text/binary mode stuff to let this part be trivialized. Maybe it only 
gets enabled by core.ImReallyParanoid, but I want that option.

Mark
