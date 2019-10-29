Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA4F31F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 12:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfJ2MbY (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 08:31:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:50943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbfJ2MbX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 08:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572352267;
        bh=ZcEC/p1j5Lrj7GP9yHg67VfXccIh7oD1U0XIXDLI5hE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XFj3A+XAED7uLt1zVxuzzW95c+OYbOMAArHa2eh0GQ3NYt+lNEMreX7COlR4TYPiu
         +mluEaI3gwcs3T0BXNZrlAsjFP5NkuezrwQZOh2Qxakw5mBiyv+h1CNJ5fEnWXOFkw
         gKvajCEsGQKJf5KfWYNSiiwSYnBrW3JfZdhLOauM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqs0R-1hdOOp3a53-00mtjB; Tue, 29
 Oct 2019 13:31:06 +0100
Date:   Tue, 29 Oct 2019 13:30:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 1/1] vreportf(): avoid buffered write in favor of unbuffered
 one
In-Reply-To: <xmqqeeyw6xyr.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910291222500.46@tvgsbejvaqbjf.bet>
References: <pull.428.git.1572274859.gitgitgadget@gmail.com> <455026ce3ef2b2d7cfecfc4b4bf5b588eebddcfe.1572274859.git.gitgitgadget@gmail.com> <xmqqeeyw6xyr.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cNKW2W2oLlU8uaQea98oekc6ON7RXA6OnXdw/XR/vDvyX/5vWfq
 ucbv5yaXnYI/0zzQP6zOgSGyg9NjwuSq3OP8jPhJzvMfnELq/Wvf9kRK9Z1ZRioq0+novZH
 EAuSaXrsMewgI5KG44465S0xC+vOKsRG2JTk89zOd2NU0b/s7GhmrmYATNjP5VfHWDwyE+r
 dA7lVsaeFhHgxPDGDKFiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+4cNR10gLi0=:rHy+CR1flvTPj0J3WWMQJr
 U+GTrfY/hqY0xKuPNMZ4+unHWGMw1Hz+dgOWNLtD/q5x5AAURSW8CBrkNTdJ2zjhKsEeYPKIp
 dwfclKec7tieClfFKxGi6g05c5MNHOAyy+6FNDFtJSpiD1DEtoYgmgoBwmabyIGss2fobqj3H
 1ALPyWSGX4lzGGYsyeyYOlvvOFywCte4iORzG8aDbpdwUeZWBxq6zEuNdSe9nekdpheaz/HA/
 E9ANiDa8frVJapGbYaO4u82iXps/hi9vCgo6ZEzvydP9+kIIXzIsCYAbC4bSjIY+gfhF96PYT
 mOZAGjPu/EObZgX/LlVU8QhV7/jIp9zDxJbnceI2uXlKHEiZvfEc5qBctoPfBBrmWqa0C7WH3
 4h8O5anRHkZLqkjwD/M/2tW7jr/Zfd7owK8PGG3NjujmQynbOg0CUtvLbDMo7IWQtNPFdNXDj
 NfBXGeIFJcIlpvnR5vixwOekl/2I7XPKepdBWw6gAcxhO/klLchp8x1v93wCgc9gs7kk900Gy
 E8osicWash4zOatd6pq7qk6+Ren9yfzM9+B7gC4s337mrkYdoPDSd7YHSHxNjgkI0ZvtbF5Xk
 TO13fAiY0UJmkE0BPao4/JKmSqTjx3u3lnGa4T1V5PE2hU+wmC9Z1hXqiUcTb+SAgJS18Ch5y
 kvVdRh2UCQka507Sn32URQJkdXqqiNes9tbeKmU6rch4kkKQykGoJredz6GG/qYLwFhMsrzG9
 HaX9Vs8TQi7bnybODwZwKuG1gSCRo5a/A6hN9Q+0fbLHGJv1umpKyuHBfQZSgV4tVEilWEhRb
 cl20l6420efOfOUBibZtDZh/YFN6OKD0Joarc9QrVXoH488MZe9Rxe+LTbwPozTwgHpOIP+d8
 MzJK5iwRF56wLtg3Y1oY/1XZSoX+HPTbEpIBDQ6MvLK/OuhgmhAY5jWfJ5vQ9lHX8Nu8mVGzy
 zmMxGwV8yAhx22b523Yi4CBKuh1/WAlGwtC5XBRWy9KsMhTkwEJ+rC4yztLROltx1ApHOb0TC
 sSWQfCsF90N2BM4/0LC8SLwnXB8pfJjZ1Lp74d9DxZ/zU+ytnnrrzBjzFja9w92CN/kojZMig
 aTS8AhsFTgULBBwzHj4HrvDWRl+px8sqIVIsYbcMCvRMvGN4a/W3v6GjgYLDVWPJAzQ8Dxm5t
 OWAGqiXLj4XaU9Uxxy8LljwVFAniS4WNtZMqQJTptpjxY/oGoPb2fbhhCkMb3l3PV6jkrLX54
 /AwHM8qBUHaFdDCeZxUPDRV9wpBVAaCqoXP5SQrxGha8vjj90uR9k3AjZOEk=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 29 Oct 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > Also please note that we `fflush(stderr)` here to help when running in=
 a
> > Git Bash on Windows: in this case, `stderr` is not actually truly
> > unbuffered, and needs the extra help.
>
> Yuck.  So on all systems, vreportf() now totally bypasses stdio?

Yep ;-)

> Also, this is only to help output from us that goes via vreportf() and
> other codepaths in us that use stdio to write to the standard error
> stream can still get mixed on Windows (I think the answer is yes,
> because we wouldn't need fflush() in this patch if we are covering all
> writes to the standard error stream)?

Yes, `write()` can get interrupted, so there is still a slight chance of
interleaving.

However, with `fprintf()`, apparently the MSVC runtime essentially
writes and flushes one character at a time, which will make it _much_
more likely that two competing processes write interleaved messages to
`stderr`.

> By the way, I'd retitle the patch to highlight that we are still doing
> buffered write, if I were doing this topic.  We are just avoiding some
> implementations of stdio that do not give us buffering and doing the
> buffering ourselves.
>
>     Subject: vreportf(): don't rely on stdio buffering
>
> or something like that.

Good idea.

> > Co-authored-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.c=
om>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  usage.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/usage.c b/usage.c
> > index 2fdb20086b..4328894dce 100644
> > --- a/usage.c
> > +++ b/usage.c
> > @@ -10,13 +10,19 @@ void vreportf(const char *prefix, const char *err,=
 va_list params)
> >  {
> >  	char msg[4096];
> >  	char *p;
> > -
> > -	vsnprintf(msg, sizeof(msg), err, params);
> > +	size_t off =3D strlcpy(msg, prefix, sizeof(msg));
>
> Like snprintf(3) the strlcpy() and strlcat() functions return the
> total length of the string they tried to create.  For strlcpy() that
> means the length of src.

True (I misread `compat/strlcpy.c` and forgot to consult the
documentation). This length can be longer than `msg`, of course.

> So "off" would be strlen(prefix), which could be longer than
> sizeof(msg)?  Then what happens to this vsnprintf() we see below?

A problem.

I `git grep`ed and saw that only very short `prefix`es are hard-coded.
So that is a hypothetical concern.

However, Alex also indicated his discomfort with this, so I will change
the code to account for a `prefix` that is too long (the entire error
message will be clipped away in that case, which is unfortunate, but to
be expected).

> > +	int ret =3D vsnprintf(msg + off, sizeof(msg) - off, err, params);
> >  	for (p =3D msg; *p; p++) {
> >  		if (iscntrl(*p) && *p !=3D '\t' && *p !=3D '\n')
> >  			*p =3D '?';
> >  	}
> > -	fprintf(stderr, "%s%s\n", prefix, msg);
>
> Strictly speaking this is a breaking change in that control
> sequences in prefix are now clobbered.  Does any caller call this
> function with prefix like "^M\033[K<some string>" to overwrite the
> last output line with the new message?  If not, then probably we do
> not have to worry about it (and reusing msg[] does feel attractive).

Such a sequence would not exactly be a prefix, but okay, I changed the
code to replace only characters in the non-prefix part. For good
measure, I also detect `NUL`s in that part and shorten `ret` in that
case (think `die("This was an\0unintentional NUL")`).

Thanks for the review!
Dscho

> > +	if (ret > 0) {
> > +		if (off + ret > sizeof(msg) - 1)
> > +			ret =3D sizeof(msg) - 1 - off;
> > +		msg[off + ret] =3D '\n'; /* we no longer need a NUL */
> > +		fflush(stderr);
> > +		xwrite(2, msg, off + ret + 1);
> > +	}
> >  }
> >
> >  static NORETURN void usage_builtin(const char *err, va_list params)
>
