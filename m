From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] fix potential infinite loop given large unsigned integer
Date: Sun, 9 Aug 2009 14:25:40 +0200
Message-ID: <40aa078e0908090525h7b4d6efeh658e2edcfbe16c7e@mail.gmail.com>
References: <a3f15ee60908082141l7b2134cg5ddcef17c45fc888@mail.gmail.com>
	 <7vy6pta4rd.fsf@alter.siamese.dyndns.org>
	 <7v3a81a13z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ryan Flynn <parseerror@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 14:25:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma7TC-0000ZN-LO
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 14:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbZHIMZm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Aug 2009 08:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752754AbZHIMZm
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 08:25:42 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:43340 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbZHIMZl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Aug 2009 08:25:41 -0400
Received: by qw-out-2122.google.com with SMTP id 8so972279qwh.37
        for <git@vger.kernel.org>; Sun, 09 Aug 2009 05:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pWSRgQ+fpG0pHnewypqxixGnNpoi6ge8dhboxablZgY=;
        b=SvyhwVVUfqsQqTGdvWgREp7o67+sMuG8+XpV2PqYxex56wOUUWBEV1mAJDsteoEiHB
         96eEzCn6maN5OVvjJA/Wva0fnEb/FY5Q9rwXMWWdw+bFDUEDp7BiG+NBSSBc/maGbMcH
         QX6z4/1c/nGgPNSwkt1sE5kzG4VtI23vWyZmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ctRU9IkEViqmDKXfAFrwvDoAHysX7vs6uAeErhe7KEJ+noRsxcoApK7wIgkQH5Ow49
         hblcuL8F3VuhIm1/Up5OQRWXkTZs8OKIGZ6ugR81fNdptWQD0HsdYFguEHtdy0iCnLwR
         t63w1El7hPdtAOYTvClOWRxr0/rG5Ogl7iEkE=
Received: by 10.224.37.136 with SMTP id x8mr2405403qad.232.1249820740855; Sun, 
	09 Aug 2009 05:25:40 -0700 (PDT)
In-Reply-To: <7v3a81a13z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125342>

On Sun, Aug 9, 2009 at 9:38 AM, Junio C Hamano<gitster@pobox.com> wrote=
:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 static char num_buf[64];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev.total =3D total + start_number - 1=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sprintf(num_buf, "%d", rev.total);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rev.num_width =3D strlen(num_buf);

how about
rev.num_width =3D (int)log10((double)rev.total) + 1;

hm?

log10() appears to be C99, but can be emulated on earlier C-versions by=
 doing
#define log10(x) (log(x) / log(10.0))

--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
