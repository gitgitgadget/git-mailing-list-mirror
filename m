From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: How does gitosis know who the key belongs to
Date: Fri, 25 Sep 2009 08:33:14 +0200
Message-ID: <20090925063314.GB27809@book.hvoigt.net>
References: <26ae428a0909240751k3a799750h121935a79439b389@mail.gmail.com> <20090924172610.GA31309@book.hvoigt.net> <vpqskeckuto.fsf@bauges.imag.fr> <26ae428a0909242310r259ccf5eya7c95b8f43fc5c23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Fri Sep 25 08:33:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mr4Mt-0006EI-5P
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 08:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbZIYGdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 02:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbZIYGdN
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 02:33:13 -0400
Received: from darksea.de ([83.133.111.250]:48325 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751704AbZIYGdM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 02:33:12 -0400
Received: (qmail 7981 invoked from network); 25 Sep 2009 08:33:14 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 25 Sep 2009 08:33:14 +0200
Content-Disposition: inline
In-Reply-To: <26ae428a0909242310r259ccf5eya7c95b8f43fc5c23@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129064>

On Fri, Sep 25, 2009 at 07:10:07AM +0100, Howard Miller wrote:
> 2009/9/24 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> > Heiko Voigt <hvoigt@hvoigt.net> writes:
> >
> >> On Thu, Sep 24, 2009 at 03:51:44PM +0100, Howard Miller wrote:
> >> Not much different. It uses the command feature of the authorized_keys
> >> file of ssh to limit access to the 'gitosis-serve' command which is
> >> given the username from the gitosis.conf as argument.
> >
> > ... the username -> key association being done in gitosis's
> > configuration itself (the key held in keydir/foobar is the one of user
> > foobar).
> 
> 
> Yes, I realise that the association is done im gitosis' config file,
> but that is exactly my question - how does that association work?
> 
> To take a step back - I have to put a name (or a name@hostname) in the
> configuration file. How do I know what that should be in the general
> sense?

Anything you like. The username is deducted from the filename in the
keydir file as Matthieu alredy pointed out. e.g:

  keydir/hvoigt.pub	<--- file contains my public key
  
  gitosis.conf contents:
  
  [group hvoigt-projects]
  members = hvoigt
  writable = myproject
  
That would give access to git@yourserver:myproject.git to the key in
hvoigt.pub. Technically its done using a update hook on the server which
is run when you push the configuration repository. It scans the config
and installs the keys in the authorized_keys file of the git user. The
above would look something like this in the git's users home dir:

  .ssh/auhtorized_keys:
  
  command="gitosis-serve hvoigt",no-port-forwarding,no-X11-forwarding,\
    no-agent-forwarding,no-pty ssh-dss AAAA... hvoigt@localhost

Because ssh can match the key you are using to one of such lines the
gitosis-serve command is given the according username.

Does this make it a little bit clearer ?

cheers Heiko
