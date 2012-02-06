From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [bug] blame duplicates trailing ">" in mailmapped emails
Date: Tue, 7 Feb 2012 01:11:01 +0200
Message-ID: <CAMP44s3i3eE8mVGHBB5zUdcX95+KEz9xcC1B3B6qON1StD=FXQ@mail.gmail.com>
References: <CAMP44s1gWNG+jJ6M7OnLS-1VA5YPa07LJfnrvdbsQb0MOJB7PA@mail.gmail.com>
	<7vhaz8vkhd.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Fq_BGwcmDM5E1kWNiyoJw6e6Hr=8XaNF6tmQAcdnUmw@mail.gmail.com>
	<7vehuboe5g.fsf@alter.siamese.dyndns.org>
	<CAMP44s2QdJ4+qgg4fF5-DOWHx3Btd0pTivTT9s_E=qqxg16YLQ@mail.gmail.com>
	<20120204182611.GA31091@sigill.intra.peff.net>
	<7v39aphw85.fsf@alter.siamese.dyndns.org>
	<7vipjlezas.fsf@alter.siamese.dyndns.org>
	<20120205234750.GA28735@sigill.intra.peff.net>
	<7vehu8dcc8.fsf@alter.siamese.dyndns.org>
	<20120206030339.GA29123@sigill.intra.peff.net>
	<7vy5sgaby1.fsf@alter.siamese.dyndns.org>
	<CAMP44s1RN+_UK9rAk_m9Z=YaJJtwHLyiCu2stMMDEWqZN9260g@mail.gmail.com>
	<7vliof62ko.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 00:11:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuXiH-00062G-My
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 00:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756099Ab2BFXLE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 18:11:04 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:50254 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756051Ab2BFXLD convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 18:11:03 -0500
Received: by lagu2 with SMTP id u2so3546435lag.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 15:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=4Jgf7wPFWT5wbldbrW35c/4ZowwO7gIaIojGQu7Q1ek=;
        b=lNKMCbPx7klWA7odLQNa62fBav+6xsORD3AOZx8NeQib6g1woaklU6hufIYdIGyqJp
         MM64P0QDbGgb/adzcJa41i8osKi3w/lHesW9RUnQA7eK+iOIP4M+VajpYkj2jDxSLPi3
         MdwjZEEZ7hMy3gBA8nYC1b9W0Y8d0gCIoOKq0=
Received: by 10.152.112.41 with SMTP id in9mr10815708lab.27.1328569861364;
 Mon, 06 Feb 2012 15:11:01 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Mon, 6 Feb 2012 15:11:01 -0800 (PST)
In-Reply-To: <7vliof62ko.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190119>

On Tue, Feb 7, 2012 at 12:04 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> This subject doesn't explain the *purpose* of the patch: always retu=
rn
>> a plain mail address from map_user()
>
> That would be a much better subject.
>
>> I think the immediate problem should be here:
>>
>> Currently 'git blame -e' would add an extra '>' if map_user() return=
s
>> true, which would end up as '<foo@bar.com>>'. This is because
>> map_user() sometimes modifies, the mail string, but sometimes not. S=
o
>> let's always modify it.
>
> That is just a symptom.

That's a matter of semantics. Is the API broken? Then the API has a
problem, and you are fixing it, otherwise you are merely *improving*
it.

> People who reached this commit by digging the
> history of mailmap.c would need to see the *cause* of the symptom
> described in the light of how the API is designed to be used.

Well, when you have a summary as "always return a plain mail address
from map_user()", I think it's pretty clear what is the "problem"; the
API does not always return a plain mail address. But any case, that is
described below, in my suggestion.

Besides, even people digging the history would benefit from seeing the
"symptom" first.

> In other
> words, "the code after the update has to be this way because these ar=
e the
> i/o constraints this API has". =C2=A0"Otherwise you would see this br=
eakage for
> example" is merely a supporting material.

I disagree. The reader of the current commit message will keep in
his/her head the question "Why?", and it would be answered only at the
very end. Besides, what more succinct way to describe a problem with
the API than with an example (that happens to be real).

--=20
=46elipe Contreras
