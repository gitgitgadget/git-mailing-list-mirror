From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH 1/2] add a --delete option to git push
Date: Thu, 13 Aug 2009 23:24:05 -0700
Message-ID: <fabb9a1e0908132324td6869aydc752f67b95546f1@mail.gmail.com>
References: <1250226349-20397-1-git-send-email-srabbelier@gmail.com> 
	<1250226349-20397-2-git-send-email-srabbelier@gmail.com> <20090814052153.GA2881@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 14 08:24:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbqDK-0007MH-RW
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 08:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053AbZHNGY0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2009 02:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756031AbZHNGY0
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 02:24:26 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:45261 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755577AbZHNGYZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Aug 2009 02:24:25 -0400
Received: by ewy10 with SMTP id 10so1293050ewy.37
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 23:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=woZdeNIY1Ch86p93AjHW94DFOpbCBXatpD1CHdskOP8=;
        b=BaFzB1nteYpBIi6zHnnSazQ2d1ZAjaLV5eJKF5RwQ0o0B8YT7JB97yN1BXfUwDEM9f
         X9CVepFi+eJVuj0aBNmwGCr4FgjmfSXmyxDQYhfG4KYp7+51KcUeQHIb+xJUoOEzKtcq
         Y3NVAI9D7Uj5FYotRrRgjBvuBsyfxi44sQJLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=L1sPVyrBel1Bq7Uq/vyDboAh0Z2VsGCxoIEI+0EDlAGf9deQbHCYnrNAVhKUKZV8EB
         12UJCiWdV0MRt3I7uFq+ELGCg3vZTf8WfjfZm+QAhQfqphaOX0xLUX/UkbP7uP8orPTa
         ohSuv/ANI1NHkB2AxPi+Lv+z0J/R9jL6XpEQ4=
Received: by 10.216.70.205 with SMTP id p55mr341810wed.55.1250231065161; Thu, 
	13 Aug 2009 23:24:25 -0700 (PDT)
In-Reply-To: <20090814052153.GA2881@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125901>

Heya,

On Thu, Aug 13, 2009 at 22:21, Jeff King<peff@peff.net> wrote:
> On Thu, Aug 13, 2009 at 10:05:48PM -0700, Sverre Rabbelier wrote:
> From reading your patch, it looks like it just touches the command-li=
ne.
> I think that's the right thing to do, but I think it makes sense to
> think half a second to make sure.

Indeed, the reason I sent out this RFC was to gather more opinions :).

> And with the way you have it, "git push --delete" will silently ignor=
e
> the --delete and push configured refspecs. Probably it should say
> "--delete is useless without refspecs on the command line".

This makes sense, I will fix that.

>> =A0 =A0 Currently `git push --delete master:master` results in a som=
ewhat
>> =A0 =A0 cryptic error message. It seems unlikely however, that those=
 new
>> =A0 =A0 to git would use the 'old:new' notation, so I haven't bother=
ed
>> =A0 =A0 guarding against it and settled for documenting it.
>
> It seems like it would be simple enough to just check whether the
> refspec contains a colon; if so, silently leave it alone. That could
> also protect configured refspecs, as mentioned above, but I wouldn't
> rule out somebody have a single-name refspec in their config (in fact=
, I
> think "remote.$X.push =3D HEAD" is reasonable -- should that delete t=
he
> HEAD on "git push --delete"?).

I don't think we should touch any configured refspecs, think about how
often one would use that vs. the inconvenience of doing so
unintentionally.

>> +--delete::
>> + =A0 =A0Delete the specified refs. Prefixes all refs with ':' to te=
ll the
>> + =A0 =A0push machinery to delete the specified ref. As such, the re=
fs
>> + =A0 =A0that are to be deleted should not contain a ':' specifier.
>> +
>
> This impacts _all_ refspecs. Remember that we can have multiple refsp=
ecs
> on the command-line. So I can "move" a ref remotely with:

Correct, hence the plural 'refs'.

> =A0git push :old-name old-name:new-name
>
> but I can't do:
>
> =A0git push --delete old-name old-name:new-name

I don't think that's the use case for this option, it is mostly for
new users who do not know about the colon notation; now you do raise a
valid point that we might want to add a 'git push --rename old new' at
some point, but I think that's beyond the scope of this patch.


> So maybe it would make more sense for it to be "--delete <ref>" and
> impact only a single ref. The simple case of "git push --delete foo"
> would remain unchanged.

I thought about that, but I decided that it was both intuitive and
convenient to be able to delete multiple refs this way.

> The counter-argument is that "--delete" does not necessarily need to =
be
> as powerful as the ":ref" syntax, but I don't see the downside in mak=
ing
> it so.

I do, it's easy to make mistakes when it's more powerful, and I think
less intuitive. I think we want this to be as intuitive as possible.

I'm not very opinionated over any of this, if you have strong feelings
yourself please let me know and I'll change the patch.

--=20
Cheers,

Sverre Rabbelier
