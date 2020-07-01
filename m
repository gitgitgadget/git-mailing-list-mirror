Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1920EC433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 11:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A542077D
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 11:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="h3fCZlMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgGALdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 07:33:17 -0400
Received: from mout.gmx.net ([212.227.17.21]:48245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730245AbgGALdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 07:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593603179;
        bh=h+14GkH7kDXlkO9ay78XVTP5HTomcGg+BXXEF12DmsY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=h3fCZlMnnCbhf0OsSgDLGsvj7fmDLO0k8cJijUqm7CuRhZ7zaK5HrFtfKRDZeUkGW
         BW2xFpZ6epxgNkUkIXQ8SlhgVovBVw1+NCFkstLCeab6uIKu0pCDv0+7ZaBcqA/+sZ
         BOQXlNm3PVJYMs7MH5jyue4ifUtC+Qw2N6xEHZ7c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.116.87] ([213.196.213.153]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmDIu-1j8hZq3h4K-00i91K; Wed, 01
 Jul 2020 13:32:58 +0200
Date:   Wed, 1 Jul 2020 13:32:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
cc:     git <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH v2 2/2] hex: make hash_to_hex_algop() and friends
 thread-safe
In-Reply-To: <CAHd-oW6U9krWYd++5ipGA6e4Xy6ZoBxE+QVFpshrjUKjN+RH0g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2007011244150.56@tvgsbejvaqbjf.bet>
References: <cover.1593208411.git.matheus.bernardino@usp.br> <b47445fa1cef6d4523dd0ca336f7ee22bce89466.1593208411.git.matheus.bernardino@usp.br> <nycvar.QRO.7.76.6.2006291646420.56@tvgsbejvaqbjf.bet>
 <CAHd-oW6U9krWYd++5ipGA6e4Xy6ZoBxE+QVFpshrjUKjN+RH0g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4CTQUlhS2vYd/hasklBbSCDdhebC60iXXsYbPo1diEnnv/Y07jZ
 B0kH0OMZm/cnjB0bYXB51V3iTLFgz1ap072AnLxyg5SSN0BxQTsGHHR2jbhBriyFtuMVgjd
 f5p+2FSDbcgiG57v7n73C7W0hOYBPdMJZ3T4UIkFpLytE4azfxcDPCBvc+feAbgph1ECc5a
 htw+D2dzb6FoWzieMSXNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t9hd+RaaUmk=:9siUNYHrY2sH+OvekmCdcZ
 QpLB+5XB7EFrZhesM5doxK1BJlA1gi8t2SQ3UeB7Ss6Ot06JAwQPyCPHGpBX0S1QRcAxvHJxL
 7fP18arZnEgJaWZLvnfHWBGZt0Llhk9Mjug5iE2FxT+Jqgj/bdcplW5n1qLuJKmYcSsbfcuHL
 Icmvdoprt1WqyTi3rH5uQN3J0PRyOMpEXEDUYh3rmi/zJHLvx3AHk5w2pq9Vlj/pZl0VJ6i6W
 NS+pg/3J57ksQ2YLp3qWGBRpIW40zlRgjrXjmNwWHK6h2aCOpnu1S67QkA1MQgy/wi9zilgmS
 FVmzr+eTLqC3HDL/eO41dxZZZULzPMXhgDsStxuTnXa8L+IW5zWkaopGdTRuQb1SUaM5IOUz1
 A80tbwEv4c+mlMzUfZrALyfQOLdList0quQtJDquLqlARykrdGyXOWTDq7RfEc58lCGgt5jSK
 qWnK3xr4DYE0DlWhW93DS8/6DKg6vwnifnvIfeWe/wAY5wMooMnZeweuHoTDzoee8um8hitj0
 WMB9nZaoGdl/TsmvyX8WHU8PMjjhdJ4gaLv7mvUJidMdehwWbKnGMdSa1bE+l0H/B9wPDgA64
 3ErhCMvUhGnm41vJSnuYWgZuZqvS9Qt+3D2pIuQRHUKXTMI3XOap4FTjTMuLOBq5YZ1jYCqMJ
 EHq7GoObM4ODmmjpqaska78903VQUpFio0CxaWY/Sjzdk0FjFdAnJTCGvt9dCdzTp25RSvWH3
 7gvItaVJcX0uA0xFEM0EG5LohzveannF/z6EuJQQln0e96dhHnL8BCCYyQRDvRaz8eATB/tNZ
 L+IG1VAjfsyDFgbOop7oeq0vDGUF3RPe4pNBA1mUokYmRzJkzQXzjSRPEBP2bBwButuWdAyKk
 n51eOVs433Q3IjTolYQV202nt7MU17I+9UyURXxi2zUFkdW2vWSlGaqfObmIU1st7GpqW1w7n
 MsJV95kcTAhtvh3KXt9ql8rFkwlhGCxU6BPkRkQ/tE2ahyvnzqNezg9mmJqhxQYhUEeXeTZnW
 Sj21Tf2Wg17H+7dc2gaszbjxN3KOvDlEt4ngB2jRPbV48Mh/d+Cu5CRqvQMVny+Ty7n9LUjeW
 0dFF6xWb0GiWxnRpHXO5zm64JJCgM5EauAj2paCE7oxPn8Ebgveh1RMg76q8ox06/+NdlHHSu
 b2mpCL4WicmK76WlNH3qK2cS18ID26iWWBKZ+KQT2vpKrFqRVvzaOn6PYqSF2HrAkymBgllEe
 ot0UV+8peRXWQtKjU
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Tue, 30 Jun 2020, Matheus Tavares Bernardino wrote:

> On Tue, Jun 30, 2020 at 12:01 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Matheus,
> >
> > I am fine with the Windows changes (although I have to admit that I di=
d
> > not find time to test things yet).
> >
> > There is one problem in that I do not necessarily know that the memory=
 is
> > released correctly when threads end; You will notice that the
> > `pthread_key_create()` shim in `compat/win32/pthread.h` does not use t=
he
> > `destructor` parameter at all. The documentation at
> >
> >       https://docs.microsoft.com/en-us/windows/win32/procthread/using-=
thread-local-storage
> >
> > is also not terribly clear _how_ the memory is released that was assig=
ned
> > via `TlsSetValue()`.
>
> Yes, I wasn't sure about that either... It would be great if someone
> familiar with TLS memory on Windows could help us with this.

=46rom reading
https://docs.microsoft.com/en-us/windows/win32/procthread/using-thread-loc=
al-storage,
I get the impression that it is the duty of the thread function to take
care of releasing the memory.

Looking at our code base, I do not see any obvious single point where we
could take care of that.

And it does not look like there is a function you can register to be
called just before threads shut down.

Hmm.

A very involved solution would be to override our `pthread_create()`
emulation to override the function being called, passing as function
parameter a pointer to a struct containing the originally-specified thread
function and parameter, and the overriding function would then call that
function, save its return value, take care of releasing the memory, and
return the saved return value.

Likewise, our `pthread_setspecific()` shim in `compat/win32/pthread.h`
would need to learn to append the passed pointer to a list, and we should
probably also edit the `pthread_key_create()` shim to record the function
to call when releasing the memory at the end of a thread.

This strikes me as pretty ugly and complex.

Yet when I read the LGPLv2'ed code of
https://sourceware.org/pthreads-win32/ that is exactly what they use.
Since their source code is still in CVS, and their anonymous CVS viewer no
longer works, I had to find a copy to point to:
https://github.com/jingyu/pthreads-w32/blob/master/pthread_key_create.c

So we could now start to require a non-minimal pthreads emulation on
Windows. I am somewhat opposed to that idea.

Now I wonder just how involved it _really_ would be to convert all of
those `oid_to_hex()` calls into what is effectively an `_r()` variant,
where you _have_ to pass a buffer to store the result. That would make it
a ton easier to keep Git portable.

I do understand that 800+ hits for `oid_to_hex()` make this somewhat of a
pain to implement...

Maybe there is a way to convince Coccinelle to do all that work for us?

> > A couple more things:
> >
> > On Fri, 26 Jun 2020, Matheus Tavares wrote:
> > >
> [...]
> > > +struct hexbuf_array {
> > > +     int idx;
> >
> > Is there a specific reason why you renamed `bufno` to `idx`? If not, I=
'd
> > rather keep the old name.
>
> OK, I'll change it back in v3.
>
> > > +     char bufs[4][GIT_MAX_HEXSZ + 1];
> > > +};
> > > +
> > > +#ifdef HAVE_THREADS
> > > +static pthread_key_t hexbuf_array_key;
> > > +static pthread_once_t hexbuf_array_once =3D PTHREAD_ONCE_INIT;
> > > +
> > > +static void init_hexbuf_array_key(void)
> > > +{
> > > +     if (pthread_key_create(&hexbuf_array_key, free))
> > > +             die(_("failed to initialize threads' key for hash to h=
ex conversion"));
> > > +}
> > > +
> > > +#else
> > > +static struct hexbuf_array default_hexbuf_array;
> > > +#endif
> > > +
> > >  char *hash_to_hex_algop(const unsigned char *hash, const struct git=
_hash_algo *algop)
> > >  {
> > > -     static int bufno;
> > > -     static char hexbuffer[4][GIT_MAX_HEXSZ + 1];
> > > -     bufno =3D (bufno + 1) % ARRAY_SIZE(hexbuffer);
> > > -     return hash_to_hex_algop_r(hexbuffer[bufno], hash, algop);
> > > +     struct hexbuf_array *ha;
> > > +
> > > +#ifdef HAVE_THREADS
> > > +     void *value;
> > > +
> > > +     if (pthread_once(&hexbuf_array_once, init_hexbuf_array_key))
> > > +             die(_("failed to initialize threads' key for hash to h=
ex conversion"));
> > > +
> > > +     value =3D pthread_getspecific(hexbuf_array_key);
> > > +     if (value) {
> > > +             ha =3D (struct hexbuf_array *) value;
> > > +     } else {
> > > +             ha =3D xmalloc(sizeof(*ha));
> > > +             if (pthread_setspecific(hexbuf_array_key, (void *)ha))
> > > +                     die(_("failed to set thread buffer for hash to=
 hex conversion"));
> > > +     }
> > > +#else
> > > +     ha =3D &default_hexbuf_array;
> > > +#endif
> >
> > This introduces two ugly `#ifdef HAVE_THREADS` constructs which are
> > problematic because they are the most likely places to introduce compi=
le
> > errors.
> >
> > I wonder whether you considered introducing a function (and probably a
> > macro) that transparently gives you a thread-specific instance of a gi=
ven
> > data type? The caller would look something like
> >
> >         struct hexbuf_array *hex_array;
> >
> >         GET_THREADSPECIFIC(hex_array);
> >
> > where the macro would look somewhat like this:
> >
> >         #define GET_THREADSPECIFIC(var) \
> >                 if (get_thread_specific(&var, sizeof(var)) < 0)
> >                         die(_("Failed to get thread-specific %s"), #va=
r);
> >
> > and the function would allocate and assign the variable.
>
> Hmm, we would need two macros, wouldn't we? GET_THREADSPECIFIC(var)
> and a DECLARE_THREADSPECIFIC(var, destructor), to declare the
> pthread_once_t and pthread_key_t variables, as well as define a
> initialization function for the key (i.e. the callback to
> pthread_once()). Or we could provide these declarations ourselves, but
> then we would need the "ifdef HAVE_THREADS" guard to avoid calling
> pthread_key_create() when there is no multithreading.

Right. I wanted to avoid the need to call `DECLARE_THREADSPECIFIC()`, in
particular because that would have to be _outside_ of any function
(because it has to define a function, and nested functions are not really
supported in C, at least not widely).

Ciao,
Dscho

>
> I think that would work, yes. Alternatively, I think we could adjust
> the dummy pthread_key_* functions in thread-utils.h to emulate the
> real ones when HAVE_THREADS =3D=3D false. Then we could eliminate the
> `#ifdef HAVE_THREADS` guards and use the same code for both cases here
> (and everywhere else pthread_key is used). I haven't thought about it
> carefully enough yet, but I think this *might* be as simple as adding
> the following defines in the "#ifdef NO_PTHREADS" section of
> thread-utils.h:
>
> #define pthread_key_t void *
> /*
>  * The destructor is not used in this case as the main thread will only
>  * exit when the program terminates.
>  */
> #define pthread_key_create(key_ptr, unused) return_0((*key_ptr) =3D NULL=
)
> #define pthread_setspecific(key, value) return_0((key) =3D (value))
> #define pthread_getspecific(key) (key)
> #define pthread_key_delete(key) return_0(NULL)
>
> static inline int return_0(void *unused)
> {
>         return 0;
> }
>
> That's the general idea, but we might as well define a `struct
> dummy_pthread_key_t` instead of defining the key directly as `void *`
> (and have functions instead of macros). This way we could store, e.g.,
> an "initialized" flag that could be used to return an error code on
> double-initializations.
>
> What do you think?
>
