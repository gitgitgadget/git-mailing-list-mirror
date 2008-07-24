From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] t6030 (bisect): work around Mac OS X "ls"
Date: Thu, 24 Jul 2008 07:57:26 +0200
Message-ID: <200807240757.26290.chriscool@tuxfamily.org>
References: <Pine.GSO.4.62.0807232014030.14945@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Thu Jul 24 07:54:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLtme-0008R5-1v
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 07:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbYGXFxf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 01:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbYGXFxf
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 01:53:35 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:49733 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752630AbYGXFxe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jul 2008 01:53:34 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id A008D1AB2D3;
	Thu, 24 Jul 2008 07:53:32 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 7F9431AB2C4;
	Thu, 24 Jul 2008 07:53:32 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <Pine.GSO.4.62.0807232014030.14945@harper.uchicago.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89837>

Le jeudi 24 juillet 2008, Jonathan Nieder a =E9crit :
> t6030-bisect-porcelain.sh relies on "ls" exiting with nonzero
> status when asked to list nonexistent files.  Unfortunately,
> /bin/ls on Mac OS X 10.3 exits with exit code 0.  So use "echo
> <shell glob pattern>" and grep instead.
>
> Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
> ---
> 	With this change, all the non-git-svn tests pass on my machine.
> 	I think the fix is portable but I do not have the experience to
> 	be sure.  So I would be happier if someone looks it over.
>
>  t/t6030-bisect-porcelain.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.s=
h
> index 0626544..d19fc1c 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -76,7 +76,7 @@ test_expect_success 'bisect fails if given any junk
> instead of revs' ' test_must_fail git bisect start foo $HASH1 -- &&
>  	test_must_fail git bisect start $HASH4 $HASH1 bar -- &&
>  	test -z "$(git for-each-ref "refs/bisect/*")" &&
> -	test_must_fail ls .git/BISECT_* &&
> +	echo .git/BISECT_* | test_must_fail grep BISECT_[^*] &&

Perhaps the following is simpler:

+	test -z "$(ls .git/BISECT_*)" &&

>  	git bisect start &&
>  	test_must_fail git bisect good foo $HASH1 &&
>  	test_must_fail git bisect good $HASH1 bar &&

Thanks,
Christian.
