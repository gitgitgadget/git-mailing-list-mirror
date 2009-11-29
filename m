From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What is the best way to backport a feature?
Date: Sun, 29 Nov 2009 18:02:32 +0100
Message-ID: <4B12A928.2000401@drmicha.warpmail.net>
References: <loom.20091129T164518-669@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Weseloh <Peter.Weseloh@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 18:02:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEnAh-0002Sa-8a
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 18:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbZK2RCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 12:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752276AbZK2RCj
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 12:02:39 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:42236 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751373AbZK2RCi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Nov 2009 12:02:38 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0BE85C576B;
	Sun, 29 Nov 2009 12:02:45 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Sun, 29 Nov 2009 12:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=R9gso8bBCX8GTiyfg1/BvbVjNIU=; b=drPN85tyPhlMBGUTPG+RB/MMQkEtQaKS35Wjxs26fwftssTOeb2V5R0ukIT3q8qvL8RYzHFHOtVYeVq3svmpqEMcGcD0M1vhQRWtkvDY1kHESnRgvNQqYaH+4UpMdt9BI3ny7VGUNUgRUZghwJgm4WjWAm3I1I3+128tovKLmwE=
X-Sasl-enc: 7zJpkqdoamHUMe4i5dsM88mzqq+sDWj2s0EIdXmlLigp 1259514164
Received: from localhost.localdomain (p5DCC0A73.dip0.t-ipconnect.de [93.204.10.115])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B103349BC90;
	Sun, 29 Nov 2009 12:02:43 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091127 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <loom.20091129T164518-669@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134026>

Peter Weseloh venit, vidit, dixit 29.11.2009 17:28:
> Hi,
> 
> Suppose I have the following situation:
> 
>   o--o--o                    Release_1.0
>  /    \  \                  
> o-o-o--o--o-o-o-o-o-o---o--o Mainline
>      \       \       \ /    
>       F1--F2--M1--F3--M2     Feature_A
> 
> Now I want to backport "Feature_A" to the "Release_1.0" branch so that it gets
> included into the next minor release, i.e. I want to apply the commits F1, F2
> and F3 onto the "Release_1.0" branch.
> I cannot just merge "Feature_A" into "Release_1.0" because that would also bring
> in the merges M1 and M2 so a lot of other stuff from the Mainline.
> 
> I played with cherry-pick but that means I have to manually find the commits F1,
> F2 and F3 (which in reality could be many more if Feature_A is big) which is not
> very nice.
> 
> I also tried 'rebase -i' but that means I have to manually delete all the lines
> for changesets from the mainline. Also not very nice.
> 
> Is there a better way? To me this scenario sounds not unusual but I could not
> find a solution.

The problem is that you've been a bad boy to begin with ;)

Seriously, I suggest reading up on "topic branches". Feature_A should
have been based off the common merge base of Mainline and Release_1.0,
and, even more importantly, there should not have been any merges from
Mainline into Feature_A. So, that branch is not at all what one would
call a feature branch/topic branch. Hopefully, this scenario is very
uncommon :)

I assume you have to deal with the given structure anyhow, and merge
will not help. The only solution is to try and replay your Feature_A
commits on top of the release branch. (Since you have merged Feature_A
into Mainline already, you probabably don't want to redo that branch and
merge.)

I you have many commits to deal with I suggest finding a good
semi-automated way to list the commits you are after, such as git
rev-list --no-merges sha1..Feature_A (with sha1 being the fork point). A
good way to find out could be git log --no-merges sha1..Feature_A.

Then, try and cherry-pick those onto the release branch. Alternatively,
you can use format-patch/am, or in fact try with rebase (I thought it
would ignore merges), which basically does what cherry-pick does.

Cheers,
Michael
