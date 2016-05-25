From: Luke Madhanga <lmadhanga@gmail.com>
Subject: Why is my git-http-backend solution using WebDAV on push?
Date: Wed, 25 May 2016 21:28:21 +0100
Message-ID: <CABwKKP958cW3a5Cjxox+1FCtNLetdufJj0rrYBouAUhJSXKKWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 22:28:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5fPo-0007ym-8J
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 22:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbcEYU2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 16:28:23 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:32803 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbcEYU2W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 16:28:22 -0400
Received: by mail-yw0-f169.google.com with SMTP id h19so59102728ywc.0
        for <git@vger.kernel.org>; Wed, 25 May 2016 13:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=zY6b0lvfSLJu3n91fOLzwChD1xXXw1hVVprlZnkiR70=;
        b=HOha7BsHhNJ4++ifvvhNIyNBZufJqYIxYyLQBg4kp/mZX2PVDcsqvB4BYoFGTlTmuR
         OARu6gctZuLwqn4nHl622nfPCQ2DrmbsghBQ30Z1EOialkhXgE6fPT8GzMvRgygpZqCn
         dN64MfRqibQUHPhfZGryutHW4MWzL8fARNDRt1gA7d48NnXAXA+S2SPs995evYBszT95
         6vNvz+afXbFGtejwbPh40SDt1wtBjuSNRDgdNBxGE1m/7RjOACFj8ytEPCA7T23lfVzi
         dLHSikthNMj2MHW0nw8Yr1oLx3rFMBxogexfKI+Vt8KhhzFqw8oZkANQijUKm6+Log3A
         sFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zY6b0lvfSLJu3n91fOLzwChD1xXXw1hVVprlZnkiR70=;
        b=aIwRx9ePiL1Mh27HSRb76jBoMRbdVWnMlRa+M9B4EQK5CJks9yLxt1tZ89B26NgXQZ
         d0y0Je4u+08vbV+k0vt6eFyhggl//w/tK1LsNPXIN5YYaTj2XiFfxl2gX+N5o6dFjPuX
         Li34P18uWJq0YII2OZyX/i1HwTMP2LoH3xcHyEm7GVGZTAAAaF4OUTEeUTlS481gl1yp
         IdLLSyf8Vap/YFDiKhxzOspiNl5Y4xQSc0tA8iEnmz4W/7TcgxzejSC/QCI8tNGYf7Rp
         x8LVwwsQiBuDOcoIqeM1j8ubiDCZdkcBI8GPxHB8XmIzI6ppgrCfPthTi9fCRWbXFS4G
         bumw==
X-Gm-Message-State: ALyK8tKiBtgqHz976uqm0/wEt9CsaYF6DRK9WZmyS9U4gvopiQ3yLvbRGzRcl1xvjP868Q0SNiJsQUXaTKwEJw==
X-Received: by 10.31.190.211 with SMTP id o202mr3433550vkf.118.1464208101571;
 Wed, 25 May 2016 13:28:21 -0700 (PDT)
Received: by 10.176.4.76 with HTTP; Wed, 25 May 2016 13:28:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295587>

I've implemented a PHP wrapper for git http backend which works well.
I've done this to give me advanced control of who has access to
repositories on my server. You can see the implementation on
http://stackoverflow.com/questions/36998492/channel-git-on-the-server-calls-through-php/37242591#37242591.
I can pull from the server okay and all works well. However, I cannot
push. When I read my trace code to see where it fails, I see that the
last request is a PROPFIND request. The URL for this request does not
have any of the usual 'info/refs' etc. that one usually gets on git
calls.

During reading of the documentation and reviewing how git-http-backend
should be implemented, I can see that it should not be making a WebDAV
request. I have also come across posts where people implementing
http-backend the 'normal' way have also had this problem, e.g.
http://serverfault.com/questions/390864/git-push-over-http-using-git-http-backend-and-apache-is-not-working



So the question is, why is WebDAV being used on push?




Trace code from the push:

[2016-05-25 09:49:35] ==========================
[2016-05-25 09:49:35] REQUEST: {
    "q": "p\/git-backend\/run\/1\/info\/refs",
    "service": "git-receive-pack"
}
[2016-05-25 09:49:35] SERVER: {
    "REDIRECT_STATUS": "200",
    "HTTP_HOST": "...",
    "HTTP_USER_AGENT": "git\/2.7.4",
    "HTTP_ACCEPT": "*\/*",
    "HTTP_ACCEPT_ENCODING": "gzip",
    "HTTP_ACCEPT_LANGUAGE": "en-GB, en;q=0.9, *;q=0.8",
    "HTTP_PRAGMA": "no-cache",
    "PATH": "...",
    "SERVER_SIGNATURE": "<address>Apache\/2.4.18 (Ubuntu) Server at
... Port 80<\/address>\n",
    "SERVER_SOFTWARE": "Apache\/2.4.18 (Ubuntu)",
    "SERVER_NAME": "...",
    "SERVER_ADDR": "...",
    "SERVER_PORT": "80",
    "REMOTE_ADDR": "...",
    "DOCUMENT_ROOT": "...",
    "REQUEST_SCHEME": "http",
    "CONTEXT_PREFIX": "",
    "CONTEXT_DOCUMENT_ROOT": "...",
    "SERVER_ADMIN": "...",
    "SCRIPT_FILENAME": "...",
    "REMOTE_PORT": "49630",
    "REDIRECT_URL": "\/p\/git-backend\/run\/1\/info\/refs",
    "REDIRECT_QUERY_STRING":
"q=p\/git-backend\/run\/1\/info\/refs&service=git-receive-pack",
    "GATEWAY_INTERFACE": "CGI\/1.1",
    "SERVER_PROTOCOL": "HTTP\/1.1",
    "REQUEST_METHOD": "GET",
    "QUERY_STRING":
"q=p\/git-backend\/run\/1\/info\/refs&service=git-receive-pack",
    "REQUEST_URI":
"\/p\/git-backend\/run\/1\/info\/refs?service=git-receive-pack",
    "SCRIPT_NAME": "\/index.php",
    "PHP_SELF": "\/index.php",
    "REQUEST_TIME_FLOAT": 1464162575.091,
    "REQUEST_TIME": 1464162575
}
[2016-05-25 09:49:35] Path: /core.git/info/refs?service=git-receive-pack
[2016-05-25 09:49:35] Cleaned, result only:
[2016-05-25 09:49:35] f4648182f5f8eee082c37a83a0072cfc4210e5c5 refs/heads/master
8c4efcd77809bc9b94a59cf94653add8007c6b7d refs/heads/zztest
[2016-05-25 09:49:35] ==========================
[2016-05-25 09:49:35] REQUEST: {
    "q": "p\/git-backend\/run\/1\/HEAD"
}
[2016-05-25 09:49:35] SERVER: {
    "REDIRECT_STATUS": "200",
    "HTTP_HOST": "...",
    "HTTP_USER_AGENT": "git\/2.7.4",
    "HTTP_ACCEPT": "*\/*",
    "HTTP_ACCEPT_ENCODING": "gzip",
    "HTTP_ACCEPT_LANGUAGE": "en-GB, en;q=0.9, *;q=0.8",
    "HTTP_PRAGMA": "no-cache",
    "PATH": "...",
    "SERVER_SIGNATURE": "<address>Apache\/2.4.18 (Ubuntu) Server at
... Port 80<\/address>\n",
    "SERVER_SOFTWARE": "Apache\/2.4.18 (Ubuntu)",
    "SERVER_NAME": "...",
    "SERVER_ADDR": "...",
    "SERVER_PORT": "80",
    "REMOTE_ADDR": "...",
    "DOCUMENT_ROOT": "...",
    "REQUEST_SCHEME": "http",
    "CONTEXT_PREFIX": "",
    "CONTEXT_DOCUMENT_ROOT": "...",
    "SERVER_ADMIN": "...",
    "SCRIPT_FILENAME": "...",
    "REMOTE_PORT": "49630",
    "REDIRECT_URL": "\/p\/git-backend\/run\/1\/HEAD",
    "REDIRECT_QUERY_STRING": "q=p\/git-backend\/run\/1\/HEAD",
    "GATEWAY_INTERFACE": "CGI\/1.1",
    "SERVER_PROTOCOL": "HTTP\/1.1",
    "REQUEST_METHOD": "GET",
    "QUERY_STRING": "q=p\/git-backend\/run\/1\/HEAD",
    "REQUEST_URI": "\/p\/git-backend\/run\/1\/HEAD",
    "SCRIPT_NAME": "\/index.php",
    "PHP_SELF": "\/index.php",
    "REQUEST_TIME_FLOAT": 1464162575.266,
    "REQUEST_TIME": 1464162575
}
[2016-05-25 09:49:35] Path: /core.git/HEAD
[2016-05-25 09:49:35] Cleaned, result only:
[2016-05-25 09:49:35] ref: refs/heads/master
[2016-05-25 09:49:35] ==========================
[2016-05-25 09:49:35] REQUEST: {
    "q": "p\/git-backend\/run\/1\/"
}
[2016-05-25 09:49:35] SERVER: {
    "REDIRECT_STATUS": "200",
    "HTTP_HOST": "...",
    "HTTP_USER_AGENT": "git\/2.7.4",
    "HTTP_ACCEPT": "*\/*",
    "HTTP_DEPTH": "0",
    "CONTENT_TYPE": "text\/xml",
    "CONTENT_LENGTH": "167",
    "HTTP_EXPECT": "100-continue",
    "PATH": "...",
    "SERVER_SIGNATURE": "<address>Apache\/2.4.18 (Ubuntu) Server at
... Port 80<\/address>\n",
    "SERVER_SOFTWARE": "Apache\/2.4.18 (Ubuntu)",
    "SERVER_NAME": "...",
    "SERVER_ADDR": "...",
    "SERVER_PORT": "80",
    "REMOTE_ADDR": "...",
    "DOCUMENT_ROOT": "...",
    "REQUEST_SCHEME": "http",
    "CONTEXT_PREFIX": "",
    "CONTEXT_DOCUMENT_ROOT": "...",
    "SERVER_ADMIN": "...",
    "SCRIPT_FILENAME": "...",
    "REMOTE_PORT": "49632",
    "REDIRECT_URL": "\/p\/git-backend\/run\/1\/",
    "REDIRECT_QUERY_STRING": "q=p\/git-backend\/run\/1\/",
    "GATEWAY_INTERFACE": "CGI\/1.1",
    "SERVER_PROTOCOL": "HTTP\/1.1",
    "REQUEST_METHOD": "PROPFIND",
    "QUERY_STRING": "q=p\/git-backend\/run\/1\/",
    "REQUEST_URI": "\/p\/git-backend\/run\/1\/",
    "SCRIPT_NAME": "\/index.php",
    "PHP_SELF": "\/index.php",
    "REQUEST_TIME_FLOAT": 1464162575.711,
    "REQUEST_TIME": 1464162575
}
[2016-05-25 09:49:35] Path: /core.git/
[2016-05-25 09:49:35] <?xml version="1.0" encoding="utf-8" ?>
<D:propfind xmlns:D="DAV:">
<D:prop xmlns:R="http://.../p/git-backend/run/1/">
<D:supportedlock/>
</D:prop>
</D:propfind>
[2016-05-25 09:49:35] Exception: Request not supported: '/path/to/git/repo.git/'

When run using curl verbose, the output is


* Couldn't find host xxx in the .netrc file; using defaults
*   Trying xxx...
* Connected to xxx (xxx) port 80 (#0)
> GET /p/git-backend/run/1/info/refs?service=git-receive-pack HTTP/1.1
Host: xxx
User-Agent: git/2.7.4
Accept: */*
Accept-Encoding: gzip
Accept-Language: en-GB, en;q=0.9, *;q=0.8
Pragma: no-cache

< HTTP/1.1 200 OK
< Date: Wed, 25 May 2016 19:00:25 GMT
< Server: Apache/2.4.18 (Ubuntu)
< Set-Cookie: PHPSESSID=yyy; path=/
< Expires: Fri, 01 Jan 1980 00:00:00 GMT
< Cache-Control: no-cache, max-age=0, must-revalidate
< Pragma: no-cache
< Vary: Accept-Encoding
< Content-Encoding: gzip
< Content-Length: 109
< Content-Type: text/plain;charset=UTF-8
<
* Connection #0 to host madhan.ga left intact
* Couldn't find host xxx in the .netrc file; using defaults
* Found bundle for host xxx: 0x9bade0 [can pipeline]
* Re-using existing connection! (#0) with host xxx
* Connected to xxx (xxx) port 80 (#0)
> GET /p/git-backend/run/1/HEAD HTTP/1.1
Host: xxx
User-Agent: git/2.7.4
Accept: */*
Accept-Encoding: gzip
Accept-Language: en-GB, en;q=0.9, *;q=0.8
Pragma: no-cache

< HTTP/1.1 200 OK
< Date: Wed, 25 May 2016 19:00:25 GMT
< Server: Apache/2.4.18 (Ubuntu)
< Set-Cookie: PHPSESSID=zzz; path=/
< Expires: Thu, 19 Nov 1981 08:52:00 GMT
< Cache-Control: no-store, no-cache, must-revalidate
< Pragma: no-cache
< Content-Length: 23
< Content-Type: text/plain;charset=UTF-8
<
* Connection #0 to host xxx left intact
* Couldn't find host xxx in the .netrc file; using defaults
*   Trying xxx...
* Connected to xxx (xxx) port 80 (#0)
> PROPFIND /p/git-backend/run/1/ HTTP/1.1
Host: xxx
User-Agent: git/2.7.4
Accept: */*
Depth: 0
Content-Type: text/xml
Content-Length: 167
Expect: 100-continue

< HTTP/1.1 100 Continue
* We are completely uploaded and fine
* HTTP 1.0, assume close after body
< HTTP/1.0 100 Continue
< Date: Wed, 25 May 2016 19:00:25 GMT
< Server: Apache/2.4.18 (Ubuntu)
< Set-Cookie: PHPSESSID=aaa; path=/
< Expires: Thu, 19 Nov 1981 08:52:00 GMT
< Cache-Control: no-store, no-cache, must-revalidate
< Pragma: no-cache
< Content-Length: 0
< Connection: close
< Content-Type: text/json; charset=utf-8
* Empty reply from server
* Closing connection 0
error: Cannot access URL http://xxx/p/git-backend/run/1/, return code 52
fatal: git-http-push failed
error: failed to push some refs to 'http://xxx/p/git-backend/run/1'



-- 
Yours,
Luke Madhanga
