From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [BUG] format-patch does not wrap From-field after author name
Date: Fri, 15 Apr 2011 10:32:27 +0200
Message-ID: <BANLkTinifkWJJCNGYo1gHKJGMVmRX7QfmA@mail.gmail.com>
References: <BANLkTimruwojkq_HNMZeCDBV6K8_aFc_XQ@mail.gmail.com>
 <7v39lkiwoj.fsf@alter.siamese.dyndns.org> <20110414175034.GA23342@sigill.intra.peff.net>
 <BANLkTin+K46_RSDsYWHso3v7Gpe_k+0m8Q@mail.gmail.com> <20110414214230.GB7709@sigill.intra.peff.net>
 <BANLkTikgZH8135=o5ODcA=780-1D7YFngw@mail.gmail.com> <20110414222940.GA19389@sigill.intra.peff.net>
 <BANLkTim0Q+RaExss+U3m-=CHT6Jd1jc56Q@mail.gmail.com> <20110415033003.GB19621@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 15 10:32:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAeSW-000439-2z
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 10:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096Ab1DOIcu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Apr 2011 04:32:50 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51835 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab1DOIcr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2011 04:32:47 -0400
Received: by pvg12 with SMTP id 12so963370pvg.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 01:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ttixdRHPi5n5QgDjyKHp/GasWiANjqZxSf62adRFtRc=;
        b=JGb/2pW4UMrFpZJ9DYgjKxdF+1cUTCs8OpoNKlrH0Ys2XdkjadJpLW0zc2/vdV+dwr
         ZDwWC8tjLy50s6QUbKrm/jwqh73v6D56M9BgXzWwkUuG+Soxy5zjXoXwWFx+jexHrqiO
         bTiMgH1wy7hJqthw2TRFU2gt9lcyy6A6b6xcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=Jc27X6Yc9/WKWUqKwnt/6OwbqlzJgqeN0zzBEclOeEmfEEEGgGAuEYT0uvJ3BUjpaf
         ua0GT/V+aYa7+AI2TZBxgThOnVZlJk5By8ffCXuHtoGrGU5lTOLlOcHkhDxNyLvLhfXK
         kkhaP4A95EQC+ey2h+/Yiqgq/mPw+Y1QySDDM=
Received: by 10.68.4.3 with SMTP id g3mr1662559pbg.129.1302856367034; Fri, 15
 Apr 2011 01:32:47 -0700 (PDT)
Received: by 10.68.56.105 with HTTP; Fri, 15 Apr 2011 01:32:27 -0700 (PDT)
In-Reply-To: <20110415033003.GB19621@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171595>

On Fri, Apr 15, 2011 at 5:30 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 15, 2011 at 12:43:08AM +0200, Erik Faye-Lund wrote:
>
>> >> That part is surprisingly easy: If it contains a '<', then it's o=
n the form
>> >> "Foo Bar Baz <foo@bar.baz>". If not, it's "foo@bar.baz" (assuming=
 it's
>> >> UTF-8 encoded rfc5322 mailbox'es we assume, which would make the =
most
>> >> sense to me)
>> >
>> > What about:
>> >
>> > =A0"Foo \"The Bar\" Baz" <foo@example.com>
>> >
>> > or
>> >
>> > =A0Foo "The Bar" Baz <foo@example.com>
>> >
>> > or
>> >
>> > =A0Foo (The Bar) Baz <foo@example.com>
>> >
>> > I.e., are we taking rfc822-style addresses, or are we taking somet=
hing
>> > that looks vaguely like an email address, and just treating everyt=
hing
>> > left of "<" as literal?
>>
>> I was just thinking of interpreting everything left of '<' literally
>> and encode it (if needed). Currently, we interpret the entire string
>> literally, encoding the name would an improvement.
>
> Won't that be a regression for people who already know that we take
> things literally and are manually quoting and/or rfc2047-encoding the
> contents?

Yes. But won't that always be the case when someone depends on buggy be=
havior?

Besides, send-email takes interprets it's --to and --cc arguments as
well as sendemail.to and sendemail.cc config options literally (i.e
quoting if needed without any attempts on unquoting first). IMO having
two closely related programs with similar options that behave
different in border-cases is pretty ugly. ESPECIALLY when one of them
has a habit of forwarding unknown options to the other, like
send-email does...
