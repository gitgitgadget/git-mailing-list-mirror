From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-svn: mangle refnames forbidden in git
Date: Thu, 08 Jul 2010 20:53:41 +0200
Message-ID: <4C361EB5.7010704@drmicha.warpmail.net>
References: <4BE3249B.7050100@theblacksun.eu> <20100708084356.GA29856@burratino> <20100708085814.GC10779@dcvr.yhbt.net> <20100708130315.GA1529@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Torsten Schmutzler <git-ts@theblacksun.eu>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 20:53:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWwE6-0001SS-VH
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 20:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758257Ab0GHSxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 14:53:33 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:33521 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756846Ab0GHSxd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jul 2010 14:53:33 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4F5D714C41F;
	Thu,  8 Jul 2010 14:53:32 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 08 Jul 2010 14:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=yHTm4f6BGymdoL9lsfiahOXTdbM=; b=R2WlBR7gWeDfiQMTzhJppfGQgF0z5dfiYJ3IeJJwCrIjLg54h6JUueyXklu6+4EOncy0jJZ1HU1Sy/jLCT0wnGSFv6HTCki5hjFc9EIp7s1zVlHVbBUk9CYPYnYCqR5UNe4CxH/iTmA2n8lcuLIguWMqKl6yQ7YAbFsVqKGYhRU=
X-Sasl-enc: HHHARoZInkbmIm3S0JBB9dsB7LqfXazcbViVBYDt2Kz8 1278615211
Received: from localhost.localdomain (p54859B9B.dip0.t-ipconnect.de [84.133.155.155])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 926AD13C48;
	Thu,  8 Jul 2010 14:53:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100702 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <20100708130315.GA1529@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150592>

Jonathan Nieder venit, vidit, dixit 08.07.2010 15:03:
> Eric Wong wrote:
> 
>> I can't reproduce it with 1.5.1 here, does URI-escaping the "@{0}"
>> to "%40%7B0%7D" work?
> 
> Yes.
> 
>  ...
>  $ svn cp -m reflog file:///tmp/foo/source 'file:///tmp/foo/not-a%40%7B0%7Dreflog'
>  Committed revision 2.
>  $ (cd wc && svn update)
>  A    not-a@{0}reflog
>  Updated to revision 2.
> 
> Does that work with svn 1.5.x?

It turns out this is not so much about general escaping but about the
treatment of so called svn PEG revisions (not so unsimilar to our @{}).

svn r954995 integrated r952973 (which implemented the eating of PEG
revisions) into the 1.6.x branch. It's considered a bug fix.

This "fix" is in 1.6.12 but not in 1.6.11.

Now, git-svn adjusts its behaviour to the svn version for things like
info. But I don't know if it's worth doing in this case - maybe we
should just change the test not to use the PEG revisions identifier "@".

Michael
