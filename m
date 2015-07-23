From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 2/2] refs: loosen restriction on wildcard "*" refspecs
Date: Thu, 23 Jul 2015 09:51:53 -0700
Message-ID: <CA+P7+xq8gSMYRD2SMNqDz8WL+A8y1jBPTBMQG_ckP-CeXk8X2A@mail.gmail.com>
References: <1437599133-13012-1-git-send-email-jacob.e.keller@intel.com>
 <1437599133-13012-3-git-send-email-jacob.e.keller@intel.com>
 <xmqqio9brgrj.fsf@gitster.dls.corp.google.com> <CA+P7+xo4xYVsoitBk7SJhQtHU9_dXFiOpWefUr_8M96GqX8W1w@mail.gmail.com>
 <xmqqa8umrfge.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 19:59:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIKmP-0001U9-4O
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 19:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbbGWR7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 13:59:33 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35868 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbbGWR7b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 13:59:31 -0400
Received: by iehx8 with SMTP id x8so1757232ieh.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 10:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HLIQRNe5yTOsikQngwH2vfHuyG8Q+jSfclIAtvSPPOM=;
        b=lrYhx9U3rQzZajYyxipYkaQwPnW2eJHqJjlQ6GT7uKS5k3cEoI/usNkG+s+xJt8CQC
         nNRQQ4Ue6TNKuLhvve949qrYZY4TB11Ed4xhUHr8X2OxhYTrsuJ+jMjAzLZ3Cz8MvHEm
         hzcIGe01aDGfUpmhK9SVk2QuCcqa0zTTJZK38s5AV0apMg+dCpYrpnWdTKs8kS2FW55Q
         7wmSdwkRi681ZnCdtC9sJ8eY2pQ3iOaUD1sRE1MnurhX8iM17IHhlAkKjO9JZfWKChH0
         ycUQwQ+pytSmcONJ3PiN4UGBhdC0bFNSdSXm2hxCsGdueiX57/Xug2RQrXMuztBliJH3
         rdYQ==
X-Received: by 10.107.136.160 with SMTP id s32mr15416564ioi.174.1437670333027;
 Thu, 23 Jul 2015 09:52:13 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Thu, 23 Jul 2015 09:51:53 -0700 (PDT)
In-Reply-To: <xmqqa8umrfge.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274515>

On Thu, Jul 23, 2015 at 9:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>>> By the way, have you run test suite before sending this (or any
>>> previous round of this) patch?  This seems to break t5511-refspec.sh
>>> for me.
>>
>> Looks like another location I forgot to update. I can send a re-spin
>> if you need with the following diff. Basically looks like the tests
>> just didn't get updated to count the new behavior is valid.
>
> Yeah, basically looks like an untested patch was sent and nobody
> noticed during earlier rounds, even the patch was rerolled a few
> times, before I finally took it to 'pu' to take a look.  A typical
> slow summer moment---people rightfully find it is more important to
> have fun themselves than to help polishing others' patches ;-).
>

I think what happened, is that I ran some tests when the patch was
"configurable" and I had modified the one set of tests to try with the
option enabled, but it didn't fail in the t5511-refspec.sh since this
series of tests didn't enable the new option. Then, I never re-tested
again (OOPS!) when I removed the optional portion.

> Will squash the changes; no need to resend (unless people discover
> other issues; let's hope that I wouldn't be the one to do so ;-).
>
> Thanks.
>

Thank you! :)

Regards,
Jake

>> diff --git i/t/t5511-refspec.sh w/t/t5511-refspec.sh
>> index de6db86ccff0..7bfca7962d41 100755
>> --- i/t/t5511-refspec.sh
>> +++ w/t/t5511-refspec.sh
>> @@ -71,11 +71,11 @@ test_refspec fetch ':refs/remotes/frotz/HEAD-to-me'
>>  test_refspec push ':refs/remotes/frotz/delete me'              invalid
>>  test_refspec fetch ':refs/remotes/frotz/HEAD to me'            invalid
>>
>> -test_refspec fetch 'refs/heads/*/for-linus:refs/remotes/mine/*-blah' invalid
>> -test_refspec push 'refs/heads/*/for-linus:refs/remotes/mine/*-blah' invalid
>> +test_refspec fetch 'refs/heads/*/for-linus:refs/remotes/mine/*-blah'
>> +test_refspec push 'refs/heads/*/for-linus:refs/remotes/mine/*-blah'
>>
>> -test_refspec fetch 'refs/heads*/for-linus:refs/remotes/mine/*' invalid
>> -test_refspec push 'refs/heads*/for-linus:refs/remotes/mine/*' invalid
>> +test_refspec fetch 'refs/heads*/for-linus:refs/remotes/mine/*'
>> +test_refspec push 'refs/heads*/for-linus:refs/remotes/mine/*'
>>
>>  test_refspec fetch 'refs/heads/*/*/for-linus:refs/remotes/mine/*' invalid
>>  test_refspec push 'refs/heads/*/*/for-linus:refs/remotes/mine/*' invalid
>>
>>
>>
>>
>> Regards,
>> Jake
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
