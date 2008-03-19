From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH Second draft] Fast forward strategies allow, never, and only
Date: Wed, 19 Mar 2008 22:20:58 +0100
Message-ID: <200803192220.59035.jnareb@gmail.com>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com> <m363vkvvzb.fsf@localhost.localdomain> <402c10cd0803182320k134116cas5f62389482f2650a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:29:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc5qA-0005me-KG
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 22:28:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937296AbYCSV2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 17:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937293AbYCSV17
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 17:27:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:20131 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937279AbYCSV15 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 17:27:57 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1324757ugc.16
        for <git@vger.kernel.org>; Wed, 19 Mar 2008 14:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=JoSlEsovEKuVOtOkkTYlo53ELa3xMKzTTYJLoSSVnmo=;
        b=K1vyiPBZPVjNixvYd800FnS8O39E3gFWMa3zYy/hJPVOvjP/gUKZ3s5qRNDD7uCH7dzgO0ZU2Oqav2keev64vevY8TTz4EMXPjj7MJaQAuTkbI1uOYsYpXTImpFD5Q+wUZ2fYkMIjZZbogVmduAbeRgbyft1Ol0ifeO9yLMMCjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qqySwLoEyZipfRM0n1mbZ58KzEeKgdCvvtdP4D0MvafCQRCVbOGTW09m3dvArEW4kTAUk2w+40irAxjaenFQebKGkb+yMcoPXrefuMJu8HFlLHdMh/yY+QUw0QseEH2S4YdYJQ8Kq5fnqU9hzE+IpPZhP28obA7ogz0gVoP0bcM=
Received: by 10.67.101.17 with SMTP id d17mr911368ugm.4.1205961671629;
        Wed, 19 Mar 2008 14:21:11 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.232.48])
        by mx.google.com with ESMTPS id e23sm19677168ugd.56.2008.03.19.14.21.08
        (version=SSLv3 cipher=OTHER);
        Wed, 19 Mar 2008 14:21:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <402c10cd0803182320k134116cas5f62389482f2650a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77558>

On Wed, 19 Mar 2008, Sverre Hvammen Johansen wrote:

> Thanks to you and everyone else for useful input.  Some of this input
> ended up in the documentation.  I will provide an updated patch
> tomorrow.  I expect to have a final patch for submission some time
> next week.
> 
> I have added some more documentation:
 
This updated documentation made it clear that this commit introduces
two (or even three accoridng to Junio) independent features, which in
my opinion should be split into separate patch. Having separate commits
for separate features helps reduce commit size and should help
readibility of patch, thus making review process easier. It also makes
bisecting easier.

First feature is introducing fast forward options (I'd rather not call
them "strategies") 'allow', 'never' and new option 'only'. This is
independent on the head reduction feature; actually the second feature
was sent as separate patch in first draft, I wonder why you have
decided to join them.
 
> +If more than one commit are specified for the merge, git will try to
> +reduce the number of commits (real parents) by eliminating commits
> +than can be reached from other commits.  The commit message will
> +reflect the actual commits specified but the merge strategy will be
> +selected based on the real parents always including `HEAD`.  The real
> +parents (only including `HEAD` if it is real) are the parents recorded
> +in the merge commit object.

IMHO this should be (besides having this as separate commit) optional.
I'm not sure if always heads reduction is always desirable.

> +The following shows master and three topic branches.  TopicB is based
> +on TopicA, TopicA is previously branched off from master, and TopicC
> +is based on the current `HEAD` of master:
> +
> +------------
> +                    o---o---o  TopicB
> +                   /
> +          o---o---o  TopicA
> +         /
> +    o---o---o---o---o---o  master
> +                         \
> +                          o---o  TopicC
> +------------

I'd provide first simpler example without 'TopicC'.

If I understand correctly you have implemented here always using
"parent" (or "dependent") reduction of merge heads. IMHO this reduction
contradict stated idea of using --ff=never (--no-ff) to always mark
where topic branch has ended.

> +A merger of master with TopicA, TopicB, and TopicC will select the
> +merge strategy based on the three branches master, TopicB, and TopicC
> +(TopicA is eliminated since it can be reached from TopicB).  TopicB
> +and TopicC are the only real parents and are therefore the only
> +parents recorded in the merge commit object:
> +
> +------------
> +         % git co master
> +         % git merge TopicA TopicB TopicC
> +
> +                    o---o---o  TopicB
> +                   /         \
> +          o---o---o  TopicA   \
> +         /                     \
> +    o---o---o---o---o---o.......o  master
> +                         \     /
> +                          o---o  TopicC
> +------------

This... is a bit unexpected. I thought that there should be line where
I have added dotted line.

The example above mixes fast-forward options with automatic reduction
of heads in a merge.

I'd really prefer if you would resurrect merge head reduction options
(strategies?) as it was, i.e. as separate patch. And of course talk
about reducing heads, not fast-forward options/strategies... this issue
is IMVHO orthogonal to options for allowing/forcing/denying fast-forward.

> On Tue, Mar 18, 2008 at 8:27 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>>
>>  I'd mention here receive.denyNonFastForward option as a way to set
>>  this globally for all branches, for public bare publishing
>>  repositories; AFAIK for push and I think also for fetch.
> 
> The denyNonFastForward option have nothing to do with merges.  It only
> applies to push on the server side.  A merge is not involved when
> doing a push.

Fact. My mistake. The result might be similar (linear history), but the
issue is different.


P.S. I think git is now in feature freeze... which is good time for
sending patches for discussion, not good for sending patches to be
accepted.

-- 
Jakub Narebski
Poland
