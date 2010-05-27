From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] compat: Add another rudimentary poll() emulation
Date: Thu, 27 May 2010 14:00:02 +0200
Message-ID: <AANLkTinXwM1fem6E3RgnLW9vqLD1fV7JvaQnxzZVRakA@mail.gmail.com>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
	<1274948384-167-2-git-send-email-abcd@gentoo.org>
	<20100527101043.GA4390@progeny.tock>
	<AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
	<AANLkTikfaWVEPkHBRF8WHNWmyXIH9f7wRju1wSRC_lwm@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jonathan Callen <abcd@gentoo.org>, git@vger.kernel.org,
	mduft@gentoo.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>,
	msysGit <msysgit@googlegroups.com>
To: Marko Kreen <markokr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 27 14:00:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHbl4-0006UN-2u
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 14:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757894Ab0E0MAK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 08:00:10 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:44454 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755304Ab0E0MAF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 08:00:05 -0400
Received: by wwb34 with SMTP id 34so162637wwb.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 05:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=GlbRLbpDOrsilNJkCSwNhy/sjIQ3wtIJ6HmofV34iO0=;
        b=Brm64m8HMxGa//YAIUPHCLEbCRxBmJY0F2vWjIBBCrZeu6+bTVMapwsiTMGGWgZt+b
         yNkVflLfkEdZxIFhydzD/TdYa/OWIztGRKAxH0nXG6rcVR3Fbhof1ajh66tjzMS3ey6a
         eoW/5lVjSn1U7t6rQKeXDFhVwLHoKxratRVfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=PKWF3xfsT12QOPFppK02oM09ltMV7l8RJnPyDwoaidHPprNT7DKmyDdHzAqqqtrcaY
         Me4lYRkZgWucrohlZncLfip2Xx1uI2/w+U9x3/TWEX1LbwiEunjLDaHc2FP7i9RIePQ4
         W/hp15yGaFAQvW5hwBw1Ga5uSEJci0Nj7QMf8=
Received: by 10.216.159.20 with SMTP id r20mr566306wek.62.1274961602398; Thu, 
	27 May 2010 05:00:02 -0700 (PDT)
Received: by 10.216.21.73 with HTTP; Thu, 27 May 2010 05:00:02 -0700 (PDT)
In-Reply-To: <AANLkTikfaWVEPkHBRF8WHNWmyXIH9f7wRju1wSRC_lwm@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147848>

On Thu, May 27, 2010 at 1:39 PM, Marko Kreen <markokr@gmail.com> wrote:
> On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
>> On Thu, May 27, 2010 at 12:10 PM, Jonathan Nieder <jrnieder@gmail.co=
m> wrote:
>> =A0> Implement the subset of poll() semantics needed by git in terms=
 of
>> =A0> select(), for use by the Interix port. =A0Inspired by commit 6e=
d807f
>> =A0> (Windows: A rudimentary poll() emulation, 2007-12-01).
>> =A0>
>>
>>
>> A possible problem with this approach is that the maximum number of
>> =A0file descriptors poll can handle limited by RLIMIT_NOFILE, wherea=
s the
>> =A0maximum number of file descriptors select can handle is limited b=
y
>> =A0FD_SETSIZE.
>>
>> =A0I don't think this is a big problem in reality, though - both val=
ues
>> =A0seem to be pretty high in most implementations. And IIRC git-daem=
on is
>> =A0the only one who needs more than 2, and it doesn't even check
>> =A0RLIMIT_NOFILE.
>>
>> =A0If we decide to go this route, perhaps it'd make sense to change =
to
>> =A0this code for Windows also? Our Windows-implementation of poll() =
has
>> =A0some annoying limitations...
>
> Example of poll() compat without FD_SETSIZE limit:
>
> =A0http://github.com/markokr/plproxy-dev/blob/master/src/poll_compat.=
c
>

How does this code convince FD_SET() that the buffer has increased? It
looks to me like it depends on a specific FD_SET() implementation...
=46or instance, Windows' FD_SET() implementation is like this:

#define FD_SET(fd, set) do { \
    if (((fd_set FAR *)(set))->fd_count < FD_SETSIZE) \
        ((fd_set FAR *)(set))->fd_array[((fd_set FAR
*)(set))->fd_count++]=3D(fd);\
} while(0)

=2E..so unless another set is passed in, it won't add any more fds once
fd_count reaches FD_SETSIZE.

Also, FD_SETSIZE is 64 on Windows. IIRC it's 1024 on Linux, so it is
much more likely that we encounter this issue on Windows than on
Linux, at least ;)

--=20
Erik "kusma" Faye-Lund
