From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v5 3/3] push: teach --recurse-submodules the on-demand
	option
Date: Wed, 28 Mar 2012 17:30:11 +0200
Message-ID: <20120328153010.GA46920@book.hvoigt.net>
References: <20120213092541.GA15585@t1405.greatnet.de> <20120213093008.GD15585@t1405.greatnet.de> <4F70DE29.6050808@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <jens.lehmann@web.de>
To: Zbigniew J??drzejewski-Szmek <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed Mar 28 17:30:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCupI-0006dC-LF
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 17:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096Ab2C1PaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 11:30:14 -0400
Received: from darksea.de ([83.133.111.250]:47001 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756518Ab2C1PaN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 11:30:13 -0400
Received: (qmail 29704 invoked from network); 28 Mar 2012 17:30:11 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 28 Mar 2012 17:30:11 +0200
Content-Disposition: inline
In-Reply-To: <4F70DE29.6050808@in.waw.pl>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194130>

On Mon, Mar 26, 2012 at 11:22:49PM +0200, Zbigniew J??drzejewski-Szmek wrote:
> On 02/13/2012 10:30 AM, Heiko Voigt wrote:
>> When using this option git will search for all submodules that
>> have changed in the revisions to be send. It will then try to
>> push the currently checked out branch of each submodule.
>>
>> This helps when a user has finished working on a change which
>> involves submodules and just wants to push everything in one go.
>
>> ---recurse-submodules=check::
>> -	Check whether all submodule commits used by the revisions to be
>> -	pushed are available on a remote tracking branch. Otherwise the
>> -	push will be aborted and the command will exit with non-zero status.
>> +--recurse-submodules=<check|on-demand>::
>> +	Make sure all submodule commits used by the revisions to be
>> +	pushed are available on a remote tracking branch. If check is
>> +	used it will be checked that all submodule commits that changed
>> +	in the revisions to be pushed are available on a remote.
>> +	Otherwise the push will be aborted and exit with non-zero
>> +	status. If on-demand is used all submodules that changed in the
>> +	revisions to be pushed will be pushed. If on-demand was not able
>> +	to push all necessary revisions it will also be aborted and exit
>> +	with non-zero status.
> Hi,
> this desciption seems awkward. Not sure how to improve it, but:
> - the argument 'check' is changed to '<check|on-demand>', i.e. brackets  
> are added. This changes the meaning, because brackets are used around a  
> name for a value provided by the user. So here brackets shouldn't be  
> used, because 'check' and 'on-demand' are literals.
> - s/if check is used it will be checked/if check is used git will verify  
> that/
> - s/a remote/the remote/
> - s/Otherwise the push/If any commits are missing the push/ (because  
> 'Otherwise' could refer to 'If check is used'.)

I agree on all of these except

	s/a remote/the remote/

which I changed to

	s/a remote/at least one remote of the submodule/

since it really just checks whether the commits are on some remote. It
it not strictly the one defined in .gitmodules. Doing it this way allows
to work with forks without the need to change .gitmodules.

Cheers Heiko
