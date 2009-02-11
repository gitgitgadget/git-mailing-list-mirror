From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv3] filter-branch: Add more error-handling
Date: Wed, 11 Feb 2009 21:48:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902112145400.10279@pacific.mpi-cbg.de>
References: <7vhc30eqy7.fsf@gitster.siamese.dyndns.org> <1234382600-7801-1-git-send-email-git@randomhacks.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Eric Kidd <git@randomhacks.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 21:50:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXM1p-0005yP-S4
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 21:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756388AbZBKUsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 15:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755910AbZBKUsJ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 15:48:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:42052 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756152AbZBKUsI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 15:48:08 -0500
Received: (qmail invoked by alias); 11 Feb 2009 20:48:01 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 11 Feb 2009 21:48:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19T4q0fFIxTXsURXinJBtgYFyK736zI8DJwhWA9aV
	QS97fN1G4UKqjg
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1234382600-7801-1-git-send-email-git@randomhacks.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109524>

Hi,

On Wed, 11 Feb 2009, Eric Kidd wrote:

> charon on #git helped with pipeline error handling.

JFYI charon is the nick of Thomas Rast.

> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 86eef56..27b57b8 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -221,7 +221,7 @@ die ""
>  trap 'cd ../..; rm -rf "$tempdir"' 0
>  
>  # Make sure refs/original is empty
> -git for-each-ref > "$tempdir"/backup-refs
> +git for-each-ref > "$tempdir"/backup-refs || exit

I haven't checked, but is "$tempdir" not the working directory?  If so, 
this would lead to funny interaction with --tree-filter.  Rather, I'd 
write the file into "$GIT_DIR".  Likewise the other files.

> +test_must_fail 'Fail if commit filter fails' '
> +	git filter-branch -f --commit-filter "exit 1" HEAD
> +'
> +

That's not how it is supposed to be used.  Rather,

	test_expect_success $LABEL '
		test_must_fail git filter-branc $OPTIONS
	'

Thanks,
Dscho
