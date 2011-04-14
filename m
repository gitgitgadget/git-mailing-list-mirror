From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [BUG] format-patch does not wrap From-field after author name
Date: Fri, 15 Apr 2011 00:43:08 +0200
Message-ID: <BANLkTim0Q+RaExss+U3m-=CHT6Jd1jc56Q@mail.gmail.com>
References: <BANLkTimruwojkq_HNMZeCDBV6K8_aFc_XQ@mail.gmail.com>
 <7v39lkiwoj.fsf@alter.siamese.dyndns.org> <20110414175034.GA23342@sigill.intra.peff.net>
 <BANLkTin+K46_RSDsYWHso3v7Gpe_k+0m8Q@mail.gmail.com> <20110414214230.GB7709@sigill.intra.peff.net>
 <BANLkTikgZH8135=o5ODcA=780-1D7YFngw@mail.gmail.com> <20110414222940.GA19389@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 15 00:43:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAVGA-00061U-G9
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 00:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272Ab1DNWn3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2011 18:43:29 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61098 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158Ab1DNWn2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 18:43:28 -0400
Received: by pwi15 with SMTP id 15so804757pwi.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 15:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ZKSMak7AsjC77NkdRzM5jwA4+sAqjfzFFDCjgdi1xLY=;
        b=teDmxeHFExRtbBiast3xKrsVQ+sBQ9l8qM6CiHUwjT0ZaN8XSNnlUFsLIMiDXPVxpC
         JZb9mFs18p6e1Y594Hr345k0/2tPz4QvdG2cR5FDu+c7gmneENsSKeGDPMLWkODT1blN
         tcp7Xw96DLvrZxKc89wycZ1heTxjBEY/lMN+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=YxOFJP0eGkB7JZp4OqT5bsDfEq+fP1UqNnGG4vjWo9NyNkmGpyEneJzf99qL2o9JGi
         ck0QCBDdhQV5gVqfobZ3spY5/nLppZdQOR11VPftWqWwjAVKo/B7TQDGydQnZhS4nyNE
         mEGrmm27v1dfFSBbNQvZi3IzZE5ALJa2AC9zU=
Received: by 10.68.37.72 with SMTP id w8mr845806pbj.263.1302821008167; Thu, 14
 Apr 2011 15:43:28 -0700 (PDT)
Received: by 10.68.56.105 with HTTP; Thu, 14 Apr 2011 15:43:08 -0700 (PDT)
In-Reply-To: <20110414222940.GA19389@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171570>

On Fri, Apr 15, 2011 at 12:29 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 15, 2011 at 12:21:24AM +0200, Erik Faye-Lund wrote:
>
>> >> True. But since the fix is as simple as it is, perhaps it's worth=
 it
>> >> just for the clean conscience?
>> >
>> > Fair enough. Patch to follow.
>> >
>>
>> Thinking about it a bit more, I'm getting a bit more unsure:
>> - The 78-limit is about user-interfaces, not protocol robustness.
>
> True. In theory we should also be limiting to avoid the 998-character
> hard protocol limit, but that is getting ridiculously unlikely.

I think that's over in my definition of "insanity land", yeah :)

>> - Since send-email unwraps the line and does not re-wrap it, even if
>> we have a name like this it's likely that the work gets undone right
>> away.
>
> Not everybody uses send-email. So you are also helping MUAs which
> consume the output of format-patch.

Good point.

> That being said, I doubt that this will make a difference to anybody.
> The real reason that we put wrapping into add_rfc2047 was for subject=
s,
> which _do_ get long.

Absolutely.

>> - So that means that send-email should probably also be fixed. But n=
ow
>> I'm wondering if we've crossed the point where this will just lead t=
o
>> less obvious code for very little gain.
>
> It is ugly code.
>
> I'm just as happy if we drop it.

OK, then I'll try to forget about this issue for now. Sorry for troubli=
ng you.

>> > Because it means we have to _parse_ those
>> > headers and understand which part is a name and which is an addres=
s.
>>
>> That part is surprisingly easy: If it contains a '<', then it's on t=
he form
>> "Foo Bar Baz <foo@bar.baz>". If not, it's "foo@bar.baz" (assuming it=
's
>> UTF-8 encoded rfc5322 mailbox'es we assume, which would make the mos=
t
>> sense to me)
>
> What about:
>
> =A0"Foo \"The Bar\" Baz" <foo@example.com>
>
> or
>
> =A0Foo "The Bar" Baz <foo@example.com>
>
> or
>
> =A0Foo (The Bar) Baz <foo@example.com>
>
> I.e., are we taking rfc822-style addresses, or are we taking somethin=
g
> that looks vaguely like an email address, and just treating everythin=
g
> left of "<" as literal?

I was just thinking of interpreting everything left of '<' literally
and encode it (if needed). Currently, we interpret the entire string
literally, encoding the name would an improvement.
