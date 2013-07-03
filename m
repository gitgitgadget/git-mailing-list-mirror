From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC/PATCHv3] submodule update: allow custom update command
Date: Wed, 03 Jul 2013 19:54:53 +1200
Message-ID: <51D3D8CD.5090804@gmail.com>
References: <7vehbii6un.fsf@alter.siamese.dyndns.org> <1372759974-19765-1-git-send-email-judge.packham@gmail.com> <51D3064C.80901@web.de> <CAFOYHZC1xMt2eqaNm0vtLVJ3X2TNjRxa3sEjBPmHVeHrQmSc4A@mail.gmail.com> <51D3CAE8.50509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>, iveqy@iveqy.com,
	stefan.naewe@atlas-elektronik.com, hvoigt@hvoigt.net,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 03 09:53:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuHsz-0001vt-Fp
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 09:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960Ab3GCHxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 03:53:53 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:62097 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460Ab3GCHxx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 03:53:53 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so7269882pac.1
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 00:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vJdUfiG6VlwGG7RbVRp2dvUnCLx6yyHYY+fuq2TEvng=;
        b=iSev8iP+y/4UC//47vQaBox5v1YNjUCiglzp4Q27SDLnvdDJP19ntsfoKnFYIAivZg
         D+XtCsEo1gWOx8bfdFT92d05TKmCt964gfMXoNKWDGjSCvGKvZ7ah9QXJN7u4Lv3GRWa
         TovqMNlNtMY08dhDkmqwjbr1+/NO7AhBmWP1TUoSYMJR7B6TQef4Ri1eLDFacwttxXXw
         NUA19Qq0CWfM1HkHA6tWKdr6GcrHdLgvVblaPDp+hPbNwMAcBgu8ggLKlf7r1NUbrwln
         26/aewLzIq764BQU2tjRV2HNracW+inTkE3hcPuDmo85UE9QP1NhM8BJcXEQqBq3FaxL
         s8SA==
X-Received: by 10.68.108.163 with SMTP id hl3mr32631381pbb.160.1372838032526;
        Wed, 03 Jul 2013 00:53:52 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id ve3sm30711458pbc.14.2013.07.03.00.53.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 03 Jul 2013 00:53:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <51D3CAE8.50509@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229461>

On 03/07/13 18:55, Jens Lehmann wrote:
> Am 03.07.2013 01:26, schrieb Chris Packham:
>> On Wed, Jul 3, 2013 at 4:56 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>> Am 02.07.2013 12:12, schrieb Chris Packham:
>>>> --- a/Documentation/git-submodule.txt
>>>> +++ b/Documentation/git-submodule.txt
>>>> @@ -159,7 +159,9 @@ update::
>>>>       This will make the submodules HEAD be detached unless `--rebase` or
>>>>       `--merge` is specified or the key `submodule.$name.update` is set to
>>>>       `rebase`, `merge` or `none`. `none` can be overridden by specifying
>>>> -     `--checkout`.
>>>> +     `--checkout`. Setting the key `submodule.$name.update` to `!command`
>>>> +     will cause `command` to be run. `command` can be any arbitrary shell
>>>> +     command that takes a single argument, namely the sha1 to update to.
>>>>  +
>>>>  If the submodule is not yet initialized, and you just want to use the
>>>>  setting as stored in .gitmodules, you can automatically initialize the
> 
> The above hunk is perfectly fine ...
> 
>>>> @@ -172,6 +174,7 @@ If `--force` is specified, the submodule will be checked out (using
>>>>  `git checkout --force` if appropriate), even if the commit specified in the
>>>>  index of the containing repository already matches the commit checked out in
>>>>  the submodule.
>>>> ++
>>>>
>>>>  summary::
>>>>       Show commit summary between the given commit (defaults to HEAD) and
> 
> ... but I don't understand the extra '+'-line added here.
> 
>>> I'm not sure this change is necessary ;-)
>>
>> Not necessary because it should be documented in
>> Documentation/config.txt instead, or not necessary because it's a
>> niche feature that doesn't need to be advertised?
> 
> Sorry for the confusion, I should have been more specific here.
> 

Ah that makes sense. It's left over from the '--exec' option in v1. Will
be cleaned up in v4.

On a related note should I be updating Documentation/config.txt as well?
Even if it's a statement that this feature exists refer to
git-submodule(1) for details.

>>>> diff --git a/git-submodule.sh b/git-submodule.sh
>>>> index eb58c8e..a7c2375 100755
>>>> --- a/git-submodule.sh
>>>> +++ b/git-submodule.sh
>>>> @@ -799,6 +799,12 @@ Maybe you want to use 'update --init'?")"
>>>>                               say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': merged in '\$sha1'")"
>>>>                               must_die_on_failure=yes
>>>>                               ;;
>>>> +                     !*)
>>>> +                             command="${update_module#!}"
>>>> +                             die_msg="$(eval_gettext "Unable to exec '\$command \$sha1' in submodule path '\$prefix\$sm_path'")"
>>>
>>> Hmm, "Unable to exec" does not quite cut it, as the command was executed
>>> but returned an error, right? Maybe something like this:
>>>
>>>    Execution of '\$command \$sha1' failed in submodule  path '\$prefix\$sm_path'
>>>
>>
>> Will include in v4 once I write some tests.
> 
> Thanks.
> 
