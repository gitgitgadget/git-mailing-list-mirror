From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 6/6] zlib: zlib can only process 4GB at a time
Date: Mon, 13 Jun 2011 13:17:00 +0200
Message-ID: <BANLkTi=sT_LxRaJSM3Cj-QkSwqGan29K7A@mail.gmail.com>
References: <1307736948-16956-1-git-send-email-gitster@pobox.com>
 <1307736948-16956-7-git-send-email-gitster@pobox.com> <BANLkTikmLDZj2qdkmF-kBUkB33o9EjtBpg@mail.gmail.com>
 <7v4o3uspiy.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 13:17:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW59S-0002tL-QE
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 13:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066Ab1FMLRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 07:17:41 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:34594 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab1FMLRk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 07:17:40 -0400
Received: by pvg12 with SMTP id 12so2066876pvg.19
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 04:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=6pBf3Z8aNrDX9u3nkhNJouaOmqsGh82OTYWkEJAS3GE=;
        b=AbC0K5h1NmJo56MsgRGda4V5uRshnyj8UP0HkJfHMpGIUYVHupfruAXAQwTHfr0Mgw
         2qUVT+bY8M0G8g/wQOIY+0RxU2Lt4hTC7jWsd5SyAfQbPL+OBBiJxHgWFmXsMp9wNUpB
         xr5V66DWQp10rOt/KCcE71qBjoAn4YYMo8Fs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=q7Qx3JVN5+BL8v230FhYUZh9KIwoy5KfEKhYVbcJyOuSipMOAMu6vpw1cJikld+gfT
         T1FhlFiXE/s0CV3nxClDJuM1lvV4XMGbCH99a1Jr8B/DDE6xM6423VxmCUR76YlWRgup
         FdeevOrBRyRx/PbY5QMcqIqxZCQQOyAQl/1YA=
Received: by 10.68.64.69 with SMTP id m5mr1872411pbs.383.1307963860134; Mon,
 13 Jun 2011 04:17:40 -0700 (PDT)
Received: by 10.68.50.231 with HTTP; Mon, 13 Jun 2011 04:17:00 -0700 (PDT)
In-Reply-To: <7v4o3uspiy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175697>

On Sun, Jun 12, 2011 at 11:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> On Fri, Jun 10, 2011 at 10:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> The size of objects we read from the repository and data we try to put
>>> into the repository are represented in "unsigned long", so that on larger
>>> architectures we can handle objects that weigh more than 4GB.
>>
>> shouldn't this be "size_t" instead of "unsigned long"?
>
> No, this must be unsigned long as that is the internal type we use.

I'm not sure I even understand what you mean here. "unsigned long" is
the only choice because it's the type we use? That's sounds pretty
close to tautology to my ears.

Looking a bit more at the code, it seems that we currently use
"unsigned long" a lot of places where "size_t" should have been used.
And this series is about changing places where "unsigned int" is being
used instead of "unsigned long". This sounds backwards to me;
shouldn't all code that deals with sizes (both the ones that are
"unsigned int" AND the ones that are "unsigned long") be changed to
size_t instead?

> Implementation of git on 32-bit platforms has always been limited to 4GB
> from day one. This topic is not about changing it.

As Matthieu pointed out, my comment wasn't about 32-bit systems;
"unsigned long" is 32-bit even on 64-bit versions on Windows. I
believe TortoiseGit builds Git for Windows as 64-bit, so AFAIK this
would still be a problem for them.
