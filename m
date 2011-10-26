From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] Re: [PATCH/RFC] mingw: implement PTHREAD_MUTEX_INITIALIZER
Date: Wed, 26 Oct 2011 15:16:03 +0200
Message-ID: <CABPQNSY9LdqOK=1nN_61ZRMv-ieXzSDYgNsQe0w21RAOw_D7yA@mail.gmail.com>
References: <1319554509-6532-1-git-send-email-kusmabite@gmail.com>
 <4EA6D594.90402@viscovery.net> <CABPQNSZ8wesy-px-n1LYbVwFT3gBNcrHfe+_553sinTferqsog@mail.gmail.com>
 <4EA716FC.2010804@kdbg.org> <CABPQNSY6-j7iNagsJc3WKVZ94=yZHdfBswA-v0XY7vH+RxyjYQ@mail.gmail.com>
 <CAGZ=bqJ7k5h_-62M3y-Jype4a7mOTe+FxeU13JreGj0mOnSRSg@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, msysgit@googlegroups.com,
	git@vger.kernel.org, johannes.schindelin@gmx.de
To: Kyle Moffett <kyle@moffetthome.net>
X-From: git-owner@vger.kernel.org Wed Oct 26 15:16:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ3Ld-0004hW-GP
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 15:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213Ab1JZNQo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Oct 2011 09:16:44 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:65241 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927Ab1JZNQo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Oct 2011 09:16:44 -0400
Received: by vws1 with SMTP id 1so1404268vws.19
        for <git@vger.kernel.org>; Wed, 26 Oct 2011 06:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=0YQ7cafQr2HzwAKhQGkZK8s7iDQnQXqjhtmShatl3Pc=;
        b=ZssMHW8xH1h6uM0l7Bw5ODYr67Ijy0OyAoq6vmUmEqKKgOZ/6qZ+5IsMXoJNlLtiOn
         1v8lKJuE+2OVW9A+vtSql4TjhcWSBvUipclXNfNGMet/1+lewVe3+zyNSYe8dkbaPQs4
         nihr65D3xyUujN1NPMFUVdc/lyEsOeL4e2Bwo=
Received: by 10.68.72.9 with SMTP id z9mr6227927pbu.93.1319635003053; Wed, 26
 Oct 2011 06:16:43 -0700 (PDT)
Received: by 10.68.71.135 with HTTP; Wed, 26 Oct 2011 06:16:03 -0700 (PDT)
In-Reply-To: <CAGZ=bqJ7k5h_-62M3y-Jype4a7mOTe+FxeU13JreGj0mOnSRSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184261>

On Wed, Oct 26, 2011 at 5:44 AM, Kyle Moffett <kyle@moffetthome.net> wr=
ote:
> On Tue, Oct 25, 2011 at 16:51, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
>> On Tue, Oct 25, 2011 at 10:07 PM, Johannes Sixt <j6t@kdbg.org> wrote=
:
>>> Am 25.10.2011 17:42, schrieb Erik Faye-Lund:
>>>> On Tue, Oct 25, 2011 at 5:28 PM, Johannes Sixt <j.sixt@viscovery.n=
et> wrote:
>>>>> Am 10/25/2011 16:55, schrieb Erik Faye-Lund:
>>>>>> +int pthread_mutex_lock(pthread_mutex_t *mutex)
>>>>>> +{
>>>>>> + =A0 =A0 if (mutex->autoinit) {
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (InterlockedCompareExchange(&mutex-=
>autoinit, -1, 1) !=3D -1) {
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pthread_mutex_init(mut=
ex, NULL);
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex->autoinit =3D 0;
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 } else
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (mutex->autoinit=
 !=3D 0)
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ; /* w=
ait for other thread */
>>>>>> + =A0 =A0 }
>>>>>
>>>>> The double-checked locking idiom. Very suspicious. Can you explai=
n why it
>>>>> works in this case? Why are no Interlocked functions needed for t=
he other
>>>>> accesses of autoinit? ("It is volatile" is the wrong answer to th=
is last
>>>>> question, BTW.)
>>>>
>>>> I agree that it should look a bit suspicious; I'm generally skepti=
cal
>>>> whenever I see 'volatile' in threading-code myself. But I think it=
's
>>>> the right answer in this case. "volatile" means that the compiler
>>>> cannot optimize away accesses, which is sufficient in this case.
>>>
>>> No, it is not, and it took me a train ride to see what's wrong. It =
has
>>> nothing to do with autoinit, but with all the other memory location=
s
>>> that are written. See here, with pthread_mutex_init() inlined:
>>>
>>> =A0if (mutex->autoinit) {
>>>
>>> Assume two threads enter this block.
>>>
>>> =A0 =A0 if (InterlockedCompareExchange(&mutex->autoinit, -1, 1) !=3D=
 -1) {
>>>
>>> Only one thread, A, say on CPU A, will enter this block.
>>>
>>> =A0 =A0 =A0 =A0InitializeCriticalSection(&mutex->cs);
>>>
>>> Thread A writes some values. Note that there are no memory barriers
>>> involved here. Not that I know of or that they would be documented.
>>>
>>> =A0 =A0 =A0 =A0mutex->autoinit =3D 0;
>>>
>>> And it writes another one. Thread A continues below to contend for =
the
>>> mutex it just initialized.
>>>
>>> =A0 =A0 } else
>>>
>>> Meanwhile, thread B, say on CPU B, spins in this loop:
>>>
>>> =A0 =A0 =A0 =A0while (mutex->autoinit !=3D 0)
>>> =A0 =A0 =A0 =A0 =A0 ; /* wait for other thread */
>>>
>>> When thread B arrives here, it sees the value of autoinit that thre=
ad A
>>> has written above.
>>>
>>> HOWEVER, when it continues, there is NO [*] guarantee that it will =
also
>>> see the values that InitializeCriticalSection() has written, becaus=
e
>>> there were no memory barriers involved. When it continues, there is=
 a
>>> chance that it calls EnterCriticalSection() with uninitialized valu=
es!
>>>
>>
>> Thanks for pointing this out, I completely forgot about write re-ord=
ering.
>>
>> This is indeed a problem. So, shouldn't replacing "mutex->autoinit =3D
>> 0;" with "InterlockedExchange(&mutex->autoinit, 0)" solve the proble=
m?
>> InterlockedExchange generates a full memory barrier:
>> http://msdn.microsoft.com/en-us/library/windows/desktop/ms683590(v=3D=
vs.85).aspx
>
> No, I'm afraid that won't solve the issue (at least in GCC, not sure =
about MSVC)
>
> A write barrier in one thread is only effective if it is paired with =
a
> read barrier in the other thread.
>
> Since there's no read barrier in the "while(mutex->autoinit !=3D 0)",
> you don't have any guaranteed ordering.
>
> I guess if MSVC assumes that volatile reads imply barriers then it mi=
ght work...

OK, so I should probably do something like this instead?

while (InterlockedCompareExchange(&mutex->autoinit, 0, 0) !=3D 0)
	; /* wait for other thread */

I really appreciate getting some extra eyes on this, thanks.
Concurrent programming is not my strong-suit (as this exercise has
shown) ;)
