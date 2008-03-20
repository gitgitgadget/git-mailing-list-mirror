From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: Importing all modules in a CVS repo with git-cvsimport
Date: Thu, 20 Mar 2008 09:58:50 +0000
Message-ID: <1206007130.24610.6.camel@pitcairn.cambridgebroadband.com>
References: <1205951736.24610.3.camel@pitcairn.cambridgebroadband.com>
	 <20080319204154.GA19556@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 20 10:59:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcHYY-0002VX-LV
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 10:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614AbYCTJ6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 05:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753652AbYCTJ6u
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 05:58:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:35943 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056AbYCTJ6t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 05:58:49 -0400
Received: by nf-out-0910.google.com with SMTP id g13so402334nfb.21
        for <git@vger.kernel.org>; Thu, 20 Mar 2008 02:58:47 -0700 (PDT)
Received: by 10.78.123.4 with SMTP id v4mr4278030huc.50.1206007126993;
        Thu, 20 Mar 2008 02:58:46 -0700 (PDT)
Received: from ?10.0.0.166? ( [212.44.17.78])
        by mx.google.com with ESMTPS id f4sm9096748nfh.26.2008.03.20.02.58.45
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 20 Mar 2008 02:58:45 -0700 (PDT)
In-Reply-To: <20080319204154.GA19556@coredump.intra.peff.net>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77646>


On Wed, 2008-03-19 at 16:41 -0400, Jeff King wrote:
> On Wed, Mar 19, 2008 at 06:35:36PM +0000, Alex Bennee wrote:
> 
> > I'm wanting to import the entirety of a CVS repository into git rather
> > than an individual module. However every approach I've tried to do this
> > fails as the underlying cvsps tool seems to only be able to deal with
> > modules rather than the whole project.
> > 
> > Is there any invocation I could do that would do the whole import?
> 
> What do you want the result to look like? If you have CVS modules 'foo',
> 'bar', and 'baz', I assume you want a repository with subdirectories
> 'foo', 'bar', and 'baz'?
> 
> In that case, you can create a CVS module that just includes all three:
> 
>   cd /path/to/cvsroot
>   mkdir all
>   cd all
>   for i in foo bar baz; do
>     ln -s ../$i
>   done
> 
> and then:
> 
>   git cvsimport all

Hmm that fails:

09:55 ajb@pitcairn/x86_64 [test.cvs] >perl /export/src/git.git/git-cvsimport.perl -v -C /export/csrc/import_test/test.git all
Initialized empty Git repository in /export/csrc/import_test/test.git/.git/
Running cvsps...
cvs rlog: Logging .
WARNING: file /newcvs/.cvsignore doesn't match strip_path /newcvs/all/. ignoring
WARNING: file /newcvs/Attic/Make.rules doesn't match strip_path /newcvs/all/. ignoring
WARNING: file /newcvs/Makefile doesn't match strip_path /newcvs/all/. ignoring
WARNING: file /newcvs/Makefile.voip doesn't match strip_path /newcvs/all/. ignoring
WARNING: file /newcvs/Attic/Vectastar.bom doesn't match strip_path /newcvs/all/. ignoring
WARNING: file /newcvs/Attic/dMakefile doesn't match strip_path /newcvs/all/. ignoring
cvs rlog: Logging CVSROOT
WARNING: file /newcvs/CVSROOT/checkoutlist doesn't match strip_path /newcvs/all/. ignoring
WARNING: file /newcvs/CVSROOT/commitinfo doesn't match strip_path /newcvs/all/. ignoring
WARNING: file /newcvs/CVSROOT/config doesn't match strip_path /newcvs/all/. ignoring
WARNING: file /newcvs/CVSROOT/cvsignore doesn't match strip_path /newcvs/all/. ignoring

test.cvs is a fresh checkout of the whole tree. "newcvs" is the root of
CVS on the server. The warnings are the same when I try with "." as the
module. Or where you saying do this with the actually CVS repo itself?

> You might be able to do something similar with the CVSROOT/modules file,
> but I haven't tried.



> 
> -Peff
Alex, homepage: http://www.bennee.com/~alex/ There is no fool to the old
fool. -- John Heywood
