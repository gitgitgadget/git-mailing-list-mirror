From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] blame: prevent a segv when -L given start > EOF
Date: Mon, 8 Feb 2010 23:09:30 -0500
Message-ID: <76718491002082009u6a94d628ncf060820d427df7c@mail.gmail.com>
References: <1265687293-11168-1-git-send-email-jaysoffian@gmail.com>
	 <7vtytrrrju.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 05:09:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NehPu-0006fE-13
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 05:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013Ab0BIEJd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2010 23:09:33 -0500
Received: from mail-iw0-f182.google.com ([209.85.223.182]:59216 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab0BIEJc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2010 23:09:32 -0500
Received: by iwn12 with SMTP id 12so8171291iwn.26
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 20:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dd72yMJx7dpfH8qlhZ5b4NSxQavw7fnkQ1ebS0Lx5vM=;
        b=ofNnr3s5APLvtLT5VpMuzNx56iJ9byIiFFkfn0cixBkIQMr2ErFuZYWCZCbp0jJyaL
         VfU/spwEKq0dNCHObzjojHFHl5ktrDvUmC2efjFNbcJf9w5WAcr+e9Lp0c2cm+46zFzY
         zWd6vGsLE565nC6BhIQGuwXE42CPgL8oKpgu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iQX8uUHNU1vStpXe31fQmftejv+VVON+3B0ri4IiycOEg9MUDqumEVGHSj2Qcu1fUt
         KKBJUsnUXsih/B5T1SJqa4E3IdsZzSc/2rG7URQKK7ttmyZ/RTSte/mRfGNc5hYKL+vo
         vS4za71dHnUrhqd9+jyZeHfoyU1Nq7LCxws5k=
Received: by 10.231.145.69 with SMTP id c5mr1109945ibv.85.1265688570911; Mon, 
	08 Feb 2010 20:09:30 -0800 (PST)
In-Reply-To: <7vtytrrrju.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139361>

On Mon, Feb 8, 2010 at 10:55 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> - =C2=A0 =C2=A0 if (lno < top)
>> + =C2=A0 =C2=A0 if (lno < top || lno < bottom)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("file %s has on=
ly %lu lines", path, lno);
>
> Thanks; I think we make sure that "bottom < top" always hold true bef=
ore
> we reach this point, so checking with bottom alone should suffice, no=
?

Right, so given "-L 10" at the point of that check:

bottom =3D 0
top =3D 10

Whereas given "-L 10,100" at the point of that check:

bottom =3D 9
top =3D 100

So the code needs to check both.  Previously it made sure neither was
< 1, and swapped bottom/top if they were reversed.

Sorry for the confusion.

j.
