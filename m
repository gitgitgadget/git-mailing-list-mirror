From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git ksshaskpass to play nice with https and kwallet
Date: Thu, 06 Oct 2011 08:33:57 +0200
Message-ID: <4E8D4BD5.2090202@drmicha.warpmail.net>
References: <4E8ADDCF.6090406@drmicha.warpmail.net> <20111004105008.GA11789@sigill.intra.peff.net> <4E8AEDBD.4070404@drmicha.warpmail.net> <20111004113713.GA19171@sigill.intra.peff.net> <4E8AF812.5090906@drmicha.warpmail.net> <20111004124344.GA30162@sigill.intra.peff.net> <4E8B5553.2080706@drmicha.warpmail.net> <20111005175536.GB22962@sigill.intra.peff.net> <20111005180125.GC22962@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 06 08:34:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBhX1-0002SB-KZ
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 08:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935705Ab1JFGeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 02:34:06 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:58447 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935243Ab1JFGeF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 02:34:05 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0023E28F1A;
	Thu,  6 Oct 2011 02:34:03 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 06 Oct 2011 02:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=LwRDawF5Z9BOrwCbNlIEB2
	9ZLjw=; b=rfCVIx0YeU3BpvpjQGXkI6D4CRSmGK6NMmVUQyw3okVjvQV4QWHJVB
	N39gxM0n0Lw0ceg5SUVJGl6GyAoUgavKmf8lE2mI18q9zzBQQ179JnmIwKEsBcuY
	imp1+TdrdUWC14d1VNmUd75SkqZrdmdoIBcWA2OQ+BZ+bJz1THffk=
X-Sasl-enc: VhblpZjFLgYze8SVTgYgzOlYoFikeUUetmj/vhM5v2Zm 1317882843
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 72DBB4001C6;
	Thu,  6 Oct 2011 02:34:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <20111005180125.GC22962@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182929>

Jeff King venit, vidit, dixit 05.10.2011 20:01:
> On Wed, Oct 05, 2011 at 01:55:36PM -0400, Jeff King wrote:
> 
>> On Tue, Oct 04, 2011 at 08:49:55PM +0200, Michael J Gruber wrote:
>>
>>> We seem to mean something different:
>>>
>>> git config --get remote.bitbucket.pushurl
>>> https://grubix@bitbucket.org/grubix/git.git
>>> SSH_ASKPASS= git push -n bitbucket
>>> Username for 'bitbucket.org':
>>>
>>> I mean that git should not need to ask for the username here.
>>
>> No, we are in agreement about the intended behavior. I think you are
>> seeing a bug. What version of git produced it?
>>
>> With my http-auth series, I get:
>>
>>   $ git push https://github.com/peff/git.git
>>   Username for 'github.com':
>>
>>   $ git push https://peff@github.com/peff/git.git
>>   Password for 'github.com':
>>
>> Using v1.7.7 produces similar results.
> 
> Hrm. I do get this, with the same version of git:
> 
>   $ git config remote.foo.url https://github.com/peff/git.git
>   $ git push foo
>   Username for 'github.com':
> 
>   $ git config remote.foo.url https://peff@github.com/peff/git.git
>   $ git push foo
>   Password for 'github.com':
> 
> So far so good. Now how about this:
> 
>   $ git config remote.foo.url https://github.com/peff/git.git
>   $ git config remote.foo.pushurl https://peff@github.com/peff/git.git
>   $ git push foo
>   Username for 'github.com':
> 
> So I think the problem is with pushurl, not with the auth code. Oddly,
> though, running GIT_TRACE reveals:

Yep, I have a pushurl in config.

> 
>   $ GIT_TRACE=1 git push foo
>   trace: built-in: git 'push' 'foo'
>   trace: run_command: 'git-remote-https' 'foo' 'https://peff@github.com/peff/git.git'
> 
> which is the right URL. So it's almost as if we are throwing away the
> passed URL in favor of the configuration, and then looking up the
> configuration wrong. I'm about to go get on a plane, so I don't have
> more time to look at it now, but I suspect it's something simple and
> stupid.

Thanks for confirming what it should be like. I never expected pushurl
and url to behave differently (I had used GIT_TRACE myself).

Good flight :)

Michael
