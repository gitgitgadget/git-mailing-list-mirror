From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-hg: fix path when cloning with tilde expansion
Date: Fri, 9 Aug 2013 18:43:09 -0500
Message-ID: <CAMP44s1Q2x9uz5Ajr=BgVjSjO88XD5UYzVSEqgMeK5_YAYSa5A@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 01:43:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7wKx-0004NM-Mk
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 01:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031647Ab3HIXnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 19:43:12 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:39667 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031620Ab3HIXnL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 19:43:11 -0400
Received: by mail-la0-f52.google.com with SMTP id fq13so3445336lab.11
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 16:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Yqteef9UrwFxYKFfvpBbMX4UF2wNOak2gXLJugUAT0M=;
        b=Q9mPIeh4XTOAEIL2URWwVTqwWx413kGXJm7hwjrHhhdDRD9nnXRBIc0xGbCbS0Irj+
         tLZ1vpa+pLYByRxT5luDJLqSMDN6Aiyg7fv//iL3xj6YE+L7Qu1bWYwVPT1vNoBg3ddp
         MOkq1BTRoA8+KshF8AI/pgzFBlJunlng7Ju6UOkvVlWzu10lYmzWkWDks96/5VSxd2H2
         q5XZsN4vSlqqTxvBHf9gbNn/UoBUuNQqdb8pcVuHt86FVlbDetIhriSSDfxKhmSNiNX/
         bWd6V67qRn7d+iZsn7neDzietFsUQqmcICnBzhZAxlGocj3mImKNyB4nsqcAHOFKv34g
         hhDQ==
X-Received: by 10.152.20.130 with SMTP id n2mr6949825lae.47.1376091789621;
 Fri, 09 Aug 2013 16:43:09 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Fri, 9 Aug 2013 16:43:09 -0700 (PDT)
In-Reply-To: <7vmwoq304o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232056>

On Fri, Aug 9, 2013 at 6:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Fri, Aug 9, 2013 at 5:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>>> OK, I think I see why you are puzzled.
>>>>>
>>>>> Cloning works fine because we "fix the path" *after* the clone is done
>>>>> successfully, for the following reason:
>>>>
>>>> So if we didn't store a different path, it would work. So instead of
>>>> expanding '~' ourselves, it would be better to don't expand anything,
>>>> and leave it as it is, but how to detect that in fix_path()?
>>>
>>> I think that the patch relies on that os.path.expanduser(), if
>>> url.path is such a path that begins with "~" (or "~whom"), returns
>>> an absolute path.  When given an absolute path, or "~whom/path",
>>> fix_path returns without running 'git config' on remote.<alias>.url
>>> configuration.
>>
>> I think ~whom/path would run 'git config'.
>
> Hmph, do you mean the third example of this?
>
>         $ python
>         >>> import os
>         >>> os.path.expanduser("~/repo")
>         '/home/junio/repo'
>         >>> os.path.expanduser("~junio/repo")
>         '/home/junio/repo'
>         >>> os.path.expanduser("~felipe/repo")
>         '~felipe/repo'
>
> which will give "~felipe/repo" that is _not_ an absolute repository
> because no such user exists on this box?
>
> It is true that in that case fix_path() will not return early and
> will throw a bogus path at "git config", but if the "~whom" does not
> resolve to an existing home directory of a user, I am not sure what
> we can do better than what Antoine's patch does.

I was thinking something like this:

if url.scheme != 'file' or os.path.isabs(url.path) or url.path[0] == '~':
  return

-- 
Felipe Contreras
