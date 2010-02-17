From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] Add `log.decorate' configuration variable.
Date: Wed, 17 Feb 2010 08:42:08 +0100
Message-ID: <36ca99e91002162342v2f151962p4d8f85f06c32205f@mail.gmail.com>
References: <alpine.LNX.2.00.1002171239430.2477@vqena.qenxr.bet.am>
	 <7vljespt2l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Drake <sdrake@xnet.co.nz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 08:42:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NheY5-0008Bk-OC
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 08:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934098Ab0BQHmM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2010 02:42:12 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:37584 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934047Ab0BQHmL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Feb 2010 02:42:11 -0500
Received: by fxm7 with SMTP id 7so8254182fxm.28
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 23:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xi85dPZfLjS3blf2qh1R42TC2jdoRxJeZ+XP9UIOwFA=;
        b=cKMlP+DSa3NHvQmuic3nPNn/7U5XvYm4MdJPlVWXXhBfsXxDsdgHrhwFVPFNIV/rRr
         gmRmZBqKY0+a9JkQTEtrVaUqjCf8vNf42nkXIn82QmZR01mQjHMPxYsvQFLFJf3b7uw8
         n9GABw3eJz3N7I3+XfoybKfHzNpPLAYIAjl9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NvatGKbRp6/l6otOsAzkW0z+c+qjI0mv2uciWr8MuLTA1+JGKjRihCiw7Y0Znmu/E/
         uvrZLk+foaPg2o6OSqpEp6RguPZjVi7FFTb56SsUumlykh8JpTK91s4ILwo9U+GnoTTS
         2Mkq20nJRwFXvNH/ygKlJsmuCYMCRieuYaIyg=
Received: by 10.223.65.12 with SMTP id g12mr6287026fai.69.1266392528615; Tue, 
	16 Feb 2010 23:42:08 -0800 (PST)
In-Reply-To: <7vljespt2l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140212>

On Wed, Feb 17, 2010 at 02:08, Junio C Hamano <gitster@pobox.com> wrote=
:
> diff --git a/config.c b/config.c
> index 6963fbe..6642d30 100644
> --- a/config.c
> +++ b/config.c
> @@ -322,9 +322,8 @@ unsigned long git_config_ulong(const char *name, =
const char *value)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
>
> -int git_config_bool_or_int(const char *name, const char *value, int =
*is_bool)
> +int git_config_maybe_bool(const char *name, const char *value)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 *is_bool =3D 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!value)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!*value)
> @@ -333,7 +332,14 @@ int git_config_bool_or_int(const char *name, con=
st char *value, int *is_bool)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcasecmp(value, "false") || !strcas=
ecmp(value, "no") || !strcasecmp(value, "off"))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> - =C2=A0 =C2=A0 =C2=A0 *is_bool =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 return -1;
> +}
> +
> +int git_config_bool_or_int(const char *name, const char *value, int =
*is_bool)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int v =3D git_config_maybe_bool(name, value);
> + =C2=A0 =C2=A0 =C2=A0 if (0 <=3D v)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return v;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return git_config_int(name, value);
> =C2=A0}
What happened with the is_bool parameter?

Bert
