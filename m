From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: Why /var/cache/git?
Date: Mon, 25 Oct 2010 08:24:47 -0700
Message-ID: <4CC5A13F.2090702@eaglescrag.net>
References: <20101025103006.GA18782@brong.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pape@smarden.org
To: Bron Gondwana <brong@fastmail.fm>
X-From: git-owner@vger.kernel.org Mon Oct 25 17:30:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAOzr-0003pp-JH
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 17:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756274Ab0JYP35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 11:29:57 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:58906 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755114Ab0JYP34 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 11:29:56 -0400
Received: from voot-cruiser.eaglescrag.net ([216.239.45.19])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id o9PFOmox028304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Mon, 25 Oct 2010 08:24:49 -0700
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.7
In-Reply-To: <20101025103006.GA18782@brong.net>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Mon, 25 Oct 2010 08:24:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159960>

On 10/25/2010 03:30 AM, Bron Gondwana wrote:
> (resent - correct address for git list!)
> 
> (Gerrit: you're CC'd as the attribution in README.Debian
>  which in the one place I can see /var/cache/git mentioned
>  in the docs - without a justification for why it was
>  chosen...)

Couple of quick points:

$ grep -Ri "/var/git\|\/var\/git" *
Documentation/git-cvsserver.txt:     export
CVSROOT=:ext:user@server:/var/git/project.git

gitweb/README:    RewriteRule ^/var(/|/gitweb.cgi)?$	
/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/var/git/,L,PT]

gitweb/README:Second, repositories found in /pub/scm/ and /var/git/ will
be accesible

Are the only 3 instances where this is mentioned.  Looking at those
quick it was probably chosen based on the fact that it's a location that
likely exists on most machines.  Or just for explanatory reasons like
/example/dir/project.git could be used.

> I'm setting up shared repositories on a machine, and I notice
> all the examples I can find on the web, and also the 
> auto-created directory from the packages are /var/cache/git/

I can't speak for the web, it's a place filled with many many evil dirty
lies, but the primary documentation should likely get updated to not
actually shove perminant data into a transient location.  Bonus that
gitweb (caching) might use the directory for it's cache storage which
could cause some amusement.

> 
> So I looked at the FHS, because that seemed odd to me:
[...]
> I guess in theory, someone else has all those commits in their
> local git repository somewhere.  Still, it feels to me that
> /var/lib/git is the correct location.  Is there any reason why
> /var/spool/git was chosen?

Ummmm are you talking about for where a set of repositories exist on a
shared setup?  Personally, and depending on your beliefs as a sysadmin,
it should likely end up under something like /home/git or some other
shared location like /group/git, /pub/git, /shared/git or really
anywhere where you are likely to do backups and not just run rm -rf
because it should be a transient location.

> (I'm running Debian Lenny with the 1.7.1 backport packages, but
> I see examples from Fedora with the same paths as well)

Speaking from the Fedora angle (since I don't have a Debian box handy
anywhere or in a VM) the only places I'm seeing /var/git mentioned is:

/usr/share/doc/git-1.7.2.3/git-cvsserver.txt
/usr/share/doc/git-1.7.2.3/git-cvsserver.html
/usr/share/doc/git-cvs-1.7.2.3/git-cvsserver.txt
/usr/share/doc/git-cvs-1.7.2.3/git-cvsserver.html
/usr/share/doc/git-cvs-1.7.2.3/git-cvsserver.html
/usr/share/doc/gitweb-1.7.2.3/README
/usr/share/doc/gitweb-caching-1.6.5.2/README

which are the latest versions of all of those packages and it's obvious
it's the git-cvs and gitweb stuff that are to blame for the confusion there.

Probably easiest thing to do is adjust the documentation to be
/example/dir/project.git vs. /var/git since I agree, that's actually
dangerous.

- John 'Warthog9' Hawley
