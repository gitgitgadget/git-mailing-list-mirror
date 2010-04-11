From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [RFC/PATCH 2/3] add a library of code for producing structured output
Date: Sun, 11 Apr 2010 14:03:38 +0100
Message-ID: <df8300572068e1da19ac8905a3ecaee4@212.159.54.234>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk> <20100411113733.80010.3767.julian@quantumfyre.co.uk> <g2z40aa078e1004110551s98e34b74w66c5bcc49538ca45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Eric Raymond <esr@thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>
To: <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 15:03:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0wpI-00053h-74
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 15:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891Ab0DKNDl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 09:03:41 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:35973 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751861Ab0DKNDk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 09:03:40 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 652EB819C6D7;
	Sun, 11 Apr 2010 14:03:33 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 1F3BD20CF47;
	Sun, 11 Apr 2010 14:03:39 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id b5hk-pe9VbSg; Sun, 11 Apr 2010 14:03:38 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id C9F1BA91DC;
	Sun, 11 Apr 2010 14:03:38 +0100 (BST)
In-Reply-To: <g2z40aa078e1004110551s98e34b74w66c5bcc49538ca45@mail.gmail.com>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144648>

On Sun, 11 Apr 2010 14:51:37 +0200, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
> On Sun, Apr 11, 2010 at 1:37 PM, Julian Phillips
> <julian@quantumfyre.co.uk> wrote:
>> Add a library that allows commands to produce structured output in a=
ny
>> of a range of formats using a single API.
>>
>> The API includes an OPT_OUTPUT and handle_output_arg so that the
>> option handling for different commands will be as similar as possibl=
e.
>>
>> At the moment JSON and XML output options are available - though the
>> XML output is _very_ rudimentary.
>>
>> Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
>> ---
>> =C2=A0Makefile =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A03 +
>> =C2=A0output-json.c | =C2=A0128 ++++++++++++++++++++++++++++++++++
>> =C2=A0output-xml.c =C2=A0| =C2=A0 68 ++++++++++++++++++
>> =C2=A0output.c =C2=A0 =C2=A0 =C2=A0| =C2=A0212
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0output.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 71 +++++++++++++++++++
>> =C2=A05 files changed, 482 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100644 output-json.c
>> =C2=A0create mode 100644 output-xml.c
>> =C2=A0create mode 100644 output.c
>> =C2=A0create mode 100644 output.h
>>
>> diff --git a/Makefile b/Makefile
>> index 910f471..4ba2a4f 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -576,6 +576,9 @@ LIB_OBJS +=3D merge-recursive.o
>> =C2=A0LIB_OBJS +=3D name-hash.o
>> =C2=A0LIB_OBJS +=3D notes.o
>> =C2=A0LIB_OBJS +=3D object.o
>> +LIB_OBJS +=3D output.o
>> +LIB_OBJS +=3D output-json.o
>> +LIB_OBJS +=3D output-xml.o
>> =C2=A0LIB_OBJS +=3D pack-check.o
>> =C2=A0LIB_OBJS +=3D pack-refs.o
>> =C2=A0LIB_OBJS +=3D pack-revindex.o
>> diff --git a/output-json.c b/output-json.c
>> new file mode 100644
>> index 0000000..0eb66b2
>> --- /dev/null
>> +++ b/output-json.c
>> @@ -0,0 +1,128 @@
>> <snip>
>> +
>> +static void json_str(FILE *file, char *value)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 char *quoted =3D json_quote(value);
>> + =C2=A0 =C2=A0 =C2=A0 fprintf(file, "\"%s\"", quoted);
>> + =C2=A0 =C2=A0 =C2=A0 free(quoted);
>> +}
>> +
>> <snip>
>> diff --git a/output-xml.c b/output-xml.c
>> new file mode 100644
>> index 0000000..50dd7d6
>> --- /dev/null
>> +++ b/output-xml.c
>> @@ -0,0 +1,68 @@
>> <snip>
>> +
>> +static void xml_str(FILE *file, char *value)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 fprintf(file, "\"%s\"", value);
>> +}
>> +
>=20
> Don't you need to quote this one, like you did in json_str()?

Yes.  That would be part of the reason for the "_very_" in the comment =
=2E..

As it stands the XML code is more of an example of a second output form=
at
than actually usable.  However, since I envision that the frontend/back=
end
API probably needs tweaking to accommodate backends other than JSON I
wanted to get at least one other backend going ...

--=20
Julian
