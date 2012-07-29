From: Bo98 <BoEllisAnderson@aol.com>
Subject: PROPFIND 405 with git-http-backend and Smart HTTP
Date: Sun, 29 Jul 2012 11:52:46 -0700 (PDT)
Message-ID: <1343587966493-7564017.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 29 20:52:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvYbk-0000SL-7d
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 20:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393Ab2G2Swr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 14:52:47 -0400
Received: from sam.nabble.com ([216.139.236.26]:59734 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753367Ab2G2Swr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 14:52:47 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <BoEllisAnderson@aol.com>)
	id 1SvYbe-0002rT-Nm
	for git@vger.kernel.org; Sun, 29 Jul 2012 11:52:46 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202491>

I'm setting up a git server with git-http-backend and Smart HTTP but I'm
getting PROPFIND Error 405 with git push.

Here's my config:

    <VirtualHost *:8000>
      ServerName localhost
      DocumentRoot /opt/local/apache2/htdocs/repo

      SetEnv GIT_PROJECT_ROOT /opt/local/apache2/htdocs/repo
      SetEnv GIT_HTTP_EXPORT_ALL

      ScriptAlias /repo/ /usr/libexec/git-core/git-http-backend/
      AliasMatch ^/repo/(.*/objects/[0-9a-f]{2}/[0-9a-f]{38})$         
/opt/local/apache2/htdocs/repo/$1
      AliasMatch ^/repo/(.*/objects/pack/pack-[0-9a-f]{40}.(pack|idx))$
/opt/local/apache2/htdocs/repo/$1

      ScriptAliasMatch \
        "(?x)^/repo/(.*/(HEAD | \
        info/refs | \
        objects/(info/[^/]+ | \
            [0-9a-f]{2}/[0-9a-f]{38} | \
            pack/pack-[0-9a-f]{40}\.(pack|idx)) | \
        git-(upload|receive)-pack))$" \
        /usr/libexec/git-core/git-http-backend/$1

      <LocationMatch "^/repo/.*/git-receive-pack$">
        AuthType Basic
        AuthName "Git"
        Require valid-user
        AuthUserFile /etc/apache2/other/htpasswd
      </LocationMatch>
    </VirtualHost>

And here's a snip from my access_log:

    ::1 - - [29/Jul/2012:18:34:34 +0100] "GET
/repo/myproject.git/info/refs?service=git-receive-pack HTTP/1.1" 200 117
    ::1 - - [29/Jul/2012:18:34:34 +0100] "GET /repo/myproject.git/HEAD
HTTP/1.1" 200 23
    ::1 - - [29/Jul/2012:18:34:34 +0100] "PROPFIND /repo/myproject.git/
HTTP/1.1" 405 247

Any ideas?



--
View this message in context: http://git.661346.n2.nabble.com/PROPFIND-405-with-git-http-backend-and-Smart-HTTP-tp7564017.html
Sent from the git mailing list archive at Nabble.com.
