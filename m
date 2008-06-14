From: Mike Hommey <mh@glandium.org>
Subject: Re: [BUG REPORT] "git ls-remote http://git.domain.com/repo.git
	HEAD" doesn't work
Date: Sat, 14 Jun 2008 09:10:11 +0200
Organization: glandium.org
Message-ID: <20080614071011.GA29699@glandium.org>
References: <loom.20080614T065448-251@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sven <svoop@delirium.ch>
X-From: git-owner@vger.kernel.org Sat Jun 14 09:12:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Pvl-0003UK-4D
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 09:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbYFNHLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 03:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752206AbYFNHLP
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 03:11:15 -0400
Received: from vuizook.err.no ([194.24.252.247]:41277 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752131AbYFNHLO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 03:11:14 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1K7Pui-0004wq-Q3; Sat, 14 Jun 2008 09:11:11 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1K7Ptr-0007lx-4b; Sat, 14 Jun 2008 09:10:11 +0200
Content-Disposition: inline
In-Reply-To: <loom.20080614T065448-251@post.gmane.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84973>

On Sat, Jun 14, 2008 at 07:03:36AM +0000, Sven wrote:
> Hi
> 
> Following up my recent post, I'm now pretty sure this is a bug. Apparently,
> ls-remote does not list the HEAD version when used over HTTP(S) whereas it does
> work otherwise. Check this out:
> 
> over HTTP - no HEAD listed here:
> git ls-remote http://www.kernel.org/pub/scm/git/git.git
> 
> over GIT - HEAD is listed in this case:
> git ls-remote git://github.com/lux/sitellite.git 
> 
> As Capistrano relies on "git ls-remote http://git.domain.com/repo.git HEAD" to
> find out which version to pull, you can't deploy from Git over HTTP(S) repos for
> now. Capistrano is the de facto standard for deploying Ruby on Rails (and
> related) web applications.
> 
> Thanks a lot for looking into this!! (My knowledge unfortunately doesn't allow
> me to submit a patch myself.)

$ GIT_CURL_VERBOSE=1 git ls-remote http://www.kernel.org/pub/scm/git/git.git HEAD
* Couldn't find host www.kernel.org in the .netrc file, using defaults
* About to connect() to www.kernel.org port 80 (#0)
*   Trying 204.152.191.37... * Connected to www.kernel.org (204.152.191.37) port 80 (#0)
> GET /pub/scm/git/git.git/info/refs HTTP/1.1
User-Agent: git/1.5.5.4
Host: www.kernel.org
Accept: */*

< HTTP/1.1 200 OK
< Date: Sat, 14 Jun 2008 07:08:36 GMT
< Server: Apache/2.2.2 (Fedora)
< Last-Modified: Sat, 14 Jun 2008 05:04:30 GMT
< ETag: "14225449-66de-44f9954509380"
< Accept-Ranges: bytes
< Content-Length: 26334
< Content-Type: text/plain; charset=UTF-8
< 
* Expire cleared
* Connection #0 to host www.kernel.org left intact

http://www.kernel.org/pub/scm/git/git.git/info/refs doesn't contain HEAD.
Shouldn't it ?

Mike
