From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Sat, 17 Mar 2012 10:05:11 +0000
Message-ID: <4F6461D7.40303@pileofstuff.org>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org> <7vty1ndcoi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 11:05:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8qWE-0002m5-Vd
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 11:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756575Ab2CQKFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 06:05:18 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:54461 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755950Ab2CQKFQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2012 06:05:16 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120317100513.QSKE6650.mtaout01-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Sat, 17 Mar 2012 10:05:13 +0000
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120317100513.GHPE13318.aamtaout03-winn.ispmail.ntl.com@[192.168.0.2]>;
          Sat, 17 Mar 2012 10:05:13 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <7vty1ndcoi.fsf@alter.siamese.dyndns.org>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=pFZ1vDXyzkQA:10 a=thCgSaaV3M8A:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=VwQbUJbxAAAA:8 a=GvpgsREupBDBYvv976QA:9 a=a8U6YdhEVGOcz6gr0P8A:7 a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193315>

On 17/03/12 05:22, Junio C Hamano wrote:
> If the conclusion of the discussion is that we will change the default,
> the transition to the new default will go like this:
> 
>  1. An announcement message to let the user communities know about the
>     future change will be distributed in a way similar to the previous
>     request-for-discussion message was distributed.
> 
>  2. The first version of Git that is released after such an announcement
>     will start issuing a warning when you type "git push" to send the
>     matching branches to the default location unless you have configured
>     push.default variable.  The users who want to keep the current default
>     can do
> 
> 	$ git config push.default matching
> 
>     and the users who want to use different settings can do one of:
> 
> 	$ git config push.default current
> 	$ git config push.default upstream
> 	$ git config push.default nothing
> 
>     to silence this warning. The warning will be issued unless you do so,
>     to help those who missed the message #1.
> 
>  3. We wait for a few release cycles.
> 
>  4. The default changes.  If you do not configure push.default variable,
>     it no longer defaults to matching, but does something else (the choice
>     among the three other alternatives will be decided in the discussion).
>     The warning message will be reworded---instead of saying "will stop
>     being the 'matching' in the future", it will say "has changed to X".
> 
>  5. We wait for a few release cycles.
> 
>  6. The warning is removed.
> 
> A typical release cycle lasts for 8-10 weeks.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Unfortunately, "a few release cycles" strikes me as a rather hopeful
description.  For example, a user installing the new Ubuntu LTS release
(due out next month) would feel completely justified in not upgrading
until 2017, whereas the rest of us would get rather bored disabling the
same old warning in every new repo we create for the next five years.

Could I suggest when a user inits/clones a new repository using a
post-change version of git, we do an automatic `git config
push.warned_about_default_change true`, then warn forevermore when users
push from a repo with neither that option nor a push.default?  This will
warn existing users with arbitrarily long upgrade cycles, and reduce the
amount of noise during the (necessarily) already noisy first days of a
new repo.

FWIW, I've been stung by the old behaviour and think the change of
default is a great idea, but have nothing more useful to add :)

	- Andrew
