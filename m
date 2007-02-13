From: Mark Levedahl <mlevedahl@verizon.net>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Mon, 12 Feb 2007 19:32:38 -0500
Message-ID: <45D10726.2070501@verizon.net>
References: <45CFA30C.6030202@verizon.net> <20070212042425.GB18010@thunk.org>
 <Pine.LNX.4.64.0702120839490.8424@woody.linux-foundation.org>
 <7vps8f6l81.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702130020450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 13 01:33:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGlbd-0006fQ-TO
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 01:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030596AbXBMAck (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 19:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030591AbXBMAck
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 19:32:40 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:34474 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030596AbXBMAcj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 19:32:39 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDD00L7GLIAWYN0@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 12 Feb 2007 18:32:36 -0600 (CST)
In-reply-to: <Pine.LNX.4.63.0702130020450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39466>

Johannes Schindelin wrote:
> Hi,
>
> On Mon, 12 Feb 2007, Junio C Hamano wrote:
>
>   
>> I agree that we can assume editors can grok files with LF end-of-line 
>> just fine and we would not need to do the reverse conversion on checkout 
>> paths (e.g. "read-tree -u", "checkout-index").
>>     
>
> In that case, a simple pre-commit hook would suffice.
>
> No, the problem mentioned by Mark was a very real one: you _cannot_ rely 
> on Windows' editors not to fsck up with line endings. The worst case is if 
> the file contains _some_ CRLF and _some _LF_. Almost always I had the 
> problem that it now converted _all_ LFs to CRLFs. Even those which already 
> were converted.
>
> So, if we are to support text mode, it is not one-way. If we do one-way, 
> we really do _not_ support text mode, but pre-commit conversion to LF 
> style text. And in this case, core git does not need _any_ change.
>
> Ciao,
> Dscho
In my work flow, I am using a pre-commit script that (among other 
things) rewrites all text files to have \n endings. This is a one-way 
conversion, and does work well for the set of tools I am using. The 
converters I use I wrote years ago, and are smart enough to deal with 
mixtures of \n, \r\n, and \r line endings in one file, transforming all 
into one unified form. d2u / u2d were not that robust when I last tried 
them (years ago), but this is an absolute necessity.

However, I don't think the one-way conversion is acceptable across the 
board. While the only Windows editor I am aware of that doesn't grok \n 
is Notepad (the moral equivalent of edlin), I suspect that undo reliance 
upon this will still lead to grief. If nothing else, someone, somewhere 
will find that their beloved crlf's are missing and will complain. 
Loudly. And in the lore, git will become known for being "wierd."  So, I 
suspect a checkout script is necessary.

Mark
