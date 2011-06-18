From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: [PATCH] rebase -i -p: doesn't pick certain merge commits that
 are children of "upstream"
Date: Sat, 18 Jun 2011 12:47:33 -0400
Message-ID: <4DFCD6A5.7000707@sohovfx.com>
References: <4DEB495F.9080900@kdbg.org>	<1307419725-4470-1-git-send-email-andrew.kw.w@gmail.com>	<1307419725-4470-2-git-send-email-andrew.kw.w@gmail.com>	<7vmxhlpvob.fsf@alter.siamese.dyndns.org>	<4DF64932.1090607@sohovfx.com>	<20110616172454.13ff1a18@sh9>	<4DFC4863.2090803@sohovfx.com> <20110618101718.6ff03688@sh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Sat Jun 18 18:50:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXyjE-0000fc-At
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 18:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942Ab1FRQrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 12:47:39 -0400
Received: from smtp04.beanfield.com ([76.9.193.173]:62451 "EHLO
	smtp04.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab1FRQrj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 12:47:39 -0400
X-Spam-Status: No
X-beanfield-mta04-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta04-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta04-MailScanner: Found to be clean
X-beanfield-mta04-MailScanner-ID: 1QXygI-0006Ui-IQ
Received: from [24.246.58.202] (helo=ZanarkandMac.local)
	by mta04.beanfield.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1QXygI-0006Ui-IQ; Sat, 18 Jun 2011 12:47:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <20110618101718.6ff03688@sh9>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175977>

On 11-06-18 11:17 AM, Stephen Haberman wrote:
> Letting C1 into the todo would mean having to explain to the user why
> some of their reorderings worked and others didn't.
The bug section in rebase's documentation does mention that "attempts to 
reorder commits tend to produce counterintuitive results", which I think 
serves as a fairly good warning saying "reorder at your own risk".  
Also, if we do a "rebase-i-p A1", the C1 branch will appear in the todo 
list.  A while ago I actually ran into this scenario, and I want to 
squash a commit onto the C1 branch, which I can't if I simply choose B1 
as the base.  To workaround it, I just made A1 the base so that the C1 
branch will appear in the todo for me to squash upon.  Otherwise, doing 
the squash onto C1 manually would've involved several more steps.
> I think that Jeff's use case of rebase-i-p'ing C1, which is not on the
> first-parent list of commits, should be an error as it delves into
> territory (topo reordering) that rebase-i-p can't fully handle.
There shouldn't be any topo-reordering unless the user explicitly 
changes the order of the commit.  The user is faced with the same 
limitations (and bugs) as rebase-i-p'ing D1, so we shouldn't have to 
handle the C1 case any different.  rebase is perfectly capable of 
handling the D1 case, just as how the C1 case is handled.  We're only 
running into this issue because we're trying to filter out C1 when 
rebase-i-p'ing B1.
