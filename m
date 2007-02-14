From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Wed, 14 Feb 2007 09:26:22 -0500
Message-ID: <45D31C0E.2040206@verizon.net>
References: <45CFA30C.6030202@verizon.net>
 <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org>
 <7v7iumx7hu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
 <7v8xf1uxme.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702132127330.3604@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702141208020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 14 15:26:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHL5d-0000zE-4o
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 15:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbXBNO0a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 09:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbXBNO0a
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 09:26:30 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:33022 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932290AbXBNO03 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 09:26:29 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDG00C9EIRSSPL2@vms046.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 14 Feb 2007 08:26:18 -0600 (CST)
In-reply-to: <Pine.LNX.4.63.0702141208020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39651>

Johannes Schindelin wrote:
> Last time I checked, the text files never had lines longer than 200 
> characters (I chose this intentionally large). So, it might be a good 
> heuristic to check the maximal line length, and refuse to believe that 
> it's text once a certain (configurable) threshold is reached.
>
> Ciao,
> Dsch
Unfortunately, on my program we have folks using text files with single 
lines over 60,000 characters long, these are data files. Think for 
example of a comma or tab separated data file saved from a spreadsheet. 
In this case, the files are pure ascii. So, the line length could be 
something else to take into account, but is not decisive by itself.

To recap, we have the following various suggestions to determine textness:

1) ratio of ascii to non-ascii characters, possibly weighting some chars 
more than others
2) line length
3) existence of a null (\0)
4) file name globbing
5) roundtrip ( lf(crlf(file) ) == file

I don't think any one suggestion is completely adequate for all uses, 
all need to be available, somehow configurable. This suggests to me a 
core.AutoCRLFstrategy variable that is a comma separated list of methods 
to use (set to a reasonable default of course that does not cause 
runtime headaches on Unix): a file would be deemed binary unless all 
listed methods declare the file as text (with an empty list disabling 
AutoCRLF detection).

Mark
