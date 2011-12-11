From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] Rename resolve_ref() to resolve_ref_unsafe()
Date: Sun, 11 Dec 2011 16:46:10 +0700
Message-ID: <CACsJy8DAjV+tczU5C17UqF4uv8MOBHx3_ZHBoJR59w_DdqVX3A@mail.gmail.com>
References: <1323521631-24320-1-git-send-email-pclouds@gmail.com>
 <1323521631-24320-3-git-send-email-pclouds@gmail.com> <20111210205519.GA24817@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Tony Wang <wwwjfy@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 11 10:47:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZfzs-0003bz-K8
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 10:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292Ab1LKJqn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Dec 2011 04:46:43 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55986 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab1LKJqn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Dec 2011 04:46:43 -0500
Received: by bkcjm19 with SMTP id jm19so451114bkc.19
        for <git@vger.kernel.org>; Sun, 11 Dec 2011 01:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mJixY362pHAFFDuLd5DrILicCgFUIcb43YqGLKagnGE=;
        b=k513mGM561Voh93wkZ5WyWP/gkRhOjxxmB8tupFvs+OKW9s2BK4o4ne6HF2aTcedfq
         nXyoNM7pLIwVMg1EZyoTri0I8mLuprwlZrxpKix9b9CVs9mtJogMqNRJUkMB7poN9amP
         TDIe2OdzD9WaF/usvbpjWnfEU3BNh0icR3Mzs=
Received: by 10.205.129.148 with SMTP id hi20mr7272648bkc.25.1323596801557;
 Sun, 11 Dec 2011 01:46:41 -0800 (PST)
Received: by 10.204.129.205 with HTTP; Sun, 11 Dec 2011 01:46:10 -0800 (PST)
In-Reply-To: <20111210205519.GA24817@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186801>

2011/12/11 Jonathan Nieder <jrnieder@gmail.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> resolve_ref() may return a pointer to a shared buffer and can be
>> overwritten by the next resolve_ref() calls. Callers need to
>> pay attention, not to keep the pointer when the next call happens.
> [...]
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -182,7 +182,7 @@ int validate_new_branchname(const char *name, st=
ruct strbuf *ref,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *head;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char sha1[=
20];
>>
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 head =3D resolve_ref("HE=
AD", sha1, 0, NULL);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 head =3D resolve_ref_uns=
afe("HEAD", sha1, 0, NULL);
>
> I wonder if it would make sense to have a separate function that
> maintains a shared buffer describing what HEAD resolves to, lazily
> loaded. =C2=A0Would invalidating the cache when appropriate be too fu=
ssy
> and subtle?

If we do not execute "git update-ref" from git binary (bisect does,
although on BISECT_HEAD, not HEAD) then it'd be safe to cache HEAD and
invalidate it in update_ref().
--=20
Duy
