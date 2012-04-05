From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Static gitweb content when using pathinfo
Date: Thu, 5 Apr 2012 23:14:09 +0200
Message-ID: <201204052314.10606.jnareb@gmail.com>
References: <4F7DA413.2020502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?q?Jos=E9_Mar=EDa_Escart=EDn_Esteban?= 
	<ripero84@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 23:14:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFu0X-00086R-P4
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 23:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755097Ab2DEVON convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Apr 2012 17:14:13 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:62820 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543Ab2DEVOM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 17:14:12 -0400
Received: by wibhj6 with SMTP id hj6so34697wib.1
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 14:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=6aiA41LclFreQCU07HhvdxMq27X471qYaw442JKY4VY=;
        b=LhFqiVDnqxvo8rbVGU9PtCeBQqV9YcNdfYiFOqOqgDCE+HP+i9EDADDQnMVtTaZKa6
         9RJO1Ir3JsPHdzWUc/DEtxYW0EGLpwsidzCzQlm//UP50t1xKTXdKIYtmiNZpek6MZ9E
         13SA/HLo7Vpd8VbbA2iuL/D9Du8ybDF4QBRutKZJ/98AiSeASt6dY/DIm+Epi6EFGcoR
         gfd/JLyS8S2LRVPHhDDZhdDHKXTXnloW1ZomtqvRz3mt5ZdRxvqbxf5Zy8TM4CU9e3Ir
         LDzL4Cqcox9e1+GhF5YKIpwcsNi9cbzfVzW4TOJ996kMa70jJwGPRFDJzS5D729hSo9S
         958A==
Received: by 10.216.133.234 with SMTP id q84mr2510488wei.102.1333660451321;
        Thu, 05 Apr 2012 14:14:11 -0700 (PDT)
Received: from [192.168.1.13] (acxc205.neoplus.adsl.tpnet.pl. [83.11.160.205])
        by mx.google.com with ESMTPS id 17sm1580097wis.0.2012.04.05.14.14.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 Apr 2012 14:14:09 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4F7DA413.2020502@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194812>

On Thu, 5 Apr 2012, Jos=E9 Mar=EDa Escart=EDn Esteban wrote:
> Hi,
>=20
> I'm running gitweb in a server.example.com/gitweb/ scenario.  If I do=
n't enable
> pathinfo everything works fine, but when I enable pathinfo the static=
 content
> stops showing up in the browser.
>=20
> I'm not an HTML or perl expert, but I think that this may be due to a=
 missing
> slash in the construction of the base tag:  Using the upstream script=
 I am getting
>=20
> <base href=3D"http://server.example.com/gitweb" />
>=20
> and no static content.  Once I tune the script to add a final slash t=
o the url
>=20
> <base href=3D"http://server.example.com/gitweb/" />
>=20
> the static content shows up again.
>=20
> Maybe I'm doing something wrong (am I?), and possibly this can be sol=
ved from
> the web server side, but maybe it also makes some sense to include in=
 the script
> some check that the url used in the base tag ends with a slash.  In t=
hat case,
> given my lack of perl skills, I would be really grateful if somebody =
implemented it.

How do you deploy gitweb, what is your web server configuration, and
what is the URL of main gitweb page (using placeholders like 'example.c=
om'
or 'foo')?

When I am running gitweb, it uses http://localhost/cgi-bin/gitweb/gitwe=
b.cgi
URL, and BASE element for path_info is

  <base href=3D"http://localhost/cgi-bin/gitweb/gitweb.cgi" />

Note that last component of 'href' attribute of base element is the
basename of script, which according to HTML 4.01[1] and RFC 3986[2]
is removed[3]

   o  return a string consisting of the reference's path component
      appended to all but the last segment of the base URI's path (i.e.=
,
      excluding any characters after the right-most "/" in the base URI
      path, or excluding the entire base URI path if it does not contai=
n
      any "/" characters).


There might be problem if you configured your web server to serve gitwe=
b
using it as a handler for subdirectory, so the script name does not nee=
d
to appear in URL, e.g.

  http://localhost/cgi-bin/gitweb

which would require the following base element

  <base href=3D"http://localhost/cgi-bin/gitweb/" />

Gitweb would have to distinguish those two cases somehow, and either ad=
d
or not add trailing slash '/'.

[1]: http://www.w3.org/TR/html401/struct/links.html#h-12.4
[2]: http://tools.ietf.org/html/rfc3986#section-5.2
[3]: http://tools.ietf.org/html/rfc3986#section-5.2.3

> Once I tune the script to add a final slash to the url
>=20
> <base href=3D"http://server.example.com/gitweb/" />
>=20
> the static content shows up again.

By "tune the script" do you mean editing gitweb.cgi, or adding setting
$base_url to gitweb configuration file, see gitweb.conf(5):

  $base_url
     Base  URL  for  relative  URLs  in  pages generated by gitweb, (e.=
g.
     $logo, $favicon, @stylesheets if they are relative URLs), needed a=
nd
     used  <base href=3D"$base_url"> only for URLs with nonempty PATH_I=
NFO.
     Usually gitweb sets its value correctly, and there is no need to s=
et
     this  variable,  e.g.  to $my_uri or "/". See $per_request_config =
if
     you need to override it anyway.

You can e.g. put

  $base_url .=3D '/' unless ($base_url =3D~ m!/$!);

in the gitweb configuration file to ensure that it ends with '/', whate=
ver
it is.

HTH
--=20
Jakub Narebski
Poland
