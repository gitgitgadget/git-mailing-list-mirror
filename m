From: Yaroslav Halchenko <debian@onerussian.com>
Subject: Re: problem cloning via http since v1.6.6-rc0
Date: Wed, 20 Jan 2010 23:38:36 -0500
Message-ID: <20100121043836.GC18213@onerussian.com>
References: <20100121004756.GA18213@onerussian.com>
 <be6fef0d1001201736g9160306g51949a5f36d83e14@mail.gmail.com>
 <20100121023310.GB18213@onerussian.com>
 <be6fef0d1001202001h4c794166y4bcf01b42f3ea1bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 05:38:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXoog-0000sY-SW
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 05:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625Ab0AUEij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 23:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754555Ab0AUEij
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 23:38:39 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:60275 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401Ab0AUEij (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 23:38:39 -0500
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1NXooX-0001EQ-13; Wed, 20 Jan 2010 23:38:37 -0500
Received: from yoh by washoe.onerussian.com with local (Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1NXooW-0001EN-QO; Wed, 20 Jan 2010 23:38:36 -0500
Content-Disposition: inline
In-Reply-To: <be6fef0d1001202001h4c794166y4bcf01b42f3ea1bb@mail.gmail.com>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: 3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: rctay89@gmail.com, git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137629>


On Thu, 21 Jan 2010, Tay Ray Chuan wrote:
> > fatal: http://git.debian.org/git/pkg-exppsy/pymvpa.git/info/refs?service=git-upload-pack not found: did you run git update-server-info on the server?
> I don't think git's at fault here, as we're getting a 404 Not Found.
khe khe, pardon me, but if git can't talk to its nephew (ie its own
repository which was created with earlier version), whenever another
nephew (ie git of earlier version) can talk to it, I do consider it to
be git's fault ;)

let me zoom in onto difference in communication between two different versions :

*   Trying 217.196.43.134... * Connected to git.debian.org (217.196.43.134) port 80 (#0)
> GET /git/pkg-exppsy/pymvpa.git/info/refs HTTP/1.1
User-Agent: git/1.6.5
Host: git.debian.org
Accept: */*
Pragma: no-cache

< HTTP/1.1 200 OK

whenever, once again, for 1.6.6 it looked much shorter:

*   Trying 217.196.43.134... * Connected to git.debian.org (217.196.43.134) port 80 (#0)
> GET /git/pkg-exppsy/pymvpa.git/info/refs?service=git-upload-pack HTTP/1.1
User-Agent: git/1.6.6.267.g5b159
Host: git.debian.org
Accept: */*
Pragma: no-cache

* The requested URL returned error: 404
* Closing connection #0
fatal: http://git.debian.org/git/pkg-exppsy/pymvpa.git/info/refs?service=git-upload-pack not found: did you run git update-server-info on the server?


> Could you check that the repository (the one the url points to, after
> taking into any url rewriting) is a bare one, ie. has structure
yes - it is bare... I was 101% sure (isn't that a convention to have
.git suffix for directories with bare repositories), but just to make
sure:

$> cd /srv/git.debian.org/git/pkg-exppsy/pymvpa.git/
total 76
 8 branches/   8 config   8 description   8 HEAD   8 hooks/   8 info/   8 objects/  12 packed-refs   8 refs/


> If that's the case, I don't think it's related to your problem. (Btw,
> "smart" refers to the http protocol that git can use to sync your
> repo, via a CGI program on the server, instead of WebDAV. See
> git-http-backend(1) for details.)
thanks for info, I did know about this beastie.

I see no references to git-http-backend in apache config -- so indeed
should not be the case... but from the git-http-backend description:

,---
| By default, only the `upload-pack` service is enabled, which serves
| 'git-fetch-pack' and 'git-ls-remote' clients, which are invoked from
| 'git-fetch', 'git-pull', and 'git-clone'.
`---

so, it looks like 1.6.6 for some reason decided to assume that it is "smart"
http whenever it is not?  is that the case here?

-- 
Yaroslav O. Halchenko
Postdoctoral Fellow,   Department of Psychological and Brain Sciences
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
