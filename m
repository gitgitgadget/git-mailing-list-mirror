From: Junio C Hamano <gitster@pobox.com>
Subject: Re: new GIT-VERSION-GEN with old GIT
Date: Sat, 23 Feb 2008 10:46:31 -0800
Message-ID: <7vtzjz33zs.fsf@gitster.siamese.dyndns.org>
References: <20080223173401.GA7808@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mkoegler@auto.tuwien.ac.at (Martin Koegler)
X-From: git-owner@vger.kernel.org Sat Feb 23 19:47:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSzPD-0005rs-Hv
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 19:47:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761953AbYBWSqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 13:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761947AbYBWSqr
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 13:46:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33904 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761936AbYBWSqq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 13:46:46 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0BB4613A0;
	Sat, 23 Feb 2008 13:46:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CC73E131E; Sat, 23 Feb 2008 13:46:38 -0500 (EST)
In-Reply-To: <20080223173401.GA7808@auto.tuwien.ac.at> (Martin Koegler's
 message of "Sat, 23 Feb 2008 18:34:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74837>

mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:

> On Debian, git 1.4.4 is still shipped in the stable distribution.
>
> Since e5fc9a0aea2c3c49829b5cdf499339e5c759706b, simply running make in
> a git checkout yields to an error message.
>
> The error is in GIT-VERSION-GEN:
> | + git diff-index --quiet HEAD
> ...

Sorry about that.  I already have forgotten that --quiet was a
relatively recent invention.

Before e5fc9a, we used --name-only, which was around forever.
The original diff-cache had it since mid July 2005, and the
command kept the option when it was renamed to diff-index in
early September 2005.  That is what we should use.


 GIT-VERSION-GEN |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 03fb9d7..d4714ee 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -16,7 +16,8 @@ elif test -d .git &&
 	case "$VN" in
 	*$LF*) (exit 1) ;;
 	v[0-9]*)
-		git diff-index --quiet HEAD || VN="$VN-dirty" ;;
+		test -z "$(git diff-index --name-only HEAD)" ||
+		VN="$VN-dirty" ;;
 	esac
 then
 	VN=$(echo "$VN" | sed -e 's/-/./g');
