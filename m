From: "J. Bakshi" <joydeep.bakshi@infoservices.in>
Subject: Re: gitweb with multiple projectroot ???
Date: Fri, 8 Jun 2012 13:27:19 +0530
Message-ID: <20120608132719.60263607@shiva.selfip.org>
References: <20120605174028.15e6af39@shiva.selfip.org>
	<20120606124538.4fdd8610@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Jun 08 09:57:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scu4d-0006zv-A6
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 09:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761440Ab2FHH53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 03:57:29 -0400
Received: from static.88-198-19-49.clients.your-server.de ([88.198.19.49]:52239
	"EHLO zimbra.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760076Ab2FHH51 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2012 03:57:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.infoservices.in (Postfix) with ESMTP id 5FD5ADA32E8
	for <git@vger.kernel.org>; Fri,  8 Jun 2012 09:57:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.infoservices.in
Received: from zimbra.infoservices.in ([127.0.0.1])
	by localhost (zimbra.infoservices.in [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sS92hVAFoejT for <git@vger.kernel.org>;
	Fri,  8 Jun 2012 09:57:24 +0200 (CEST)
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by zimbra.infoservices.in (Postfix) with ESMTPSA id 71B0CDA32CD
	for <git@vger.kernel.org>; Fri,  8 Jun 2012 09:57:23 +0200 (CEST)
In-Reply-To: <20120606124538.4fdd8610@shiva.selfip.org>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199467>


 Any head up ?



On Wed, 6 Jun 2012 12:45:38 +0530
"J. Bakshi" <joydeep.bakshi@infoservices.in> wrote:

> 
> From the http://www.kernel.org/pub/software/scm/git/docs/v1.7.8/gitweb.html
> I have found the following
> 
> [.........]
> 
> Here actual project root is passed to gitweb via GITWEB_PROJECT_ROOT environment variable from a web server,
> so you need to put the following line in gitweb configuration file (/etc/gitweb.conf in above example):
> 
> $projectroot = $ENV{'GITWEB_PROJECTROOT'} || "/pub/git";
> 
> Note that this requires to be set for each request, so either $per_request_config must be false, 
> or the above must be put in code referenced by $per_request_config;
> 
> [.........]
> 
> 
> I have already set  
> 
> $per_request_config = 'false';
> 
> at /etc/gitweb.conf but no effect. 
> 
> I appreciate if anyone put me on the right track.
> 
> Thanks
> 
> On Tue, 5 Jun 2012 17:40:28 +0530
> "J. Bakshi" <joydeep.bakshi@infoservices.in> wrote:
> 
> > Dear list,
> > 
> > My gitweb has been running since long with a single project root, which
> > has been defined at the /etc/gitweb.conf through $projectroot variable.
> > 
> > I need one more project root for gitweb, hence I have added this apache config
> > ( not a vhost, but just calling by alias)
> > 
> > ````````````````````
> >  
> > SetEnv GIT_PROJECT_ROOT /home/newgit/
> > SetEnv GIT_HTTP_EXPORT_ALL
> > SetEnv  GITWEB_CONFIG  /home/newgit/gitweb.conf
> > #git is strict about the authenticated SSL certificate only
> > #disable the strict CA certificate check
> > SetEnv GIT_SSL_NO_VERIFY 
> > 
> > AliasMatch ^/newgit/(.*/objects/[0-9a-f]{2}/[0-9a-f]{38})$       /home/newgit/$1
> > AliasMatch ^/newgit/(.*/objects/pack/pack-[0-9a-f]{40}.(pack|idx))$ /home/newgit/$1
> > ScriptAliasMatch \
> >         "(?x)^/newgit/(.*/(HEAD | \
> >                         info/refs | \
> >                         objects/info/[^/]+ | \
> >                         git-(upload|receive)-pack))$" \
> >         /usr/lib/git-core/git-http-backend/$1
> > 
> > #same location for gitweb
> > Alias /newgit /usr/share/gitweb
> > <Directory /usr/share/gitweb>
> > Options FollowSymLinks +ExecCGI
> > AddHandler cgi-script .cgi
> > </Directory>
> > 
> > #force https and authentication
> > <LocationMatch "/newgit">
> > # Require SSL connection for password protection.
> > SSLRequireSSL
> > AuthType Basic
> > # Message to give to the committer
> > AuthName "access requires a password"
> > # File listing users with write (commit) access
> > AuthUserFile /home/newgit/PASSWD
> > Require valid-user
> > </LocationMatch>
> > 
> > `````````````````````````````````````````SetEnv
> > 
> > But "SetEnv  GITWEB_CONFIG" as well as other SetEnv ( like SetEnv GIT_SSL_NO_VERIFY )
> > is not been taken and as an effect the gitweb processing the default /etc/gitweb.conf and going to the
> > old projectroot.
> > 
> > What am I missing here ? any clue ?
> > 
> > Thanks
> > --
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
