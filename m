From: nguyenhu@minatec.inpg.fr
Subject: Re: [PATCHv6 1/4] Read (but not write) from
 $XDG_CONFIG_HOME/git/config file
Date: Fri, 08 Jun 2012 14:54:23 +0200
Message-ID: <20120608145423.Horde.qT2BG3wdC4BP0fX-GHdFAeA@webmail.minatec.grenoble-inp.fr>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <7vpq9aenl0.fsf@alter.siamese.dyndns.org>
 <20120608142601.Horde.Tq7UO3wdC4BP0e9ZGAy1EwA@webmail.minatec.grenoble-inp.fr>
 <CABPQNSbSVznFbnm=iy4HdZ4PDC70UfbrqvvSKx9moy+9AOk+Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 14:54:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scyhy-00084O-Qk
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 14:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039Ab2FHMy1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 08:54:27 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:42074 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751360Ab2FHMy0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2012 08:54:26 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 7F9051A02F1;
	Fri,  8 Jun 2012 14:54:23 +0200 (CEST)
Received: from wifi-030031.grenet.fr (wifi-030031.grenet.fr [130.190.30.31])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Fri, 08 Jun
 2012 14:54:23 +0200
In-Reply-To: <CABPQNSbSVznFbnm=iy4HdZ4PDC70UfbrqvvSKx9moy+9AOk+Rw@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199485>


Erik Faye-Lund <kusmabite@gmail.com> a =E9crit=A0:

>> char *mkpathdup(const char *fmt, ...)
>> {
>> =A0 =A0 =A0 =A0char *path;
>> =A0 =A0 =A0 =A0struct strbuf sb =3D STRBUF_INIT;
>> =A0 =A0 =A0 =A0va_list args;
>>
>> =A0 =A0 =A0 =A0va_start(args, fmt);
>> =A0 =A0 =A0 =A0strbuf_vaddf(&sb, fmt, args);
>> =A0 =A0 =A0 =A0va_end(args);
>> =A0 =A0 =A0 =A0path =3D sb.buf;
>>
>> =A0 =A0 =A0 =A0strbuf_release(&sb);
>> =A0 =A0 =A0 =A0return xstrdup(cleanup_path(path));
>>
>> }
>
> No, strbuf_release(&sb) frees 'sb.buf', causing 'path' to point to
> unallocated memory. You can fix that by doing something along these
> lines on top:
>
>  	va_end(args);
> -	path =3D sb.buf;
> +	path =3D xstrdup(cleanup_path(path));
>
>  	strbuf_release(&sb);
> -	return xstrdup(cleanup_path(path));
> +	return path;
>  }

You are right, but I think you rather mean this, no?

  	va_end(args);
-	path =3D sb.buf;
+	path =3D xstrdup(cleanup_path(sb.buf));

  	strbuf_release(&sb);
-	return xstrdup(cleanup_path(path));
+	return path;
  }
