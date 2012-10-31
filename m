From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 4/4] fast-export: make sure refs are updated properly
Date: Wed, 31 Oct 2012 03:08:32 +0100
Message-ID: <CAMP44s0jyvwmqD59o+cRgWc9vjxAdWO_4rORYrNcqU4VLJ9Kfg@mail.gmail.com>
References: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
	<1351623987-21012-5-git-send-email-felipe.contreras@gmail.com>
	<20121031001117.GA29486@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 03:08:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTNjh-0006S9-Qd
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 03:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933023Ab2JaCIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 22:08:34 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40263 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069Ab2JaCId (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 22:08:33 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so965625obb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 19:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XaAYJ3gkbS+gTCMRrdcV0Vjqarvra+5kPLMxlexpfoI=;
        b=sRiizPu8KUJlscB6UiEN90YV6r43zpTE0KQbHvh1pLEsvy45R52jqqBX4CXWNaZ8x6
         4wTNLbqOmw0i/i1RtFJgtlHYQo9gO8/WcNm5gI6A/gyaImg4btsJm8OMtrMbht8ZWn4T
         DgDyvOiJSehUEua7Cu2e5KiyuhjeI+C4XmaiHbausvg/2i7UVSciJq/cNA5FAHbd82ao
         YINaY52iicqA3Gh1L9TkIXenbcCwKT0It1+gI8sbAlsT5bWydmUEwHRYI3DeuOfzpxis
         Vs3fnYp2mrl6l2kSOyIgDGYmcooTiP7NrhT9g+w2xWPikmrpsUZK/r+96qA1zcNKRMDM
         r5Hg==
Received: by 10.60.32.5 with SMTP id e5mr11416365oei.46.1351649312120; Tue, 30
 Oct 2012 19:08:32 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 19:08:32 -0700 (PDT)
In-Reply-To: <20121031001117.GA29486@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208784>

On Wed, Oct 31, 2012 at 1:11 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> (cc-ing the git list)
> Felipe Contreras wrote:
>
>> When an object has already been exported (and thus is in the marks) it
>> is flagged as SHOWN, so it will not be exported again, even if this time
>> it's exported through a different ref.
>>
>> We don't need the object to be exported again, but we want the ref
>> updated
>
> Yes, makes perfect sense.
>
> For what it's worth,
> Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Yay!

> [...]
>> --- a/t/t5800-remote-helpers.sh
>> +++ b/t/t5800-remote-helpers.sh
>> @@ -145,4 +145,15 @@ test_expect_failure 'push new branch with old:new refspec' '
>>       compare_refs clone HEAD server refs/heads/new-refspec
>>  '
>>
>> +test_expect_success 'push ref with existing object' '
>> +     (cd localclone &&
>> +     git branch point-to-master master &&
>> +     git push origin point-to-master
>> +     ) &&
>> +
>> +     (cd server &&
>> +     git show-ref refs/heads/point-to-master
>> +     )
>
> Style: if you indent like this, the test becomes clearer:

And then it would become inconsistent with the rest of the file.

>> +     git fast-export --import-marks=tmp-marks \
>> +             --export-marks=tmp-marks master > actual &&
>> +     test_cmp expected actual
>
> Redirections in git shell scripts are generally spelled as
> "do_something >actual", without a space between the operator and
> filename.

I generally am OK with adapting to whatever code-style is used
(sometimes under protest), but this is a place where I draw   the
line. Sorry, '>actual' is more annoying to me than a knife screeching
glass. Fortunately, '> actual' is used in many other places in 't/',
so I'm going to use the other people jumping over the bridge argument.

Cheers.

-- 
Felipe Contreras
