From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Fri, 12 Jan 2007 11:09:09 -0300
Message-ID: <200701121409.l0CE9923015123@laptop13.inf.utfsm.cl>
References: <riddochc@gmail.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 15:09:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5N5p-0006dv-3C
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 15:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbXALOJO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 09:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbXALOJO
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 09:09:14 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:51791 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063AbXALOJN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 09:09:13 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0CE999W024590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 12 Jan 2007 11:09:09 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0CE9923015123;
	Fri, 12 Jan 2007 11:09:09 -0300
To: "Chris Riddoch" <riddochc@gmail.com>
In-Reply-To: Message from "Chris Riddoch" <riddochc@gmail.com> 
   of "Fri, 12 Jan 2007 06:41:21 PDT." <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 12 Jan 2007 11:09:09 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2437/Thu Jan 11 20:59:09 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36673>

Chris Riddoch <riddochc@gmail.com> wrote:
> I've got a very, very old codebase I'm trying to wrap my head around.
> It was apparently once tracked with RCS, but the ,v files are long
> gone and all that remains are a series of tarballs on an FTP site
> containing alpha, beta, and final releases of various versions of the
> project.  There's a logical progression, but between each there are
> new files, deleted files, and lots of changed files.  gitk will at
> least help me make sense of the actual changes.  I've got part of a
> shell script to automate this process.
> 
> Here's the problem.
> 
> I have tried to follow the debate on git add, rm, commit -a, etc.  But
> I can't figure out how to simply say, take the full state of the
> working directory, and make the index directly reflect that state.
> Additions, removals, and differences alike.  One step, preferably.

Hum... something like the following (completely untested!) should do the
trick:

  cd /basedir
  mkdir codebase; cd codebase; git init-db
  for version in 1.0 1.1 1.1a 1.1b 2.0.0 ...; do
     cd /basedir
     tar xf tarball-$version.tar
     mv codebase-$version/* codebase    # Take care to move everything!
     cd codebase
     git add .
     git commit -a -m "Updated to $version"
     rm -rf *                  # Delete everything except for git stuff
  done

Files that don't change will be recorded as is (git tracks contents).
    
Comments?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
