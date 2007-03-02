From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH, 4th version] git-branch: register where to merge from,
 when branching off a remote branch
Date: Fri, 2 Mar 2007 16:54:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703021647560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <es450f$d58$1@sea.gmane.org>
 <Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com>
 <45E68897.8000607@lu.unisi.ch> <81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com>
 <45E68EDE.2090405@lu.unisi.ch> <81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com>
 <45E69297.8070001@lu.unisi.ch> <81b0412b0703010059w52a33b54n4d3c25ada6b96369@mail.gmail.com>
 <45E69EEE.8070905@lu.unisi.ch> <81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com>
 <7vvehls1h9.fsf@assigned-by-dhcp.cox.net> <45E70041.1030705@lu.unisi.ch>
 <Pine.LNX.4.63.0703012240210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45E7DC04.5010701@lu.unisi.ch> <45E7E53E.5020704@gnu.org>
 <7vtzx4ezvm.fsf@assigned-by-dhcp.cox.net> <45E8072A.2020303@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Paolo Bonzini <paolo.bonzini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 16:54:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNA5c-0005zz-LT
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 16:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992540AbXCBPye (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 10:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992537AbXCBPye
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 10:54:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:32798 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992540AbXCBPyd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 10:54:33 -0500
Received: (qmail invoked by alias); 02 Mar 2007 15:54:32 -0000
X-Provags-ID: V01U2FsdGVkX19+Q/EF97F+KzIed6vMJqd9yAanQirIWkp5rCKlx2
	Hv1rvv8pi9TOJa
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45E8072A.2020303@lu.unisi.ch>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41223>

Hi,

On Fri, 2 Mar 2007, Paolo Bonzini wrote:

> >  - (micronit) Is it true that both strlen() tests are about long
> >    *branch* names?

Yes. "name" refers to the _new_ branch, and "remote_branch_name" refers to 
the remote branch.

> >  - (moderately serious) The code blindly trusts that
> >    "refs/remotes/foo/bar" tracks "refs/heads/bar" from remote
> >    named "foo", which is a bit disturbing.  With the default
> >    configuration git-clone and git-remote creates, it always is
> >    the case, but I suspect you might want to at least verify
> >    that assumption (the user can have different settings in the
> >    config), if not figuring them out by reading the existing
> >    configuration yourself.
> 
> Ouch.  Absolutely right, but this means I will prepare the patch later 
> then.

I really recommend doing what I said in another reply: check that 
the remote information in the config for that remote meets our 
expectations. And do nothing at all if it does not (maybe warn that no 
branch.<foo> voodoo was done).

> >> +	else if (dwim_ref(start_name, strlen(start_name), sha1, &real_ref))
> >> +		remote = !prefixcmp(real_ref, "refs/remotes/");
> > 
> >  - (pure question) What happens if dwim_ref() returns more than one?
> 
> Then, real_ref is the one matching sha1.

Which one ;-)

What Junio tried to get at: if you have "refs/heads/my" and 
"refs/remotes/origin/my", dwim_ref("my", ...) returns 2 (or even more, if 
you have other refs ending in "/my").

Please test if the return value is exactly 1, and if it is not, do 
nothing.

Ciao,
Dscho
