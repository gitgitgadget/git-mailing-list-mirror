From: Michele Marcionelli <michele.marcionelli@math.ethz.ch>
Subject: Re: push problem with anonymous access
Date: Mon, 4 Jul 2011 12:02:24 +0200
Message-ID: <27A41224-5E1E-4F32-8369-438E48432E60@math.ethz.ch>
References: <FCA17A33-EC1F-4649-9047-D8D56BE11D46@math.ethz.ch>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 04 12:08:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qdg55-0008QA-4J
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jul 2011 12:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757088Ab1GDKIh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jul 2011 06:08:37 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:42313 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754494Ab1GDKIg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2011 06:08:36 -0400
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jul 2011 06:08:36 EDT
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 4 Jul
 2011 12:02:25 +0200
Received: from fibonacci.math.ethz.ch (129.132.147.190) by mail.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 4 Jul
 2011 12:02:24 +0200
In-Reply-To: <FCA17A33-EC1F-4649-9047-D8D56BE11D46@math.ethz.ch>
X-Mailer: Apple Mail (2.1084)
X-Originating-IP: [129.132.147.190]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176593>

I found out something: with these 2 lines in "public_test.git/config":

[http]
    receivepack =3D true

Now I can push and the log files looks like this:
=3D=3D> /var/log/httpd/git-ssl.access_log <=3D=3D
129.132.147.190 - - [04/Jul/2011:11:26:57 +0200] "GET /git/math/public_=
test.git/info/refs?service=3Dgit-receive-pack HTTP/1.1" 200 153 "-" "gi=
t/1.7.5.4"
129.132.147.190 - - [04/Jul/2011:11:26:57 +0200] "POST /git/math/public=
_test.git/git-receive-pack HTTP/1.1" 406 - "-" "git/1.7.5.4"
129.132.147.190 - michele [04/Jul/2011:11:26:57 +0200] "POST /git/math/=
public_test.git/git-receive-pack HTTP/1.1" 200 52 "-" "git/1.7.5.4"
=3D=3D> /var/log/httpd/git-ssl.error_log <=3D=3D
[Mon Jul 04 11:26:57 2011] [error] [client 129.132.147.190] no acceptab=
le variant: /var/www/error/HTTP_UNAUTHORIZED.html.var

So 2 questions:
1) it is ok to set "receivepack =3D true"? It's not dangerous?
2) I still get an error 406 (see second line)... is that normal?
3) shouldn't somebody include this information in some official FAQ or =
in the man page of git-http-backend?

Regards,
Michele


On Jul 4, 2011, at 9:13 , Michele Marcionelli wrote:

> Hi Ray
>=20
> I tried as you suggested (even if to clone I don't need a password):
>=20
> $ git clone https://michele:******@git.math.ethz.ch/git/math/public_t=
est.git
> =3D=3D>
> Cloning into public_test...
> remote: Counting objects: 15, done.
> remote: Compressing objects: 100% (7/7), done.
> remote: Total 15 (delta 0), reused 0 (delta 0)
> Unpacking objects: 100% (15/15), done.
>=20
> And in the apache logs:
> 129.132.147.190 - - [04/Jul/2011:08:14:40 +0200] "GET /git/math/publi=
c_test.git/info/refs?service=3Dgit-upload-pack HTTP/1.1" 200 264 "-" "g=
it/1.7.5.4"
> 129.132.147.190 - - [04/Jul/2011:08:14:40 +0200] "POST /git/math/publ=
ic_test.git/git-upload-pack HTTP/1.1" 200 1688 "-" "git/1.7.5.4"
>=20
> But the when I push (and here is my problem):
> $ cd public_test
> $ echo foo >> TODO
> $ git commit TODO -m bar
> $ git push
> =3D=3D>
> error: Cannot access URL https://michele:******@git.math.ethz.ch/git/=
math/public_test.git/, return code 22
> fatal: git-http-push failed
>=20
> I get following in the apache logs:
>=20
> =3D=3D> /var/log/httpd/git-ssl.access_log <=3D=3D
> 129.132.147.190 - - [04/Jul/2011:08:17:45 +0200] "GET /git/math/publi=
c_test.git/info/refs?service=3Dgit-receive-pack HTTP/1.1" 403 - "-" "gi=
t/1.7.5.4"
> 129.132.147.190 - - [04/Jul/2011:08:17:45 +0200] "GET /git/math/publi=
c_test.git/info/refs HTTP/1.1" 200 59 "-" "git/1.7.5.4"
> =3D=3D> /var/log/httpd/git-ssl.error_log <=3D=3D
> [Mon Jul 04 08:17:45 2011] [error] [client 129.132.147.190] Service n=
ot enabled: 'receive-pack'
> =3D=3D> /var/log/httpd/git-ssl.access_log <=3D=3D
> 129.132.147.190 - - [04/Jul/2011:08:17:45 +0200] "GET /git/math/publi=
c_test.git/HEAD HTTP/1.1" 200 23 "-" "git/1.7.5.4"
> 129.132.147.190 - - [04/Jul/2011:08:17:46 +0200] "PROPFIND /git/math/=
public_test.git/ HTTP/1.1" 404 - "-" "git/1.7.5.4"
> =3D=3D> /var/log/httpd/git-ssl.error_log <=3D=3D
> [Mon Jul 04 08:17:46 2011] [error] [client 129.132.147.190] Request n=
ot supported: '/var/www/vhosts/git/root/math/public_test.git/'
>=20
>=20
> The problem that I see is that in the configuration (see also the "ma=
n git-http-backend") you have this
>=20
>    <LocationMatch "^/git/.*/git-receive-pack$">
>=20
> and "git push" do following request:
>=20
>    /git/whatever/info/refs?service=3Dgit-receive-pack
>=20
> which is not matched by the "LocationMarch".
>=20
> Thx, Michele
>=20
> PS: I'm not using WebDAV, since it is not documented in the man page.
>=20
>=20
> On Jul 2, 2011, at 17:19 , Tay Ray Chuan wrote:
>=20
>> On Sat, Jul 2, 2011 at 6:32 AM, Michele Marcionelli
>> <michele.marcionelli <at> math.ethz.ch> wrote:
>>> =3D=3D> /var/log/httpd/git-ssl.access_log <=3D=3D
>>> 85.1.201.213 - - [02/Jul/2011:00:13:32 +0200] "GET
>> /git/math/public_test.git/info/refs?service=3Dgit-receive-pack HTTP/=
1.1" 403 - "-" "git/1.7.5.4"
>>=20
>> Try
>>=20
>> $ git clone https://<user>:<pwd>@git.math.ethz.ch/git/math/public_te=
st.git
>>=20
>> or put it in ~/.netrc.
>>=20
>> --=20
>> Cheers,
>> Ray Chuan
>=20
> --
> Michele Marcionelli =B7 mm@ethz.ch =B7 +41 44 632 6193
> * Please consider the environment before printing
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
Michele Marcionelli =B7 mm@ethz.ch =B7 +41 44 632 6193
* Please consider the environment before printing
