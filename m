From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: submodule: if $command was not matched, don't parse other args
Date: Sun, 23 Sep 2012 19:36:27 +0200
Message-ID: <505F489B.1000309@web.de>
References: <CALkWK0npySdS7FDt=6VKdtoNS2gqQH5WaTQ4H6TEmXdP9fuF=g@mail.gmail.com> <7v8vc13ilc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 19:36:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFq6p-000334-0z
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 19:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288Ab2IWRgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2012 13:36:38 -0400
Received: from mout.web.de ([212.227.15.4]:53093 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754119Ab2IWRgi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2012 13:36:38 -0400
Received: from [192.168.178.41] ([91.3.183.9]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0M73Jx-1TRkrG45SP-00wPBh; Sun, 23 Sep 2012 19:36:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7v8vc13ilc.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:99b1mHbMbMU8fXfLnKLIYdXipQp7xFzAHtRSaur7Vsz
 2PKG/vWf9hnyceHYqm+GC6IvOWZPiHYfX8QyxbZNn0O0L1nho0
 SYryFmReO42S+vPtKI5ELntB6AECJKRTT6zM3eV9b8HAVPKmfp
 bJOvsRL51Zqi0JNqTxr0ZPbgyshNs4ECeZzOHrtsp0hauiQW4a
 tXE0vm2poELwm5hmjXp6g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206248>

Am 22.09.2012 22:31, schrieb Junio C Hamano:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index a7e933e..dfec45d 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -1108,7 +1108,15 @@ do
>>  done
>>
>>  # No command word defaults to "status"
>> -test -n "$command" || command=status
>> +if test -z "$command"
>> +then
>> +    if test $# = 0
>> +    then
>> +	command=status
>> +    else
>> +	usage
>> +    fi
>> +fi
> 
> I personally feel "no command means this default" is a mistake for
> "git submodule", even if there is no pathspec or other arguments,
> but I am not a heavy user of submodules, so others should discuss
> this.

The commit message of 97a5d8cce9 (git-submodule: re-enable 'status'
as the default subcommand) back from 2007 indicates that Lars did
back then think that "status" is a sane default. I agree with Junio
that this is not optimal, but I'd rather tend to not change that
behavior which has been there from day one for backward compatibility
reasons. But if many others see that as an improvement too I won't
object against changing it the way Ramkumar proposes (but he'd have
to change the documentation too ;-).

Since diff and status learned to display submodule status information
(except for a submodule being uninitialized) I almost never use this
option myself, so I'd be interested to hear what submodule users who
do use "git submodule [status]" frequently think.
