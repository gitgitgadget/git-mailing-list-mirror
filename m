From: "J. Bakshi" <joydeep.bakshi@infoservices.in>
Subject: gitweb with multiple projectroot ???
Date: Tue, 5 Jun 2012 17:40:28 +0530
Message-ID: <20120605174028.15e6af39@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 14:10:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbsat-0005U3-Lc
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 14:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756789Ab2FEMKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 08:10:35 -0400
Received: from static.88-198-19-49.clients.your-server.de ([88.198.19.49]:56433
	"EHLO zimbra.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756859Ab2FEMKe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2012 08:10:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.infoservices.in (Postfix) with ESMTP id 102ADDA3BC0
	for <git@vger.kernel.org>; Tue,  5 Jun 2012 14:10:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.infoservices.in
Received: from zimbra.infoservices.in ([127.0.0.1])
	by localhost (zimbra.infoservices.in [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hFMhd2cFGT+v for <git@vger.kernel.org>;
	Tue,  5 Jun 2012 14:10:33 +0200 (CEST)
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by zimbra.infoservices.in (Postfix) with ESMTPSA id 90703DA3BAE
	for <git@vger.kernel.org>; Tue,  5 Jun 2012 14:10:32 +0200 (CEST)
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199233>

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
