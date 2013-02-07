From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Thu, 7 Feb 2013 11:30:24 +0100
Message-ID: <CACBZZX4LzW5bbfo+UkcXsBF3nfZSJstC22NEUsJe=7oCenJgpw@mail.gmail.com>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <5110BD18.3080608@alum.mit.edu> <20130205083327.GA4931@elie.Belkin>
 <5110DF1D.8010505@alum.mit.edu> <CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com>
 <7v4nhpckwd.fsf@alter.siamese.dyndns.org> <CACBZZX6xLvuMEhPnfYLj8W9pMLwdoS7Zb+mTtn+3DanJPiWfXw@mail.gmail.com>
 <7vmwvh9e3p.fsf@alter.siamese.dyndns.org> <20130207001635.GA29318@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 11:31:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Ol4-0005WD-EX
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 11:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664Ab3BGKar convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Feb 2013 05:30:47 -0500
Received: from mail-oa0-f42.google.com ([209.85.219.42]:36519 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447Ab3BGKaq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Feb 2013 05:30:46 -0500
Received: by mail-oa0-f42.google.com with SMTP id i18so2633744oag.15
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 02:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=I7tnnuiyDF1/Vs37X9LUFRUY09Y/mmiTDA5w2xtQ9iU=;
        b=quVqmbQZ9a8f23XP5jEFtc+ZONJjg3UqP0OCTqeHmrfAyxSyRnEQEt5NTq+IJMwuOY
         ka85dXBrRf54Hvu6uRRura/fJTYt/w0Lw+2IOn1BKKe5+6qROSJCDYgqa8pdMZj+8H17
         9cuEWH4SaOY+8SELYZC2thIkCOLXx4CHTPwsF3NOoPsFVTD9QuKHZxtLAXl63v2iPhk8
         vFdChtZ8ymePQ392C51JTP07+X+AQGBaiayF8R3SEBTTfylqHtz8eREWH3xD2TdYm3DZ
         10StLzbvqaTvQRcLInGQ1q2iqjIYhcrlDpV1EHWRvAB7Emm+bEf3VJlnXFKgTFuDuj4E
         1jWA==
X-Received: by 10.60.32.243 with SMTP id m19mr564819oei.13.1360233045756; Thu,
 07 Feb 2013 02:30:45 -0800 (PST)
Received: by 10.76.168.163 with HTTP; Thu, 7 Feb 2013 02:30:24 -0800 (PST)
In-Reply-To: <20130207001635.GA29318@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215689>

On Thu, Feb 7, 2013 at 1:16 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 06, 2013 at 04:12:10PM -0800, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>> > I think there's a simpler way to do this, which is that:
>> >
>> >  * New clients supporting v2 of the protocol send some piece of da=
ta
>> >    that would break old servers.
>> >
>> >  * If that fails the new client goes "oh jeeze, I guess it's an ol=
d
>> >    server", and try again with the old protocol.
>> >
>> >  * The client then saves a date (or the version the server gave us=
)
>> >    indicating that it tried the new protocol on that remote, tries
>> >    again sometime later.
>>
>> For that to work, the new server needs to wait for the client to
>> speak first.  How would that server handle old clients who expect to
>> be spoken first?  Wait with a read timeout (no timeout is the right
>> timeout for everybody)?
>
> If the new client can handle the old-style server's response, then th=
e
> server can start blasting out refs (optionally after a timeout) and s=
top
> when the client interrupts with "hey, wait, I can speak the new
> protocol". The server just has to include "you can interrupt me" in i=
ts
> capability advertisement (obviously it would have to send out at leas=
t
> the first ref with the capabilities before the timeout).

Can't this also be handled by passing an extra argument to
upload-pack? Whether you're talking http, ssh + normal shell, ssh +
git-shell or git:// you pass some argument that older clients would
reject on but would cause newer clients that know about that argument
to wait for you to speak before blasting refs at you.

It would mean that older clients (e.g. older git-shell) would reject
your initial connection, but you could just try again, and save away
info about that remote's version.
