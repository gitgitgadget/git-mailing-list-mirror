From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCHv2 10/19] git-submodule.sh: convert test -a/-o to && and ||
Date: Thu, 22 May 2014 10:38:06 +0200
Message-ID: <CA+EOSB=wqBUb_QB6XtK0v4Lsux1mG7wCvXP3XVeDe7o=ofsYFA@mail.gmail.com>
References: <1400682255-17616-1-git-send-email-gitter.spiros@gmail.com>
	<vpqha4is3yd.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"j.sixt" <j.sixt@viscovery.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 22 10:38:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnOVy-0003A9-F3
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 10:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718AbaEVIiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 04:38:09 -0400
Received: from mail-vc0-f177.google.com ([209.85.220.177]:64464 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbaEVIiH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 04:38:07 -0400
Received: by mail-vc0-f177.google.com with SMTP id if11so630518vcb.36
        for <git@vger.kernel.org>; Thu, 22 May 2014 01:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SdxWOwc6bTK+Ff9tcaJMwzHweFTQESPmtmZWYtrlMUU=;
        b=KEKes7mpml+MH8jbFVo64zQzJDzrJYF32GcYg7B3T57zoOWVFsh8tBFZBe/3KXLmCa
         IOCxYqeQd9hGtEn9RrIMzcT/L7HxvfwzdOVIwA5WOKP7gdTASK4eXfBSnfyAgILWaJj1
         VtImf6dIC6k2t7/H6BWOvrHT+/Zf/sQE6XJsJJr+i/3Td1oXDpSo00mXslPe2cTbOt2D
         5fsWAwN6a2vBLx4QIFFRB36oV/pfIKso7Dkk+/UXfW/JN+mVKQdA0J/fkAOeQI3i/iV/
         HiIKupMxG1Owa19pTKBcqm2GmMpsePOF1+cozniEcXcQbXUXVucqibz49dgHb8DHI44a
         1URQ==
X-Received: by 10.52.183.228 with SMTP id ep4mr12197096vdc.30.1400747886449;
 Thu, 22 May 2014 01:38:06 -0700 (PDT)
Received: by 10.52.163.207 with HTTP; Thu, 22 May 2014 01:38:06 -0700 (PDT)
In-Reply-To: <vpqha4is3yd.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249881>

2014-05-22 8:49 GMT+02:00 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>> This is version 2 of the patch to git-submodule of the
>> patch series "convert  test -a/-o to && and ||".
>> It contains the fixes identified by Johannes and
>> Matthieu.
>
> This version of the patch (not the whole series) is
>
> Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>
> Some comments for next time:
>
> * I agree with Johannes that splitting the series with one patch per
>   file is not the right way to split. As a reviewer, I want to
>
>   - check that -a trivially translates to &&
>   - check that -o trivially translates to ||
>   - check non-trivial cases
>
>   Interleaving these cases (especially the trivial and non-trivial
>   cases) makes the review much harder. For this kind of series, the
>   change is trivial, but the review is not (Johannes caught a || Vs &&
>   inversion that I didn't find for example, which is quite serious), so
>   the "optimize your patches for review" is even more important than
>   usual.
>
> * Again, to avoid mixing trivial and non-trivial changes, ...

First of all, thank you. I will take note of your valuable suggestions
for the future.

>
>> @@ -1059,13 +1059,17 @@ cmd_summary() {
>>               while read mod_src mod_dst sha1_src sha1_dst status sm_path
>>               do
>>                       # Always show modules deleted or type-changed (blob<->module)
>> -                     test $status = D -o $status = T && echo "$sm_path" && continue
>> +                     case "$status" in
>> +                     [DT])
>> +                             printf '%s\n' "$sm_path" &&
>> +                             continue
>> +                     esac
>
> turning a echo into a printf is good, but would be better done
> separately.

I had thought, but the change was in the fix of Johannes, and it did
not think was right to change this, especially that it was right
anyway. But I understand very well the observation.

Best Regards
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
