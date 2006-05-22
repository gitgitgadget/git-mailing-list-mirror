From: Jim Meyering <jim@meyering.net>
Subject: Re: don't accept bogus N in `HEAD~N'
Date: Mon, 22 May 2006 09:38:40 +0200
Message-ID: <87psi6h5kv.fsf@rho.meyering.net>
References: <87mzdcjqey.fsf@rho.meyering.net>
	<7v3bf3jl15.fsf@assigned-by-dhcp.cox.net>
	<87d5e7hxhl.fsf_-_@rho.meyering.net> <e4qmsn$3mv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 09:39:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi50A-0005YW-TY
	for gcvg-git@gmane.org; Mon, 22 May 2006 09:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbWEVHim (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 03:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbWEVHim
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 03:38:42 -0400
Received: from mx.meyering.net ([82.230.74.64]:48003 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S932592AbWEVHim (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 03:38:42 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 760B98135; Mon, 22 May 2006 09:38:40 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e4qmsn$3mv$1@sea.gmane.org> (Jakub Narebski's message of "Sun,
	21 May 2006 23:42:47 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20485>

Jakub Narebski <jnareb@gmail.com> wrote:

> Jim Meyering wrote:
>
>> In a very shallow audit, I spotted code where overflow was not detected.
>> But it's hardly critical.
>>
>> Currently,
>>
>>   git-diff HEAD HEAD
>>
>> is equivalent to this
>>
>>   git-diff HEAD HEAD~18446744073709551616   # aka 2^64
>>
>> Exercising git-rev-parse directly, currently I get this:
>>
>>   $ git-rev-parse --no-flags --sq HEAD~18446744073709551616
>>   '639ca5497279607665847f2e3a11064441a8f2a6'
>>
>> It'd be better to produce a diagnostic and fail:
>>
>>   $ ./git-rev-parse --no-flags --sq -- HEAD~18446744073709551616 /dev/null
>>   fatal: ambiguous argument 'HEAD~18446744073709551616': unknown revision or filename
>
> Wouldn't it remove ability to say "to the root commit"?
> One can do it now I guess exactly by specyfying overly large N.
> Although there should probably be some limit... or not.

Do people really use HEAD~<VERY_LARGE_INTEGER> to refer to the root?
Any who do that will find it surprising that HEAD~18446744073709551616
is currently interpreted just like `HEAD~0'.
And HEAD~18446744073709551617 just like HEAD~1, etc.
