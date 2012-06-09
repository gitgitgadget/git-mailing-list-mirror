From: nguyenhu@minatec.inpg.fr
Subject: Re: [PATCHv6 1/4] Read (but not write) from
 $XDG_CONFIG_HOME/git/config file
Date: Sat, 09 Jun 2012 12:53:36 +0200
Message-ID: <20120609125336.Horde.iUq0R3wdC4BP0yswpGlGBZA@webmail.minatec.grenoble-inp.fr>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <7vpq9aenl0.fsf@alter.siamese.dyndns.org>
 <20120608142601.Horde.Tq7UO3wdC4BP0e9ZGAy1EwA@webmail.minatec.grenoble-inp.fr>
 <7vvcj1dep7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu.Moy@grenoble-inp.fr,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 13:22:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdJjh-0002If-Fy
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 13:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840Ab2FILVh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Jun 2012 07:21:37 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:51908 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750884Ab2FILVg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jun 2012 07:21:36 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 04C3B1A340C;
	Sat,  9 Jun 2012 12:53:37 +0200 (CEST)
Received: from 183.24.91.79.rev.sfr.net (183.24.91.79.rev.sfr.net
 [79.91.24.183]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Sat, 09 Jun 2012 12:53:36 +0200
In-Reply-To: <7vvcj1dep7.fsf@alter.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199548>


Junio C Hamano <gitster@pobox.com> a =E9crit=A0:

>> char *mkpathdup(const char *fmt, ...)
>> {
>> 	char *path;
>> 	struct strbuf sb =3D STRBUF_INIT;
>> 	va_list args;
>>
>> 	va_start(args, fmt);
>> 	strbuf_vaddf(&sb, fmt, args);
>> 	va_end(args);
>> 	path =3D sb.buf;
>>
>> 	strbuf_release(&sb);
>> 	return xstrdup(cleanup_path(path));
>> }
>
> Modulo
>
> 	path =3D strbuf_detach(&sb, NULL);
>
> that is more or less what I meant.

So now the mkpathdup() function looks like:

char *mkpathdup(const char *fmt, ...)
{
	char *path;
	struct strbuf sb =3D STRBUF_INIT;
	va_list args;

	va_start(args, fmt);
	strbuf_vaddf(&sb, fmt, args);
	va_end(args);
	path =3D strbuf_detach(&sb, NULL);

	strbuf_release(&sb);
	return path;
}

This new variation of mkpathdup() function both fix the bug addressed
by commit 05bab3ea and avoid the use of bounded buffer.
