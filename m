From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [PATCH 2/2] grep: don't call regexec() for fixed strings
Date: Mon, 12 Jan 2009 13:25:11 +0100
Message-ID: <237967ef0901120425x79b7c1a4p238081a99694ae23@mail.gmail.com>
References: <4967D8F8.9070508@lsrfire.ath.cx> <4967DB4A.2000702@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jan 12 13:27:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMLsN-0000cy-76
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 13:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbZALMZQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jan 2009 07:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbZALMZP
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 07:25:15 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:36740 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbZALMZN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 07:25:13 -0500
Received: by ewy10 with SMTP id 10so11468405ewy.13
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 04:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=P5aYlEgrFMWAhe2oWUEClpXp7K1rxcy6Hzy5eOBs8AM=;
        b=UKh5zQCGc8RzASVSkjByS95ikRaiNgsriARupBQtrz1FE6HXqthyFRbJNGUfaOH/Hj
         yfntfASGQvP+3Lb/6MOEkMfYOEg+bKBCpDMTR73Z+IKY3MkIoJh+N/mderKZDOqPbGdE
         clP9RfsQmhmFu1ud1j1UfWD1Zhtm8YF5ny+LQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YAz9b4pXmAavRd/72bsF/EtP8IhjgQUbyL3v9bs/aUYcgjQP07LqP9adEUBYwK0WXG
         9fOoiAYxmz0Nmaxge0Ye5VmkQR8SzUrZG31TwDc/yg7kpF4uz0YHEYFKgTtm702eEoib
         cSM24utymdYMddHomCbtb3pBeJYL1uFk8fWWM=
Received: by 10.210.131.6 with SMTP id e6mr34027028ebd.77.1231763111186; Mon, 
	12 Jan 2009 04:25:11 -0800 (PST)
In-Reply-To: <4967DB4A.2000702@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105336>

2009/1/10 Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>:
> Add the new flag "fixed" to struct grep_pat and set it if the pattern
> is doesn't contain any regex control characters in addition to if the
> flag -F/--fixed-strings was specified.
>
> diff --git a/grep.c b/grep.c
> index 394703b..a1092df 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -28,9 +28,31 @@ void append_grep_pattern(struct grep_opt *opt, con=
st char *pat,
>        p->next =3D NULL;
>  }
>
> +static int isregexspecial(int c)
> +{
> +       return isspecial(c) || c =3D=3D '$' || c =3D=3D '(' || c =3D=3D=
 ')' || c =3D=3D '+' ||
> +                              c =3D=3D '.' || c =3D=3D '^' || c =3D=3D=
 '{' || c =3D=3D '|';
> +}

Shouldn't this include '*' and '\'?

--=20
Mikael Magnusson
