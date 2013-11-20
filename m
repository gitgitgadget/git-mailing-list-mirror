From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] t7507-*.sh: Fix test #8 (could not run '"$FAKE_EDITOR"')
Date: Wed, 20 Nov 2013 22:32:07 +0100
Message-ID: <528D2A57.4090404@web.de>
References: <528CE716.8060307@ramsay1.demon.co.uk> <xmqqsiur6l9k.fsf@gitster.dls.corp.google.com> <528D0EE5.4060909@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 20 22:32:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjFNk-0001w8-BD
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 22:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503Ab3KTVcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 16:32:14 -0500
Received: from mout.web.de ([212.227.15.4]:62641 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755428Ab3KTVcN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 16:32:13 -0500
Received: from [192.168.178.41] ([91.3.183.35]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0MPpD8-1VoDBh2PiM-0053fc for <git@vger.kernel.org>; Wed,
 20 Nov 2013 22:32:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <528D0EE5.4060909@ramsay1.demon.co.uk>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:p0xuwjxkbQnndkvgHM/QI6GyxIXm2VZwiJ45fAvF4d9NIkGCfNE
 zvtLZWI4NVcZAtModMzBINk/2dHCqwXYJEMQ44c1yguA4tOGx0ZXru0ACNl00Ns7N/nqKxL
 rj/jKooNCnDO35HxdcgzJ8fD1+/GvlP8hZnFHjAbVSIezffYk8wr/9FDQYRkpglazyCguVv
 mwhCWY/qEt9L36DfGuaFg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238096>

Am 20.11.2013 20:35, schrieb Ramsay Jones:
> On 20/11/13 17:22, Junio C Hamano wrote:
>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>>
>>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>>> ---
>>>
>>> Hi Jens,
>>>
>>> commit 61b6a633 ("commit -v: strip diffs and submodule shortlogs
>>> from the commit message", 19-11-2013) in 'pu' fails the new test
>>> it added to t7507.
>>>
>>> I didn't spend too long looking at the problem, so take this patch
>>> as nothing more than a quick suggestion for a possible solution! :-P
>>> [The err file contained something like: "There was a problem with the
>>> editor '"$FAKE_EDITOR"'"].
>>>
>>> Having said that, this fixes it for me ...
>>
>> Well spotted.  test_must_fail being a shell function, not a command,
>> we shouldn't have used the "VAR=val cmd" one-shot environment
>> assignment for portability.
>>
>> Even though this happens to be the last test in the script, using
>> test_set_editor to permanently affect the choice of editor for tests
>> that follow is not generally a good idea.  It would be safer to do
>> this, I would have to say:
>>
>> 		git commit -a -m "submodule commit"
>> 	) &&
>>         (
>> 		GIT_EDITOR=cat &&
>>                 export GIT_EDITOR &&
>>                 test_must_fail git commit -a -v 2>err
>> 	) &&
>>         test_i18ngrep "Aborting ..."
> 
> Yes, this works great (and I very nearly wrote exactly this, but since
> the test was using test_set_editor anyway ...) :-D

Thanks all, will use that in the next iteration.
