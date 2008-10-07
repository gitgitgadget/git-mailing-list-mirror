From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] error out if path is invalid
Date: Tue, 07 Oct 2008 08:03:46 +0200
Message-ID: <48EAFBC2.7020305@viscovery.net>
References: <20081005004036.GO21650@dpotapov.dyndns.org> <1223172881-4948-1-git-send-email-dpotapov@gmail.com> <1223172881-4948-2-git-send-email-dpotapov@gmail.com> <48E9B7FE.2000503@viscovery.net> <20081007002221.GS21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 08:05:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn5gp-0006WK-Ms
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 08:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbYJGGDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 02:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbYJGGDt
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 02:03:49 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:17386 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbYJGGDt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 02:03:49 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kn5fe-0005d0-TH; Tue, 07 Oct 2008 08:03:47 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A71F754D; Tue,  7 Oct 2008 08:03:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20081007002221.GS21650@dpotapov.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97668>

Dmitry Potapov schrieb:
> On Mon, Oct 06, 2008 at 09:02:22AM +0200, Johannes Sixt wrote:
>> Dmitry Potapov schrieb:
>>>  	if (!verify_path(path))
>>> -		return -1;
>>> +		return error("Invalid path '%s'", path);
>> Look at this change. Didn't the code error out before, too?
> 
> It is certainly did not here. As to its caller, it depends. In fact,
> there are two chunks like that in my patch, so I am not sure to which
> one you refer here. If we speak about add_cacheinfo() then though the
> function did not error out, its caller died with one of the following
> messages:
>   git update-index: unable to update some-file-name
> or
>   git update-index: --cacheinfo cannot add some-file-name

Look at the original patch. You did not change the behavior except to
write more error messages. Maybe I misunderstand the words "to error out".
I understand them as "to detect an error and return early", but not "write
an error message".

> However, if we speak about add_index_entry_with_check then the caller
> will not produce any error. The git would exit successfully (it still
> does) and there was no error message as if everything was fine.
> 
> Perhaps, the exit code should be corrected too, but if the git just dies
> when add_index_entry() fails it may cause that having one invalid path
> will prevent to check out other files, which does not seem to be the
> right thing to do.
> 
> As to correction to correction to make_cache_entry then after my
> previous patch, it started to error out:
> 
>   make_cache_entry failed for path 'some-file-name'
> 
> before that it silently segfaulted.
> 
>> Same in the
>> other cases. Hence, your patch subject does not describe the patch.
> 
> Should I include the above explanation in the commit message or do you
> have any objection to having the above error message in cases where the
> caller already produce some message when it dies?

I don't object the change, only its (missing or IMHO incorrect)
justification. I don't think that the above text would be the correct
description because as far as I can see the only change you made was to
add error messages.

-- Hannes
