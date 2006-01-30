From: Romano Giannetti <romanol@upcomillas.es>
Subject: Re: Two newbie question: "dead" branches and merging after cherry-pick.
Date: Mon, 30 Jan 2006 12:44:44 +0100
Message-ID: <20060130114444.GA17093@pern.dea.icai.upcomillas.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
X-From: git-owner@vger.kernel.org Mon Jan 30 12:44:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3XS6-0002D3-MR
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 12:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWA3LoH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 06:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWA3LoH
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 06:44:07 -0500
Received: from mail1.upco.es ([130.206.70.227]:26522 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S932230AbWA3LoF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2006 06:44:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail1.upco.es (Postfix) with ESMTP id C84C21131C6
	for <git@vger.kernel.org>; Mon, 30 Jan 2006 12:44:04 +0100 (CET)
Received: from mail1.upco.es ([127.0.0.1])
	by localhost (mail1 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 25301-04 for <git@vger.kernel.org>;
	Mon, 30 Jan 2006 12:44:03 +0100 (CET)
Received: from pern.dea.icai.upcomillas.es (pern.dea.icai.upco.es [130.206.71.186])
	by mail1.upco.es (Postfix) with ESMTP id A462D1131B2
	for <git@vger.kernel.org>; Mon, 30 Jan 2006 12:44:03 +0100 (CET)
Received: by pern.dea.icai.upcomillas.es (Postfix, from userid 1153)
	id 7CD10102DD; Mon, 30 Jan 2006 12:44:44 +0100 (CET)
To: git@vger.kernel.org
Mail-Followup-To: Romano Giannetti <romanol@upcomillas.es>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: by amavisd-new-20030616-p7 (Debian) at upco.es
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15268>

First of all, 1000 thanks and please forgive me for the broken thread, I was
not subscribed to the list before so I did a copy-and-paste from the web
archive. 

Junio C. Hamano wrote:
> 
> You are done with what you did in the branch for now, but you
> have not merged the work to your day-to-day development "master"
> for some reason.  In the meantime you would want to switch to
> other topic branches to work on other topics, and while working
> on them you do not want to "git branch" and "git show-branch" to
> show the topic you are done with but not merged yet.  Later you
> would want to come back to it to do some interesting stuff with
> it (maybe finally merge into "master", or format-patch to send
> upstream).  Is that what is happening here?
> If so, I would have chosen "postponed" not "dead" to describe
> the situation but you said "dead" and that is why I am wondering
> if I am getting you correctly.

Yes, you have understood perfectly. I called them "dead" because really I do
not think to come back to them ever, but I want to maintain that as "old
story", something of the style "that was an error, store it so that you will
never fall in it again". 
> 
> Yes.  You have the tag under .git/refs which points at the tip
> of that postponed branch head, so the development trail will not
> be lost.  When you are done with other topics and would want to
> come back to that topic again, you could do this:
> 

>     $ git tag hold/jc/gitlink jc/link ;# copy it to tags/
>        $ git branch -D jc/link             ;# delete it from heads/
> 
> Now "git branch" would not show it, but "gitk --all" still would.
>

What I have done (and it seems to work perfectly) is 

    git checkout master
    mkdir .git/refs/olds 
    mv .git/heads/test-bill-idea .git/olds

and it seems to work ok. Thanks! 

    
>         - Easier: suppose I cheery-picked "abababab" from branch "testing"
>         to master branch. What will happen if later I decide to merge
>         all "testing" to master branch? I will have a merge conflict (trying
>         to apply two times the same fix) or not? 
> 
> This is easy to experiment so I'd suggest you to try it and tell
> us what you see, like this:
> 
>   $ git checkout -b test-merge-throwaway master
>        $ git cherry-pick abababab
>        $ ... play with it, maybe making a couple of commits
>        $ git pull . testing
> 
> I would not be surprised if this resolves cleanly. If abababab
> is the only thing that touches the set of paths it touches,
> other than what are in "testing" and what you did since
> "testing" forked from "master", it is likely that the merge
> would resolve cleanly.
> 
> Otherwise you would likely to see conflicts --- in which case
> you may want to suggest if/how we can reduce it.  "cherry-pick"
> without -r drops a hint of which commit was picked in the commit
> log so it _might_ be a good idea to teach git to optionally take
> that information into account while doing the merge.  I dunno.
> 
> Once you are done experimenting, you can come back to master and
> delete the test-merge-throwaway branch:
> 
>       $ git checkout master
>        $ git branch -D test-merge-throwaway
> 

Thanks. I will play a bit with it. I sometime have a bit of fear to not
being able to come back to a good state. I will do my homework and study a
bit more git checkout, branch and reset (this latter gives me a bit of
headheache last time... ;-) ).

Thanks a lot. 
          
-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
http://www.dea.icai.upcomillas.es/romano/
