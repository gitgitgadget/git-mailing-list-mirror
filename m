From: "J. Bakshi" <joydeep.bakshi@infoservices.in>
Subject: gitweb with multiple projectroot ???
Date: Mon, 4 Jun 2012 19:07:37 +0530
Message-ID: <20120604190737.4f357a16@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 15:45:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbXbD-0003O3-F7
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 15:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040Ab2FDNpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 09:45:31 -0400
Received: from static.88-198-19-49.clients.your-server.de ([88.198.19.49]:57496
	"EHLO zimbra.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753478Ab2FDNpa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2012 09:45:30 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jun 2012 09:45:30 EDT
Received: from localhost (localhost [127.0.0.1])
	by zimbra.infoservices.in (Postfix) with ESMTP id 0A7F9DA3911
	for <git@vger.kernel.org>; Mon,  4 Jun 2012 15:37:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.infoservices.in
Received: from zimbra.infoservices.in ([127.0.0.1])
	by localhost (zimbra.infoservices.in [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EM3Nc0jYLQCZ for <git@vger.kernel.org>;
	Mon,  4 Jun 2012 15:37:42 +0200 (CEST)
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by zimbra.infoservices.in (Postfix) with ESMTPSA id 8E6BADA390D
	for <git@vger.kernel.org>; Mon,  4 Jun 2012 15:37:41 +0200 (CEST)
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199135>

Dear list,

My gitweb has been running since long with a single project root, which
has been defined at the /etc/gitweb.conf through $projectroot variable.

I need one more project root for gitweb, hence I have added this apache config
( not a vhost, but just calling by alias)

````````````````````
 
SetEnv GIT_PROJECT_ROOT /home/newgit/
SetEnv GIT_HTTP_EXPORT_ALL
SetEnv  GITWEB_CONFIG  /home/newgit/gitweb.conf
#git is strict about the authenticated SSL certificate only
#disable the strict CA certificate check
SetEnv GIT_SSL_NO_VERIFY 

AliasMatch ^/newgit/(.*/objects/[0-9a-f]{2}/[0-9a-f]{38})$       /home/newgit/$1
AliasMatch ^/newgit/(.*/objects/pack/pack-[0-9a-f]{40}.(pack|idx))$ /home/newgit/$1
ScriptAliasMatch \
        "(?x)^/newgit/(.*/(HEAD | \
                        info/refs | \
                        objects/info/[^/]+ | \
                        git-(upload|receive)-pack))$" \
        /usr/lib/git-core/git-http-backend/$1

#same location for gitweb
Alias /newgit /usr/share/gitweb
<Directory /usr/share/gitweb>
Options FollowSymLinks +ExecCGI
AddHandler cgi-script .cgi
</Directory>

#force https and authentication
<LocationMatch "/newgit">
# Require SSL connection for password protection.
SSLRequireSSL
AuthType Basic
# Message to give to the committer
AuthName "access requires a password"
# File listing users with write (commit) access
AuthUserFile /home/newgit/PASSWD
Require valid-user
</LocationMatch>

`````````````````````````````````````````SetEnv

But "SetEnv  GITWEB_CONFIG" as well as other SetEnv ( like SetEnv GIT_SSL_NO_VERIFY )
is not been taken and as an effect the gitweb processing the default /etc/gitweb.conf and going to the
old projectroot.

What am I missing here ? any clue ?

Thanks
