From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH][resend] git-svn: Respect GIT_SSH setting
Date: Tue, 18 Aug 2009 01:20:13 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908180117140.8306@pacific.mpi-cbg.de>
References: <4A89E185.2010307@fastmail.fm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Karthik R <karthikr@fastmail.fm>
X-From: git-owner@vger.kernel.org Tue Aug 18 01:19:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdBUX-00032L-Ju
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 01:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758299AbZHQXTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 19:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758285AbZHQXTZ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 19:19:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:40528 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758187AbZHQXTY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 19:19:24 -0400
Received: (qmail invoked by alias); 17 Aug 2009 23:19:24 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 18 Aug 2009 01:19:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+WvKsoi3iWrBXu7bQfCEASGJW2u65eLue84TSh2E
	o+jNvQrfb8LXnQ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4A89E185.2010307@fastmail.fm>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126318>

Hi,

On Mon, 17 Aug 2009, Karthik R wrote:

> Setting GIT_SSH when using "git svn clone svn+ssh://..." does not
> override the default ssh; SVN_SSH needed to be set instead.

This is now in past tense, no?

> diff --git a/git-svn.perl b/git-svn.perl
> index b0bfb74..9bc1e71 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -21,6 +21,13 @@ $Git::SVN::default_ref_id = $ENV{GIT_SVN_ID} || 'git-svn';
> $Git::SVN::Ra::_log_window_size = 100;
> $Git::SVN::_minimize_url = 'unset';
> 
> +# If GIT_SSH is set, also set SVN_SSH...
> +$ENV{SVN_SSH} = $ENV{GIT_SSH} if defined $ENV{GIT_SSH};
> +# ... and escape \s in shell-variable on Windows
> +if ($^O eq 'MSWin32' || $^O eq 'msys') {
> +       $ENV{SVN_SSH} =~ s/\\/\\\\/g if defined $ENV{SVN_SSH};
> +}

This is a change from before... I do not know if it is a good one, as 
SVN_SSH could be defined differently by the user, no?  In that case, the 
user was most likely using the correct amount of backslashes...

So maybe it was correct to make this dependent on "if defined 
$ENV{GIT_SSH}", and maybe it should be dependent on "&& !defined 
$ENV{SVN_SSH}" as well...

Ciao,
Dscho
