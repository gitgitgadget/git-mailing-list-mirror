From: Guy Rouillier <guyr@burntmail.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Wed, 22 Dec 2010 00:43:49 -0500
Message-ID: <4D119015.6020207@burntmail.com>
References: <4D0ED5EC.9020402@burntmail.com> <20101220213654.GA24628@burratino> <4D112586.2060904@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>,
	Martin Langhoff <martin@laptop.org>
To: Emil Medve <Emilian.Medve@Freescale.com>
X-From: git-owner@vger.kernel.org Wed Dec 22 06:52:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVHcO-0003g0-9b
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 06:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282Ab0LVFo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 00:44:27 -0500
Received: from mx02.burntmail.com ([70.87.63.122]:56643 "EHLO
	mx02.burntmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab0LVFo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 00:44:27 -0500
Received: from [173.79.59.45] (helo=[192.168.1.60])
	by mx02.burntmail.com with esmtpa (Exim 4.63)
	(envelope-from <guyr@burntmail.com>)
	id 1PVHUP-0002iE-CV; Tue, 21 Dec 2010 23:43:53 -0600
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <4D112586.2060904@Freescale.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164072>

On 12/21/2010 5:09 PM, Emil Medve wrote:
> Hello Guy,
>
>
> On 12/20/10 15:36, Jonathan Nieder wrote:
>> (+cc: Emil, some cvsimport people)
>>
>> Guy Rouillier wrote:
>
> Sometimes, on some particularly nasty CVS repos, I noticed better
> results when using http://cvs2svn.tigris.org
>
>>> I'm going to try sending this blind, as the mailing list has sent me
>>> the promised authorization key after 24 hrs.
>>
>> No problem.  Actually a subscription is not required --- the
>> convention on this list is to always reply-to-all.
>>
>>> I finally found the problems, both of which were reported in 2008
>>> here:
>>>
>>> http://kerneltrap.org/mailarchive/git/2008/3/13/1157364
>>
>> Seems to have received no replies[1].
>
> I don't remember why, but that patch didn't get enough interest
>
>>> I do see one possible issue with the supplied modifications.  At
>>> work, we upgraded from CVS to CVSNT.  So, my home directory has both
>>> .cvspass (from the original CVS) and .cvs/cvspass (after the
>>> conversion to CVSNT.)  Sloppy housekeeping on my part, I admit, but
>>> probably not uncommon.  The supplied patch would pick up the
>>> original CVS file and would fail.  (BTW, this is true only of the
>>> git-cvsimport.perl script itself; cvsps must shell out to the
>>> installed CVS client (in my case, cvsnt), because when I invoked
>>> that manually, it worked.)
>>>
>>> So, I would advise checking to see if both files exist, and if so
>>> exit with an error.  Unless cvsimport wants to get real fancy and
>>> shell out to the installed cvs client to try to figure out what is
>>> installed, there is no way to tell which cvspass file is actively
>>> being used.  I don't recommend trying to figure this out, as the
>>> user's intent is unclear.
>>
>> Thanks, sounds sane to me.  Care to write a patch?
>
> If you care enough about this scenario, how about search for the
> relevant<CVSROOT, password>  in both files. If you find just one pair or
> if you find a pair in both files and they are "equal" then just use it.
> If you find two pairs, one in each file, use the one from the file with
> a newer modified time-stamp. In a migration scenario such as this, you'd
> imaging the "old" file will get stale after a while. Not perfect, but
> some informational messages in case of a duplicate would help the user
> clarify their intentions
>
> Additionally/Alternatively just add a command line parameter to allow
> the user to explicitly specify a cvspass file

Emil and Jonathan, thanks for the feedback.  Perl is not my strong 
point, but I'll take a crack at it over the upcoming holidays.  I'm 
inclined not to get too fancy and try to second-guess the user's 
environment.  Perhaps he has both cvs and cvsnt installed for some 
reason (testing one, using the other for regular work); perhaps a tool 
installed one or the other and he doesn't even know he has them both. Etc.

So, at most I can see, as Emil suggested, seeing if the entry exists in 
both files and is the same in both.  If so, or if the entry is only in 
one of them, then just use the entry.  However, if the entry is in both 
files and is different, I'd prefer to just exit with an error and have 
the user clarify his environment.

-- 
Guy Rouillier
