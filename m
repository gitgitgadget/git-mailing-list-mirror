From: Andreas Ericsson <ae@op5.se>
Subject: Re: git push
Date: Thu, 05 Mar 2009 09:45:11 +0100
Message-ID: <49AF9117.1020407@op5.se>
References: <43d8ce650902242238s7ab4c851p9c820c96b67aa62b@mail.gmail.com> <7vskm3c84t.fsf@gitster.siamese.dyndns.org> <20090225225826.GA13510@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Thu Mar 05 10:06:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf9Xd-000408-JG
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 10:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbZCEJF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 04:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbZCEJF1
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 04:05:27 -0500
Received: from spsmtp02oc.mail2world.com ([74.202.142.148]:2996 "EHLO
	spsmtp02oc.mail2world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbZCEJF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 04:05:26 -0500
X-Greylist: delayed 1209 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Mar 2009 04:05:26 EST
Received: from mail pickup service by spsmtp02oc.mail2world.com with Microsoft SMTPSVC;
	 Thu, 5 Mar 2009 00:43:41 -0800
auth-sender: exon@home.se
Received: from 212.112.174.166 unverified ([212.112.174.166]) by spsmtp02oc.mail2world.com with Mail2World SMTP Server; 
	Thu, 05 Mar 2009 00:43:40 -0800
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <20090225225826.GA13510@pvv.org>
X-OriginalArrivalTime: 05 Mar 2009 08:43:41.0792 (UTC) FILETIME=[7C867600:01C99D6E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112273>

Finn Arne Gangstad wrote:
> Sorry to people receiving this mail twice, the list ate my first reply
> since it managed to hit the spam-filter (maybe I should take a hint... :)
> 
> On Tue, Feb 24, 2009 at 11:01:38PM -0800, Junio C Hamano wrote:
>> [...]
>>
>> But if you are talking about changing the default when "git push" is run
>> without any parameter, I have to say it is a terrible idea, for two
>> reasons, and one is too obvious to state so I wouldn't repeat it and talk
>> only about the other one.
> 
> The current default behaviour of git push is very annoying for us at
> least. The current behaviour is _dangerous_ and leads to serious
> problems. It is too easy for someone to write "git push". They hit
> enter too soon, or they write it expecting to get usage
> information. They do not necessarily expect to overwrite random
> branches in a remote repository.
> 
> Most git commands are not destructive with no arguments at all, and
> push is the _only_ command that really can screw things up for others,
> so this command in particular should refrain from destructive default
> behaviour.
> 
> An example of random branch overwriting:
> $ mkdir a
> $ cd a
> $ git init
> $ echo contents > file
> $ git add file
> $ git commit -m message
> $ cd ..
> $ git clone a b
> $ cd b
> $ git checkout -b gif-support
> $ echo foo > somefile
> $ git add somefile
> $ git commit -m message
> $ ( cd ../a && git branch gif-support) # Assume done by someone else
> $ git checkout master
> $ # <hack away, maybe commit a bit>
> $ git push  # <-- OOOPS! pushes gif-support!
> 
> Notice that what branches git push ends up pushing is out of your
> control, since new branches can appear in the remote repository at any
> time. This is very unfriendly in our setup with a shared incoming repo.
> 
> If developer A creates "gif-support", shares it with developer B, who
> does an additional commit on it to make it print more debug info (but
> has no intent of pushing it anywhere), and A pushes it to the "incoming"
> repo, developer B risks overwriting that with his debug version.
> 

git push will never overwrite changes in the remote repo unless you
specify --force. If anyone *blindly* uses --force, they really shouldn't
have write-access to anything so precious as your code repositories.

Worst-case scenario, you commits that were never intended for publication
enter your public wateringhole and needs a revert later on. Big deal.

> It is not realistic to believe that in a big project with many
> developers, no one will ever do the mistake of typing "git push".  It
> is also not realistic to believe that everyone will know how to (or
> remember to) configure this away.
> 

But it *is* realistic to not assume that they will also use --force
while doing so.

>> If you shoot for the least damage for such people, the sanest default for
>> "git push" would be to do nothing.  You *always* say what to push where,
>> then there is no risk of pushing something you did not intend to.  Perhaps
>> "push.default = never" configuration may not be such a bad idea?
> 
> If "git push" could do nothing at all without configuring anything, that
> would be a big improvement to us.
> 

I can buy this, I guess. I always type the remote-name I want to push to
anyways. A sane no-op default would probably be to list the pre-configured
remotes along with a short usage message. I still don't quite see the point
of it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
