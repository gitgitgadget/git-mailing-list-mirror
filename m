From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Suggestion on git-push --porcelain
Date: Wed, 10 Feb 2010 19:28:11 +0800
Message-ID: <be6fef0d1002100328g4dac78f6y88497aca791a17fc@mail.gmail.com>
References: <be6fef0d1002091834i1c4b202cp5afacc326bd1a4d6@mail.gmail.com>
	 <7vmxzhn6fp.fsf@alter.siamese.dyndns.org>
	 <20100210045446.GC28526@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Larry D'Anna" <larry@elder-gods.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 10 12:28:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfAjz-0003ws-93
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 12:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504Ab0BJL2O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 06:28:14 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:45529 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103Ab0BJL2N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Feb 2010 06:28:13 -0500
Received: by iwn39 with SMTP id 39so9659635iwn.1
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 03:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WCnjvSBZtNzIBkVoX5jdkAP8Ip3m3yUwgIMO1DamaNw=;
        b=td+cnV1ME2MID9AlmTbS+hMiorNIwtgpPGsxzuYENU7awIEivDjaSt3QSdYFw7kafP
         2NhlBfN3VLIu/4OpgcGL3Hi3krFnxpdmL89Ge96jSe5FKbDFchCmJz6E43jKMAKJPlV8
         arxIgYyRJP10w+v8D7fWVWpNgrLCGd6/HCnOc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EvBUOiyg9zs7JXonldBXE02kWxh1pON20gzXtTS6J8UWWXF7lKs3plGtlQIwU4Pngt
         SYQ90eOO/qML/f8vSzyqZiIYBYM/CBVhDY6D+agUumU4KHEZ8CqjvQkMVTsjsPdG+rDX
         hYSiKg2F21X5O6ktw4LHMS17WXA/HYRxbo9HE=
Received: by 10.231.160.149 with SMTP id n21mr99732ibx.93.1265801292013; Wed, 
	10 Feb 2010 03:28:12 -0800 (PST)
In-Reply-To: <20100210045446.GC28526@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139505>

Hi,

On Wed, Feb 10, 2010 at 12:54 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 09, 2010 at 06:57:46PM -0800, Junio C Hamano wrote:
>
>> Tay Ray Chuan <rctay89@gmail.com> writes:
>>
>> > =A0 $ git push --porcelain
>> > =A0 PORCELAIN To git://foo.com/git/myrepo.git
>> > =A0 PORCELAIN uptodate refs/heads/baz:refs/heads/baz 1234ab ba4321
>> > =A0 PORCELAIN nonff refs/heads/bar:refs/heads/bar 2345cd 3456de
>> >
>> > This is an "positive" approach, in the sense that we don't remove
>> > anything from the current output; we just add more printf("PORCELA=
IN")
>> > lines to wherever is appropriate.
>>
>> Sorry, but I don't see what that would solve. =A0For example, we use=
d not to
>> give the destination to the standard output stream, but that line ca=
rries
>> a necessary information and Larry's series corrects that.
>
> I think he is trying to future-proof any additional output that push =
(or
> remote helpers) produce.

Yes. By using this (or some other output scheme), we're deliberately
marking out output for porcelain scripts.

> I don't think it is really worth it, though.
> All of that should be going to stderr, and thus would be, at worst,
> noise on the terminal. I don't think it is that hard or error-prone a
> rule to send such cruft to stderr.

on examining the code paths, there's a fair bit of work needed to
ensure this. Apart from transport.c (transport-helper.c and by
extension, remote helpers, looks ok), we would have to look at the
individual builtin-transport implementations for git and bundle.

Also, as you mentioned above, we would also have to take care future
transport implementations send messages in the desired fashion so that
we wouldn't break porcelain scripts. If we have an output scheme, then
such risks are minimized.

--=20
Cheers,
Ray Chuan
