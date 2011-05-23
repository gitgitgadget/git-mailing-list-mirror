From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Is there a debug mode for git-clone https traffic?
Date: Mon, 23 May 2011 10:21:55 +0200
Message-ID: <BANLkTinqKSwOYJOC93w-yyG79O9za7Z4yA@mail.gmail.com>
References: <BANLkTi=-i063MqrboT1MHrQy-vM0yBTUGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 23 10:22:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOQOq-0004XL-Cd
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 10:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648Ab1EWIV6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2011 04:21:58 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40571 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab1EWIV5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2011 04:21:57 -0400
Received: by fxm17 with SMTP id 17so3740725fxm.19
        for <git@vger.kernel.org>; Mon, 23 May 2011 01:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=0Mz7Ay5QTZI+zD4TQ4VvoLf1Oy6WL6kQSbDQYYHrIcc=;
        b=fwc23O2o5iotydxhmqveU1tyjAyFOXBfBeDRivtmyVA+AcB3/Ni3Aq52vgjn5LBS8T
         96eO/fFZi8sJsrZKAfyucczg909UTOW4Zh+LTgChg+UzDjyWgaBRuPe0A5yHiYZp+VUN
         46c7GHbph62K6HUwqAEq7Gnx1z1SDevVeyHlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=be06akagfr2plVJb1qSVfDB6copWKB0XPsWjkbmjLpVy+FNbeAHmjJ7EJN8Q21VvK3
         llmM8ekiv7cJBaKxUlYwWCPUu14PC0sqcQROhonFrj6k+nH8D63ysKonRgbwoTrvSm/L
         W6xqA13txyn8/SWrJf8HixMPLtPhAU/KvlUvA=
Received: by 10.223.3.132 with SMTP id 4mr2091514fan.132.1306138915091; Mon,
 23 May 2011 01:21:55 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Mon, 23 May 2011 01:21:55 -0700 (PDT)
In-Reply-To: <BANLkTi=-i063MqrboT1MHrQy-vM0yBTUGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174231>

On Wed, May 18, 2011 at 01:08, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> I''m trying to debug a problem where over a https proxy I have
> "warning: remote HEAD refers to nonexistent ref, unable to checkout."
> when doing git-clone.
>
> I suspect that it might be an overzealous security scanner sitting in
> the middle.
>
> Is there some debugging mode for git-clone where it'll dump the
> traffic being sent over the wire that I could use to confirm this?

I've debugged this, and the results are strange. Here it is on a
machine that doesn't work (proxy hostname manually munged):

    Cloning into magit...
    * Couldn't find host github.com in the .netrc file; using defaults
    * About to connect() to proxy proxy-BROKEN.example.net port 3128 (#=
0)
    *   Trying 10.146.207.60... * Connected to
proxy-BROKEN.example.net (10.146.207.60) port 3128 (#0)
    * Establish HTTP proxy tunnel to github.com:443
    > CONNECT github.com:443 HTTP/1.1
    Host: github.com:443
    User-Agent: git/1.7.4.4
    Proxy-Connection: Keep-Alive
    Pragma: no-cache

    < HTTP/1.0 200 Connection established
    <
    * Proxy replied OK to CONNECT request
    * found 158 certificates in /etc/ssl/certs/ca-certificates.crt
    > GET /magit/magit.git/info/refs?service=3Dgit-upload-pack HTTP/1.1
    User-Agent: git/1.7.4.4
    Host: github.com
    Accept: */*
    Pragma: no-cache

    * Connection #0 to host proxy-BROKEN.example.net left intact
    * Couldn't find host github.com in the .netrc file; using defaults
    * Connection #0 seems to be dead!
    * Closing connection #0
    * About to connect() to proxy proxy-BROKEN.example.net port 3128 (#=
0)
    *   Trying 10.146.207.60... * Connected to
proxy-BROKEN.example.net (10.146.207.60) port 3128 (#0)
    * Establish HTTP proxy tunnel to github.com:443
    > CONNECT github.com:443 HTTP/1.1
    Host: github.com:443
    User-Agent: git/1.7.4.4
    Proxy-Connection: Keep-Alive
    Pragma: no-cache

    < HTTP/1.0 200 Connection established
    <
    * Proxy replied OK to CONNECT request
    * found 158 certificates in /etc/ssl/certs/ca-certificates.crt
    > GET /magit/magit.git/HEAD HTTP/1.1
    User-Agent: git/1.7.4.4
    Host: github.com
    Accept: */*
    Pragma: no-cache

    * Connection #0 to host proxy-BROKEN.example.net left intact
    warning: remote HEAD refers to nonexistent ref, unable to checkout.

And here on a box with a different proxy where this does work:

    Cloning into magit...
    * Couldn't find host github.com in the .netrc file, using defaults
    * About to connect() to proxy proxy-OK.example.net port 3128
    *   Trying 10.147.82.1... * connected
    * Connected to proxy-OK.example.net (10.147.82.1) port 3128
    * Establish HTTP proxy tunnel to github.com:443
    > CONNECT github.com:443 HTTP/1.0
    Host: github.com:443
    User-Agent: git/1.7.2.1
    Proxy-Connection: Keep-Alive
    Pragma: no-cache

    < HTTP/1.0 200 Connection established
    <
    * Proxy replied OK to CONNECT request
    * successfully set certificate verify locations:
    *   CAfile: /etc/pki/tls/certs/ca-bundle.crt
      CApath: none
    * SSL connection using AES256-SHA
    * Server certificate:
    *        subject: /O=3D*.github.com/OU=3DDomain Control
Validated/CN=3D*.github.com
    *        start date: 2009-12-11 05:02:36 GMT
    *        expire date: 2014-12-11 05:02:36 GMT
    *        subjectAltName: github.com matched
    *        issuer: /C=3DUS/ST=3DArizona/L=3DScottsdale/O=3DGoDaddy.co=
m,
Inc./OU=3Dhttp://certificates.godaddy.com/repository/CN=3DGo Daddy Secu=
re
Certification Authority/serialNumber=3D07969287
    * SSL certificate verify ok.
    > GET /magit/magit.git/info/refs?service=3Dgit-upload-pack HTTP/1.1
    User-Agent: git/1.7.2.1
    Host: github.com
    Accept: */*
    Pragma: no-cache

    < HTTP/1.1 200 OK
    < Server: nginx/0.7.67
    < Date: Mon, 23 May 2011 08:14:22 GMT
    < Content-Type: application/x-git-upload-pack-advertisement
    < Transfer-Encoding: chunked
    < Connection: keep-alive
    < Expires: Fri, 01 Jan 1980 00:00:00 GMT
    < Pragma: no-cache
    < Cache-Control: no-cache, max-age=3D0, must-revalidate
    * Connection #0 to host proxy-OK.example.net left intact
    * Couldn't find host github.com in the .netrc file, using defaults
    * Re-using existing connection! (#0) with host proxy-OK.example.net
    * Connected to proxy-OK.example.net (10.147.82.1) port 3128
    > POST /magit/magit.git/git-upload-pack HTTP/1.1
    User-Agent: git/1.7.2.1
    Host: github.com
    Accept: */*
    Accept-Encoding: deflate, gzip
    Content-Type: application/x-git-upload-pack-request
    Accept: application/x-git-upload-pack-result
    Content-Length: 828

    0073want 761d6ad09bfce0d354c8fe958f5fc1b0fdde0a9a
multi_ack_detailed side-band-64k thin-pack no-progress ofs-delta
    0032want 292c83d70df3735ba3809dd946d99cf7aa49f6bd
    0032want 1984ce646f25ec073afe77f9d90c11f422659c60
    0032want fd6f6d5ea7b209f8968dfcd999a20f84e6e63edc
    0032want b60cb2bdb31d78670690e22a7fa9eb1a5fb6a40c
    0032want eb0da0582e6635e8b89636170a0de847a71d975e
    0032want 387969a8734377e4baabaf2533dfad8f427dce5f
    0032want cff8d04ef1fc0cce10a274e3737fbbe3ae9be43c
    0032want 8be54f67577478ce05cf68a44a377cab893e9ea0
    0032want 7b3473865309c8a6bc41d0e674ee648e124bf106
    0032want 01aa8d5874b4ad19ffd0423e2c0e0123c5393051
    0032want 00579d3e79504ce0be173b9cd0aec4100cbe8a76
    0032want be85320fabef7af16fb1a27fa74908f54a1f2403
    0032want b4b0a8bffc393137d3a52d62bc92c762a77067e9
    0032want e4d766306adbda64a974b5ea1daa9b7fffdc29d6
    00000009done
    < HTTP/1.1 200 OK
    < Server: nginx/0.7.67
    < Date: Mon, 23 May 2011 08:14:22 GMT
    < Content-Type: application/x-git-upload-pack-result
    < Transfer-Encoding: chunked
    < Connection: keep-alive
    < Expires: Fri, 01 Jan 1980 00:00:00 GMT
    < Pragma: no-cache
    < Cache-Control: no-cache, max-age=3D0, must-revalidate
    * Connection #0 to host proxy-OK.example.net left intact

Which is curious, because I can get that file manually with curl on
both of those boxes, i.e. the BROKEN and OK one, respectively:

    $ curl -v https://github.com/magit/magit.git/info/refs?service=3Dgi=
t-upload-pack
| sha1sum
    * About to connect() to proxy proxy-BROKEN.example.net port 3128 (#=
0)
    *   Trying 10.146.207.60...   % Total    % Received % Xferd
Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent
Left  Speed
      0     0    0     0    0     0      0      0 --:--:-- --:--:--
--:--:--     0connected
    * Connected to proxy-BROKEN.example.net (10.146.207.60) port 3128 (=
#0)
    * Establish HTTP proxy tunnel to github.com:443
    > CONNECT github.com:443 HTTP/1.1
    > Host: github.com:443
    > User-Agent: curl/7.21.6 (i486-pc-linux-gnu) libcurl/7.21.6
OpenSSL/1.0.0d zlib/1.2.3.4 libidn/1.20 libssh2/1.2.8 librtmp/2.3
    > Proxy-Connection: Keep-Alive
    >
    < HTTP/1.0 200 Connection established
    <
    * Proxy replied OK to CONNECT request
    * successfully set certificate verify locations:
    *   CAfile: none
      CApath: /etc/ssl/certs
    * SSLv3, TLS handshake, Client hello (1):
    } [data not shown]
    * SSLv3, TLS handshake, Server hello (2):
    { [data not shown]
    * SSLv3, TLS handshake, CERT (11):
    { [data not shown]
    * SSLv3, TLS handshake, Server finished (14):
    { [data not shown]
    * SSLv3, TLS handshake, Client key exchange (16):
    } [data not shown]
    * SSLv3, TLS change cipher, Client hello (1):
    } [data not shown]
    * SSLv3, TLS handshake, Finished (20):
    } [data not shown]
    * SSLv3, TLS change cipher, Client hello (1):
    { [data not shown]
    * SSLv3, TLS handshake, Finished (20):
    { [data not shown]
    * SSL connection using AES256-SHA
    * Server certificate:
    *        subject: O=3D*.github.com; OU=3DDomain Control Validated;
CN=3D*.github.com
    *        start date: 2009-12-11 05:02:36 GMT
    *        expire date: 2014-12-11 05:02:36 GMT
    *        subjectAltName: github.com matched
    *        issuer: C=3DUS; ST=3DArizona; L=3DScottsdale; O=3DGoDaddy.=
com,
Inc.; OU=3Dhttp://certificates.godaddy.com/repository; CN=3DGo Daddy
Secure Certification Authority; serialNumber=3D07969287
    *        SSL certificate verify ok.
    > GET /magit/magit.git/info/refs?service=3Dgit-upload-pack HTTP/1.1
    > User-Agent: curl/7.21.6 (i486-pc-linux-gnu) libcurl/7.21.6
OpenSSL/1.0.0d zlib/1.2.3.4 libidn/1.20 libssh2/1.2.8 librtmp/2.3
    > Host: github.com
    > Accept: */*
    >
      0     0    0     0    0     0      0      0 --:--:-- --:--:--
--:--:--     0< HTTP/1.1 200 OK
    < Server: nginx/0.7.67
    < Date: Mon, 23 May 2011 08:19:19 GMT
    < Content-Type: application/x-git-upload-pack-advertisement
    < Transfer-Encoding: chunked
    < Connection: keep-alive
    < Expires: Fri, 01 Jan 1980 00:00:00 GMT
    < Pragma: no-cache
    < Cache-Control: no-cache, max-age=3D0, must-revalidate
    <
    { [data not shown]
    100  1531    0  1531    0     0   2773      0 --:--:-- --:--:--
--:--:--  2877
    * Connection #0 to host proxy-BROKEN.example.net left intact
    * Closing connection #0
    * SSLv3, TLS alert, Client hello (1):
    } [data not shown]
    5b7eb0b5c25a8700bfc8376a5a38da78724dc1dd  -

    $ curl -v https://github.com/magit/magit.git/info/refs?service=3Dgi=
t-upload-pack
| sha1sum
    * About to connect() to proxy proxy-OK.example.net port 3128
    *   Trying 10.147.82.5... connected
    * Connected to proxy-OK.example.net (10.147.82.5) port 3128
    * Establish HTTP proxy tunnel to github.com:443
    > CONNECT github.com:443 HTTP/1.0
    > Host: github.com:443
    > User-Agent: curl/7.15.5 (x86_64-redhat-linux-gnu) libcurl/7.15.5
OpenSSL/0.9.8b zlib/1.2.3 libidn/0.6.5
    > Proxy-Connection: Keep-Alive
    >
    < HTTP/1.0 200 Connection established
    <
    * Proxy replied OK to CONNECT request
    * successfully set certificate verify locations:
    *   CAfile: /etc/pki/tls/certs/ca-bundle.crt
      CApath: none
    * SSLv2, Client hello (1):
    SSLv3, TLS handshake, Server hello (2):
    SSLv3, TLS handshake, CERT (11):
    SSLv3, TLS handshake, Server finished (14):
    SSLv3, TLS handshake, Client key exchange (16):
    SSLv3, TLS change cipher, Client hello (1):
    SSLv3, TLS handshake, Finished (20):
    SSLv3, TLS change cipher, Client hello (1):
    SSLv3, TLS handshake, Finished (20):
    SSL connection using AES256-SHA
    * Server certificate:
    *        subject: /O=3D*.github.com/OU=3DDomain Control
Validated/CN=3D*.github.com
    *        start date: 2009-12-11 05:02:36 GMT
    *        expire date: 2014-12-11 05:02:36 GMT
    *        subjectAltName: github.com matched
    *        issuer: /C=3DUS/ST=3DArizona/L=3DScottsdale/O=3DGoDaddy.co=
m,
Inc./OU=3Dhttp://certificates.godaddy.com/repository/CN=3DGo Daddy Secu=
re
Certification Authority/serialNumber=3D07969287
    * SSL certificate verify ok.
    > GET /magit/magit.git/info/refs?service=3Dgit-upload-pack HTTP/1.1
    > User-Agent: curl/7.15.5 (x86_64-redhat-linux-gnu) libcurl/7.15.5
OpenSSL/0.9.8b zlib/1.2.3 libidn/0.6.5
    > Host: github.com
    > Accept: */*
    >
    < HTTP/1.1 200 OK
    < Server: nginx/0.7.67
    < Date: Mon, 23 May 2011 08:18:47 GMT
    < Content-Type: application/x-git-upload-pack-advertisement
    < Transfer-Encoding: chunked
    < Connection: keep-alive
    < Expires: Fri, 01 Jan 1980 00:00:00 GMT
    < Pragma: no-cache
    < Cache-Control: no-cache, max-age=3D0, must-revalidate
      % Total    % Received % Xferd  Average Speed   Time    Time
Time  Current
                                     Dload  Upload   Total   Spent
Left  Speed
    100  1531    0  1531    0     0   3173      0 --:--:-- --:--:--
--:--:--     0* Connection #0 to host proxy-OK.example.net left intact

    * Closing connection #0
    * SSLv3, TLS alert, Client hello (1):
    5b7eb0b5c25a8700bfc8376a5a38da78724dc1dd  -

The SSL part seems different though, but since curl(1) can get the
content perhaps there's some use of the curl library in Git that's
tripping me up?
