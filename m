From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] git remote update: New option --prune (-p)
Date: Thu, 2 Apr 2009 16:17:35 +0200
Message-ID: <9b18b3110904020717h3a0d4b34h7f4b2b83527e6743@mail.gmail.com>
References: <20090402123823.GA1756@pvv.org>
	 <9b18b3110904020634i17633645ue4ba91701ea243a1@mail.gmail.com>
	 <20090402134414.GB26699@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 02 16:19:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpNlP-0000Fp-Vl
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 16:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757859AbZDBORj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Apr 2009 10:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755323AbZDBORj
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 10:17:39 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:44550 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757345AbZDBORi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2009 10:17:38 -0400
Received: by qw-out-2122.google.com with SMTP id 8so664949qwh.37
        for <git@vger.kernel.org>; Thu, 02 Apr 2009 07:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+OU1oSc03Iiy1PTSnc4hU/wBye1cwwx4s/IRbNRVRME=;
        b=apNNBS4vMvoEp4JSRGF2jEfJVTGe+19WnAm9mMiY0xEWIJgChfY5l57XYULJHblhCY
         vaKsnP4HJHgb8nmDPDgxMVKXAWQAVJ13IyIXnWKP8MpHl/mYwnyaMMRhWAfbLlpUhRgB
         JSSUYtNGTX946mACba2shCx4vZ7n4G5dBUdAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EoeEWqH2EdWIzChTjMih8sP11cHmWzSp6OsvPk1RFDwrkvm0N1y8PvAeF+DyOzoE6/
         +rQn/cYNPqbzi2ajsbOr+ua1Ml+TiqnuQLSvn3g75W841YT3pwmvdPpMxOqdqBg+EP/d
         5QRO066YKJGp8PaRx0Ptoz6wb6kywtUzxHPfo=
Received: by 10.231.19.72 with SMTP id z8mr16508iba.41.1238681855802; Thu, 02 
	Apr 2009 07:17:35 -0700 (PDT)
In-Reply-To: <20090402134414.GB26699@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115468>

2009/4/2 Jeff King <peff@peff.net>:
> On Thu, Apr 02, 2009 at 03:34:15PM +0200, demerphq wrote:
>
>> But one question. It seem to me odd to put this as an option to git
>> remote update, and not git remote prune.
>>
>> I mean, it seems weird that one must say:
>>
>> =A0 =A0git remote update --prune
>>
>> and one cannot say:
>>
>> =A0 =A0git remote prune --all
>
> But "git remote update" actually respects "remote groups", so it is n=
ot
> just "--all". I think what you want is "git remote prune <group>".

Are there any implicit groups defined, like "all-remotes" or
something? It seems less than desirable to have to define such a group
for an operation that IMO is pretty reasonable to expect to happen
regularly.

I personally haven't found any use for defining  remote groups yet to
be honest. Its a granularity of operation that hasnt served much
purpose for me yet. Although i could see it being useful in the
future.

Generally tho I either want to update and prune one remote only, with

   git fetch $remote; git prune $remote,

or i want to update and prune all with something like:

  git remote update; for r in $(git remote); do git remote prune $r; do=
ne;

This patch makes the latter better huffman encoded, but I'd kind of
expect both to be doable as single commands in terms of how often I
want to do them.

Maybe git fetch --prune would be a nice complement to this patch.

>> especially when there is a `git remote prune` already. It seems a bi=
t
>> counterintuitive to find pruning actions under "update", but not all
>> that strange to find an all "--all" option for the "prune" action.
>
> I think it makes sense under update as pruning is really just a
> different (and perhaps slightly more dangerous) form of update.
> Generally I would only want to run prune after having run update, so
> combining them makes sense from a workflow perspective.

Yeah, conceptually they approach the same point from different angles.

>
>> Although to me having both be allowed and mean the same thing also
>> makes sense.
>
> I think that would make sense, too.

And the solution that presents the least surprise to the most users.

Yves



--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
