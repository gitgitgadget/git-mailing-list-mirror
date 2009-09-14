From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 14/17] Add ftruncate implementation for MSVC
Date: Mon, 14 Sep 2009 16:18:23 +0200
Message-ID: <81b0412b0909140718i7d2c4e3cpc96477f8374d80b4@mail.gmail.com>
References: <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com>
	 <1d699897d4163224ce22db9400569fab20547e9d.1252925290.git.mstormo@gmail.com>
	 <8da5dcea21ce49b3a57fd224c088785a9f98e867.1252925290.git.mstormo@gmail.com>
	 <a48108513bf13247ba9b42fd703ba679804e8d8a.1252925290.git.mstormo@gmail.com>
	 <aed24a7f9524c9872f8a2455cfc5dd8baf6c3c0b.1252925290.git.mstormo@gmail.com>
	 <4931b7ac3102ee259353fe6b3c5ceeb2a67c53ba.1252925290.git.mstormo@gmail.com>
	 <1b5c5e90392e813ffab4fd510b70e57903a451cc.1252925290.git.mstormo@gmail.com>
	 <cover.1252925290.git.mstormo@gmail.com>
	 <9c5670f92cd0b3b8b74dd2204698e9c45ad03c90.1252925290.git.mstormo@gmail.com>
	 <c95a367520435feec0833d2d0edc33d86cf939a8.1252925290.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 16:18:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnCO0-0001Hf-Mz
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 16:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbZINOSZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Sep 2009 10:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbZINOSY
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 10:18:24 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:44818 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbZINOSX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Sep 2009 10:18:23 -0400
Received: by bwz19 with SMTP id 19so2107246bwz.37
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 07:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WkPa7ouXqjoXtZr5VFakscO0hXZAXnqf2ELW8vjk+RU=;
        b=fvBmqECweNfBaVYlQPpLsMQI1lQz5hSBw5pV8SSp0VcSG1w3at5InkV+4kfSQGy80C
         NrbSTtUlD1+A7K307dtPJ+5TW+rXFTaz272Ho+ozaGlzcKsDKGGn1g5+6VcJokCeb5Ua
         vQTpHHlas6BX3pa+keRYopKry6pn8ulZMWzKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vpKLRAOpsl29SPq5Bg9SR2Ml/jt9POr9UST/+09KM5Op5OtaQLwKuIXlq/lCJpKV1D
         nqOdQ7fjwgYN3mfrlXe2RFMnFnwLWNRZIKSwcJ7bODC6DAjYhlPSZlUA3Y01+lF0ATYJ
         JFLOGASKyYj2Z3bQDYiro0dwMWfdJuxpuAcVI=
Received: by 10.204.15.16 with SMTP id i16mr5180423bka.72.1252937905975; Mon, 
	14 Sep 2009 07:18:25 -0700 (PDT)
In-Reply-To: <c95a367520435feec0833d2d0edc33d86cf939a8.1252925290.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128486>

On Mon, Sep 14, 2009 at 15:11, Marius Storm-Olsen <mstormo@gmail.com> w=
rote:
> +int ftruncate(int fd, __int64 length)
> +{
> + =C2=A0 =C2=A0 =C2=A0 HANDLE fh =3D (HANDLE)_get_osfhandle(fd);
> + =C2=A0 =C2=A0 =C2=A0 if (!fh || _lseeki64(fd, length, SEEK_SET))

According to MSDN, error is manifested by returning INVALID_HANDLE_VALU=
E (=E2=80=931):

http://msdn.microsoft.com/en-us/library/ks2530z6.aspx
