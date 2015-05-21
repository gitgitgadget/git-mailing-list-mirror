From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v4 8/8] t5520: check reflog action in fast-forward merge
Date: Thu, 21 May 2015 16:07:05 +0800
Message-ID: <CACRoPnRHAA7w8iJ-GQGPt11Hnm29o6wgP5bEG_q531XmcK-P1Q@mail.gmail.com>
References: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
	<1431955978-17890-9-git-send-email-pyokagan@gmail.com>
	<8e51ff8168d050cb2f8fedd4464b2f7b@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 21 10:08:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvLWL-0006Wc-18
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 10:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187AbbEUIHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 04:07:55 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:33998 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754940AbbEUIHH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 04:07:07 -0400
Received: by laat2 with SMTP id t2so96677254laa.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 01:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5Co2+juXHf4MKf27lILPwUM2ZofQbCE3K43xhB+r33E=;
        b=TvPFRTBU9HkBLaXsN+RC6wP4N++NYhGI+TcRoqHjBcx4DnfLIO51HiQXUiSNe7EFdE
         qSlKXovhs0EQYEdHTdjivVdahrd078SQpYSh9mm3vOAQ02DUnJQ+4c/I02vQrXUY3THS
         p1NcRheA0NB1rAiIBd0Qt0sXjc9hT7rhZ5VoLxtnghMyj8IHPzGzXEn2r55hseWWrhoQ
         kWZFfMe/2zcg5vcv9AVfXdkiwoc2RYNlZyWiHzAMyb1jn/zghNoRD3nygY8zHDF95ZZg
         kOvOlfl61I5ZZmZv1r9c7GRz4w/5FIOBxQxJw8BFbOeReDUBIMbCUdXdqcerHrWw7lkA
         XPfw==
X-Received: by 10.112.142.232 with SMTP id rz8mr1143056lbb.74.1432195625466;
 Thu, 21 May 2015 01:07:05 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 21 May 2015 01:07:05 -0700 (PDT)
In-Reply-To: <8e51ff8168d050cb2f8fedd4464b2f7b@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269566>

Hi,

On Mon, May 18, 2015 at 11:20 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Paul,
>
> On 2015-05-18 15:32, Paul Tan wrote:
>
>> @@ -95,7 +94,11 @@ test_expect_success 'test . as a remote' '
>>       git checkout copy &&
>>       test "$(cat file)" = file &&
>>       git pull &&
>> -     test "$(cat file)" = updated
>> +     test "$(cat file)" = updated &&
>> +     git reflog -1 >reflog.actual &&
>> +     sed "s/$_x05[0-9a-f]*/OBJID/g" reflog.actual >reflog.fuzzy &&
>
> Actually, let's use "s/^[0-9a-f]*/OBJID/" instead: you only want to replace the first few characters.

Did you mean "s/^$_x05[0-9a-f]*/OBJID/"? (with "$_x05" expanding to
'[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]' from test-lib.sh). If not,
then it would match even if there was no SHA1 hash.

But yes, without the "^" there will very likely be false positives.
Thanks for catching.

>> @@ -106,7 +109,11 @@ test_expect_success 'the default remote . should
>> not break explicit pull' '
>>       git reset --hard HEAD^ &&
>>       test "$(cat file)" = file &&
>>       git pull . second &&
>> -     test "$(cat file)" = modified
>> +     test "$(cat file)" = modified &&
>> +     git reflog -1 >reflog.actual &&
>> +     sed "s/$_x05[0-9a-f]*/OBJID/g" reflog.actual >reflog.fuzzy &&
>
> Same here.

Regards,
Paul
