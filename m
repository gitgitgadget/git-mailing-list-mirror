From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] allow TTY tests to run under recent Mac OS
Date: Fri, 14 Nov 2014 20:23:52 +0100
Message-ID: <546656C8.3070009@kdbg.org>
References: <1415918419-20807-1-git-send-email-blume.mike@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: Mike Blume <blume.mike@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 14 20:24:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpMTR-0007HE-7i
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 20:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161304AbaKNTX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 14:23:57 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:53131 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965580AbaKNTX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 14:23:57 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3jfV3H31s5z5tlF;
	Fri, 14 Nov 2014 20:23:54 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1BA9F19F75B;
	Fri, 14 Nov 2014 20:23:52 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <1415918419-20807-1-git-send-email-blume.mike@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.11.2014 um 23:40 schrieb Mike Blume:
> listed bug doesn't reproduce on Mac OS Yosemite. For now, just enable
> TTY on Yosemite and higher
> 
> Signed-off-by: Mike Blume <blume.mike@gmail.com>
> Improved-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/lib-terminal.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
> index 5184549..6395a34 100644
> --- a/t/lib-terminal.sh
> +++ b/t/lib-terminal.sh
> @@ -29,7 +29,10 @@ test_lazy_prereq TTY '
>  	# After 2000 iterations or so it hangs.
>  	# https://rt.cpan.org/Ticket/Display.html?id=65692
>  	#
> -	test "$(uname -s)" != Darwin &&
> +	# Under Mac OS X 10.10.1 and Perl 5.18.2, this problem
> +	# appears to be gone.
> +	#
> +	test "$(uname -s)" != Darwin || test "$(uname -r | cut -d. -f1)" -ge 14 &&

This is part of an &&-chain; you can't just throw in a || in the middle.

How about

	if test "$(uname -s)" = Darwin
	then
		test "$(uname -r | cut -d. -f1)" -ge 14
	fi &&

>  
>  	perl "$TEST_DIRECTORY"/test-terminal.perl \
>  		sh -c "test -t 1 && test -t 2"
> 

-- Hannes
