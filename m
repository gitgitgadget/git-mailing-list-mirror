From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: HOWTO set up a repository which can be pushed into over HTTP
Date: Wed, 9 Aug 2006 01:11:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608090049480.1800@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0608042021300.1800@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vac6kjoxh.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0608050044000.1800@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd5bd6ku8.fsf@assigned-by-dhcp.cox.net> <20060808190220.GA6001@nospam.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1657511205-1155078684=:1800"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 09 01:11:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAajS-0006xP-B9
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 01:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbWHHXL1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 19:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbWHHXL1
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 19:11:27 -0400
Received: from mail.gmx.de ([213.165.64.20]:32747 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965067AbWHHXL0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Aug 2006 19:11:26 -0400
Received: (qmail invoked by alias); 08 Aug 2006 23:11:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 09 Aug 2006 01:11:24 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@wingding.demon.nl
In-Reply-To: <20060808190220.GA6001@nospam.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25099>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1657511205-1155078684=:1800
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 8 Aug 2006, Rutger Nijlunsing wrote:

> On Mon, Aug 07, 2006 at 12:55:43AM -0700, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > Do people find it useful? Or would you like to wait until I implement an 
> > > option in git-http-push to actually init an HTTP repo remotely?
> > 
> > I do not have need for push over http-dav at the moment myself,
> > but I would imagine I would certainly look for it when I would
> > need to later.
> > 
> > Do people find it useful?  More importantly, has somebody else
> > independently tried to follow the documentation and found the
> > description accurate and helpful?
> 
> Today I did try to follow it, and it made an otherwise impossible job
> for me doable, although still taking too much hours and a patch. The
> 'impossible job' for me had to do with my zero-apache experience and
> (probably) a bug in WebDAV.

Thank you for doing that valuable work! I think the patch is fine (take 
that as an Acked-by:); next time you might want to send it as a proper 
patch mail ;-)

> -This text assumes that you
> -
> -- have an Apache webserver,
> -- can edit the configuration of it,
> -- can restart it, and
> +
> +What's needed:
> +
> +- Have an Apache webserver
> +
> +  On Debian:
> +    $ apt-get install apache2
> +    To get apache2 by default started,
> +    edit /etc/default/apache2 and set NO_START=0
> +
> +- can edit the configuration of it
> +
> +  On Debian: this means being able to edit files under /etc/apache2

On some other setups, it is /etc/httpd/. Since it is not specific to 
Debian, we might want to give some common options, but refer the user to 
the Apache manual if she cannot find it.

> +
> +- can restart it.
> +  'apachectl --graceful' might do.

It is Ã'apachectl graceful' here (without'--').

> +  On Debian:
> +    $ /etc/init.d/apache2 restart

This should work everywhere, except it might be called apache or httpd 
instead. However, please warn users that this interrupts (however briefly) 
a running webserver, and if you do that on a production machine, users 
just downloading an iso file might be rightfully upset.

>  - have permissions to chown a directory
>  
> +In effect, this probably means you're going to be root.

Right.

> -	$ cd /usr/local/apache/htdocs
> -	$ mkdir my-new-repo.git
> +    $ cd /usr/local/apache/htdocs
> +    $ mkdir my-new-repo.git
> +
> +  On Debian:
> +
> +    $ cd /var/www
> +    $ mkdir my-new-repo.git

Again, it might be cooler to be a bit more portable: if the user found 
httpd.config, he could just "grep DocumentRoot /where/ever/httpd.conf".

>  Change the ownership to your webserver's credentials
> + 
> +    $ chown -R www.www .
> +
> +  On Debian:
> +
> +    $ chown -R www-data.www-data .

Again, a better way would be to direct the user to "grep ^User httpd.conf" 
and "grep ^Group httpd.conf".

> +Restart apache2, and check whether http://server/my-new-repo.git gives
> +a directory listing. If not, check whether apache started up
> +succesfully.

A useful addition.

>  Step 2: enable DAV on this repository
>  -------------------------------------
>  
> -In your httpd.conf, make sure that this line exists:
> +In your httpd.conf, make sure that this line exists which is the file
> +used for locking DAV operations:
> +
> +  DAVLockDB "/usr/local/apache2/temp/DAV.lock"
> +
> +  On Debian:
>  
> -	DAVLockDB "/usr/local/apache2/temp/DAV.lock"
> +    Enable the dav and dav_fs modules of apache:
> +    $ a2enmod dav_fs
> +    $ a2enmod dav
> +    The DAV lock is located in /etc/apache2/mods-available/dav_fs.conf:
> +      DAVLockDB /var/lock/apache2/DAVLock

I did not find a2enmod on my only Debian setup, so a more portable way 
would be to tell the user to insert the following lines in httpd.conf:

	LoadModule dav_module libexec/httpd/libdav.so
	AddModule mod_dav.c

(I do not know if there are setups where you have to load dav_fs 
explicitely...)

>  Then, add something like this to your httpd.conf
>  
> -	<Location /my-new-repo.git>
> -		DAV on
> -		AuthType Basic
> -		AuthName "Git"
> -		AuthUserFile /usr/local/apache2/conf/passwd.git
> -		Require valid-user
> -	</Location>
> +  <Location /my-new-repo.git>
> +     DAV on
> +     AuthType Basic
> +     AuthName "Git"
> +     AuthUserFile /usr/local/apache2/conf/passwd.git
> +     Require valid-user
> +  </Location>
> +
> +  On Debian:
> +    Create (or add to) /etc/apache2/conf.d/git.conf :

Is this picked up automatically?

> +    <Location /my-new-repo.git>
> +       DAV on
> +       AuthType Basic
> +       AuthName "Git"
> +       AuthUserFile /etc/apache2/passwd.git
> +       Require valid-user
> +    </Location>

We should not violate the DRY principle ("DonÂ´'Repeat Yourself").

> +
> +The password file can be somewhere else, but it has to be readable by
> +Apache and preferably not readable by the world.
>  
> -The password file can be somewhere else, but it has to be readable by 
> -Apache.
> +Create this file by
> +    $ htpasswd -c /usr/local/apache2/conf/passwd.git <user>
>  
> -You can create this file by
> +    On Debian:
> +      $ htpasswd -c /etc/apache2/passwd.git <user>
>  
> -	$ htpasswd -c /usr/local/apache2/conf/passwd.git <user>
> -
> -you will be asked a password, and the file is created. Subsequent calls
> +You will be asked a password, and the file is created. Subsequent calls
>  to htpasswd should omit the '-c' option, since you want to append to the
>  existing file.
>  
> -You need to restart Apache; 'apachectl --graceful' is sufficient.

So, it was my fault to begin with: the '--' is wrong.

> +Now go to http://<username>@<servername>/my-new-repo.git in your
> +browser to check whether it asks for a password and accepts the right
> +password.

Helpful.

> +On Debian:
> +
> +   To test the WebDAV part, do:
> +
> +   $ apt-get install litmus
> +   $ litmus http://<servername>/my-new-repo.git <username> <password>

There has to be a more portable way to test WebDAV, like an URL to type 
into a webbrowser. DAV wizards, anyone?

> -Then, add the following to your .netrc (you can do without, but will be
> +Then, add the following to your ~/.netrc (you can do without, but will be

Okay, I thought it was common knowledge where this resides. Although I 
would say $HOME/.netrc instead.

> +...and set permissions:
> +     chmod 600 ~/.netrc

Yeah, right. I always forget about this.

> +    On Windows, use %HOMEDRIVE%%HOMEPATH%.netrc instead.

Huh? You want to access it with something else than cygwin?

> +To check whether all is OK, do:
> +
> +   curl --netrc --location -v http://<username>@<servername>/my-new-repo.git/
> +
> +...this should give a directory listing in HTML of /var/www/my-new-repo.git .

Does everybody who has libcurl installed, have curl installed also?

>  >From your client repository, do
>  
> -	$ git-http-push upload master
> +   $ git push upload master
> +
> +This pushes branch 'master' (which is assumed to be the branch you
> +want to export) to repository called 'upload', which we previously
> +defined with git-repo-config.
>  
> -(This assumes that the branch you want to export is called 'master' in your
> -client setup...)

Your wording is much clearer.

>  request; This can happen when you start Apache, but then disable the
>  network interface. A simple restart of Apache helps.
>  
> -In other cases, reading /usr/local/apache2/logs/error_log is often helpful.
> -
> +Errors like (22/502) are of format (curl error code/http error
> +code). So (22/404) means something like 'not found' at the server.

I think the error log is more useful than the http error codes.

Ciao,
Dscho

---1148973799-1657511205-1155078684=:1800--
