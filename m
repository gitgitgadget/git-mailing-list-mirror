From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use --upload-pack in clone, fetch and ls-remote instead of --exec
Date: Tue, 23 Jan 2007 00:40:37 -0800
Message-ID: <7vveiynnju.fsf@assigned-by-dhcp.cox.net>
References: <20070123082017.GA10007@cepheus> <20070123082437.GA10053@cepheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 09:40:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9HCy-0004rf-W3
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 09:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932793AbXAWIkm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 23 Jan 2007 03:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932902AbXAWIkm
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 03:40:42 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:47898 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932793AbXAWIkk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jan 2007 03:40:40 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070123084039.YVSX20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Tue, 23 Jan 2007 03:40:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id EYfj1W0051kojtg0000000; Tue, 23 Jan 2007 03:39:43 -0500
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
In-Reply-To: <20070123082437.GA10053@cepheus> (Uwe =?iso-8859-1?Q?Kleine-K?=
 =?iso-8859-1?Q?=F6nig's?= message of
	"Tue, 23 Jan 2007 09:24:37 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37491>

Uwe Kleine-K=F6nig  <ukleinek@informatik.uni-freiburg.de> writes:

> Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.d=
e>
> ---
> I don't like the change to git-fetch.sh.  But currently git-fetch-pac=
k
> needs a =3D and ls-remote doesn't like it.  So it continues to have t=
wo
> variables for the remote upload program.

Then maybe something like this is in order to make things more
consistent?

Totally untested, of course ;-).

diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index 03b624e..69d4c2a 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -25,6 +25,10 @@ do
 	shift
 	exec=3D"--exec=3D$1"
 	shift;;
+  -u=3D*|--u=3D*|--up=3D*|--upl=3D*|--uplo=3D*|--uploa=3D*|--upload=3D=
*|\
+  --upload-=3D*|--upload-p=3D*|--upload-pa=3D*|--upload-pac=3D*|--uplo=
ad-pack=3D*)
+  	exec=3D--exec=3D`expr "$1" : '-[^=3D]*=3D\(.*\)'`
+	shift;;
   --)
   shift; break ;;
   -*)
