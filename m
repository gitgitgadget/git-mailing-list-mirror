From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: [PATCHv5 0/2] bash completion: Support "divergence from upstream"
 messages in __git_ps1
Date: Fri, 18 Jun 2010 22:02:11 +0100
Message-ID: <4C1BDED3.2090002@pileofstuff.org>
References: <20100612000002.GA30196@neumann> <cover.1276336602.git.trast@student.ethz.ch> <4C13F32B.7060106@pileofstuff.org> <201006140942.43099.trast@student.ethz.ch> <4C17F5B3.4070907@pileofstuff.org> <7v7hlyg5nh.fsf@alter.siamese.dyndns.org> <4C1A9442.7080304@pileofstuff.org> <7vljacxqwc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 18 23:33:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPjBZ-0005XI-6j
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 23:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167Ab0FRVdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 17:33:04 -0400
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:26818 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752989Ab0FRVdB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jun 2010 17:33:01 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100618210214.KYAL3266.mtaout01-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Fri, 18 Jun 2010 22:02:14 +0100
Received: from [192.168.1.5] (really [80.6.134.127])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100618210214.GBFR1598.aamtaout03-winn.ispmail.ntl.com@[192.168.1.5]>;
          Fri, 18 Jun 2010 22:02:14 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <7vljacxqwc.fsf@alter.siamese.dyndns.org>
X-Cloudmark-Analysis: v=1.1 cv=W3tOLUehizD4qj6VhtReFuw5MKb8d+XqjIxlDsIazEA= c=1 sm=0 a=uccVAaSrvSQA:10 a=1CvaPgNKC-EA:10 a=8nJEP1OIZ-IA:10 a=mvbXojFnNZgdDBl48RsA:9 a=dPqaQ6b4qtQkrU88QY0A:7 a=9hNWrfK63hfdWtV5bwg019jBxw8A:4 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149365>

On 18/06/10 17:10, Junio C Hamano wrote:
> 
> But doesn't all of the above suggest the decision should be per branch?
> It is not too implausible to have a branch that is actively interacting
> with SVN upstream and another branch whose upstream has migrated from SVN
> and now managed by git.  Say you and your pal are working with a project
> that is managed by SVN, and you use one of your branches to interact
> directly with SVN upstream.  Your pal has a branch forked from the same
> SVN upstream, and one of your other branches is building on top of her
> work.  When you are on the former branch, you would want to know how your
> work diverged from the SVN upstream; when you are on the latter branch,
> you would want to know how your work diverged from your pal's git branch
> that you are using as its upstream.  No?
> 

It sounds like you're asking for git-svn to set
git.<branch>.{remote|upstream}, and for this script to ditch the
SVN-specific workarounds.  I have no problem with such a solution, but I
also have no idea where to begin with it.  Is there some reason we don't
do this already?

A simpler 90% solution would be to switch the defaults around, so you
always use @{upstream} if defined, or otherwise search for the SVN
upstream.  This enables every use case except noMetadata, and I suspect
any solution to that one would be at least as complex as setting
git.<branch>.{remote|upstream}.

>>> If you "tr" to trash "\0" anyway, do you need to run "config -z"?
>>
>> The `tr` is there to work around issues like this:
>>
>> 	git config bash.showUpstream $'svn\nlegacy'
>> 	git config bash.showUpstream | tr '\0\n' '\n '
> 
> Is that even an issue?  Why should there be a LF in the value?  I thought
> you defined it as a string with space separated magic tokens...  Perhaps I
> am missing something?

My concern was more with the robustness principle than anything - LFs
aren't part of the format defined in the docs, and I can't think of a
reason why people would need them, but there's no mechanical way to stop
people putting them in there.  If you're saying that git users can be
trusted not to do anything so stupid (and/or that it's their problem if
they do), then I'm happy to get rid of this.

	- Andrew
