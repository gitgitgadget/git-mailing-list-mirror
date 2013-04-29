From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/2] test output: respect $TEST_OUTPUT_DIRECTORY
Date: Mon, 29 Apr 2013 19:19:50 +0100
Message-ID: <20130429181950.GM472@serenity.lan>
References: <7c0618f3fa7f68b963bf483f1e97afed835bdb74.1367002553.git.john@keeping.me.uk>
 <7c0618f3fa7f68b963bf483f1e97afed835bdb74.1367002553.git.john@keeping.me.uk>
 <47c9ba4200a22e865040208628357d9bc4bcf3f4.1367002553.git.john@keeping.me.uk>
 <87fvy9dxok.fsf@hexa.v.cablecom.net>
 <7vwqrli4mb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 20:20:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWsgJ-0001ra-IH
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 20:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758390Ab3D2SUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 14:20:01 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:41964 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757427Ab3D2SUA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 14:20:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 513686064B8;
	Mon, 29 Apr 2013 19:20:00 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Nl8h6P1Jnxj; Mon, 29 Apr 2013 19:19:59 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id A7E1619800D;
	Mon, 29 Apr 2013 19:19:52 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vwqrli4mb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222838>

On Mon, Apr 29, 2013 at 11:17:00AM -0700, Junio C Hamano wrote:
> Thomas Rast <trast@inf.ethz.ch> writes:
> 
> > John Keeping <john@keeping.me.uk> writes:
> >> diff --git a/t/test-lib.sh b/t/test-lib.sh
> >> index ca6bdef..70ad085 100644
> >> --- a/t/test-lib.sh
> >> +++ b/t/test-lib.sh
> >> @@ -54,8 +54,8 @@ done,*)
> >>  	# do not redirect again
> >>  	;;
> >>  *' --tee '*|*' --va'*)
> >> -	mkdir -p test-results
> >> -	BASE=test-results/$(basename "$0" .sh)
> >> +	mkdir -p "$(TEST_OUTPUT_DIRECTORY)/test-results"
> >> +	BASE="$(TEST_OUTPUT_DIRECTORY)/test-results/$(basename "$0" .sh)"
> >>  	(GIT_TEST_TEE_STARTED=done ${SHELL_PATH} "$0" "$@" 2>&1;
> >>  	 echo $? > $BASE.exit) | tee $BASE.out
> >>  	test "$(cat $BASE.exit)" = 0
> >
> > Hmm, I initially was too lazy to review this change, and now it's biting
> > me.  The above is Makefile-quoted, which to the shell reads like a
> > command substitution.
> 
> Heh, when I let my eyes coast over it I didn't notice them either.
> Everything in that patch is bad.
> 
> This squashed in?

This is identical to the interdiff of what I posted at the same time, so
it obviously looks good to me.

>  t/test-lib.sh         | 4 ++--
>  t/valgrind/analyze.sh | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 1b1e843..e7d169c 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -54,8 +54,8 @@ done,*)
>  	# do not redirect again
>  	;;
>  *' --tee '*|*' --va'*)
> -	mkdir -p "$(TEST_OUTPUT_DIRECTORY)/test-results"
> -	BASE="$(TEST_OUTPUT_DIRECTORY)/test-results/$(basename "$0" .sh)"
> +	mkdir -p "$TEST_OUTPUT_DIRECTORY/test-results"
> +	BASE="$TEST_OUTPUT_DIRECTORY/test-results/$(basename "$0" .sh)"
>  	(GIT_TEST_TEE_STARTED=done ${SHELL_PATH} "$0" "$@" 2>&1;
>  	 echo $? > $BASE.exit) | tee $BASE.out
>  	test "$(cat $BASE.exit)" = 0
> diff --git a/t/valgrind/analyze.sh b/t/valgrind/analyze.sh
> index 7b58f01..2ffc80f 100755
> --- a/t/valgrind/analyze.sh
> +++ b/t/valgrind/analyze.sh
> @@ -119,7 +119,7 @@ handle_one () {
>  	finish_output
>  }
>  
> -for test_script in "$(TEST_OUTPUT_DIRECTORY)"/test-results/*.out
> +for test_script in "$TEST_OUTPUT_DIRECTORY"/test-results/*.out
>  do
>  	handle_one $test_script
>  done
