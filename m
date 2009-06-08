From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Expand the rename(2) workaround in mingw to cover case 
	change in filename
Date: Tue, 9 Jun 2009 00:08:09 +0200
Message-ID: <81b0412b0906081508v5435c59cm3faf3ac92a56578c@mail.gmail.com>
References: <20090608203248.GA22972@blimp.localdomain>
	 <alpine.DEB.1.00.0906082355350.26154@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 09 00:08:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDn1S-0003Cw-Nn
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 00:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756313AbZFHWIK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2009 18:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753962AbZFHWIJ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 18:08:09 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:63614 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756605AbZFHWII convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2009 18:08:08 -0400
Received: by bwz9 with SMTP id 9so3431854bwz.37
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 15:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=a1K7q0BdRWljk2yQIEhQKsU9ZbbUavL0LASIUZsnbpg=;
        b=x88DQgohucwEEv19++++/16TuGjUXsRno7/U/pKM4jXi7Pp1kkb39UiPgIxCfN75NG
         oU20ndI4rnuzdpiWw+PaXQGhrNN9DkWt4/dlATiIe4MOGbJd6ANF5sFXveQzkc6JFijf
         9YvXAKAq8tvDsLVk+FLBxyboi9O26F9E488T8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EfZNkZg25+D+cLNK7RDJY2v3fgXed2h9ro0cYJldb58CSbuJdPEZVYb09XrONJApon
         AqibU9MjWQ9cnMJqFmQR3WRkGytdITIlxpCl7SL2SKNF0mmiCa+gNv0ICJv9wD5l5M0P
         81t0Lp9CqypHkwmRcMrZ1fR0m7oC5wmxT/Oik=
Received: by 10.204.113.198 with SMTP id b6mr7122568bkq.108.1244498889057; 
	Mon, 08 Jun 2009 15:08:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0906082355350.26154@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121122>

2009/6/8 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> On Mon, 8 Jun 2009, Alex Riesen wrote:
>> NOT TESTED. Can't. My Windows broke again. Not even compile-tested.
>
> Yes, that is pretty easy to see as you first used pold/pnew and then
> src/dst.

Yep.

> I minimally fixed up your patch (it now uses strbuf), and added a
> test-case.
>
> This test-case is actually crucial: it shows that your patch is not
> enough: the culprit is this code in builtin-mv.c:167--168:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (lstat=
(dst, &st) =3D=3D 0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0bad =3D "destination exists";

Ah, thanks. Missed that completely.
