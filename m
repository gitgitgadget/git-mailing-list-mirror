From: "Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>
Subject: RE: Trying to understand the web dav details
Date: Sun, 6 Jan 2013 04:49:57 +0000
Message-ID: <871B6C10EBEFE342A772D1159D1320853A011871@umechphj.easf.csd.disa.mil>
References: <151C51E6FBD848739A43A2C17D78DD68@black>
 <20130106041942.GB4879@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_00D6_01CDEB9E.D5D57A30"
To: 'git' <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 05:49:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TriB2-0005na-Uf
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 05:49:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945Ab3AFEtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 23:49:21 -0500
Received: from edge-mech.mail.mil ([214.21.82.9]:22952 "EHLO
	edge-mech.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818Ab3AFEtU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 23:49:20 -0500
Received: from UMECHPIA.easf.csd.disa.mil (214.21.83.149) by
 umechpid.easf.csd.disa.mil (214.21.82.9) with Microsoft SMTP Server (TLS) id
 14.2.309.2; Sun, 6 Jan 2013 04:49:58 +0000
Received: from UMECHPHJ.easf.csd.disa.mil ([169.254.5.12]) by
 UMECHPIA.easf.csd.disa.mil ([214.21.83.149]) with mapi id 14.02.0309.003;
 Sun, 6 Jan 2013 04:49:58 +0000
Thread-Topic: Trying to understand the web dav details
Thread-Index: Ac3rraUwukeVcQcNR7e4aJWGHuRM1wAF2ekAAAC77RA=
In-Reply-To: <20130106041942.GB4879@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [214.21.83.188]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212750>

------=_NextPart_000_00D6_01CDEB9E.D5D57A30
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Jeff King
> Sent: Saturday, January 05, 2013 11:20 PM
>=20
> On Sat, Jan 05, 2013 at 08:32:09PM -0500, Jason Pyeron wrote:
>=20
> > When doing a clone by https (reverse proxied to http) the first
> request is
> >
> > GET /git/project/info/refs?service=3Dgit-upload-pack
> >
> > How does the ?service=3Dxxxx get translated in to the action =
performed
> on the web
> > server?
>=20
> If you are using the git-http-backend CGI, it will interpret the
> service

No, using plain jane http and webdav. This server is not "allowed" to =
use cgi processes.

> tag and start smart-http. See "git help http-backend" for details on
> plugging it into Apache.
>=20
> Cloning/fetching does not use DAV at all; it is only for non-smart
> pushing (and I would not recommend setting it up; the smart protocol
> spoken by git-http-backend does pushing much more efficiently, and is
> better maintained).
>=20
> > I ask because I have 2 projects, one works the other does not.

Should have said I get a 404 versus 200, see below.

> >
> > I am using httpd-2.0.52-49.ent.centos4 and git-1.7.9.6-1.
> >
> > I am not even sure what to tell more about or where to look next.
>=20
> If you haven't set up git-http-backend, then git is just going to =
fetch
> the remote repo's data directly over http. So the usual advice for
> accessing something via http would apply (check the server's access =
and
> error logs, try hitting it with a web browser, etc).
>=20
> If you set GIT_CURL_VERBOSE=3D1 in your environment, git will spew a =
lot

That=E2=80=99s what I did before mailing out the first time. I tried to =
summarize the contents, but I will paste the relevant portions below.

> of debugging information about what http requests it is making. That
> might give you a clue (you haven't said anything about what does not
> work, so I can't be more specific).

Below are two traces, the first one is the one that does not work, the =
second does. I cannot see any differences on the web server for the two =
directory trees.

*************************************************************************=
*
*************************************************************************=
*
*************************************************************************=
*
*************************************************************************=
*

jason.pyeron@localhost ~/tmp
$ GIT_TRACE=3D1 GIT_CURL_VERBOSE=3D1 git clone =
https://server/git/project-x
trace: built-in: git 'clone' 'https://server/git/project-x'
Cloning into 'project-x'...
trace: run_command: 'git-remote-https' 'origin' =
'https://server/git/project-x'
* Couldn't find host server in the .netrc file; using defaults
* About to connect() to proxy 214.36.0.135 port 8080 (#0)
*   Trying 214.36.0.135...
* 0x80076a48 is at send pipe head!
* STATE: CONNECT =3D> WAITCONNECT handle 0x8007f3c0; (connection #0)
* Connected to 214.36.0.135 (214.36.0.135) port 8080 (#0)
* Connected to 214.36.0.135 (214.36.0.135) port 8080 (#0)
* Establish HTTP proxy tunnel to server:443
> CONNECT server:443 HTTP/1.1
Host: server:443
User-Agent: git/1.7.9
Proxy-Connection: Keep-Alive
Pragma: no-cache

* STATE: WAITCONNECT =3D> WAITPROXYCONNECT handle 0x8007f3c0; =
(connection #0)
* Multi mode finished polling for response from proxy CONNECT
< HTTP/1.1 200 Connection established
<
* Proxy replied OK to CONNECT request
* successfully set certificate verify locations:
*   CAfile: /usr/ssl/certs/ca-bundle.crt
  CApath: none
* STATE: WAITPROXYCONNECT =3D> WAITCONNECT handle 0x8007f3c0; =
(connection #0)
* STATE: WAITCONNECT =3D> PROTOCONNECT handle 0x8007f3c0; (connection =
#0)
* SSL connection using DHE-RSA-AES256-SHA
* Server certificate:
*        subject: C=3DUS; ST=3DMaryland; O=3DPD Inc; OU=3DIntranet; =
CN=3Dserver; emailAddress=3Dsecurity@pdinc.us
*        start date: 201
*        expire date: 201
*        issuer: C=3DU
*        SSL certificate verify result: self signed certificate in =
certificate chain (19), continuing anyway.
* STATE: PROTOCONNECT =3D> DO handle 0x8007f3c0; (connection #0)
> GET /git/project-x/info/refs?service=3Dgit-upload-pack HTTP/1.1
User-Agent: git/1.7.9
Host: server
Accept: */*
Pragma: no-cache

* STATE: DO =3D> DO_DONE handle 0x8007f3c0; (connection #0)
* STATE: DO_DONE =3D> WAITPERFORM handle 0x8007f3c0; (connection #0)
* STATE: WAITPERFORM =3D> PERFORM handle 0x8007f3c0; (connection #0)
* additional stuff not fine =
/usr/src/ports/curl/curl-7.27.0-1/src/curl-7.27.0/lib/transfer.c:1037: 0 =
0
* additional stuff not fine =
/usr/src/ports/curl/curl-7.27.0-1/src/curl-7.27.0/lib/transfer.c:1037: 0 =
0
* The requested URL returned error: 404 Not Found
* Closing connection #0
* Couldn't find host server in the .netrc file; using defaults
* About to connect() to proxy 214.36.0.135 port 8080 (#0)
*   Trying 214.36.0.135...
* 0x80076a48 is at send pipe head!
* STATE: CONNECT =3D> WAITCONNECT handle 0x80139640; (connection #0)
* Connected to 214.36.0.135 (214.36.0.135) port 8080 (#0)
* Connected to 214.36.0.135 (214.36.0.135) port 8080 (#0)
* Establish HTTP proxy tunnel to server:443
> CONNECT server:443 HTTP/1.1
Host: server:443
User-Agent: git/1.7.9
Proxy-Connection: Keep-Alive
Pragma: no-cache

* STATE: WAITCONNECT =3D> WAITPROXYCONNECT handle 0x80139640; =
(connection #0)
* Multi mode finished polling for response from proxy CONNECT
< HTTP/1.1 200 Connection established
<
* Proxy replied OK to CONNECT request
* successfully set certificate verify locations:
*   CAfile: /usr/ssl/certs/ca-bundle.crt
  CApath: none
* SSL re-using session ID
* STATE: WAITPROXYCONNECT =3D> WAITCONNECT handle 0x80139640; =
(connection #0)
* STATE: WAITCONNECT =3D> PROTOCONNECT handle 0x80139640; (connection =
#0)
* SSL connection using DHE-RSA-AES256-SHA
* Server certificate:
*        subject: C=3DUS; ST=3DMaryland; O=3DPD Inc; OU=3DIntranet; =
CN=3Dserver; emailAddress=3Dsecurity@pdinc.us
*        start date: 201
*        expire date: 201
*        issuer: C=3DU
*        SSL certificate verify result: self signed certificate in =
certificate chain (19), continuing anyway.
* STATE: PROTOCONNECT =3D> DO handle 0x80139640; (connection #0)
> GET /git/project-x/info/refs HTTP/1.1
User-Agent: git/1.7.9
Host: server
Accept: */*
Pragma: no-cache

* STATE: DO =3D> DO_DONE handle 0x80139640; (connection #0)
* STATE: DO_DONE =3D> WAITPERFORM handle 0x80139640; (connection #0)
* STATE: WAITPERFORM =3D> PERFORM handle 0x80139640; (connection #0)
* additional stuff not fine =
/usr/src/ports/curl/curl-7.27.0-1/src/curl-7.27.0/lib/transfer.c:1037: 0 =
0
* additional stuff not fine =
/usr/src/ports/curl/curl-7.27.0-1/src/curl-7.27.0/lib/transfer.c:1037: 0 =
0
* additional stuff not fine =
/usr/src/ports/curl/curl-7.27.0-1/src/curl-7.27.0/lib/transfer.c:1037: 0 =
0
* additional stuff not fine =
/usr/src/ports/curl/curl-7.27.0-1/src/curl-7.27.0/lib/transfer.c:1037: 0 =
0
* additional stuff not fine =
/usr/src/ports/curl/curl-7.27.0-1/src/curl-7.27.0/lib/transfer.c:1037: 0 =
0
* The requested URL returned error: 404 Not Found
* Closing connection #0
fatal: https://server/git/project-x/info/refs not found: did you run git =
update-server-info on the server?

*************************************************************************=
*
*************************************************************************=
*
*************************************************************************=
*
*************************************************************************=
*

jason.pyeron@localhost ~/tmp
$ GIT_TRACE=3D1 GIT_CURL_VERBOSE=3D1 git clone https://server/git/test
trace: built-in: git 'clone' 'https://server/git/test'
Cloning into 'test'...
trace: run_command: 'git-remote-https' 'origin' =
'https://server/git/test'
* Couldn't find host server in the .netrc file; using defaults
* About to connect() to proxy 214.36.0.135 port 8080 (#0)
*   Trying 214.36.0.135...
* 0x80076968 is at send pipe head!
* STATE: CONNECT =3D> WAITCONNECT handle 0x8007f2c8; (connection #0)
* Connected to 214.36.0.135 (214.36.0.135) port 8080 (#0)
* Connected to 214.36.0.135 (214.36.0.135) port 8080 (#0)
* Establish HTTP proxy tunnel to server:443
> CONNECT server:443 HTTP/1.1
Host: server:443
User-Agent: git/1.7.9
Proxy-Connection: Keep-Alive
Pragma: no-cache

* STATE: WAITCONNECT =3D> WAITPROXYCONNECT handle 0x8007f2c8; =
(connection #0)
* Multi mode finished polling for response from proxy CONNECT
< HTTP/1.1 200 Connection established
<
* Proxy replied OK to CONNECT request
* successfully set certificate verify locations:
*   CAfile: /usr/ssl/certs/ca-bundle.crt
  CApath: none
* STATE: WAITPROXYCONNECT =3D> WAITCONNECT handle 0x8007f2c8; =
(connection #0)
* STATE: WAITCONNECT =3D> PROTOCONNECT handle 0x8007f2c8; (connection =
#0)
* SSL connection using DHE-RSA-AES256-SHA
* Server certificate:
*        subject: C=3DUS; ST=3DMaryland; O=3DPD Inc; OU=3DIntranet; =
CN=3Dserver; emailAddress=3Dsecurity@pdinc.us
*        start date: 201
*        expire date: 201
*        issuer: C=3DU
*        SSL certificate verify result: self signed certificate in =
certificate chain (19), continuing anyway.
* STATE: PROTOCONNECT =3D> DO handle 0x8007f2c8; (connection #0)
> GET /git/test/info/refs?service=3Dgit-upload-pack HTTP/1.1
User-Agent: git/1.7.9
Host: server
Accept: */*
Pragma: no-cache

* STATE: DO =3D> DO_DONE handle 0x8007f2c8; (connection #0)
* STATE: DO_DONE =3D> WAITPERFORM handle 0x8007f2c8; (connection #0)
* STATE: WAITPERFORM =3D> PERFORM handle 0x8007f2c8; (connection #0)
* additional stuff not fine =
/usr/src/ports/curl/curl-7.27.0-1/src/curl-7.27.0/lib/transfer.c:1037: 0 =
0
* additional stuff not fine =
/usr/src/ports/curl/curl-7.27.0-1/src/curl-7.27.0/lib/transfer.c:1037: 0 =
0
* HTTP 1.1 or later with persistent connection, pipelining supported
< HTTP/1.1 200 OK
< Date: Sun, 06 Jan 2013 04:26:14 GMT
< Server: Apache/2.0.52 (CentOS)
< Last-Modified: Fri, 02 Nov 2012 05:05:55 GMT
< ETag: "714064-3b-172852c0"
< Accept-Ranges: bytes
< Content-Length: 59
< Content-Type: text/plain; charset=3DUTF-8
< Connection: close
<
* STATE: PERFORM =3D> DONE handle 0x8007f2c8; (connection #0)
* Closing connection #0
* Couldn't find host server in the .netrc file; using defaults
* About to connect() to proxy 214.36.0.135 port 8080 (#0)
*   Trying 214.36.0.135...
* 0x80076968 is at send pipe head!
* STATE: CONNECT =3D> WAITCONNECT handle 0x801395e8; (connection #0)
* Connected to 214.36.0.135 (214.36.0.135) port 8080 (#0)
* Connected to 214.36.0.135 (214.36.0.135) port 8080 (#0)
* Establish HTTP proxy tunnel to server:443
> CONNECT server:443 HTTP/1.1
Host: server:443
User-Agent: git/1.7.9
Proxy-Connection: Keep-Alive
Pragma: no-cache

* STATE: WAITCONNECT =3D> WAITPROXYCONNECT handle 0x801395e8; =
(connection #0)
* Multi mode finished polling for response from proxy CONNECT
< HTTP/1.1 200 Connection established
<
* Proxy replied OK to CONNECT request
* successfully set certificate verify locations:
*   CAfile: /usr/ssl/certs/ca-bundle.crt
  CApath: none
* SSL re-using session ID
* STATE: WAITPROXYCONNECT =3D> WAITCONNECT handle 0x801395e8; =
(connection #0)
* STATE: WAITCONNECT =3D> PROTOCONNECT handle 0x801395e8; (connection =
#0)
* SSL connection using DHE-RSA-AES256-SHA
* Server certificate:
*        subject: C=3DUS; ST=3DMaryland; O=3DPD Inc; OU=3DIntranet; =
CN=3Dserver; emailAddress=3Dsecurity@pdinc.us
*        start date: 201
*        expire date: 201
*        issuer: C=3DU
*        SSL certificate verify result: self signed certificate in =
certificate chain (19), continuing anyway.
* STATE: PROTOCONNECT =3D> DO handle 0x801395e8; (connection #0)
> GET /git/test/HEAD HTTP/1.1

------=_NextPart_000_00D6_01CDEB9E.D5D57A30
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
GDAWBgNVBAMTD0RPRCBFTUFJTCBDQS0zMDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AOYpItQUJtGYGlJexYSDc37BYLOz0JS+/RyUVb/2hCybycB0c+/MwpnymcltyhTTdP++EPL3Lb/L
uwaj7phQQWUB4VcstsvkyhysflI0DrGOByY+MjWvo2EKxeUIthJ5jFTBeunxUB9dgzpnMLMp2x06
TDkhUNgYLI0Gde5jcnhorWKcdaSUBtMyaxKvBgcpvhOgwKfwJU+3/h+3V+AYEo0hahW5WlT7d2XY
TD/1ujzAN+EGfsK+niOMKNGa18ZnONdzyb0HHYVv1ZUKmtzaOk4o8KXrCd/l2wvNR6+KzbtvlEDj
WZxQn8kOqXECudzpaYA6iTtFBSIYBYS1EvA8wIECAwEAAaOCAhwwggIYMA4GA1UdDwEB/wQEAwIB
hjAfBgNVHSMEGDAWgBRJdLsMXrp6/gJU73ugxpXGCYBwljAdBgNVHQ4EFgQUNWFmKAm8ViVbi8y/
gV5hLDA50yEwEgYDVR0TAQH/BAgwBgEB/wIBADAMBgNVHSQEBTADgAEAMGYGA1UdIARfMF0wCwYJ
YIZIAWUCAQsFMAsGCWCGSAFlAgELCTALBglghkgBZQIBCxEwCwYJYIZIAWUCAQsSMAsGCWCGSAFl
AgELEzAMBgpghkgBZQMCAQMaMAwGCmCGSAFlAwIBAxswNwYDVR0fBDAwLjAsoCqgKIYmaHR0cDov
L2NybC5kaXNhLm1pbC9jcmwvRE9EUk9PVENBMi5jcmwwggEBBggrBgEFBQcBAQSB9DCB8TA6Bggr
BgEFBQcwAoYuaHR0cDovL2NybC5kaXNhLm1pbC9pc3N1ZWR0by9ET0RST09UQ0EyX0lULnA3YzAg
BggrBgEFBQcwAYYUaHR0cDovL29jc3AuZGlzYS5taWwwgZAGCCsGAQUFBzAChoGDbGRhcDovL2Ny
bC5nZHMuZGlzYS5taWwvY24lM2REb0QlMjBSb290JTIwQ0ElMjAyJTJjb3UlM2RQS0klMmNvdSUz
ZERvRCUyY28lM2RVLlMuJTIwR292ZXJubWVudCUyY2MlM2RVUz9jcm9zc0NlcnRpZmljYXRlUGFp
cjtiaW5hcnkwDQYJKoZIhvcNAQEFBQADggEBAAqIVhylVyZaYst10N2GxVLiL/O8EWQ/jC8+EfyY
YEDygA0ogppo/uBISyfTOgp7lfYDDIEUkUI6YGziK1Mt7N8RrvVUF/AB+ZcHp5urC9usl4kJxu/5
BzQWAKh+EVOefC+hOKKZeTk0QW59uFgwVoie5KpkRdmgRGI6t+Ux05GA8RsQsmdw1VurWbRaSBZC
xAJM2mxoylAdMb43mcfPU8xCKVbDnRfKA+cQWvE5PBzM+xuXCibzMd/gq1wknZ7eOH0CUWdG+ZNw
he0KVcL0wWhanwjJHXubdtxU7zmMGOUMRO73BrIf9cvmDr3Uof/U+ZEHIlJ5t8D97LL4hfRE+1wx
ggMyMIIDLgIBATBkMF0xCzAJBgNVBAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAK
BgNVBAsTA0RvRDEMMAoGA1UECxMDUEtJMRgwFgYDVQQDEw9ET0QgRU1BSUwgQ0EtMzACAyLbDjAJ
BgUrDgMCGgUAoIIBozAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0x
MzAxMDYwNDQ2MDhaMCMGCSqGSIb3DQEJBDEWBBT8wcor5NNIyD+JkBWRvFSL44dQNjBYBgkqhkiG
9w0BCQ8xSzBJMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBggqhkiG9w0D
AgIBKDAHBgUrDgMCGjAKBggqhkiG9w0CBTBzBgkrBgEEAYI3EAQxZjBkMF0xCzAJBgNVBAYTAlVT
MRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0RvRDEMMAoGA1UECxMDUEtJMRgw
FgYDVQQDEw9ET0QgRU1BSUwgQ0EtMzACAyLbETB1BgsqhkiG9w0BCRACCzFmoGQwXTELMAkGA1UE
BhMCVVMxGDAWBgNVBAoTD1UuUy4gR292ZXJubWVudDEMMAoGA1UECxMDRG9EMQwwCgYDVQQLEwNQ
S0kxGDAWBgNVBAMTD0RPRCBFTUFJTCBDQS0zMAIDItsRMA0GCSqGSIb3DQEBAQUABIIBAKyvPt4B
ILRz+JvpsOpAp13a0W905VJZKHf55VEb3rn044g2PWKW/HQePM+p2PmKU8r3TFVANwBsczdSiYHc
qIXT2afaHZIZSZOuU6nknFx+FEmPqu8JxDfRTOtDCW4Pm6hIg2JTds3gPkpH0Sq9UxuqT8n4h3LE
QR37npGqMfh9BiTYNh3W7A4eGF4cbjukrBWcv7Z5h2UvaeFUxLxLO2w0u7D8H8g2ylLzCwrcFQMX
te1BPt6fk37gr2uuyljatAtCWXJQv83NJ0WFMxwIadrZBkkfb2Ib87jkvfYkabF/ZreBY3cQuZGB
DiYQrMNacx0Q/ENMJBaz5VX18F/pxH8AAAAAAAA=

------=_NextPart_000_00D6_01CDEB9E.D5D57A30--
