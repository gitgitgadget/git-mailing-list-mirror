From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [RFC] New kind of upstream branch: base branch
Date: Sat, 18 May 2013 17:29:57 +0300
Message-ID: <51979065.4060609@bracey.fi>
References: <CAMP44s3LQ0GN4rrXdpb8Fe0iLeAEm2VjkH6BHK64pmX-xpc7+Q@mail.gmail.com> <51968311.1020107@bracey.fi> <7va9ntxu3w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 16:37:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdiGX-0006he-23
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 16:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024Ab3EROhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 10:37:41 -0400
Received: from mo3.mail-out.ovh.net ([178.32.228.3]:36105 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429Ab3EROhk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 10:37:40 -0400
Received: from mail91.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 1DB15FF8548
	for <git@vger.kernel.org>; Sat, 18 May 2013 16:30:00 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 18 May 2013 16:29:59 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 18 May 2013 16:29:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.3 (mo3.mail-out.ovh.net)
In-Reply-To: <7va9ntxu3w.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 10405003990573420760
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeelucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.503222/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeelucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224794>

On 17/05/2013 22:51, Junio C Hamano wrote:
> Kevin Bracey <kevin@bracey.fi> writes:
>
>> On 15/05/2013 23:34, Felipe Contreras wrote:
>>>    I think I'm using 'upstream' for something it was not intended to,
>>> and
>>> I think the current 'upstream' behavior should be split into
>>> 'upstream' and 'base'.
>>>
>> I found myself thinking the same thing. It's really convenient being
>> able to set your topic branch's upstream to another local branch, so
> What is that "another local branch"? ...  And if that is your workflow, setting
> push.default to "current" (and setting remote.pushdefault to your
> publishing repository) should be a sufficient interim solution, and
> you do not need to set branch.$name.push to each and every branch
> you intend to push out, I think.

I agree that using "push.default current" covers some cases - I hadn't 
really considered it - tended to just stick with "upstream". "current" 
nearly does the job, but I will sometimes be wanting different names.

What I'll often be doing is creating a topic branch based on master or 
origin/master. (I would hardly ever be updating master or pushing to 
origin/master myself, so I probably should be just doing origin/master, 
but I tend to create a local master just to save typing on all those 
"git rebase origin/master").

During work, to give others visibility, and the possibility to tinker 
with the topic branch during development (as we don't have full 
inter-site sharing of work areas), I would push the topic branch up to 
the central "origin" server, often with a "kbracey/" prefix, partially 
for namespacing, and partially to indicate it's currently "private" work 
and subject to rebasing.  I guess I could create the topic branch as 
"kbracey/topic" locally, but I'd rather not have to.

So I'd like "git rebase (-i)" to move my topic branch up 
(origin/)master. And I'd like "git push (-f)" to send it to 
"origin/kbracey/topic". And by extension, I suppose "git pull --rebase" 
to update origin/master and rebase. (Although I'm not much of a puller - 
I tend to fetch then rebase manually).

The final releasing procedure for the topic branch would be to hand that 
branch over to an integrator, who would then merge/rebase it into master.

And it would be ideal if the initial base and push tracking information 
could be set up automatically on the first "git checkout -b"/"git 
branch" and "git push". (For one, I've always found it odd that there's 
an asymmetry - if you check out a topic branch from the server to work 
on or use it, you get a local copy with upstream set by default. But if 
you create a topic branch yourself then push it, the upstream isn't set 
by default - you need the -u flag. This seems odd to me, and I've seen 
others confused by this).

Kevin
