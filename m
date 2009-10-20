From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: [PATCH] pull: refuse complete src:dst fetchspec arguments
Date: Tue, 20 Oct 2009 13:30:53 -0700
Message-ID: <BLU0-SMTP97AA2287062D9A104101C8AEC00@phx.gbl>
References: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Oct 20 22:37:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0LSE-0001Zy-JM
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 22:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbZJTUhC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 16:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752877AbZJTUhC
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 16:37:02 -0400
Received: from blu0-omc3-s34.blu0.hotmail.com ([65.55.116.109]:7903 "EHLO
	blu0-omc3-s34.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752682AbZJTUhB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 16:37:01 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Oct 2009 16:37:00 EDT
Received: from BLU0-SMTP97 ([65.55.116.72]) by blu0-omc3-s34.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 20 Oct 2009 13:30:55 -0700
X-Originating-IP: [66.183.8.119]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from lex.hookers.net ([66.183.8.119]) by BLU0-SMTP97.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 20 Oct 2009 13:30:55 -0700
In-Reply-To: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.16.6; x86_64-redhat-linux-gnu)
X-OriginalArrivalTime: 20 Oct 2009 20:30:55.0541 (UTC) FILETIME=[399B7650:01CA51C4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130839>

On Tue, 20 Oct 2009 20:23:06 +0200
Thomas Rast <trast@student.ethz.ch> wrote:

Hi Thomas,

> git-pull has historically accepted full fetchspecs, meaning that you
> could do
> 
>   git pull $repo A:B
> 
> which would simultaneously fetch the remote branch A into the local
> branch B and merge B into HEAD.  This got especially confusing if B
> was checked out.  New users variously mistook pull for fetch or read
> that command as "merge the remote A into my B", neither of which is
> correct.
> 
> Since the above usage should be very rare and can be done with
> separate calls to fetch and merge, we just disallow full fetchspecs in
> git-pull.

It is however a handy shortcut to be able to specify the full refspec
and specify where you want the head stored locally.  It seems a shame to
throw away that functionality because of one confusing case.   Wouldn't
it be better to test of the confusing case and instead error out if the
local refname is already checked out?


[...]
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index dd2ee84..a566a99 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -29,18 +29,6 @@ test_expect_success 'checking the results' '
>  	diff file cloned/file
>  '
>  
> -test_expect_success 'pulling into void using master:master' '
> -	mkdir cloned-uho &&
> -	(
> -		cd cloned-uho &&
> -		git init &&
> -		git pull .. master:master
> -	) &&
> -	test -f file &&
> -	test -f cloned-uho/file &&
> -	test_cmp file cloned-uho/file
> -
> -
>  test_expect_success 'test . as a remote' '
>  
>  	git branch copy master &&
> -- 
> 

Instead of removing this test it should be modified or replaced
with a test that ensures the new functionality operates correctly.
In this case that would mean checking that using a full refspec
errors out.

Cheers,
Sean
