From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-filter-branch could be confused by similar names
Date: Sat, 29 Dec 2007 23:36:51 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712292334080.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1198593316-7712-1-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 23:37:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8kJ0-0002AO-Lu
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 23:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbXL2Wgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 17:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbXL2Wgy
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 17:36:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:51180 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751947AbXL2Wgx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 17:36:53 -0500
Received: (qmail invoked by alias); 29 Dec 2007 22:36:51 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp029) with SMTP; 29 Dec 2007 23:36:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19L1fhQ/plLifQIk+Dq6mIjQrmcGlMA//9f8qXE5G
	1i6lW0vTcQRlG0
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <1198593316-7712-1-git-send-email-dpotapov@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69334>

Hi,

On Tue, 25 Dec 2007, Dmitry Potapov wrote:

> 'git-filter-branch branch' could fail producing the error:
> "Which ref do you want to rewrite?" if existed another branch
> or tag, which name was 'branch-something' or 'something/branch'.
> 
> Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
> ---
>  git-filter-branch.sh     |    2 +-
>  t/t7003-filter-branch.sh |   10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletions(-)
> 
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index dbab1a9..b89a720 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -219,7 +219,7 @@ do
>  	;;
>  	*)
>  		ref="$(git for-each-ref --format='%(refname)' |
> -			grep /"$ref")"
> +			grep '^refs/[^/]\+/'"$ref"'$')"

Hmm.  I wonder if this is a proper solution.  It still does not error out 
when you have a tag and a branch of the same name.

I kinda hoped that by 1.5.4, rewrite-commits would be finished, but it 
seems that nothing happened in that area after 1.5.3-rcX.

It would be so much easier to have checks like this -- returning the real 
refname for short but unique short refnames -- in C.

Ciao,
Dscho
