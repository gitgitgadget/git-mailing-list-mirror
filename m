From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] calculate the maximal number of revisions to test
Date: Sat, 17 Mar 2007 18:49:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703171845541.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070317141209.GA7838@cepheus>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1325752059-1174153785=:22628"
Cc: git@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Sat Mar 17 18:50:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSd2e-0001p2-CR
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 18:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbXCQRts (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 13:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752601AbXCQRts
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 13:49:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:47261 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752694AbXCQRtr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 13:49:47 -0400
Received: (qmail invoked by alias); 17 Mar 2007 17:49:45 -0000
X-Provags-ID: V01U2FsdGVkX18kBx8lLN4kb7khy2ueyRjSvzZWz+vfykRHSpn7wy
	Id9fbgKOaoMHoN
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070317141209.GA7838@cepheus>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42444>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1325752059-1174153785=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi zeisberg,

the subject really could use a "bisect:" prefix, and maybe be a little 
clearer to begin with? Imagine how much sense it makes to read the commit 
messages, and see that some maximal number of revisions is calculated.

On Sat, 17 Mar 2007, Uwe Kleine-König wrote:

> diff --git a/git-bisect.sh b/git-bisect.sh
> index b1c3a6b..a5b4fdd 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -150,8 +150,14 @@ bisect_next() {
>  	    git-diff-tree --pretty $rev
>  	    exit 0
>  	fi
> -	nr=$(eval "git-rev-list $rev $good -- $(cat $GIT_DIR/BISECT_NAMES)" | wc -l) || exit
> -	echo "Bisecting: $nr revisions left to test after this"
> +	nr_bad=$(eval "git-rev-list $rev^ $good -- $(cat $GIT_DIR/BISECT_NAMES)" | wc -l) || exit
> +	nr_good=$(eval "git-rev-list $bad^ ^$rev $good -- $(cat $GIT_DIR/BISECT_NAMES)" | wc -l) || exit
> +	if test "$nr_bad" -ge "$nr_good"; then
> +		nr="$nr_bad";
> +	else
> +		nr="$nr_good";
> +	fi;
> +	echo "Bisecting: maximal $nr revisions left to test after this"

How about this instead:

-	echo "Bisecting: $nr revisions left to test after this"
+	echo "Bisecting: approx. $nr revisions left to test after this"

since your version is an approximation (although a conservative one) 
anyway. Hmm?

Ciao,
Dscho

---1148973799-1325752059-1174153785=:22628--
