From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: gitattributes - clean filter invoked on pull?
Date: Mon, 11 Apr 2011 11:50:09 +0200
Message-ID: <4DA2CED1.6070107@drmicha.warpmail.net>
References: <20110411084229.GW5146@genesis.frugalware.org> <20110411091919.GE28959@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	timar74@gmail.com
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 11:50:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9DlE-0003XF-P7
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 11:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488Ab1DKJuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 05:50:12 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:45263 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755312Ab1DKJuL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Apr 2011 05:50:11 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E89392091B;
	Mon, 11 Apr 2011 05:50:10 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 11 Apr 2011 05:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=G5IzC+PyLRv1ZJQEqKtBcPJLXaI=; b=YKUNW2viYKvodrs1HZaumikx0bTYof+mQxECYN3Jv7A6LHVeuGqRrg8s3D+wIMGEclFRDhHSRbjwmQQt7uGiqeZbREWsU3gYPM4tKGJBmDSUO77C1X/3ZBabXPFL3N4nXRCkjdpXxPNnVB4EuoRMbJiyc2PuEvvNLU+2X68GjpQ=
X-Sasl-enc: uwenD0X65lRg8FpmDY/xw7h/28XZcfPnGwxNCANMI+86 1302515410
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3156444023B;
	Mon, 11 Apr 2011 05:50:10 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110411091919.GE28959@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171321>

Ramkumar Ramachandra venit, vidit, dixit 11.04.2011 11:19:
> Hi Miklos,
> 
> Miklos Vajna writes:
>> Background: We at LibreOffice are trying to use the 'filter'
>> gitattributes feature to clean up line wrappings in po files.
>>
>> The problem is that it seems the clean filter - which is supposed to be
>> invoked only in case a new blob is created - is invoked even on
>> clone/pull, and other developers are claiming that it slows down their
>> workflow.
>>
>> Is this a bug? I don't exactly understand why this would be necessary.
> 
> From config.txt:
> - 'clean' is "The command which is used to convert the content of a
> worktree file to a blob upon checkin".
> - 'smudge' is "The command which is used to convert the content of a
> blob object to a worktree file upon checkout."
> 
> According to the documentation, 'smudge' is *supposed* to be invoked
> on a clone/ pull, since it involves a checkout.  I don't see how you
> can avoid running these filters on every checkin/ checkout unless you
> cache the result somewhere.

Exactly that is why it's surprising that the clean filter is invoked on
pull - clean is about checking in, pull only checks out.

If you run your script with GIT_TRACE=1 you see that the two last clean
invocations come from merge and gc. They go away when you do a fetch only.

Note that with clean/smudge, a check "worktree == repo" requires a
conversion of "worktree" to what would be checked in, and that uses
"clean". That's why it's invoked not only for "commit".

But maybe there is a better solution for your actual use case? Do you
want to ignore line wrap or normalise it?

Michael
