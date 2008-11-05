From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn: Having a "rare" structure
Date: Wed, 05 Nov 2008 14:07:57 +0100
Message-ID: <49119AAD.2010803@drmicha.warpmail.net>
References: <2686a05b0811050204v59edc4a3h7f9ce6c6ecd13058@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marc Fargas <telenieko@telenieko.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 14:28:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxiRD-0004Dk-Aa
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 14:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbYKEN1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 08:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbYKEN1L
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 08:27:11 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:41290 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751042AbYKEN1K (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Nov 2008 08:27:10 -0500
X-Greylist: delayed 1149 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Nov 2008 08:27:10 EST
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 876F21A2B4B;
	Wed,  5 Nov 2008 08:08:00 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 05 Nov 2008 08:08:00 -0500
X-Sasl-enc: hH8J1LM5NMT6DsZpEGW88SZZzhJGlM2GdjaruXOWAcq7 1225890480
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D3368C517;
	Wed,  5 Nov 2008 08:07:59 -0500 (EST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <2686a05b0811050204v59edc4a3h7f9ce6c6ecd13058@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100158>

Marc Fargas venit, vidit, dixit 05.11.2008 11:04:
> Hi all,
> 
> First of all, please CC responses to me as I'm not subscribed to this list ;)
> 
> On the subject, I use git-svn to for most of my stuff and also to
> "interact" with some SVN projects out there, there's one that is
> driving me mad.
> 
> The Django project has a (somehow) rare SVN structure that I almost
> managet to make git-svn understand, but a recent "rarity" to the
> structure broke it again and I haven't succeeded in making git-svn
> understand it, so I'm trying to get some guidance on how to make
> git-svn understand the structure.
> 
> Right know the Django SVN repo is like that:
> browse: http://code.djangoproject.com/browser/django
> svn url:  http://code.djangoproject.com/svn/django
> 
> trunk/
> tags/notable_moments/
> tags/releases/
> branches/*
> branches/features/
> branches/releases/
> 
> Until now, the last two didn't exist and git-svn was working nicely,
> but now "features" and "releases" were created, and git-svn is taking
> them as if they were branches, while they arent (branches are in
> subdirectories of those two).
> 
> My git repo was done like that until now:
> 
>     git svn init --prefix svn/
> http://code.djangoproject.com/svn/django -T trunk -b branches -t
> 'tags/*/*'
>     git svn fetch
> 
> With that, git-svn understood that tags were in the subdirectories of
> tags/{notable_moments,releases}/ but I can't do that with the branches
> as there are branches also in the top branches/ directory.
> 
> I do not really care about those branches on the top directory as
> those are old, so I really only need git-svn to understand the
> {features,releases}/* thing. So:
> 
> How can I do something like "-b branches/{features,releases}/*" making
> git-svn ignore the other top-level branches? Or, can I make it
> understand both, the top-level ones and the ones inside those two
> subdirectories?

You can use "-T trunk -t 'tags/*/*'" and then set up the branches config
by hand:

git config svn-remote.svn.branches
'django/branches/features/*:refs/remotes/svn/features/*'

git config --add svn-remote.svn.branches
'django/branches/releases/*:refs/remotes/svn/releases/*'

In fact, you should be able to use your previous branches config when
fetching up to r9093, then switch to the config I suggested, and the
fetch from r9094.

Cheers,
Michael
