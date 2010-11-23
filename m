From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2 5/6] msvc: opendir: handle paths ending with a slash
Date: Tue, 23 Nov 2010 20:48:44 +0100
Message-ID: <AANLkTimkPMCAmpobetAvWjcGDt+G_wMdX+cXaf9-Z_v9@mail.gmail.com>
References: <1290537509-360-1-git-send-email-kusmabite@gmail.com>
 <1290537509-360-6-git-send-email-kusmabite@gmail.com> <4CEC1677.6000207@lsrfire.ath.cx>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	gitster@pobox.com, jrnieder@gmail.com
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Nov 23 20:49:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKyrY-0002pc-Ut
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 20:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419Ab0KWTtH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 14:49:07 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46366 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab0KWTtG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 14:49:06 -0500
Received: by fxm13 with SMTP id 13so4226866fxm.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 11:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=AUjeNezgXV4DmRDisYmCMePIT1r99rdy7o+BXILEdLY=;
        b=boZZtV/TGgkapMf+vPwhUvKOs8O9wyARax523JhYsDSDvXgiXE1R9+ymYI90kfKDV8
         65v2HY76FTNDBLDS4GuD3CR9ZXK6ADc7c7ioqa+j5sQA8ZzwzvdCivXMCSQDNUXMymkl
         GGINVPQRjxKKWEts0l39HnCQ1LKQWuoQFAB7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=v21JCqU5VCj1xW+SwE4xMvL3lVd3FP/Vw4pHrA9NOS4M5e541jdzMI/j0TepwMZgRg
         GMXR7tQDefQEYv/Leb4kThSAkAVg7XKyeu2RSxg+AIkIUGQd59FNXXMuZF4KAcGZLzyG
         DL9lqmKtTrD0BlpsO6+AiVWNwQUPAYYGXcaK8=
Received: by 10.223.120.84 with SMTP id c20mr398576far.102.1290541744960; Tue,
 23 Nov 2010 11:49:04 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Tue, 23 Nov 2010 11:48:44 -0800 (PST)
In-Reply-To: <4CEC1677.6000207@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162015>

On Tue, Nov 23, 2010 at 8:31 PM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 23.11.2010 19:38, schrieb Erik Faye-Lund:
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>> ---
>> =A0compat/msvc.c | =A0 =A02 ++
>> =A01 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/compat/msvc.c b/compat/msvc.c
>> index 199eb22..fdbfb70 100644
>> --- a/compat/msvc.c
>> +++ b/compat/msvc.c
>> @@ -23,6 +23,8 @@ DIR *opendir(const char *name)
>>
>> =A0 =A0 =A0 /* check that the pattern won't be too long for FindFirs=
tFileA */
>> =A0 =A0 =A0 len =3D strlen(name);
>> + =A0 =A0 if (is_dir_sep(name[len - 1]))
>
> Perhaps extend this thus, and handle multiple slashes?
>
> =A0 =A0 =A0 =A0while (len > 0 && is_dir_sep(name[len - 1]))
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 len--;
>> =A0 =A0 =A0 if (len + 2 >=3D MAX_PATH) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 errno =3D ENAMETOOLONG;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;

Sure, it could be done. But the reason why I didn't do that myself was
that I got a bit worried about this being a slippery slope towards
full path-normalization. FindFirstFileA() does handle non-normalized
paths, as long as they are below MAX_PATH in length.

I just didn't want to add a slash if there was already one there,
which is something different than trying to fix the input-path.

In other words, I'm not entirely sure if fixing up such a case is a
task that belongs to opendir.
