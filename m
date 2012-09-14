From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Using Format/export-subst Howto.
Date: Fri, 14 Sep 2012 23:09:22 +0200
Message-ID: <1347656962.3998.140661128069097.6D9BE3C4@webmail.messagingengine.com>
References: <84EA18831601B6429E578236AE239B01A54807F242@EAGNMNSXMB07.usa.dce.usps.gov>
 <50532B35.9050607@drmicha.warpmail.net> <5053480E.2010002@viscovery.net>
 <84EA18831601B6429E578236AE239B01A54807F376@EAGNMNSXMB07.usa.dce.usps.gov>
 <50534FC6.2040207@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>,
	"Mestnik, Michael J - Eagan, MN - Contractor" 
	<Michael.J.Mestnik@usps.gov>
X-From: git-owner@vger.kernel.org Fri Sep 14 23:09:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCd8m-000318-Pz
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 23:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254Ab2INVJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 17:09:24 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49392 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753746Ab2INVJX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 17:09:23 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 94FC9206C0;
	Fri, 14 Sep 2012 17:09:22 -0400 (EDT)
Received: from web1.nyi.mail.srv.osa ([10.202.2.211])
  by compute1.internal (MEProxy); Fri, 14 Sep 2012 17:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:from:to:cc:mime-version
	:content-transfer-encoding:content-type:in-reply-to:references
	:subject:date; s=smtpout; bh=oaC75Yj5V4aDId/yJrZ6c8E4keA=; b=acO
	zRlKzm/KM7ajFnjEzAbv5DxOc4VMTkEzyAEe2CgSMZl22Au1Tsv8jjCXDYB/7NKz
	a7MUn+/7wX/LXib0T30gBlWW/NpriD0g6qhGAiPP/fTMRdkDc2++XHcyCZp53m1B
	JYt6YHKAt80n3fxa/R6jBsFTfieVQWWcVNyF8nJ0=
Received: by web1.nyi.mail.srv.osa (Postfix, from userid 99)
	id 5BA5DA00176; Fri, 14 Sep 2012 17:09:22 -0400 (EDT)
X-Sasl-Enc: f8H8q0zsC0bZNgVgmLcgepc/7EOM3kyrGXwFn49EiijC 1347656962
X-Mailer: MessagingEngine.com Webmail Interface
In-Reply-To: <50534FC6.2040207@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205531>



On Fri, Sep 14, 2012, at 05:39 PM, Johannes Sixt wrote:
> Am 9/14/2012 17:27, schrieb Mestnik, Michael J - Eagan, MN - Contractor:
> > 
> >> -----Original Message----- From: Johannes Sixt
> >> If EOL conversion or a clean filter was applied during 'git add
> >> file', is the version in the worktree suddenly wrong? Of course,
> >> not.
> >> 
> >> I would place $Id$ treatment in the same ball park and declare it as
> >> a mistake of the editor that it did not remove the now "wrong" SHA1
> >> from $Id:$.
> > 
> > I think the difference here is that git does not *currently change the
> > OS's LEF.  In this case each commit alters the Id and git is the one
> > altering the Id.
> 
> Maybe you misunderstood $Id$? The value you get there is the blob's SHA1,
> not the commit's. That is, it does not change on every commit, but only
> when the file changes.
> 
> You are right that the value itself is something that is dictated by
> git's
> database model, but the change logically happens when the editor modifies
> the file.

Exactly, but the problem is that neither $Id$ nor $Id: deadbeef$ in the
work-tree copy of the file
are updated with $Id: abacbeef$ after the file's content has changed and
has been committed, i.e.
after the blob's sha1 has changed. What's worse, even a "git checkout
file" does not
correct this (because git sees that there's no change to the file
compared to the index),
you need to "rm file && git checkout file"). If the user has to update
$Id$ to match the current sha1
(by remembering to do a more forceful checkout than checkout -f) then
one half of that feature is useless. 

> (My contribution to this thread should be regarded as food for thought.
> Personally, I don't mind whether or not and when $Id$ is updated.)
> 
> -- Hannes

I think at least we should do a commit.renormalize akin to
merge.renormalize if we can't do
more for hysterical raisins. But maybe the behavior even has changed
during some
stat/lstat related optimizations. I'll check next week if nobody beats
me to it.

Cheers,
Michael
