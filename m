From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: serious problem with `git format-patch' & `git am'
Date: Thu, 26 Feb 2009 11:42:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902261138260.6258@intel-tinevez-2-302>
References: <20090225.230352.177616203.wl@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, keithp@keithp.com
To: Werner LEMBERG <wl@gnu.org>
X-From: git-owner@vger.kernel.org Thu Feb 26 11:44:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcdiY-0007Bd-Pd
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 11:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbZBZKmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 05:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753096AbZBZKmX
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 05:42:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:58759 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751274AbZBZKmW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 05:42:22 -0500
Received: (qmail invoked by alias); 26 Feb 2009 10:42:19 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp052) with SMTP; 26 Feb 2009 11:42:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/RxAoipt3RJFuS3Gf2K3957RRh8hXWYCiWTk5LLE
	Iu5jGSM3I6MdCJ
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090225.230352.177616203.wl@gnu.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111550>

Hi,

[welcome on the Git list, Werner!]

On Wed, 25 Feb 2009, Werner LEMBERG wrote:

> 
> [both version 1.6.0.2 and git from 2009-01-24]
> 
> Folks,
> 
> 
> I'm going to convert the FreeType CVS repository to git, using Keith
> Packard's `parsecvs'.  It sometimes happens that there are git entries
> titled
> 
>   *** empty log message ***
> 
> I want to massage the git repository before publishing it, replacing
> those entries with something more meaningful.
> 
> The last time I tested this (using git 1.5.something, I no longer
> remember the exact version) I did the following:
> 
>   . git format-patch <start>..HEAD
>     git reset --hard <start>
> 
>   . Edit the `Subject:' field in the created *.patch files where
>     necessary.
> 
>   . git am --whitespace=nowarn *.patch
> 
> Unfortunately, this no longer works as before, and since I can't find
> a hint in the docs about this change I wonder whether it is a bug.
> 
> With git 1.5.something, if the first paragraph of the commit message
> (as output by parsecvs) looks like this
> 
>    foo foo foo foo
>    bar bar bar bar
>    baz baz baz baz
> 
> it is emitted exactly as-is (after `git format-patch' & `git am');
> gitk shows `foo foo foo foo' as the first line.  However, git version
> 1.6.0.2 and the current git both convert newlines to spaces in the
> first paragraph!  I now get
> 
>   foo foo foo foo bar bar bar bar baz baz baz baz
> 
> as the beginning of the commit message which is VERY bad since
> CVS-style entries often have a long first paragraph, causing
> ugly-looking, overlong lines.
> 
> In case this is an intended change I ask you urgently to provide an
> option to get back the old behaviour of `git format-patch' & `git am'.

It is an intended change, for the _opposite_ case: some people thrive on 
overly-long subject lines, and the change was supposed to help them.

I was not sure if it would be a good change back then, but I did not have 
anything concrete I could present as an example where the behavior hurts.

In your case, I suggest using something different, though.  Either use 
"rebase -i" and mark the commits you want to massage as "edit", or use 
"fast-export > dump", edit "dump" by hand, and then reimport the whole 
thing using fast-import.

IMHO your use case is not a good candidate for format-patch, as that 
program was really meant for patch submission (even if it also serves 
other purposes pretty well).

Ciao,
Dscho
