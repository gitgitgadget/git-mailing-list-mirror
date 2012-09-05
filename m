From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2] fetch: align new ref summary printout in UTF-8 locales
Date: Wed, 05 Sep 2012 21:20:34 +0200
Message-ID: <5047A602.1020802@web.de>
References: <1346670609-19986-1-git-send-email-pclouds@gmail.com> <1346755175-31468-1-git-send-email-pclouds@gmail.com> <504796A5.4070700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?dG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 21:25:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9LEd-0005KK-7S
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 21:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759165Ab2IETZw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Sep 2012 15:25:52 -0400
Received: from mout.web.de ([212.227.15.3]:62970 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754669Ab2IETZv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 15:25:51 -0400
Received: from wanderer.site ([195.67.191.22]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MbhSP-1SqQrB2FL3-00JJsL; Wed, 05 Sep 2012 21:20:45
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120825 Thunderbird/15.0
In-Reply-To: <504796A5.4070700@gmail.com>
X-Provags-ID: V02:K0:FE7lb+u59rJ3pgOFMnixgadDwIst7ykTPKsPChwVW/Y
 xurNYcwtAWJWhP68H92SKSoZxwIb36BDAoR/AiNOezgx1t3Y7p
 E5jvqQBsHvKDvfOYPV8RfHEY2U9E0O6SyIgnHXaUdOIelOarlx
 PR2NZfc4EMB5GDlw7EgxGsZUbdqIiylEjhyvdTYou2bZVF5D9w
 Xecb7W7vUJi4is4YkEMIw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204840>

On 09/05/2012 08:15 PM, Torsten B=C3=B6gershausen wrote:
> On 04.09.12 12:39, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> +/* return the number of columns of string 's' in current locale */
>> +int gettext_width(const char *s)
>> +{
>> +	static int is_utf8 =3D -1;
>> +	if (is_utf8 =3D=3D -1)
>> +		is_utf8 =3D !strcmp(charset, "UTF-8");
>> +
>> +	return is_utf8 ? utf8_strwidth(s) : strlen(s);
>
> Will that work for non-ASCII encodings?
> For ISO-8859-x we can say strlen() =3D=3D strwidth(),
> but for other encodings using multibytes that doesn't work, does it?
(Sorry the message went out before completely written)
Something like that:

int gettext_width(const char *s) {
   static int is_utf8 =3D -1;

   if (is_utf8 =3D=3D -1)
     is_utf8 =3D !strcmp(charset, "UTF-8");

   if (is_utf8)
     return utf8_strwidth(s);
   else  {
     char *s_utf =3D reencode_string(s, "UTF-8", charset);
     if (s_utf) {
       witdh =3D utf8_strwidth(s_utf);
       free(s_utf);
     } else
       width =3D strlen(s);

     return width;
}
