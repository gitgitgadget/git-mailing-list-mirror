From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] xdiff-interface: allow consume function to quit early
 by returning non-zero
Date: Wed, 17 Aug 2011 09:26:06 +0700
Message-ID: <CACsJy8AYskdAvLViEjOCmxas2O=NVGWz-Pj6GQS42LZbKr1U_A@mail.gmail.com>
References: <1313376083-24713-1-git-send-email-pclouds@gmail.com> <7v39h2laxb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 04:26:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtVq6-0003yi-Bw
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 04:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133Ab1HQC0i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Aug 2011 22:26:38 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37309 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771Ab1HQC0h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2011 22:26:37 -0400
Received: by bke11 with SMTP id 11so367915bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 19:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=T9OOyghLsaMsJ/3G/JSwSPwVRQliKicqu38mbdAJmXI=;
        b=SKsOkKkwspCJGJv/7732tATZq3YYlg84h5Bi1sc7rK1KXTBKlzjXpy9aC/OZBzfcBN
         1Wwxj3UULR+Tllt89CTlZuk8Xhbj3S21j+K2naob/n9WZy1w7xI+fLPuaiG9TMUiW2Ju
         6hvEFEfSpPMnnzfPTKOGmu5MUwl3VcoBpHiaE=
Received: by 10.204.231.143 with SMTP id jq15mr151976bkb.227.1313547996132;
 Tue, 16 Aug 2011 19:26:36 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Tue, 16 Aug 2011 19:26:06 -0700 (PDT)
In-Reply-To: <7v39h2laxb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179498>

2011/8/16 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>
> What is this for? No explanation?

Um.. for stopping emitting diff when the consumer feels enough and
wants no more. Will update.

>> @@ -64,10 +64,12 @@ static void consume_one(void *priv_, char *s, un=
signed long size)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long this_=
size;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ep =3D memchr(s, '\=
n', size);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 this_size =3D (ep =3D=
=3D NULL) ? size : (ep - s + 1);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 priv->consume(priv->cons=
ume_callback_data, s, this_size);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (priv->consume(priv->=
consume_callback_data, s, this_size))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -1;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size -=3D this_size=
;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s +=3D this_size;
>> =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 return 0;
>> =C2=A0}
>
> Returning a negative value implies that this is an error condition. S=
hould
> all "non-zero" returns from ->consume necessarily be considered error=
?

Perhaps negative values only, like how xdiff treats it.
--=20
Duy
