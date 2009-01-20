From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git fast-import problem converting from CVS with git 1.6.1 and
 cvs2svn 2.2.0
Date: Tue, 20 Jan 2009 17:41:23 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901201736210.5159@intel-tinevez-2-302>
References: <63BEA5E623E09F4D92233FB12A9F794302BC6851@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Kelly F. Hickel" <kfh@mqsoftware.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 17:43:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPJgr-0005CZ-Bj
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 17:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757609AbZATQlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 11:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757550AbZATQlg
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 11:41:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:59906 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757385AbZATQlg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 11:41:36 -0500
Received: (qmail invoked by alias); 20 Jan 2009 16:41:31 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp068) with SMTP; 20 Jan 2009 17:41:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/RU8MnFpbRHw5/H42cveJrFZhD/YztSV+zkZmMLZ
	HNHJcd2cEN6mDP
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794302BC6851@emailmn.mqsoftware.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106490>

Hi,

On Tue, 20 Jan 2009, Kelly F. Hickel wrote:

> cat ../cvs2svn-tmp/git-blob.dat ../cvs2svn-tmp/git-dump.dat | git
> fast-import
> fatal: Unsupported command: '.
> fast-import: dumping crash report to .git/fast_import_crash_19097
> 
> The crash is 18MB and I'd rather not post it, but the only bits that
> seem somewhat interesting are:
> fast-import crash report:
>     fast-import process: 19097
>     parent process     : 19095
>     at Mon Jan 19 11:44:42 2009
> 
> fatal: Unsupported command: '.
> 
> Most Recent Commands Before Crash
> ---------------------------------
> (...)
>   reset refs/tags/T_9772
>   from :1000007127
>   reset refs/heads/TAG.FIXUP
>   
>   commit refs/heads/TAG.FIXUP
>   mark :1000007128
>   committer cvs2svn <cvs2svn> 1002043747 +0000
>   data 88
> * '.
> 
> 

That is strange.  The command "data 88" should read the next 88 bytes and 
not stop at the line starting with '.

Just to test, I successfully imported this:

-- snip --
commit refs/heads/testing/test
mark :1
committer cvs2svn <cvs2svn> 1002043747 +0000
data 3
'.

-- snap --

So I guess the problem lies much earlier: I could imagine that there is 
_another_ "data" command that has a bogus length and just happens to end 
after the line "data 88".

Maybe that helps?

I could also imagine that the '. actually is the end of an example 
inside a blob, that literally looks like a fast-import script, but 
actually is not meant for _this_ fast-import run.

Ciao,
Dscho
