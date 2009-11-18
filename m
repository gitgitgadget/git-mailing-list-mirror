From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn of both trunk and tags while having no access to the
 'parent' of those
Date: Wed, 18 Nov 2009 16:07:01 +0100
Message-ID: <4B040D95.9040901@drmicha.warpmail.net>
References: <20091117025945.GE17964@onerussian.com> <4B03B7D3.8050905@drmicha.warpmail.net> <20091118133205.GB17964@onerussian.com> <4B03FD29.3090001@drmicha.warpmail.net> <20091118142332.GC17964@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Yaroslav Halchenko <debian@onerussian.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 16:08:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAm8g-0004Aj-SI
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 16:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757403AbZKRPH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 10:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757273AbZKRPH5
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 10:07:57 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:37275 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754147AbZKRPH4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2009 10:07:56 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 518ACC0ED7;
	Wed, 18 Nov 2009 10:08:02 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 18 Nov 2009 10:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=KCQeemjEdkupiWKzRZojLH3+BrE=; b=udhrUVoLZEWUf7vAzaXPGS1AV0cVwLzJ4+/e+pVN9i2LtBkJewUZbbVh4U2C0JeleFHiaUAEXnP/vrkpHQL7t4L60bUxd2wMim3Kqds/o+E5h5UdugPqzw0SLwP0Fj8x9FAhFEfUYWfHnNMeD8ANTuOlMH0e0rW3nYSVupj7UD4=
X-Sasl-enc: VFOz40khXhPRqwz+s5Me6H/foFT1X3ed8iWAW6MeL0Qo 1258556881
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8811AAB5C;
	Wed, 18 Nov 2009 10:08:01 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091116 Lightning/1.0pre Shredder/3.0.1pre
In-Reply-To: <20091118142332.GC17964@onerussian.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133182>

Yaroslav Halchenko venit, vidit, dixit 18.11.2009 15:23:
> 
> On Wed, 18 Nov 2009, Michael J Gruber wrote:
>>> git svn clone --no-minimize-url --prefix=upstream-svn/ -T trunk -t releases  http://domain.com/svnrepo/trunk svnrepo.gitsvn
>> Is the trunk really at svnrepo/trunk/trunk?
> nope... it is just svnrepo/trunk but if I set url to point to parent --
> git svn seeks authentication right away
> 
>> I would try both
>> git svn clone --no-minimize-url --prefix=upstream-svn/ -T trunk -t
>> releases  http://domain.com/svnrepo/ svnrepo.gitsvn
> 
> asks for authentication since there is no public access to
> http://domain.com/svnrepo/
> 
>> and also the seemingly equivalent
> 
>> git svn clone --no-minimize-url --prefix=upstream-svn/ -T
>> http://domain.com/svnrepo/trunk -t http://domain.com/svnrepo/releases
>> svnrepo.gitsvn
> seems to not work since it wants url as a parameter 
> 
> Bad URL passed to RA layer: Illegal repository URL svnrepo.gitsvn  at /usr/lib/git-core/git-svn line 940
> 
>> Also, I assume you can svn list http://domain.com/svnrepo/trunk and
>> http://domain.com/svnrepo/releases ;)
> yeap -- I can list both of those but not their parent.
> 
> 

OK, so the way it's implemented --no-minimize-url might be half as
useful as it could be. One last try (before asking Eric...) would be

git svn clone --no-minimize-url --prefix=upstream-svn/ -T
http://domain.com/svnrepo/trunk -t http://domain.com/svnrepo/releases
http://domain.com/svnrepo/trunk svnrepo.gitsvn

because that involves accessible URLs only and trunk and branch URLs are
absolute.

[Meanwhile I git the actual URL PMed by Yaroslov.]

So, what happens with the above is that git-svn tries to set the URL
config again from the URL part of an absolute tags argument. I don't
know how absolute URLs (which are documented) for tags etc. could
possibly work if git-svn tries to do that. Eric?

I tried also with two svn sections to circumvent this:

[svn-remote "svn"]
        url = http://domain.com:/project/trunk
        fetch = :refs/remotes/trunk
[svn-remote "svnr"]
        url = http://domain.com:/project/releases
        tags = /*:refs/remotes/tags/*

Fetching -Rsvn works fine, but fetching -Rsvnr gives the same
authentication problems. And fetch does not accept --no-minimize-url as
an option. OTOH: If the option is not used it seems to me (from the
source) that not minimizing is the default, which leaves me really
stomped. Eric?? ;)

Michael
