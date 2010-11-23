From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [RFC PATCH 1/6] msvc: opendir: use xmalloc
Date: Tue, 23 Nov 2010 19:00:28 +0100
Message-ID: <AANLkTin01j-yb1j7WsCkZ2MThJ80qbcOw5yjE5LxrqJZ@mail.gmail.com>
References: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
 <1290533444-3404-2-git-send-email-kusmabite@gmail.com> <20101123174050.GB12113@burratino>
 <AANLkTiknTQp96PeiBd+MqCO6uEs1mCzFYDsW8NwYpBsm@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 19:00:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKxAm-0003nn-L4
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 19:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756040Ab0KWSAv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 13:00:51 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41512 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178Ab0KWSAu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 13:00:50 -0500
Received: by fxm13 with SMTP id 13so4119680fxm.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 10:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=OM5SQMFORrkiUuix5Y9CwmLRKsZXaU5h65R/wPSdFe8=;
        b=aRR6GFifH+Hslh45ZfGffwnnkp9iamcyGsJyQ8oJEvJ8OLsIzHRH5ifnUbAN4mxMCK
         TBqKCUQ2KK8bvK+VRoBL9aGa4TNmTZHT2B5jiUiJBXWiFjEZ2+kQqfXdNHY51skXSIWc
         8bYImhhg3VVktQRMYdyj0uCksDrlRlS8lfQv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=YzbZU+RYOEXoctqrtLvM/duJZDNJrGZOKQd2mteYZuDRr8B7nVCivVlion7vM+E+Qq
         lYHw3gP3M5ZdeTHOPeB8BTx6zMpFU28t8/y4R3vMpScvv2+M0Iaayy4e41Z2zOJbZpFl
         Fs/M3Hojrz6A5UTdYDMCy523Q4m9nwmyQVp2s=
Received: by 10.223.107.16 with SMTP id z16mr284247fao.7.1290535248887; Tue,
 23 Nov 2010 10:00:48 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Tue, 23 Nov 2010 10:00:28 -0800 (PST)
In-Reply-To: <AANLkTiknTQp96PeiBd+MqCO6uEs1mCzFYDsW8NwYpBsm@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161999>

On Tue, Nov 23, 2010 at 6:45 PM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> On Tue, Nov 23, 2010 at 6:40 PM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:
>> Erik Faye-Lund wrote:
>>
>>> --- a/compat/msvc.c
>>> +++ b/compat/msvc.c
>>> @@ -7,16 +7,13 @@ DIR *opendir(const char *name)
>>> =A0{
>>> =A0 =A0 =A0 int len;
>>> =A0 =A0 =A0 DIR *p;
>>> - =A0 =A0 p =3D (DIR*)malloc(sizeof(DIR));
>>> + =A0 =A0 p =3D xmalloc(sizeof(DIR));
>>> =A0 =A0 =A0 memset(p, 0, sizeof(DIR));
>>> =A0 =A0 =A0 strncpy(p->dd_name, name, PATH_MAX);
>>> =A0 =A0 =A0 len =3D strlen(p->dd_name);
>>> =A0 =A0 =A0 p->dd_name[len] =3D '/';
>>> =A0 =A0 =A0 p->dd_name[len+1] =3D '*';
>>>
>>> - =A0 =A0 if (p =3D=3D NULL)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>>
>> A behavior change but maybe a good one. =A0For example, the
>> prune_packed_objects() loop currently skips object dirs it can't ope=
n,
>> even if that is due to memory exhaustion, but this changes it to err=
or
>> out.
>>
>> What is the motivation?
>>
>
> The motivation is just to avoid having to deal with the error, like w=
e
> do other places. It's not a big deal though. I could also set errno t=
o
> ENOMEM and return NULL if that's preferable. I just don't see how it
> is.
>
> I also slightly dislike setting an error not listed in POSIX'
> documentation of opendir, even though it's probably allowed.
>

Of course, I don't have to set errno; malloc would already have done
that. All I need to do is move the check for NULL a bit earlier, so it
won't segfault on ENOMEM. I'll change it for the next round.
