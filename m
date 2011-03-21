From: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
Subject: Re: [PATCH] git-submodule: Remove duplicate entries during merge
 with conflict
Date: Mon, 21 Mar 2011 09:43:23 +0100
Message-ID: <4D870FAB.4050307@morey-chaisemartin.com>
References: <4D81C1AA.5010008@morey-chaisemartin.com> <7v1v254ma7.fsf@alter.siamese.dyndns.org> <7vhbb1320t.fsf@alter.siamese.dyndns.org>
Reply-To: devel-git@morey-chaisemartin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 09:50:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1aoY-00074i-Qc
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 09:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330Ab1CUIuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 04:50:09 -0400
Received: from 30.mail-out.ovh.net ([213.186.62.213]:39341 "HELO
	30.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752120Ab1CUIuH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 04:50:07 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Mar 2011 04:50:07 EDT
Received: (qmail 30642 invoked by uid 503); 21 Mar 2011 08:34:07 -0000
Received: from b9.ovh.net (HELO mail419.ha.ovh.net) (213.186.33.59)
  by 30.mail-out.ovh.net with SMTP; 21 Mar 2011 08:34:07 -0000
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 21 Mar 2011 10:43:25 +0200
Received: from mailhost.kalray.eu (HELO sat.lin.mbt.kalray.eu) (devel-git@morey-chaisemartin.com@217.108.237.233)
  by ns0.ovh.net with SMTP; 21 Mar 2011 10:43:24 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <7vhbb1320t.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 1128996133183676376
X-Ovh-Remote: 217.108.237.233 (mailhost.kalray.eu)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|U 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169560>

On 03/17/2011 09:50 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com> writes:
>>
>>> During a merge with conflict on a submodule, the submodule appears 3
>>> times in git ls-files (stage 1,2,3) which causes the submodule to be
>>> used 3 times in git submodule update or status command.  This patch
>>> filters the results of git ls-files and only shows submodule in stage 0
>>> or 1 thus removing the duplicates.
>> That is a wrong thing to do.  What if both sides added a submodule at the
>> same directory after forked from an ancestor that did not have it?  You
>> will have only stage #2 and stage #3, no?
After a quick check, you're right on that ;)
> It is not very friendly to say a solution is wrong without hinting what
> the right thing to do, so let's try.

Thanks for taking the time to point me in the right direction !
> There are 5 callers of module_list; they all read (mode, sha1, stage,
> path) tuple, and most of them care only about path.  As a first level
> approximation, it should be Ok (in the sense that it does not make things
> worse than it currently is) to filter the duplicate paths from module_list
> output.
>
...
>  - Status does not have anything to report for an unmerged submodule. It
>    may want to recurse into the submodule of the unmerged one, but people
>    involved in submodule work should think things through; and
>
I agree that the actual behavior of status is definitely wrong and it should be changed.
But I think there needs to be a simple way for a user to know whats happening to a conflicted submodule.
When merging a file, editing the conflicting area in the code is often enough.
For a submodule, I think the user needs an easy access to which branch used what SHA1.

Git submodule status is probably not the right place to do that.
git ls-files --stage allows that but it's not part of the standard porcelain commands...

I guess a first step should be to apply the patch you proposed and discuss a later solution to get the submodule SHA1 (well except if there's already one I just don't know about !)

I'll check/test the patch you proposed as soon as possible and repost it if it's allright !

Nicolas Morey-Chaisemartin
