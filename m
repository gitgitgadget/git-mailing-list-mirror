From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/2] remote-helpers: tests: use python directly
Date: Fri, 17 May 2013 19:51:18 -0700
Message-ID: <CAJDDKr6Qnx5ddBn=6reNOY44CxaDgD254H7M3K2mb8bbd8jpmA@mail.gmail.com>
References: <1368825008-2815-1-git-send-email-felipe.contreras@gmail.com>
	<1368825008-2815-2-git-send-email-felipe.contreras@gmail.com>
	<7vwqqxujby.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 04:51:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdXEy-0007ik-EO
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 04:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756741Ab3ERCvT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 May 2013 22:51:19 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:32819 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551Ab3ERCvT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 May 2013 22:51:19 -0400
Received: by mail-pd0-f175.google.com with SMTP id y14so3832125pdi.6
        for <git@vger.kernel.org>; Fri, 17 May 2013 19:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=4FD2wxFWe5nudRzDbLYa6dvmMkgfoXgrK3+/HFRmE/o=;
        b=oZDhBNObW5pU39Kqev6wXbUM3FmbrDVYywP8a1U6P3OBT58AZgyGQsOR8b/YLjDvRj
         kYZYHloRkf3vikm1eYIgDeKgVFbgYrbZ4Qx6oIOeK3/WMgAIUOPWOWcA6To2ciDmytps
         b/Qzr7myo0YPyGENQjv1jxSbToefqf0EbRaR4NMTT1MFFJB5rg9CAUBqKvyTa/8xA7MT
         c4jqGpkVOhevsqYYQjp3/S1wz/9UR+mvreaNd+grScWCZr8KwmCUlAvGEYosd/BBqaSx
         P1eBgGUHR/4IQ5EJlEPNp7LmVou93Xg+BQfqZn1tagLxAU0sZrUVMoqIz/6NSY+QU5Yh
         ajnQ==
X-Received: by 10.66.233.9 with SMTP id ts9mr51983674pac.15.1368845478738;
 Fri, 17 May 2013 19:51:18 -0700 (PDT)
Received: by 10.70.55.106 with HTTP; Fri, 17 May 2013 19:51:18 -0700 (PDT)
In-Reply-To: <7vwqqxujby.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224753>

On Fri, May 17, 2013 at 7:12 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> These remote helpers use 'env python', not PYTHON_PATH, so that's wh=
ere
>> we should check for the extensions. Otherwise, if 'python' is not
>> PYTHON_PATH (e.g. /usr/bin/python: Makefile's default), there will b=
e a
>> mismatch between the python libraries actually accessible to the rem=
ote
>> helpers.
>
> What I am reading here is that what the "helper" uses and what the
> "test" checks to see if it can use the "helper" were different; and
> this patch fixes that misalignment by testing what the "helper"
> actually uses.
>
> So it is a right thing to do in that sense.
>
> I however am having this nagging feeling that I may be missing
> something subtle here.  Comments from others are very much welcome.

Yes, this is correct.  Another way to skin this cat would be to do
search/replace in a Makefile to burn in the PYTHON_PATH similar to how
we do for the .sh scripts and other .py files in the main Makefile.
The remote helpers are in contrib/ so they do not go through the main
Makefile, which is the root cause.

Longer-term, it would be good to treat these uniformly, but this is no
worse for now.

> Will queue but the result will be on tomorrow's pushout.
>
> Thanks.
>
>> Suggested by: Torsten B=C3=B6gershausen <tboegi@web.de>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  contrib/remote-helpers/test-bzr.sh       | 2 +-
>>  contrib/remote-helpers/test-hg-bidi.sh   | 2 +-
>>  contrib/remote-helpers/test-hg-hg-git.sh | 4 ++--
>>  contrib/remote-helpers/test-hg.sh        | 2 +-
>>  4 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-hel=
pers/test-bzr.sh
>> index 5dfa070..2c89caa 100755
>> --- a/contrib/remote-helpers/test-bzr.sh
>> +++ b/contrib/remote-helpers/test-bzr.sh
>> @@ -12,7 +12,7 @@ if ! test_have_prereq PYTHON; then
>>       test_done
>>  fi
>>
>> -if ! "$PYTHON_PATH" -c 'import bzrlib'; then
>> +if ! python -c 'import bzrlib'; then
>>       skip_all=3D'skipping remote-bzr tests; bzr not available'
>>       test_done
>>  fi
>> diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote=
-helpers/test-hg-bidi.sh
>> index f569697..2c693d0 100755
>> --- a/contrib/remote-helpers/test-hg-bidi.sh
>> +++ b/contrib/remote-helpers/test-hg-bidi.sh
>> @@ -15,7 +15,7 @@ if ! test_have_prereq PYTHON; then
>>       test_done
>>  fi
>>
>> -if ! "$PYTHON_PATH" -c 'import mercurial'; then
>> +if ! python -c 'import mercurial'; then
>>       skip_all=3D'skipping remote-hg tests; mercurial not available'
>>       test_done
>>  fi
>> diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remo=
te-helpers/test-hg-hg-git.sh
>> index 8440341..fbad2b9 100755
>> --- a/contrib/remote-helpers/test-hg-hg-git.sh
>> +++ b/contrib/remote-helpers/test-hg-hg-git.sh
>> @@ -15,12 +15,12 @@ if ! test_have_prereq PYTHON; then
>>       test_done
>>  fi
>>
>> -if ! "$PYTHON_PATH" -c 'import mercurial'; then
>> +if ! python -c 'import mercurial'; then
>>       skip_all=3D'skipping remote-hg tests; mercurial not available'
>>       test_done
>>  fi
>>
>> -if ! "$PYTHON_PATH" -c 'import hggit'; then
>> +if ! python -c 'import hggit'; then
>>       skip_all=3D'skipping remote-hg tests; hg-git not available'
>>       test_done
>>  fi
>> diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-help=
ers/test-hg.sh
>> index 8de2aa7..ce03fa3 100755
>> --- a/contrib/remote-helpers/test-hg.sh
>> +++ b/contrib/remote-helpers/test-hg.sh
>> @@ -15,7 +15,7 @@ if ! test_have_prereq PYTHON; then
>>       test_done
>>  fi
>>
>> -if ! "$PYTHON_PATH" -c 'import mercurial'; then
>> +if ! python -c 'import mercurial'; then
>>       skip_all=3D'skipping remote-hg tests; mercurial not available'
>>       test_done
>>  fi
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
David
