From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [RFC/PATCH 2/3] add a library of code for producing structured 
	output
Date: Sun, 11 Apr 2010 14:51:37 +0200
Message-ID: <g2z40aa078e1004110551s98e34b74w66c5bcc49538ca45@mail.gmail.com>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk>
	 <20100411113733.80010.3767.julian@quantumfyre.co.uk>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Eric Raymond <esr@thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sun Apr 11 14:51:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0wdi-0001Tr-Rv
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 14:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703Ab0DKMvj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 08:51:39 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:40392 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143Ab0DKMvi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 08:51:38 -0400
Received: by wwi17 with SMTP id 17so1662799wwi.19
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 05:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NstcIVGDULElUoKzJWxOY2Me46ujQYZo6b1uQWtHUsA=;
        b=apj0YBDco0pNlNV26UfhTL0bPKKwIIigkHa1n43zzcuFw6RFFrYVORQUFIEd82yEwN
         tgaMe22mQQ7uHmM8FLfNoD+AbskDunCuwO+lhr7400D9pHvgEORQziQU1BK/TaWhQIi1
         s5U/w8V3J9IaW+xdXfKPyqoUb1kX4ImjRwdOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=UB178hll0p8Zau2miuaLVV/VB0Ex53bSFmkzbQPZhVraFKbKVfTSMGn8xsfe7mg4km
         1Nm8rUIvV74i6Vb0qVMSPdoVVNBHgVvS3UEtofFiUQpTsg6tIBt44EI3n/n4CX2+jUnI
         cacWsntKtA+dWL5ObIiPtKK4TtnyxUQcD5DPc=
Received: by 10.216.73.8 with HTTP; Sun, 11 Apr 2010 05:51:37 -0700 (PDT)
In-Reply-To: <20100411113733.80010.3767.julian@quantumfyre.co.uk>
Received: by 10.216.88.11 with SMTP id z11mr1556206wee.116.1270990297141; Sun, 
	11 Apr 2010 05:51:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144646>

On Sun, Apr 11, 2010 at 1:37 PM, Julian Phillips
<julian@quantumfyre.co.uk> wrote:
> Add a library that allows commands to produce structured output in an=
y
> of a range of formats using a single API.
>
> The API includes an OPT_OUTPUT and handle_output_arg so that the
> option handling for different commands will be as similar as possible=
=2E
>
> At the moment JSON and XML output options are available - though the
> XML output is _very_ rudimentary.
>
> Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
> ---
> =A0Makefile =A0 =A0 =A0| =A0 =A03 +
> =A0output-json.c | =A0128 ++++++++++++++++++++++++++++++++++
> =A0output-xml.c =A0| =A0 68 ++++++++++++++++++
> =A0output.c =A0 =A0 =A0| =A0212 +++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++
> =A0output.h =A0 =A0 =A0| =A0 71 +++++++++++++++++++
> =A05 files changed, 482 insertions(+), 0 deletions(-)
> =A0create mode 100644 output-json.c
> =A0create mode 100644 output-xml.c
> =A0create mode 100644 output.c
> =A0create mode 100644 output.h
>
> diff --git a/Makefile b/Makefile
> index 910f471..4ba2a4f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -576,6 +576,9 @@ LIB_OBJS +=3D merge-recursive.o
> =A0LIB_OBJS +=3D name-hash.o
> =A0LIB_OBJS +=3D notes.o
> =A0LIB_OBJS +=3D object.o
> +LIB_OBJS +=3D output.o
> +LIB_OBJS +=3D output-json.o
> +LIB_OBJS +=3D output-xml.o
> =A0LIB_OBJS +=3D pack-check.o
> =A0LIB_OBJS +=3D pack-refs.o
> =A0LIB_OBJS +=3D pack-revindex.o
> diff --git a/output-json.c b/output-json.c
> new file mode 100644
> index 0000000..0eb66b2
> --- /dev/null
> +++ b/output-json.c
> @@ -0,0 +1,128 @@
> <snip>
> +
> +static void json_str(FILE *file, char *value)
> +{
> + =A0 =A0 =A0 char *quoted =3D json_quote(value);
> + =A0 =A0 =A0 fprintf(file, "\"%s\"", quoted);
> + =A0 =A0 =A0 free(quoted);
> +}
> +
> <snip>
> diff --git a/output-xml.c b/output-xml.c
> new file mode 100644
> index 0000000..50dd7d6
> --- /dev/null
> +++ b/output-xml.c
> @@ -0,0 +1,68 @@
> <snip>
> +
> +static void xml_str(FILE *file, char *value)
> +{
> + =A0 =A0 =A0 fprintf(file, "\"%s\"", value);
> +}
> +

Don't you need to quote this one, like you did in json_str()?

--=20
Erik "kusma" Faye-Lund
