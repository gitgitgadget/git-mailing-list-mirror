From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC v4 3/5] sha1_name: support @{-N} syntax in
 get_sha1()
Date: Sat, 17 Jan 2009 18:55:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901171854060.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de> <1232208597-29249-1-git-send-email-trast@student.ethz.ch> <1232208597-29249-2-git-send-email-trast@student.ethz.ch> <1232208597-29249-3-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-4-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jan 17 18:56:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOFOf-0003Kc-0f
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 18:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755877AbZAQRy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 12:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755303AbZAQRy1
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 12:54:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:45761 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754587AbZAQRy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 12:54:26 -0500
Received: (qmail invoked by alias); 17 Jan 2009 17:54:24 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp034) with SMTP; 17 Jan 2009 18:54:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Q3oIcbzfQtpUcLNzkexpG8ZMWQ/8Gf14UWTG4sI
	FrYwv//CRm+5xI
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232208597-29249-4-git-send-email-trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106089>

Hi,

On Sat, 17 Jan 2009, Thomas Rast wrote:

> diff --git a/t/t1505-rev-parse-last.sh b/t/t1505-rev-parse-last.sh
> new file mode 100755
> index 0000000..1e49dd2
> --- /dev/null
> +++ b/t/t1505-rev-parse-last.sh
> @@ -0,0 +1,71 @@
> +#!/bin/sh
> +
> +test_description='test @{-N} syntax'
> +
> +. ./test-lib.sh
> +
> +
> +make_commit () {
> +	echo "$1" > "$1" &&
> +	git add "$1" &&
> +	git commit -m "$1"
> +}
> +
> +
> +test_expect_success 'setup' '
> +
> +	make_commit 1 &&
> +	git branch side &&
> +	make_commit 2 &&
> +	make_commit 3 &&
> +	git checkout side &&
> +	make_commit 4 &&
> +	git merge master &&
> +	git checkout master
> +
> +'
> +
> +# 1 -- 2 -- 3 master
> +#  \         \
> +#   \         \
> +#    --- 4 --- 5 side
> +#
> +# and 'side' should be the last branch
> +
> +git log --graph --all --pretty=oneline --decorate
> +

Maybe you want to squash this in, so that the output of "make test" is 
not cluttered by the graph?

-- snipsnap --
diff --git a/t/t1505-rev-parse-last.sh b/t/t1505-rev-parse-last.sh
index 1e49dd2..72e8322 100755
--- a/t/t1505-rev-parse-last.sh
+++ b/t/t1505-rev-parse-last.sh
@@ -32,7 +32,11 @@ test_expect_success 'setup' '
 #
 # and 'side' should be the last branch
 
-git log --graph --all --pretty=oneline --decorate
+test_expect_success 'show a log (for debugging)' '
+
+	git log --graph --all --pretty=oneline --decorate
+
+'
 
 test_rev_equivalent () {
 
-- 
1.6.1.332.g9a59d
