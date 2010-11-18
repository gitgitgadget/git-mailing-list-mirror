From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [BUG?] git checkout -b removes MERGE_HEAD
Date: Thu, 18 Nov 2010 20:01:01 +0100
Message-ID: <20101118190101.GP3693@efreet.light.src>
References: <456aec650e66bba518b8a5ec88c88a6b.squirrel@artax.karlin.mff.cuni.cz>
 <7vwroabhng.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 20:01:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ9jU-0000PE-16
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 20:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757407Ab0KRTBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 14:01:04 -0500
Received: from cuda1.bluetone.cz ([212.158.128.5]:41498 "EHLO
	cuda1.bluetone.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757402Ab0KRTBD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 14:01:03 -0500
X-ASG-Debug-ID: 1290106860-0702ed9d0001-QuoKaX
Received: from efreet.light.src (152-31-80-78.tmcz.cz [78.80.31.152]) by cuda1.bluetone.cz with ESMTP id 5YqQJAWfBEeqv4Kl; Thu, 18 Nov 2010 20:01:00 +0100 (CET)
X-Barracuda-Envelope-From: bulb@ucw.cz
X-Barracuda-Apparent-Source-IP: 78.80.31.152
Received: from bulb by efreet.light.src with local (Exim 4.72)
	(envelope-from <bulb@ucw.cz>)
	id 1PJ9jB-00049w-Af; Thu, 18 Nov 2010 20:01:01 +0100
X-ASG-Orig-Subj: Re: [BUG?] git checkout -b removes MERGE_HEAD
Content-Disposition: inline
In-Reply-To: <7vwroabhng.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Barracuda-Connect: 152-31-80-78.tmcz.cz[78.80.31.152]
X-Barracuda-Start-Time: 1290106860
X-Barracuda-URL: http://212.158.128.5:8000/cgi-mod/mark.cgi
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5097 1.0000 0.7500
X-Barracuda-Spam-Score: 1.25
X-Barracuda-Spam-Status: No, SCORE=1.25 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=4.5 KILL_LEVEL=4.8 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.47003
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161705>

On Thu, Nov 18, 2010 at 10:39:31 -0800, Junio C Hamano wrote:
> "Jan Hudec" <bulb@ucw.cz> writes:
> 
> >  So I did:
> >
> >    $ git checkout -b temp
> >    $ git commit
> >
> >    OOPS! It forgot it was a merge.
> 
> I think it was an oversight by the author of 91dcdfd (Make "git checkout"
> create new branches on demand, 2005-07-11) who forgot that he also did
> ef0bfa2 (Remove MERGE_HEAD in "git checkout/reset", 2005-06-21).  The
> rationale for the removal of MERGE_HEAD from the earlier commit is:
> 
>     [this command] will end up resetting the index to some specific
>     head, and any unresolved merge will be forgotten [hence there is no
>     point recording the result as a merge].
> 
> but when used with -b no such "resetting of the index" happens.
> 
> Having said that, changing it not to remove MERGE_HEAD and MERGE_MSG is
> probably not sufficient, as MERGE_MSG would likely to already record to
> which branch you are recording the merge (I didn't check, though).

I believe it indeed does. However since it's now just a template for the
commit message, it can be fixed up by the user. If he actually wants to, that
is.

In my case, I only needed to stash the changes, so I could switch back to
'master' (left merge parent) to test the bug I was seeing was already there
and than I merged the temporary branch to 'master' (which was fast forward).
So the message saying I merged to 'master' was actually appropriate even when
I was commiting to some other ref.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
