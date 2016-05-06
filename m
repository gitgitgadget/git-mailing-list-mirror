From: Yaroslav Halchenko <yoh@onerussian.com>
Subject: wishlist; unify behavior while cloning non-bare repos over http to
 be in line with ssh/local
Date: Fri, 6 May 2016 09:18:55 -0400
Message-ID: <20160506131855.GD7907@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Michael Hanke <michael.hanke@gmail.com>
To: Git Gurus hangout <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 06 15:19:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayfeo-0002SX-AZ
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 15:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758072AbcEFNS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 09:18:58 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:40133 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757596AbcEFNS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 09:18:57 -0400
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <yoh@onerussian.com>)
	id 1ayfei-00055t-2O; Fri, 06 May 2016 09:18:56 -0400
Received: from yoh by washoe.onerussian.com with local (Exim 4.84)
	(envelope-from <yoh@onerussian.com>)
	id 1ayfeh-00055o-QK; Fri, 06 May 2016 09:18:55 -0400
Content-Disposition: inline
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org, benjaminpoldrack@gmail.com, michael.hanke@gmail.com
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293777>

Dear Git Folks,

Originally this issue was mentioned in previous thread [1], and I have decided
to bring it into a separate thread.  ATM there is a dichotomy in git behavior
between cloning non-bare repos:  if I clone over ssh or just locally by
providing url without trailing /.git, git senses for /.git and works just fine
with ssh or local repositories, but fails for "dummy" http ones, the demo
script is here [2] which produces output listed below.  From which you can see
that  cloning using http URL to the repository without /.git fails (git version
2.8.1, Debian).  As it was noted in [1], concern could have been to not
traverse website since could lead to dangerous places.  But .git is under
originating url directory, as well as info/ or HEAD or any other object
accessed by git, so IMHO this concern is not a concern.

So do you think that cloning from  http urls could be adjusted so git senses
for presence of .git/ subdirectory if originating url is missing necessary
/info/refs?.... ?  That would make behavior uniform and help us and users in
many use-cases IMHO (in particular with relative paths to submodules as in
[1])

Thank you in advance, and please maintain CC

$> /tmp/democlone
Initiating repo
cloning via ssh: localhost:/tmp/repo1
Cloning into 'repo1-ssh'...
remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (3/3), done.
Checking connectivity... done.
SUCCESS
cloning locally: /tmp/repo1
Cloning into 'repo1-local'...
done.
SUCCESS
starting local http server
Serving HTTP on 0.0.0.0 port 8080 ...
cloning via http: http://localhost:8080/repo1
Cloning into 'repo1-http-failed'...
127.0.0.1 - - [06/May/2016 09:13:41] code 404, message File not found
127.0.0.1 - - [06/May/2016 09:13:41] "GET /repo1/info/refs?service=git-upload-pack HTTP/1.1" 404 -
fatal: repository 'http://localhost:8080/repo1/' not found
FAILED
doing with /.git: http://localhost:8080/repo1/.git
Cloning into 'repo1-http'...
127.0.0.1 - - [06/May/2016 09:13:41] "GET /repo1/.git/info/refs?service=git-upload-pack HTTP/1.1" 200 -
127.0.0.1 - - [06/May/2016 09:13:41] "GET /repo1/.git/HEAD HTTP/1.1" 200 -
127.0.0.1 - - [06/May/2016 09:13:41] "GET /repo1/.git/objects/36/31fa81eb6422349035c915a5a11b177688f491 HTTP/1.1" 200 -
127.0.0.1 - - [06/May/2016 09:13:41] "GET /repo1/.git/objects/12/ddeb87cc045cd67063e95125fbeb014bd1d9b1 HTTP/1.1" 200 -
127.0.0.1 - - [06/May/2016 09:13:41] "GET /repo1/.git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391 HTTP/1.1" 200 -
Checking connectivity... done.
SUCCESS



[1] problems serving non-bare repos with submodules over http
http://thread.gmane.org/gmane.comp.version-control.git/292032
[2] http://www.onerussian.com/tmp/democlone
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
