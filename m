From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] string-list.h: Add STRING_LIST_INIT macro and make use of 
	it.
Date: Mon, 28 Jun 2010 10:29:49 +0200
Message-ID: <AANLkTim14fh1RRSoYFK5uIqi8OrkB2zHahInDpO80gws@mail.gmail.com>
References: <c4c9797a4cbea89f1f0fb0501e6a03912b598b17.1277595284.git.tfransosi@gmail.com>
	<de7ad1688930aa47515736885b7d8438118e7aa1.1277595923.git.tfransosi@gmail.com>
	<7vbpawifwa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org,
	jrnieder@gmail.com, srabbelier@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 28 10:30:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OT9j5-0006BJ-3o
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 10:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348Ab0F1I3v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jun 2010 04:29:51 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52865 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755000Ab0F1I3u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jun 2010 04:29:50 -0400
Received: by gwaa18 with SMTP id a18so1887076gwa.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 01:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=C9IYCoBPsmktjG8JSaUQiLxpOR2UO6SXXASnDUhIXns=;
        b=K8ft9XppNH7VieXzuMWP/F1fkzFZta8lTlGDg6noK40p6SCiiHRUbtPIMhz9l8mK9U
         tH84+/AdwCm537HMm2UMo+r95ZgociFJdGELnD1wiLJ4Vh1By+tZpROqoZQ42i4vdMmx
         2vONhj9wwwhxo2P9aug7vW56jZKWpcww9niuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VI+GrQLtqO3VTAA6786tRn5Xh62Z2/NIVVg1Nkg92s8ELj9JADvMdsNcKRnq08fSct
         fAixLY1dKioAifOYhvA1ZilwslrYXQsW40FhUT+P2WzuHh3i+UMgZKTtTPvMlGRwK6wK
         sQ5A2Te/2gwcPPsJNtxJ3g7q8r0ZR5Xyw4j1o=
Received: by 10.100.46.1 with SMTP id t1mr5963363ant.23.1277713789510; Mon, 28 
	Jun 2010 01:29:49 -0700 (PDT)
Received: by 10.101.49.20 with HTTP; Mon, 28 Jun 2010 01:29:49 -0700 (PDT)
In-Reply-To: <7vbpawifwa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149821>

On Sun, Jun 27, 2010 at 18:44, Junio C Hamano <gitster@pobox.com> wrote=
:
> I think you need the attached on top to be more complete.
>
> But I wonder if this is worth it (not this "more complete", but your
> patch). =C2=A0We convert 16 or so instances of initialization for "no=
 strdup"
> list, but there are about the same number of "strdup" instances still
> spelled out:
>
> =C2=A0 =C2=A0$ git grep -e 'struct string_list [^ ]* =3D {.*'
> =C2=A0 =C2=A0$ git grep -e 'struct string_list [^ ]* =3D {.*1'
>
> Wouldn't it be more sensible to use this instead?
>
> =C2=A0 =C2=A0#define STRING_LIST_INIT(pleasedup) { NULL, 0, 0, (pleas=
edup) }
>

This begs for using strdup(string-to-dup) in the macro argument, which
will not compile with ancient compilers which don't allow code in an
initializer.
