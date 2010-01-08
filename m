From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3 5/6] transport-helper.c::push_refs(): ignore 
	helper-reported status if ref is not to be pushed
Date: Fri, 8 Jan 2010 09:04:45 +0800
Message-ID: <be6fef0d1001071704s3d3fd0a3wb9b46172a8e891d@mail.gmail.com>
References: <20091224154352.ecefd242.rctay89@gmail.com>
	 <20091224154258.08b4fe44.rctay89@gmail.com>
	 <20091224154158.15ba580f.rctay89@gmail.com>
	 <20091224154057.33611ae7.rctay89@gmail.com>
	 <20091224154005.a642c8ec.rctay89@gmail.com>
	 <20091224154445.ad4b7a01.rctay89@gmail.com>
	 <20100105063253.GA19368@coredump.intra.peff.net>
	 <20100105180113.6e0572dc.rctay89@gmail.com>
	 <20100106120456.GA7221@coredump.intra.peff.net>
	 <20100107054120.84972788.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 08 02:05:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT3I8-0001aV-20
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 02:05:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587Ab0AHBEs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2010 20:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754578Ab0AHBEr
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 20:04:47 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:34257 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576Ab0AHBEq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2010 20:04:46 -0500
Received: by iwn32 with SMTP id 32so2770545iwn.33
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 17:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XGpHeb3UTT10cz2kCcUm05twMwrY2u41IAFgyZk1QNE=;
        b=YsGr3MMdnmBMUwZN+iLp0CV7lVdDG9/ImeFlYtXVmmBzc/wXJHZ00bArc0PjrKJTN4
         hGwMmiLupwaeDTzeFdpst03bB88DsuBrRUztslgkbYnSg5GwndxQbxCmO2HNFw76EqMr
         dZzhpRnVpVnKbvwsGj6v8+ND9lSHAtQxhRnaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k+B7cN2A+c6CRsysB23ausl6ixtF1u12DrSsSQYzTm488iGFloMefRTAEld7W0GPxE
         1yyhMvAdRuBqGzvGlKI5e5zyDUyXzGE4eMaQmdDYjpHMlVLcrt1K35IDZS/hRZLRKDj+
         IiJ2aNgQc2+BURX+fxL1noAJ/PX/gLp7ryscM=
Received: by 10.231.170.201 with SMTP id e9mr2221464ibz.16.1262912685415; Thu, 
	07 Jan 2010 17:04:45 -0800 (PST)
In-Reply-To: <20100107054120.84972788.rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136403>

Hi,

On Thu, Jan 7, 2010 at 5:41 AM, Tay Ray Chuan <rctay89@gmail.com> wrote=
:
> Regarding this point, I now think that we should ignore the
> helper-reported status only if that status is none, and continue
> updating the ref status in the top-level transport if the helper did
> push successfully/failed, even if we didn't tell it to push:
>
> @@ -429,7 +429,7 @@ static int push_refs(struct transport *transport,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ref->status =3D status;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ref->remote_status =3D msg;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ref->status =3D=3D REF_STATUS_NONE)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ref->status =3D=3D REF_STATUS_NONE =
&& status =3D=3D REF_STATUS_NONE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ref->status =3D status=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ref->remote_status =3D=
 msg;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {

sorry for this broken hunk. I'll be re-sending shortly to make things c=
learer.

--=20
Cheers,
Ray Chuan
