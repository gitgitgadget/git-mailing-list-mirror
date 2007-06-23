From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9500: skip gitweb tests if perl version is too old
Date: Fri, 22 Jun 2007 23:31:40 -0700
Message-ID: <7vps3n89mb.fsf@assigned-by-dhcp.pobox.com>
References: <20070622154908.GA7946MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat Jun 23 08:31:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1zA3-000553-Sm
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 08:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbXFWGbv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 02:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbXFWGbv
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 02:31:51 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:63785 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbXFWGbu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 02:31:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070623063142.OJJP3993.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Jun 2007 02:31:42 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id EuXh1X0041kojtg0000000; Sat, 23 Jun 2007 02:31:41 -0400
In-Reply-To: <20070622154908.GA7946MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Fri, 22 Jun 2007 17:49:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50722>

Sven Verdoolaege <skimo@kotnet.org> writes:

> gitweb calls Encode::decode_utf8 with two arguments,
> but old versions of perl only allow this function to be called
> with one argument.  Even older versions of perl do not even
> have an Encode module.
>
> Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
> ---
>  t/t9500-gitweb-standalone-no-errors.sh |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
> index 44ae503..d948724 100755
> --- a/t/t9500-gitweb-standalone-no-errors.sh
> +++ b/t/t9500-gitweb-standalone-no-errors.sh
> @@ -60,6 +60,12 @@ gitweb_run () {
>  
>  . ./test-lib.sh
>  
> +perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
> +    test_expect_success 'skipping gitweb tests, perl version is too old' :
> +    test_done
> +    exit
> +}
> +

Hmph.  Even something silly like:

	perl -MEncode -e 'decode_utf8("", Encode::FB_CLUCK)'

seem to succeed for me with 5.8.8.

Maybe you would want "perl -w" there instead?
