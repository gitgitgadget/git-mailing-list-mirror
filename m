From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v3] Add log.abbrevCommit config variable
Date: Tue, 17 May 2011 15:08:03 -0400
Message-ID: <BANLkTikW2Y0iAW6jiVMN9ifvTezY+iO+bg@mail.gmail.com>
References: <BANLkTi=og+e6JW8t+sCvkFJUnR=SrFtWGg@mail.gmail.com>
	<1305413341-56450-1-git-send-email-jaysoffian@gmail.com>
	<7vy625f9fc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 21:08:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMPcw-0002mk-6L
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 21:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756432Ab1EQTIH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 May 2011 15:08:07 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37780 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756428Ab1EQTID convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2011 15:08:03 -0400
Received: by pzk9 with SMTP id 9so367894pzk.19
        for <git@vger.kernel.org>; Tue, 17 May 2011 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=29QZD9SMNfUWpWynv+eLl8dW1ViLY+xi8Jx9aQRPvqY=;
        b=oabmxEs2ieyod2HXz2KkQyK2cBaoYy5Ba4nz14xHN89kvQtfozY8P+qwyDp+kQBSaT
         YfnbDu+4LqabqQRjVbvHWmCaE+89LscUC3AIEgX2i/H+pqA6UqiqGVRgLU9zVtrZHcje
         1XneRO9LlcrZtwhmvlxUWSJeZmm2yO0eIAqzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lVAvqK0g9OZQlvR+adVTmADsCTjE0aH1tsWc2UNQ80adQw+qZvK2XZDRC6ibDTpFsJ
         FjCwa+6hlq4QhCAIHYHQAF1VDdLgjyUKnxM/4n952fIvbcbAZWNu78EcO3/9nYKof8gN
         YH1LTAoWHERwWfm9shZ4J+uaEdQO13I+4s1T4=
Received: by 10.142.107.12 with SMTP id f12mr593923wfc.226.1305659283070; Tue,
 17 May 2011 12:08:03 -0700 (PDT)
Received: by 10.142.200.15 with HTTP; Tue, 17 May 2011 12:08:03 -0700 (PDT)
In-Reply-To: <7vy625f9fc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173819>

On Tue, May 17, 2011 at 2:50 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Care to explain why your check has to be different?

It doesn't. I thought through it poorly.

>=C2=A0If there is no reason
> to use a different logic, then a natural thing to do is to rewrite th=
e
> existing decoration logic and add yours like this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rev->pretty_given && rev->commit_forma=
t =3D=3D CMIT_FMT_RAW) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* "log --pret=
ty=3Draw" is special */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!decoratio=
n_given)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0decoration_style =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!abbrev_co=
mmit_given)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0rev->abbrev_commit =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}

It would be lovely if you could squash that in.

Thanks,

j.
