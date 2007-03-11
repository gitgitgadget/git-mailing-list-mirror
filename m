From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 2/3] git-bundle: die if a given ref is not included in
 bundle
Date: Sun, 11 Mar 2007 10:51:51 -0400
Message-ID: <45F41787.4080506@gmail.com>
References: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45F0D1B3.9020204@gmail.com> <7vejny7umx.fsf@assigned-by-dhcp.cox.net> <45F17EF0.5060008@gmail.com> <7v1wjy56qf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0703101637300.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45F2D955.8050800@gmail.com> <Pine.LNX.4.63.0703101749270.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45F2F934.8060407@gmail.com> <Pine.LNX.4.63.0703110201450.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vy7m4y3cn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0703110244130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 11 15:52:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQPP3-0003vI-S1
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 15:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933695AbXCKOvt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 10:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933699AbXCKOvt
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 10:51:49 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:11713 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933695AbXCKOvs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 10:51:48 -0400
Received: by wr-out-0506.google.com with SMTP id 70so1864599wra
        for <git@vger.kernel.org>; Sun, 11 Mar 2007 07:51:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=CrgjgqTEqdN7NTbxiQUMbgxDWqao9H7DUQXJx9GykNzUMNIak1z2CrIevbGR4W4R21TQ1VARO0l0Dy1u2jmxSb4lfsfpWE1lPdH7HSzEc77WOPJlPcFNvuc0WYnwkIAvjNFw4RqsuaPFGyEWefWilZ03x3Gf9JsjXG/MzH58CvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sg5vh8ZiymU/MLI39ME4oJYA20DULRSrwskrNlIukXALfHvGLNjfqzvLe0FQ0vAi/bvbBUrVNt6u5NW8vugg5BNZTQgWoYlYq8JoUlKDtSZshUg9e0eerYpNmvosv8GAdn+mhiorEO1uobtJZJo0sPcDPP56OH7UpXV7bXv8MqA=
Received: by 10.90.34.3 with SMTP id h3mr2419465agh.1173624707601;
        Sun, 11 Mar 2007 07:51:47 -0700 (PDT)
Received: from ?192.168.100.117? ( [71.246.235.75])
        by mx.google.com with ESMTP id 26sm5240072aga.2007.03.11.07.51.46;
        Sun, 11 Mar 2007 07:51:46 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <Pine.LNX.4.63.0703110244130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41929>

Johannes Schindelin wrote:
> git-bundle (as is in "next") has clearly defined semantics.
>   
git-bundle on next with the patch in 
<Pine.LNX.4.63.0703091726530.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
works well enough for me, but absent that latter patch is too punishing.
> But the bundle concept is not thought through. Obviously, the clearly 
> defined semantics of git-bundle do not match what people want to use 
> bundles for.
>
>   
>> I've been wondering if we can define prereqs per listed head.
>>     
Currently, a bundle has a single pack. The bundle's prerequisites are 
that pack's dependencies. Splitting prerequisites per head requires 
either creating one pack per head or unpacking at the receiving and and 
extracting only the objects needed for the selected head. I'm not sure 
that either is warranted, and my uses of bundle do not require this 
regardless.

I think we need to restate purpose here. git-bundle is an alternate 
transport mechanism: git-bundle + git-fetch over sneakernet allows doing 
what git-push or git-fetch can do when directly connected. However, 
there are limitations due to the lack of direct connect, specifically 
the user of git-bundle needs to specify the prerequisites as the 
protocol cannot negotiate these. The exchange needs to be robust in that 
git-bundle+git-fetch must never result in leaving a repository in a 
corrupted state: the current prerequisites list + use of git-fetch seem 
to satisfy this.

 From a given connected repo, I can do:

    git fetch -f <source url> master:master

and nothing complains, even if no update occurs (remote master is up to 
date). I can also do
        git fetch -f <source url> master:next

and the new ref is created without complaint even if no new objects need 
to be defined or if the new definition is completely unrelated to the old.

With appropriate remote settings in .git/config, I can have git-fetch 
get all branches, or all branches and tags, and never complain when no 
update is required for something.

What I desire is similar functionality across sneakernet, and this is 
where git-bundle steps in. I cannot know what is on the destination 
repository exactly, so I need an imprecise way to specify prerequisites 
(e.g., --since=10.days.ago): I *know* that this is not exactly correct 
and *must* be conservative so that the bundle likely can be used. As the 
system is distributed and I don't control the recipients of the bundle, 
there is *no* way to know exactly what exists, the previous bundle is 
not definitive, it might not have been applied, they might have received 
data by a side-channel communication, etc.

So, a date range is the best method I have found to specify a bundle's 
prerequisites. However, I should not have to know which refs have been 
updated within the date range: this is too punishing. Directly connected 
git-fetch does not abort when the refspec says "get everything" but some 
ref in "everything" has not changed, why should git-bundle complain? 
Absent the latest patch (i.e., what is now on next), git-bundle will 
error out which is extremely unfriendly and unhelpful.

The single disconnect for the above with latest git-bundle + patch is 
that we cannot package a ref whose commit object is directly a bundle 
prerequisite. (I cannot do the equivalent of "git fetch remote 
master:next", where I already have all the objects for master). These 
instead result in a string of warning messages with the latest patch: I 
can live with this limitation (though I don't think this should even be 
a warning, git-fetch/git-push do not warn here). Absent the latest 
patch, git-bundle errors out: this is too punishing to the user.

While it is possible to fetch a particular ref from the bundle rather 
than taking all, the monolithic pack structure and protocol dictates 
that you will get all objects regardless. I do not see this as a 
problem: the bundle came from a single repository, everything in the 
bundle is therefore related, excess is easily trimmed by git-repack. 
This is really just a limitation of the disconnected protocol that 
cannot optimize the pack for the exact transfer required.

At some point, we have to make a clear distinction between what rules 
the protocol should enforce for "correctness" vs what an "intelligent" 
use of bundle is, and not try to enforce the latter in the software. 
What practices are useful or good vary considerably from business to 
business (I have many times been told that things I find essential to my 
work are "bad practice," usually stated by people who didn't have to 
solve a problem given constraints I actually face). The only requests 
git-bundle/git-fetch should refuse are things that will corrupt a 
git-repository, and the pair should endeavor to enable any information 
transfer that can be done with git-push or git-fetch given direct 
connections.

Bottom line, I strongly advocate Dscho's last patch + what is on next be 
promoted to master. We can revisit how well it is working and refine it 
after it gets some usage from others defining additional use-cases.

Mark
