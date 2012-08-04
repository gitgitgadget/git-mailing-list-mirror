From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH] tests: Introduce test_seq
Date: Sat, 4 Aug 2012 10:14:03 +0200
Message-ID: <20120804101403.10ad79b5@gmail.com>
References: <7v3943bsuc.fsf@alter.siamese.dyndns.org>
	<1344032464-14104-1-git-send-email-michal.kiedrowicz@gmail.com>
	<7vfw83a7t5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 10:14:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxZVJ-0006Q5-8J
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 10:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049Ab2HDIOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 04:14:14 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:40726 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342Ab2HDIOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 04:14:09 -0400
Received: by wibhq12 with SMTP id hq12so206675wib.1
        for <git@vger.kernel.org>; Sat, 04 Aug 2012 01:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=i96/57Gx+Va+KiQgDcDEWLrv8I7bnkohY5zTeJuXVJM=;
        b=DF1qVM7lM7LDvIko5ny98gyfCdHoK5K/BoynfJcEn/gEHWzeb5QMSPDD4tHmBj3Wnm
         QeF371yJZnpYyu5vqPCHfbMwLX6JUGer5iusM2cOhLXP2Vf8/85ySW2vR72Hgl8ZNv4a
         Biu5vglMcm0bfa0BWvKdc57kfu7KHJCNXWtqmm3t68dqIPcRGV7a77TaPOqXVA+Lff2o
         GvovOY2VhapKzP8HO0la8erxxMHaEs1sTsXY2Eg1gZcIyE2kt7hIK1Sg/7e2esmp3Ej0
         bkg0qw6CBmZ5CZ/VMfJBapncpie2lLG6rsUIoS6BWloDzK4LbrCxqXf5weV1WV0nejSf
         IpiQ==
Received: by 10.216.135.147 with SMTP id u19mr2249552wei.12.1344068048128;
        Sat, 04 Aug 2012 01:14:08 -0700 (PDT)
Received: from localhost (94-178-78-94.net.stream.pl. [94.78.178.94])
        by mx.google.com with ESMTPS id t8sm1801932wiy.3.2012.08.04.01.14.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Aug 2012 01:14:07 -0700 (PDT)
In-Reply-To: <7vfw83a7t5.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202873>

Junio C Hamano <gitster@pobox.com> wrote:

> Tentatively I'll queue this one on top, but I am tempted to squash
> this in before merging the topic down.
> 
> -- >8 --
> Subject: [PATCH] fixup! tests: Introduce test_seq
> 
> Complex chains of && and || are harder to read when used as
> replacement for if/else statements, but it is easy to rewrite it
> with a case/esac in this case.

I just copied it from test_expect_success, but yeah, case/esac is
clearer.

> 
> Avoid using unnecessary variables $first and $last.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/test-lib-functions.sh | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index c8b4ae3..7dc70eb 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -532,7 +532,7 @@ test_cmp() {
>  
>  # Print a sequence of numbers or letters in increasing order.  This is
>  # similar to GNU seq(1), but the latter might not be available
> -# everywhere.  It may be used like:
> +# everywhere (and does not do letters).  It may be used like:
>  #
>  #	for i in `test_seq 100`; do
>  #		for j in `test_seq 10 20`; do
> @@ -543,11 +543,12 @@ test_cmp() {
>  #	done
>  
>  test_seq () {
> -	test $# = 2 && { first=$1; shift; } || first=1
> -	test $# = 1 ||
> -	error "bug in the test script: not 1 or 2 parameters to test_seq"
> -	last=$1
> -	"$PERL_PATH" -le 'print for "$ARGV[0]".."$ARGV[1]"' "$first" "$last"
> +	case $# in
> +	1)	set 1 "$@" ;;
> +	2)	;;
> +	*)	error "bug in the test script: not 1 or 2 parameters to test_seq" ;;
> +	esac
> +	"$PERL_PATH" -le 'print for $ARGV[0]..$ARGV[1]' "$@"
>  }
>  
>  # This function can be used to schedule some commands to be run
