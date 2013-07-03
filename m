From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCHv3] submodule update: allow custom update command
Date: Wed, 03 Jul 2013 08:55:36 +0200
Message-ID: <51D3CAE8.50509@web.de>
References: <7vehbii6un.fsf@alter.siamese.dyndns.org> <1372759974-19765-1-git-send-email-judge.packham@gmail.com> <51D3064C.80901@web.de> <CAFOYHZC1xMt2eqaNm0vtLVJ3X2TNjRxa3sEjBPmHVeHrQmSc4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>, iveqy@iveqy.com,
	stefan.naewe@atlas-elektronik.com, hvoigt@hvoigt.net,
	Junio C Hamano <gitster@pobox.com>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 08:55:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuGys-0003lP-Gg
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 08:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075Ab3GCGzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 02:55:54 -0400
Received: from mout.web.de ([212.227.17.11]:49746 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753938Ab3GCGzy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 02:55:54 -0400
Received: from [192.168.178.41] ([79.193.89.81]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0M4HmV-1U2RXE3t47-00rq2Z; Wed, 03 Jul 2013 08:55:41
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <CAFOYHZC1xMt2eqaNm0vtLVJ3X2TNjRxa3sEjBPmHVeHrQmSc4A@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V03:K0:3znbzhAfOqdtSBpRM8TNg0SrIfWig1jlwoaynbkBlgG7JsNDyJN
 2VWHkAKX6VM+0gz90ysuamv/BJ//ogB+td0tMqilEQZ5c06TjUI7yRAm64bd6RaqeBf/6A+
 LbOMzySO5smoCnpUM4YPC3F+y3hRNi1eCGEX30QVjo6JELKdamfE/pRIaP5qye2B14/LEew
 yUD+KjXNmz+rvgVk3EQnQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229455>

Am 03.07.2013 01:26, schrieb Chris Packham:
> On Wed, Jul 3, 2013 at 4:56 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 02.07.2013 12:12, schrieb Chris Packham:
>>> --- a/Documentation/git-submodule.txt
>>> +++ b/Documentation/git-submodule.txt
>>> @@ -159,7 +159,9 @@ update::
>>>       This will make the submodules HEAD be detached unless `--rebase` or
>>>       `--merge` is specified or the key `submodule.$name.update` is set to
>>>       `rebase`, `merge` or `none`. `none` can be overridden by specifying
>>> -     `--checkout`.
>>> +     `--checkout`. Setting the key `submodule.$name.update` to `!command`
>>> +     will cause `command` to be run. `command` can be any arbitrary shell
>>> +     command that takes a single argument, namely the sha1 to update to.
>>>  +
>>>  If the submodule is not yet initialized, and you just want to use the
>>>  setting as stored in .gitmodules, you can automatically initialize the

The above hunk is perfectly fine ...

>>> @@ -172,6 +174,7 @@ If `--force` is specified, the submodule will be checked out (using
>>>  `git checkout --force` if appropriate), even if the commit specified in the
>>>  index of the containing repository already matches the commit checked out in
>>>  the submodule.
>>> ++
>>>
>>>  summary::
>>>       Show commit summary between the given commit (defaults to HEAD) and

... but I don't understand the extra '+'-line added here.

>> I'm not sure this change is necessary ;-)
> 
> Not necessary because it should be documented in
> Documentation/config.txt instead, or not necessary because it's a
> niche feature that doesn't need to be advertised?

Sorry for the confusion, I should have been more specific here.

>>> diff --git a/git-submodule.sh b/git-submodule.sh
>>> index eb58c8e..a7c2375 100755
>>> --- a/git-submodule.sh
>>> +++ b/git-submodule.sh
>>> @@ -799,6 +799,12 @@ Maybe you want to use 'update --init'?")"
>>>                               say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': merged in '\$sha1'")"
>>>                               must_die_on_failure=yes
>>>                               ;;
>>> +                     !*)
>>> +                             command="${update_module#!}"
>>> +                             die_msg="$(eval_gettext "Unable to exec '\$command \$sha1' in submodule path '\$prefix\$sm_path'")"
>>
>> Hmm, "Unable to exec" does not quite cut it, as the command was executed
>> but returned an error, right? Maybe something like this:
>>
>>    Execution of '\$command \$sha1' failed in submodule  path '\$prefix\$sm_path'
>>
> 
> Will include in v4 once I write some tests.

Thanks.
