From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] t7507-*.sh: Fix test #8 (could not run '"$FAKE_EDITOR"')
Date: Wed, 20 Nov 2013 19:35:01 +0000
Message-ID: <528D0EE5.4060909@ramsay1.demon.co.uk>
References: <528CE716.8060307@ramsay1.demon.co.uk> <xmqqsiur6l9k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens.Lehmann@web.de, GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 20 20:35:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjDYO-0000AS-9l
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 20:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965Ab3KTTfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 14:35:07 -0500
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:51286 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754953Ab3KTTfG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 14:35:06 -0500
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id DDA21AC4083;
	Wed, 20 Nov 2013 19:35:04 +0000 (GMT)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 9972EAC407A;
	Wed, 20 Nov 2013 19:35:03 +0000 (GMT)
Received: from [192.168.254.8] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta004.tch.inty.net (Postfix) with ESMTP;
	Wed, 20 Nov 2013 19:35:03 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqsiur6l9k.fsf@gitster.dls.corp.google.com>
X-MDF-HostID: 17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238093>

On 20/11/13 17:22, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> ---
>>
>> Hi Jens,
>>
>> commit 61b6a633 ("commit -v: strip diffs and submodule shortlogs
>> from the commit message", 19-11-2013) in 'pu' fails the new test
>> it added to t7507.
>>
>> I didn't spend too long looking at the problem, so take this patch
>> as nothing more than a quick suggestion for a possible solution! :-P
>> [The err file contained something like: "There was a problem with the
>> editor '"$FAKE_EDITOR"'"].
>>
>> Having said that, this fixes it for me ...
> 
> Well spotted.  test_must_fail being a shell function, not a command,
> we shouldn't have used the "VAR=val cmd" one-shot environment
> assignment for portability.
> 
> Even though this happens to be the last test in the script, using
> test_set_editor to permanently affect the choice of editor for tests
> that follow is not generally a good idea.  It would be safer to do
> this, I would have to say:
> 
> 		git commit -a -m "submodule commit"
> 	) &&
>         (
> 		GIT_EDITOR=cat &&
>                 export GIT_EDITOR &&
>                 test_must_fail git commit -a -v 2>err
> 	) &&
>         test_i18ngrep "Aborting ..."

Yes, this works great (and I very nearly wrote exactly this, but since
the test was using test_set_editor anyway ...) :-D

Thanks.

ATB,
Ramsay Jones
