From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of 
	Pthreads API
Date: Thu, 5 Nov 2009 10:00:03 +0100
Message-ID: <16cee31f0911050100v76316dacye7edd8718a893f01@mail.gmail.com>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
	 <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>
	 <alpine.LFD.2.00.0911041247250.10340@xanadu.home>
	 <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com>
	 <40aa078e0911041341s1adbbf31t6961207ba9c7905b@mail.gmail.com>
	 <4AF20534.2030004@gmail.com>
	 <alpine.LFD.2.00.0911042111270.10340@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Nov 05 10:00:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5yCS-0005I3-0e
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 10:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbZKEJAA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Nov 2009 04:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbZKEJAA
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 04:00:00 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:40772 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbZKEI77 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Nov 2009 03:59:59 -0500
Received: by bwz27 with SMTP id 27so9827685bwz.21
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 01:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cdiP0Y1ub8SIcndGcEgVN/3hf1EVp23UQNZHqrh7zy0=;
        b=T2v3jRKPNxOKHEb/I+S8ULdkZXkTkQ0ZZXy91UxXzF2tjaLqnjAjTtACaZVuZu3sMK
         rffEz25o+mdOQ2CEEkqAzs7i+dbSUYjLrrNKryfQD/VC3IvFzmWoPemEtb6xHalhMMm1
         A7k4JawhtbvriYxxwkCe/2GLlRQj+6h9ZP2mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QzmVTqx0fcGm7Z7WCWwW1dZg4ekwaeRXhRkqsuedTYviIUHJBoL89B5J3qEj02dxUz
         weBYRta4ArHSjXtwLfipoVZ6Wx14tMkTfMxzm56CmFbQ79Bo2/m1eCa0eWFoxGHx3kwS
         IEZlRUxRivKaGIrYpeYaLQb6E6iLAWwgHVl5I=
Received: by 10.239.139.156 with SMTP id t28mr280516hbt.33.1257411603510; Thu, 
	05 Nov 2009 01:00:03 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0911042111270.10340@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132216>

2009/11/5 Nicolas Pitre <nico@fluxnic.net>:
> On Wed, 4 Nov 2009, Andrzej K. Haczewski wrote:
>
> What about:
>
> typedef struct {
> =A0 =A0 =A0 =A0HANDLE handle;
> =A0 =A0 =A0 =A0void *(*start_routine)(void *);
> =A0 =A0 =A0 =A0void *arg;
> } pthread_t;
>
> DWORD __stdcall windows_thread_start(LPVOID _self)
> {
> =A0 =A0 =A0 =A0pthread_t *self =3D _self;
> =A0 =A0 =A0 =A0void *ret =3D self->start_routine(self->arg);
> =A0 =A0 =A0 =A0return (DWORD)ret;
> }
>
> static inline int pthread_create(pthread_t *thread, const void *unuse=
d,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void =
*(*start_routine)(void *), void *arg)
> {
> =A0 =A0 =A0 =A0thread->handle =3D CreateThread(NULL, 0, windows_threa=
d_start,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0thread, 0, NULL);
> =A0 =A0 =A0 =A0[...]
> }

The problem I see is not with pthread_init, but pthread_join. Here's
how it looks:

int pthread_join(pthread_t thread, void **value_ptr);

If pthread_t would be a struct, then we can't call pthread_join like
that... At least that's what I though yesterday, but maybe it can be
done like this:

int win32_pthread_join(pthread_t *thread, void **value_ptr)
{
        [...]
}

#define pthread_join(a, b) win32_pthread_join(&(a), (b))

That way we don't need allocations to simulate pthread init/join API

> And thread creation is a relatively rare event compared to e.g. mutex
> lock/unlock, so the indirection shouldn't be noticeable. =A0For the s=
ame
> reason, I also think that you could make pthread_create() and
> pthread_join() into a C file instead of being inlined which would red=
uce
> the code footprint at every call site, and allow for only one instanc=
e
> of windows_thread_start() which could then be made static.

Yeah, I'll factor that out to separate file.

--
Andrzej
