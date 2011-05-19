From: Nir Friedman <nirfri@hotmail.com>
Subject: RE: FW: git over https and http 1.1
Date: Thu, 19 May 2011 07:43:44 +0300
Message-ID: <BLU0-SMTP207861424D1FA595A51BBBEC78E0@phx.gbl>
References: <BLU0-SMTP122315AAE364595FDA4A30AC78F0@phx.gbl> <alpine.DEB.2.00.1105181615180.26343@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 19 06:43:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMv5U-0002vX-TF
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 06:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447Ab1ESEnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 00:43:47 -0400
Received: from blu0-omc3-s24.blu0.hotmail.com ([65.55.116.99]:56471 "EHLO
	blu0-omc3-s24.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751104Ab1ESEnq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 00:43:46 -0400
Received: from BLU0-SMTP207 ([65.55.116.73]) by blu0-omc3-s24.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 18 May 2011 21:43:46 -0700
X-Originating-IP: [212.179.48.132]
X-Originating-Email: [nirfri@hotmail.com]
Received: from nirftp ([212.179.48.132]) by BLU0-SMTP207.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 18 May 2011 21:43:44 -0700
In-Reply-To: <alpine.DEB.2.00.1105181615180.26343@tvnag.unkk.fr>
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AcwVaW/mIjIo9blURlWMUjnhIwYe4QAdSHLw
Content-Language: en-us
X-OriginalArrivalTime: 19 May 2011 04:43:45.0141 (UTC) FILETIME=[55FC9A50:01CC15DF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173928>

See below the output of GIT_CURL_VERBOSE, I marked the position (POINT 1)
where there seems to be a hang (~20 seconds)


GIT_CURL_VERBOSE=1 git clone http:// @10.1.30.61/git/WebGui
Cloning into WebGui...
* Couldn't find host 10.1.30.61 in the .netrc file; using defaults
* About to connect() to 10.1.30.61 port 80 (#0)
*   Trying 10.1.30.61... * connected
* Connected to 10.1.30.61 (10.1.30.61) port 80 (#0)
* 0x8fb5b58 is at send pipe head!
> GET /git/WebGui/info/refs?service=git-upload-pack HTTP/1.1
User-Agent: git/1.7.5.1
Host: 10.1.30.61
Accept: */*
Pragma: no-cache

< HTTP/1.1 200 OK
< Date: Thu, 19 May 2011 04:37:40 GMT
< Server: Apache/2.2.17 (Ubuntu)
< Expires: Fri, 01 Jan 1980 00:00:00 GMT
< Pragma: no-cache
< Cache-Control: no-cache, max-age=0, must-revalidate
< Transfer-Encoding: chunked
< Content-Type: application/x-git-upload-pack-advertisement
<
*********************************************///////////POINT
1///////////**************************************
* Connection #0 to host 10.1.30.61 left intact
* Couldn't find host 10.1.30.61 in the .netrc file; using defaults
* About to connect() to 10.1.30.61 port 80 (#0)
*   Trying 10.1.30.61... * connected
* Connected to 10.1.30.61 (10.1.30.61) port 80 (#0)
> POST /git/WebGui/git-upload-pack HTTP/1.1
User-Agent: git/1.7.5.1
Host: 10.1.30.61
Accept-Encoding: deflate, gzip
Content-Type: application/x-git-upload-pack-request
Accept: application/x-git-upload-pack-result
Content-Encoding: gzip
Content-Length: 15639

< HTTP/1.1 200 OK
< Date: Thu, 19 May 2011 04:37:40 GMT
< Server: Apache/2.2.17 (Ubuntu)
< Expires: Fri, 01 Jan 1980 00:00:00 GMT
< Pragma: no-cache
< Cache-Control: no-cache, max-age=0, must-revalidate
< Transfer-Encoding: chunked
< Content-Type: application/x-git-upload-pack-result
<
remote: Counting objects: 33641, done.
^Cmote: Compressing objects:  99% (6677/6744)

real    0m1.866s
user    0m0.008s
sys     0m0.008s

-----Original Message-----
From: Daniel Stenberg [mailto:daniel@haxx.se] 
Sent: Wednesday, May 18, 2011 5:40 PM
To: Nir Friedman
Cc: git@vger.kernel.org
Subject: Re: FW: git over https and http 1.1

On Wed, 18 May 2011, Nir Friedman wrote:

> Fast is - 15 seconds, around  50% less

15 seconds is a really long time. I think it might be useful if you did some

network snooping/capturing to see what's really going on. Or set 
GIT_CURL_VERBOSE to get some verbose libcurl output and see if that explains

anything.

> This was checked on 	Ubuntu 	11.04  Libcurl 	7.21.3
> This problem didn't exist on windows clients.

libcurl works exactly the same on Windows so that effectively nullifies the 
theory it would have something to do with libcurl's HTTP 1.1 support...

-- 

  / daniel.haxx.se
