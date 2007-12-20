From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: Serious bug with pretty format strings & empty bodies?
Date: Thu, 20 Dec 2007 10:44:12 +0000
Message-ID: <57518fd10712200244o656c7f44j426cc71c89515de3@mail.gmail.com>
References: <57518fd10712190632o490af924n61326fddf1819014@mail.gmail.com>
	 <20071219184457.GC3015@steel.home>
	 <57518fd10712191437s6f192feds50d006fdfc624444@mail.gmail.com>
	 <4769A7FB.1070904@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Ren=E9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Dec 20 11:44:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5ItK-0005zV-Qw
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 11:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbXLTKoP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Dec 2007 05:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754367AbXLTKoP
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 05:44:15 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:40771 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216AbXLTKoN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Dec 2007 05:44:13 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2999225rvb.1
        for <git@vger.kernel.org>; Thu, 20 Dec 2007 02:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=ZAYEblvveXVyyfYy6DyZdub4zuKi+ijExaLLyHMqRQs=;
        b=AeR/clrIrFddCvuGmULpVgPIam9jgpMI2AeXVSTzfr7Kittat6dNAYkCh+FGPdpeoDPIcuVPGzSsHxGNUWkq2MGZez46+jwoTUfpat6Qb+vtkg46ypTG7uCKj2K5I8wSIrsm2UToji3M/hywviz8shgUYpC/6iqfdLNCS7Jj0Wo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=xG3pyVT0v65asOhWoRM3Rzx6MRXyMoQIGo4/C5+1Pnca5hgXHFJynm/oDCuOzjLfHDt79LHcSGycMWhaf/zZiPXAkKqcdbyivh9gybsh03PpaHogDiAzzvYNi9KWeCvwnjdnJhzhjqABR17zZtwA0icZYfo72f+betuk/VSiBEQ=
Received: by 10.141.26.6 with SMTP id d6mr3510262rvj.289.1198147452417;
        Thu, 20 Dec 2007 02:44:12 -0800 (PST)
Received: by 10.140.134.14 with HTTP; Thu, 20 Dec 2007 02:44:12 -0800 (PST)
In-Reply-To: <4769A7FB.1070904@lsrfire.ath.cx>
Content-Disposition: inline
X-Google-Sender-Auth: 7d63e4cd10a0f7d4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68989>

On Dec 19, 2007 11:23 PM, Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> =
wrote:
> Jonathan del Strother schrieb:
> > On Dec 19, 2007 6:44 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
> >> Could you try
> >>
> >>     git cat-file 18d2480ab689b483ef1ebbdb3f7420904049ba0b
> >>
> >> (or any other problematic commit) and post its output here?
> >
> > You mean git cat-file commit ... ?
> > I get the normal output, but the problematic commits don't show a
> > newline character at the end of the cat-file output.
>
> Just a shot in the dark: does this patch on top of master make a diff=
erence?
>
> diff --git a/pretty.c b/pretty.c
> index 9db75b4..5f95a59 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -412,7 +412,7 @@ static void parse_commit_header(struct format_com=
mit_context *context)
>                 if (i =3D=3D eol) {
>                         state++;
>                         /* strip empty lines */
> -                       while (msg[eol + 1] =3D=3D '\n')
> +                       while (msg[eol] =3D=3D '\n' && msg[eol + 1] =3D=
=3D '\n')
>                                 eol++;
>                 } else if (!prefixcmp(msg + i, "author ")) {
>                         context->author.off =3D i + 7;
>

No luck with that, I'm afraid.
