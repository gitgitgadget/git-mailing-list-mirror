From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Support comparing blobs (files) with different names
Date: Sat, 31 Mar 2007 18:16:04 +0200
Message-ID: <200703311816.05283.jnareb@gmail.com>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at> <20070328210301.GA57@auto.tuwien.ac.at> <200703310155.14452.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Sat Mar 31 23:50:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXlSs-0000ch-3C
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 23:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbXCaVuU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 31 Mar 2007 17:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbXCaVuU
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 17:50:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:28318 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbXCaVuS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 17:50:18 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1166079uga
        for <git@vger.kernel.org>; Sat, 31 Mar 2007 14:50:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Wn4FOzj3G8YgIjpAyAwvB0sAtOze32Sh16ZEU7cAy2wSOhHK0wskSGDKM5GpCuOW679xZnZHl5iPyynVSsIjQrauBmZMyiASG1rQBYRZvUPGDBbtAbrylAg88bkhqLB0PwszCr5Byp7adTOq1JVSTMhQkyWVSRyuKImVaVM0qUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=U2HG8TTEkA4cKFtx2jVsRJkT4F78NXX2qBCkXI9nUh2TIGRiN/xCY27FpVTtE2+wMi2LppIecGdW/rQx8INHXEsvlSdHqE7fhVPMq1aNZWN0dQf6CHFIu/iEszrFQr5cVgs/VdwajKM1fr0zEJbSVZ4PjTvFBmtnFguHzLlxZhQ=
Received: by 10.66.253.17 with SMTP id a17mr3042017ugi.1175377817101;
        Sat, 31 Mar 2007 14:50:17 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id w7sm13595673mue.2007.03.31.14.50.15;
        Sat, 31 Mar 2007 14:50:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200703310155.14452.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43572>

On Sat, Mar 31, 2007 at 01:55 +0200, Jakub Narebski wrote:
> On Wed, Mar 28, 2007, Martin Koegler wrote:
>=20
>> I created a blob with a "strange" filename: &()=3D!"=A7$%[<>]*#+_;.
>> In the result of the blob view, the " is not escaped in the filename=
 in the header
>> and a strange content type is returned:
>>=20
>> $ telnet localhost 80
>> Trying 127.0.0.1...
>> Connected to localhost.
>> Escape character is '^]'.
>> GET /gitweb/gitweb.cgi?p=3Dt/.git;a=3Dblob;f=3D%26()%3D%21%22%A7%24%=
25%5B%3C%3E%5D%2A%23%2B_%3B.;hb=3D7bfed2588bee66b33db544830606fa6606478=
fd9 HTTP/1.0
>>=20
>> HTTP/1.1 200 OK
>> Date: Wed, 28 Mar 2007 19:55:36 GMT
>> Server: Apache
>> Content-disposition: inline; filename=3D"&()=3D!"=C2=A7$%[<>]*#+_;."
>> Expires: Thu, 29 Mar 2007 19:55:39 GMT
>> Connection: close
>> Content-Type: application/vnd.mif
>>=20
>> xx
>=20
> There are two separate things.=20
>=20
> First is not escaped filename in HTTP header. There was some discussi=
on
> about this, and even patch by Luben Tuikov which added to_qtext=20
> subroutine to deal with escaping in HTTP (which has diferent rules th=
an
> escaping in HTML, or in HTML attributes)
>  * gitweb: using quotemeta
>    http://thread.gmane.org/gmane.comp.version-control.git/28050/
>  * [PATCH] gitweb: Convert Content-Disposition filenames into qtext
>    http://thread.gmane.org/gmane.comp.version-control.git/28437
> But the patch was newer accepted; either lost in the noise, or in lac=
k
> of summary to the discussion.

Junio, do you remember by chance why this patch was dropped?

> Second is detecting file as binary (for text files we always return
> HTML), and content type set. Gitweb checks mimetype of a file (based
> on extension, mainly) by default using /etc/mime.magic, and if it is
> neither text/* nor HTML images (png, jpg, gif) it uses "blobdiff_plai=
n"
> view. Perhaps instead of just calling git_blob_plain($mimetype) we
> should do a redirect (but then how to pass detected mimetype?). It lo=
oks
> like there is an error with mimetype detection: could you tell me the
> line with "application/vnd.mif" in your /etc/mime.types?


Unfortunately trying to find the source of this error failed (perhaps
due to name of file slightly changed by accident), and I get no errors.
WORKSFORME aka SAA#1 (Standard Answer of Admin #1: Works for me).

I use the following script to debug errors in gitweb:

-- >8 ------------------------------------
#!/bin/sh

export GATEWAY_INTERFACE=3D"CGI/1.1"
export HTTP_ACCEPT=3D"*/*"
export REQUEST_METHOD=3D"GET"
export QUERY_STRING=3D""$1""
export PATH_INFO=3D""$2""

ddd "/var/www/cgi-bin/gitweb/gitweb.cgi"
-- >8 ------------------------------------

--=20
Jakub Narebski
Poland
