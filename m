From: Stefan Karpinski <stefan.karpinski@gmail.com>
Subject: Re: [PATCH] git-cvsserver: run post-update hook *after* update.
Date: Thu, 22 Jan 2009 21:43:48 -0800
Message-ID: <d4bc1a2a0901222143i1a7dd051h1778dcb563120195@mail.gmail.com>
References: <1232144521-21947-1-git-send-email-stefan.karpinski@gmail.com>
	 <1232144521-21947-2-git-send-email-stefan.karpinski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 23 06:45:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQEqx-0004S1-UZ
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 06:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbZAWFnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 00:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbZAWFnu
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 00:43:50 -0500
Received: from rv-out-0506.google.com ([209.85.198.237]:41150 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbZAWFnu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 00:43:50 -0500
Received: by rv-out-0506.google.com with SMTP id k40so4526144rvb.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 21:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=4GFy11jFU3dlZqHIOzNHeHFAmiXIXvH5TL3cUO4jWt4=;
        b=op2AxTc4J6w6zvogDEfnpLZ7YJTNRzU3t4+99o50jrdXAwcaP0Vsgug8mrhn1UoIZw
         SzUQcPESVsgVQz5pMdVpbefsje5k54pw1eqbzk5bmgTiePbnYUpCOicVXw0SeuP1aN6H
         d+BJpIZwGcnQyQygsE//53MSWbRtyNFENbPGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=a6hIs2Y1exR7pE/JGrW88YViUdjxxgIE2MyZUZa0+d+puNc3XmacdaA/TktYtrAdOW
         Vu83x+NvOI8pWQt4amFZX31pQ2kbNy6/Zkc74cOhFlnvSFjY6Xe+dl4ll4CQ1+LtEWze
         3roIdWascW1AT5aALk0EumZ9cQ9xrWz/HPEho=
Received: by 10.114.184.7 with SMTP id h7mr1841442waf.151.1232689429019; Thu, 
	22 Jan 2009 21:43:49 -0800 (PST)
In-Reply-To: <1232144521-21947-2-git-send-email-stefan.karpinski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106836>

I know that this and the other patch I sent are completely trivial and
uninteresting, but they would appear to be correct. Do I need to prod
more to get them included or what? Did I submit them incorrectly?

On Fri, Jan 16, 2009 at 2:22 PM, Stefan Karpinski
<stefan.karpinski@gmail.com> wrote:
>
> CVS server was running the hook before the update
> action was actually done. This performs the update
> before the hook is called.
> ---
>
> Unless I'm severely misunderstanding the meaning of
> a *post-update* hook, I think this is a no-brainer.
>
>  git-cvsserver.perl |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index c1e09ea..d2e6003 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -1413,14 +1413,14 @@ sub req_ci
>                close $pipe || die "bad pipe: $! $?";
>        }
>
> +    $updater->update();
> +
>        ### Then hooks/post-update
>        $hook = $ENV{GIT_DIR}.'hooks/post-update';
>        if (-x $hook) {
>                system($hook, "refs/heads/$state->{module}");
>        }
>
> -    $updater->update();
> -
>     # foreach file specified on the command line ...
>     foreach my $filename ( @committedfiles )
>     {
> --
> 1.6.0.3.3.g08dd8
>
