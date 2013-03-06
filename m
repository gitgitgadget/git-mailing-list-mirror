From: Yves Blusseau <yves.blusseau@gmail.com>
Subject: Re: Using socks proxy with git for http(s) transport
Date: Wed, 6 Mar 2013 10:35:58 +0100
Message-ID: <CABmRxH1=wjXXLDTCAO2Ge9YcBJq4yJQd4-NUs9P=qKWzh8kkjw@mail.gmail.com>
References: <CABmRxH1g2BR+-MvGZ4J-2vC8NDq3x8pG148hXfuYTpUkX0L=0A@mail.gmail.com>
	<20130306082110.GA31638@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 06 10:36:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDAlw-0000RL-ON
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 10:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756552Ab3CFJgC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 04:36:02 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:58996 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789Ab3CFJf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 04:35:59 -0500
Received: by mail-pb0-f42.google.com with SMTP id xb4so5757116pbc.15
        for <git@vger.kernel.org>; Wed, 06 Mar 2013 01:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=IqvyrVgCD2dQC1qjnoI+1yFS+7l2PWAwg7qLotTdjqg=;
        b=o4iUkPnLodOh0zOuSvqFvyAm6RUc8C2hf1LI7r9rArLHDb01SYqhdS2V51K9EFUFcX
         biqSijY5sbf4dFogCVbHF5bMwYk2ENoCfMQHn0KUCAFCwcEk2N7vl/a0JNjYrWaTubki
         aZYbUN28ZPlNqn0lCTri7QH4fBVdRKsVR1YRE0KkgW5xEYAacSFItW8bJ1R7ftatnOfk
         KjKSdNtqsAjnSrsE1n0PSTESq7x5zKF4YA0/wLzuT0kbFCABAlL/nVuuhwVP8kdeU06I
         jId6NfdTjfV3DGnp6YNZ+F3vzkusMWR+TbzVwSv0q5lPGjNkPDFjs09oe5k+NzUUQH8J
         jGrg==
X-Received: by 10.68.213.132 with SMTP id ns4mr45950618pbc.84.1362562558578;
 Wed, 06 Mar 2013 01:35:58 -0800 (PST)
Received: by 10.68.136.225 with HTTP; Wed, 6 Mar 2013 01:35:58 -0800 (PST)
In-Reply-To: <20130306082110.GA31638@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217510>

2013/3/6 Jeff King <peff@peff.net>:
> Try:
>
>   git config --global http.proxy 'socks://yourhost:port'
>
> That will enable it for all git repositories on your machine. Git should
> also respect any environment variables that curl handles (because we use
> libcurl under the hood), if you prefer to set it up that way. See "man
> curl" for details.
>
> -Peff

Also try setting ALL_PROXY environment variable that curl handle:
export ALL_PROXY='socks5://127.0.0.1:1080'

Work with curl:
curl -v http://git.kernel.org/pub/scm/git/git.git/info/refs?service=git-upload-pack

* About to connect() to proxy 127.0.0.1 port 1080 (#0)
*   Trying 127.0.0.1...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:--
--:--:--     0* 198
* 145
* 20
* 140
* Connected to 127.0.0.1 (127.0.0.1) port 1080 (#0)
> GET /pub/scm/git/git.git/info/refs?service=git-upload-pack HTTP/1.1
> User-Agent: curl/7.29.1-DEV
> Host: git.kernel.org
> Accept: */*
>
< HTTP/1.1 200 OK
< Server: nginx
< Date: Wed, 06 Mar 2013 09:33:05 GMT
< Content-Type: application/x-git-upload-pack-advertisement
< Transfer-Encoding: chunked
< Connection: keep-alive
< Expires: Fri, 01 Jan 1980 00:00:00 GMT
< Pragma: no-cache
< Cache-Control: no-cache, max-age=0, must-revalidate
<
{ [data not shown]


But with git (without the http.proxy configuration in .gitconfig):

GIT_TRACE=1 GIT_CURL_VERBOSE=1 git clone
http://git.kernel.org/pub/scm/git/git.git
trace: built-in: git 'clone' 'http://git.kernel.org/pub/scm/git/git.git'
Cloning into 'git'...
trace: run_command: 'git-remote-http' 'origin'
'http://git.kernel.org/pub/scm/git/git.git'
* Couldn't find host git.kernel.org in the .netrc file, using defaults
* About to connect() to proxy 127.0.0.1 port 1080
*   Trying 127.0.0.1... * connected
* Connected to 127.0.0.1 (127.0.0.1) port 1080
> GET http://git.kernel.org/pub/scm/git/git.git/info/refs?service=git-upload-pack HTTP/1.1
User-Agent: git/1.8.1.5
Host: git.kernel.org
Accept: */*
Accept-Encoding: gzip
Proxy-Connection: Keep-Alive
Pragma: no-cache

* Empty reply from server
* Connection #0 to host 127.0.0.1 left intact
error: Empty reply from server while accessing
http://git.kernel.org/pub/scm/git/git.git/info/refs?service=git-upload-pack
fatal: HTTP request failed

Regards,
Yves
