From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to create tags outside of refs/tags?
Date: Wed, 23 Feb 2011 13:42:45 +0100
Message-ID: <4D6500C5.7020803@drmicha.warpmail.net>
References: <AANLkTimxAhMfPsqEJVyteuTzXLr+QnhcxpJLgaE=y12_@mail.gmail.com> <AANLkTi=7yUh9J9S5LdpNY0SwCv008ih2LEd3KNvy46sL@mail.gmail.com> <20110222080305.GA11177@sigill.intra.peff.net> <7vvd0cebi6.fsf@alter.siamese.dyndns.org> <20110222081458.GA11825@sigill.intra.peff.net> <m3wrks756a.fsf@localhost.localdomain> <20110222152723.GA23353@sigill.intra.peff.net> <AANLkTinTj7BehKYc15jbQzMq+q=2CfLvzTkGSJ-Ps-FH@mail.gmail.com> <7v7hcrewyz.fsf@alter.siamese.dyndns.org> <AANLkTiki9W_mJKLON+punKJLDWx5rmQdZ3bS16zadYFj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>, git <git@vger.kernel.org>
To: Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 13:46:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsE6b-0005nq-Gf
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 13:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164Ab1BWMqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 07:46:03 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41407 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753546Ab1BWMqB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 07:46:01 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1204020A65;
	Wed, 23 Feb 2011 07:46:01 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 23 Feb 2011 07:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=bB5YbLBgAl4GUhd7xKQAXEMmO6s=; b=AMk9Cd3N42/QQTMKumGYeQJr8rj9P9SDBiFj1MG+l6p3f0tpV97XRHhHM5GJenqeg36H1540K9pZCZFPpW4cDfaTxZ0RfRWO35uHEWB7ZVmJdMt1nwHO6LU8dQ1ca0JSs2gGW1pFka0FAD9VJL5Uj7lfE/xzfzTmIEMWylIbfM8=
X-Sasl-enc: 7iE1d/0V1xku2siSzSz8X38SRKDfobTEdm69YGKvvzHJ 1298465160
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4369144036C;
	Wed, 23 Feb 2011 07:46:00 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTiki9W_mJKLON+punKJLDWx5rmQdZ3bS16zadYFj@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167691>

Christian Halstrick venit, vidit, dixit 22.02.2011 23:08:
> Hi,
> 
>> How about taking advantage of the fact that you do not have to treat tag
>> namespace as a global thing?  For the "release tool" to "get a commit ID"
>> and do something useful, the "release tool" must be working on a git
>> repository, and hopefully that repository is something other than the ones
>> developers directly play with (by checking out random branches in its
>> working tree and compiling, etc.).
> 
> These assumptions are all correct. The "release tool" works on his clone
> of a central repo. The release tool may even modify the content (e.g. increasing
> release numbers in project metadata files) and create new git commits.
> In the end it wants to create tags/refs locally und push these tags back
> so that in the central repo the commits are not gc'ed.
> 
> Something like:
> 
> cd <releaseRepo>
> git fetch origin
> git checkout <commitIdToRelease>
> edit pom.xml; git add pom.xml
> git commit -m "release ..."
> git tag <releaseName>
> git push origin 'refs/tags/<releaseName>:refs/releases/<releaseName>'
> 
> should do the job, or?

Yep. Also, if you do

git tag release/<releasename>

then a simple push refspec 'refs/tags/release/*:refs/releases/*' in your
config does the job. (Assuming you don't have any other tags in release/.)

Michael
