From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: Advice on strategy for "temporary" commits
Date: Thu, 8 Mar 2007 17:07:56 +0000
Message-ID: <e1dab3980703080907v58739287p18bc2797db7d209e@mail.gmail.com>
References: <e1dab3980703080639i4c553e89nb931c2aea45b023b@mail.gmail.com>
	 <20070308163239.GH22713@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bfields@fieldses.org, raa.lkml@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 18:08:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPM65-0000fz-Vu
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 18:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbXCHRH7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 12:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbXCHRH6
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 12:07:58 -0500
Received: from nz-out-0506.google.com ([64.233.162.232]:3763 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbXCHRH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 12:07:57 -0500
Received: by nz-out-0506.google.com with SMTP id s1so481549nze
        for <git@vger.kernel.org>; Thu, 08 Mar 2007 09:07:57 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sxbxvWxwvUaoSqT2WTN3MyL1auD0ppEwTUx/Yzscts0Ti/V8AqoGaGWwHILDF19t31/lJm+axB7M69B8EJYaLcTAI5OqY65znYdZnpH+rr1O3V9n86SU6pRy3WTT8gWlJquBa4eMmM66YycfGX0uv1VbqN6YSwEy2cM9oBH4vEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kIqG0rIAESugT4nLHlWMAOtDrV9Nwt2qPf6cnBaN+XvJPTXZkh++goc158QXQvXN87SUGk3Fj0a8Y0wmt1NncJazoExGjiBfYzkm5KxQuK7FARGrALsH2eTIrXt3rOqwOmMLGnNpmohKTPmMfBWQbEzIekGAmh5bJq68FjI//Ic=
Received: by 10.65.237.15 with SMTP id o15mr1175557qbr.1173373677124;
        Thu, 08 Mar 2007 09:07:57 -0800 (PST)
Received: by 10.65.160.2 with HTTP; Thu, 8 Mar 2007 09:07:56 -0800 (PST)
In-Reply-To: <20070308163239.GH22713@fieldses.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41757>

> You don't want to run git-rebase out of a cron job, because it may
> require human interaction.
>
> The simplest thing might be to make the temporary commits onto a
> separate branch, and throw that branch away periodically.

Thanks to you & Alex for suggesting this.

So, at this point I need to ask an embarassingly basic
question: how do I "change branches" from T (say), in order to commit
to a different branch A, without changing the contents of
the working directory back to match what it was at the
time of the last commit to A? (I know this is not the
thing you normally want to do.) Ie, in terms of diagrams
I've got my archival commit branch with its hourly
commits running along the top and the temporary branch
with its temporary commits running along the bottom
and a $ means that, considered just as commited trees
the objects linked are the same:

a-----------a-----------a
 \          $           $
  \-t---t---t---t---t---t---t---t

(In case it's not clear, the "temporary branch" record
extends past the last "archival commit" and throwing
away the temporary commits shouldn't remove any
archival commits.)

So I'm on the temporary branch and have been doing
temporary commits to it and we hit an hour mark.
Cron wants to commit what's _currently_ in my working
directory as a new head to the "archival branch" A
and then swap back the temporary branch to
commit it on that branch and carry on, ie, make
the diagram look like:

a-----------a-----------a-----------a
 \          $           $           $
  \-t---t---t---t---t---t---t---t---t

AIUI neither git-branch nor git-checkout provide
a way to do this. (Clearly the git datastructures
can represent this situation, I'm just not sure how
to ask the tools to do it.)

Again, thanks for all the assistance,
-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
Details are all that matters; God dwells there, and you never get to
see Him if you don't struggle to get them right. -- Stephen Jay Gould
