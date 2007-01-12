From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Fri, 12 Jan 2007 12:39:37 -0300
Message-ID: <200701121539.l0CFdbR4017026@laptop13.inf.utfsm.cl>
References: <J.Sixt@eudaptics.com>
Cc: git@vger.kernel.org, Chris Riddoch <riddochc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 12 16:40:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5OVu-0005bv-20
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 16:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbXALPj6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 10:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbXALPj6
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 10:39:58 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:55529 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932113AbXALPj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 10:39:57 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0CFdcWp001332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 12 Jan 2007 12:39:38 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0CFdbR4017026;
	Fri, 12 Jan 2007 12:39:37 -0300
To: Johannes Sixt <J.Sixt@eudaptics.com>
In-Reply-To: Message from Johannes Sixt <J.Sixt@eudaptics.com> 
   of "Fri, 12 Jan 2007 15:39:56 BST." <45A79DBC.1795F5C4@eudaptics.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 12 Jan 2007 12:39:38 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2437/Thu Jan 11 20:59:09 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36678>

Johannes Sixt <J.Sixt@eudaptics.com> wrote:
> "Horst H. von Brand" wrote:
> > Hum... something like the following (completely untested!) should do the
> > trick:
> > 
> >   cd /basedir
> >   mkdir codebase; cd codebase; git init-db
> >   for version in 1.0 1.1 1.1a 1.1b 2.0.0 ...; do
> >      cd /basedir
> >      tar xf tarball-$version.tar
> >      mv codebase-$version/* codebase    # Take care to move everything!
> >      cd codebase
> >      git add .
> >      git commit -a -m "Updated to $version"
> >      rm -rf *                  # Delete everything except for git stuff
> >   done
> 
> You can let GIT_DIR point somewhere outside the extracted directory.

OK! Then it would be:

   cd /basedir
   mkdir codebase/.git; cd codebase; git init-db
   for version in 1.0 1.1 1.1a 1.1b 2.0.0 ...; do
      cd /basedir
      tar xf tarball-$version.tar
      cd codebase-$version
      git --git-dir=/basedir/codebase/.git add .
      git --git-dir=/basedir/codebase/.git \
          commit -a -m "Updated to $version"    # Spice up to taste
   done

And the "add" looks strangely misplaced... but it /does/ its job.

> If the dates of your tarballs are meaningful, you can use something like
> this:
> 
> export GIT_AUTHOR_DATE="$(date --reference=foo-1.1.tar +%s) -07:00"

Better use it to make up a commit message. Could use inline docs for this.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
