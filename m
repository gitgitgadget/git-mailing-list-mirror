From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-hg: fix path when cloning with tilde expansion
Date: Sat, 10 Aug 2013 01:39:59 -0500
Message-ID: <CAMP44s3ULMBg6BJr6m4zkqHyD70rHSwLcuG5ph+ABr6KME8T=w@mail.gmail.com>
References: <CAMP44s1Jqao0YvBSh18t1C2LwAF4_u2GaTNx1RwdW+pmCFcxvQ@mail.gmail.com>
	<1376068387-28510-1-git-send-email-apelisse@gmail.com>
	<7veha266nq.fsf@alter.siamese.dyndns.org>
	<CALWbr2w2JjEr_hYX9ighu_-=iTV6etG=78g4AbKko64EsecxFA@mail.gmail.com>
	<7vy58a4mcy.fsf@alter.siamese.dyndns.org>
	<CALWbr2y5H_dfHAFW_qN+j8YtF4F9+VcG8G503hr4YN2Qv69CXA@mail.gmail.com>
	<CAMP44s13y39f-eCP1sBuMEedciU230C1O11+iMb1SHi45RnSNQ@mail.gmail.com>
	<7v7gfu4ikb.fsf@alter.siamese.dyndns.org>
	<CAMP44s1Ky2AkEt-XS_nAo=_RrPXSVAL=8cGiMuJabw0=BRU0Dw@mail.gmail.com>
	<7vmwoq304o.fsf@alter.siamese.dyndns.org>
	<CAMP44s1Q2x9uz5Ajr=BgVjSjO88XD5UYzVSEqgMeK5_YAYSa5A@mail.gmail.com>
	<7vioze2kev.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 08:40:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V82qt-0004kA-Ez
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 08:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098Ab3HJGkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 02:40:03 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:52040 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755833Ab3HJGkB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 02:40:01 -0400
Received: by mail-wg0-f44.google.com with SMTP id l18so4121908wgh.35
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 23:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+2MFh00In+8DvF0rMiCmTYyMCR7XQ63flvAaHoEwcUM=;
        b=SssymtlJMmn//LcVZBsrZULlEQILpEL5vUVriNeooi1ZHVleowfOEtN9K7ELkR+0zq
         uRkh96Rkcb5OuAn0X7dkUxVjyqUrNBKoFD/KcuWzDCNYJJA66XXdzkBznJD3BvoUnl8J
         2Xu917vCcKmZYR0Fk8uPXa2fcHPFNCpgGNfsN4cekeVthpJVRxYoGxSXCjR5GIYbk3KM
         mbaOh9md3EATw6+5WMOa/tuRaWs5kmB3oRIv3YoSm0BXOEEIO3nGQmBErE2qm69ysck1
         tTzTCbtwzlZ+U3zjEKAFzHCXNTHuT/STHQcaz223ByzurDliE+RtMJXo9Tkrb5dK/bcF
         qy7A==
X-Received: by 10.180.182.229 with SMTP id eh5mr2137937wic.63.1376116799525;
 Fri, 09 Aug 2013 23:39:59 -0700 (PDT)
Received: by 10.194.39.234 with HTTP; Fri, 9 Aug 2013 23:39:59 -0700 (PDT)
In-Reply-To: <7vioze2kev.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232066>

On Sat, Aug 10, 2013 at 12:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> Hmph, do you mean the third example of this?
>>>
>>>         $ python
>>>         >>> import os
>>>         >>> os.path.expanduser("~/repo")
>>>         '/home/junio/repo'
>>>         >>> os.path.expanduser("~junio/repo")
>>>         '/home/junio/repo'
>>>         >>> os.path.expanduser("~felipe/repo")
>>>         '~felipe/repo'
>>>
>>> which will give "~felipe/repo" that is _not_ an absolute repository
>>> because no such user exists on this box?
>>>
>>> It is true that in that case fix_path() will not return early and
>>> will throw a bogus path at "git config", but if the "~whom" does not
>>> resolve to an existing home directory of a user, I am not sure what
>>> we can do better than what Antoine's patch does.
>>
>> I was thinking something like this:
>>
>> if url.scheme != 'file' or os.path.isabs(url.path) or url.path[0] == '~':
>>   return
>
> That did cross my mind.
>
> I know ~/ and ~who/ are expanded on UNIXy systems, and I read in
> Python documentation that Python on Windows treats ~/ and ~who/ the
> same way as on UNIXy systems, so the "begins with ~" test would work
> on both systems.  But it is probably a better design to outsource
> that knowledge to os.path.expanduser(), with the emphasis on "os."
> part of that function.  That way, we do not even have to care about
> such potential platform specifics, which is a big plus.  The only
> possible difference that approach makes is the above example of
> naming a non-existent ~user, but that will not work anyway, so...

We would be doing better than os.path.expanduser(), because if
Mercurial somehow decided to treat ~ differently, our code would still
work just fine. If we do os.path.expanduser(), then we are not
outsourcing anything, we are taking ownership and fixing the path by
ourselves and dealing with all the consequences.

If I clone ~/git, and then change my username, and move my home
directory, doing a 'git fetch' in ~/git wouldn't work anymore, because
we have expanded the path and fixed it to my old home, if instead we
simply return without fixing, it would still work just fine.

-- 
Felipe Contreras
