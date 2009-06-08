From: Alexander Potashev <aspotashev@gmail.com>
Subject: Re: [PATCH v2 1/3] Introduce die_errno() that appends strerror(errno) 
	to die()
Date: Mon, 8 Jun 2009 19:35:55 +0400
Message-ID: <2325a7950906080835h6d6d2d28j2c7261f2296a3da6@mail.gmail.com>
References: <200906061509.15870.trast@student.ethz.ch>
	 <cover.1244299302.git.trast@student.ethz.ch>
	 <3672f22723a4c14c4a6d67278e9865424c0c68dc.1244299302.git.trast@student.ethz.ch>
	 <20090606221320.GB30064@coredump.intra.peff.net>
	 <2325a7950906070412k3a440558h35db7511cc390e4b@mail.gmail.com>
	 <7vzlck9e3j.fsf@alter.siamese.dyndns.org>
	 <20090608123608.GG13775@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>, Petr Baudis <pasky@suse.cz>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 17:36:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDgtJ-0000ai-AE
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 17:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633AbZFHPfz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2009 11:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754537AbZFHPfz
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 11:35:55 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:51900 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbZFHPfz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2009 11:35:55 -0400
Received: by bwz9 with SMTP id 9so3146874bwz.37
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 08:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dv9C/I5qPMbgvsBhYhJ1M+YGN63TEOyZzWbCnuc5m24=;
        b=bZ/f7weIrJe740Ldq88sScpdBGxv76CzGteISS8J5b2HRrTk7fji8OOk3oPMSE8Qvw
         ZtM+IWAjyaDrT+AZZkIfkGjBF5RqnyaSBdA0DymfbMvaDaDY6vw6Ql0pnL60rNP/R2JM
         UjJ+Y9ny3MKVta/spC7EbJz3Tjj1J6MWy66g0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=X3CivHGBfUBpYc9R+jZZevOveOMYFI8nmlAEvXLVuY0FVqZDJ9JSzESiFJo4S/nqpG
         IPH2agxOLpJ78iADAY+C/BYiA9O7RsrckIlkfnA1dUXLp9emZGpZYUkO8nlf/Mkkxubk
         2GXt/ng2mnRIjrLCem2hl8NmnbRCc/iTqx/D0=
Received: by 10.223.112.204 with SMTP id x12mr4327022fap.70.1244475355185; 
	Mon, 08 Jun 2009 08:35:55 -0700 (PDT)
In-Reply-To: <20090608123608.GG13775@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121081>

2009/6/8 Jeff King <peff@peff.net>:
> On Sun, Jun 07, 2009 at 09:57:04AM -0700, Junio C Hamano wrote:
>
>> > This breaks theoretical usage of custom format string in custom di=
e
>> > routines:
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 1. A custom die routine might not supp=
ort %s.
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 2. If the die routine adds a custom fo=
rmat specifier, vsnprintf
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 will fail.
>>
>> I do not think that flies even as a theory. =C2=A0The "custom" 39a3f=
5ea talks
>> about is more about "Instead of sending it to stderr, let's pop up a=
n info
>> window and give the message there" kind of customization.
>>
>> Existing die() that prints errno does so by giving strerror() to "%s=
", so
>> no matter how custom your die routine is, you must support '%s' for =
its
>> output to make sense to humans. =C2=A0If you "not support %s", then =
you will
>> ignore (or choke at) such strerror() result without this patch anywa=
y.
>
> More than that, you must support arbitrary printf format strings,
> because the die routine is passed whatever goes to die() (a quick gre=
p
> revealed that we use at least %u and %c at various points). So it is =
an
> undocumented requirement that the die routine process its parameters =
as
> if it were from the printf family.

Your last statement is not quite true. A custom die routine may
support all printf specifiers and some additional ones, but Thomas'
die_errno passes the format string (and arguments list) to vsnprintf
anyway, so the additional specifiers would be lost.

>
> I think what Thomas posted is fine.
>
> -Peff
>
