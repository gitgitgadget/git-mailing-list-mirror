From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 15/25] t9502: fix &&-chain breakage
Date: Fri, 20 Mar 2015 18:48:35 +0100
Message-ID: <550C5D73.4080901@kdbg.org>
References: <20150320100429.GA17354@peff.net> <20150320101301.GO12543@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 18:48:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ12P-0003uD-NY
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 18:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbbCTRsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 13:48:40 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:19555 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977AbbCTRsj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 13:48:39 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3l7sz85nDtz5tlD;
	Fri, 20 Mar 2015 18:48:36 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id CF55C5200;
	Fri, 20 Mar 2015 18:48:35 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150320101301.GO12543@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265920>

Am 20.03.2015 um 11:13 schrieb Jeff King:
> This script misses a trivial &&-chain in one of its tests,
> but it also has a weird reverse: it includes an &&-chain
> outside of any test_expect block! This "cat" should never
> fail, but if it did, we would not notice, as it would cause
> us to skip the follow-on test entirely (which does not
> appear intentional; there are many later tests which rely on
> this cat).
>
> Let's instead move the setup into its own test_expect_success
> block, which is the standard practice nowadays.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   t/t9502-gitweb-standalone-parse-output.sh | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
> index 86dfee2..a93e159 100755
> --- a/t/t9502-gitweb-standalone-parse-output.sh
> +++ b/t/t9502-gitweb-standalone-parse-output.sh
> @@ -145,9 +145,11 @@ test_expect_success 'forks: not skipped unless "forks" feature enabled' '
>   	grep -q ">fork of .*<"           gitweb.body
>   '
>
> -cat >>gitweb_config.perl <<\EOF &&
> -$feature{'forks'}{'default'} = [1];
> -EOF
> +test_expect_success 'enable forks feature' '
> +	cat >>gitweb_config.perl <<-\EOF
> +	$feature{'forks'}{'default'} = [1];
> +	EOF
> +'

This loses the single-quotes in the generated perl script, doesn't it? 
Most likely, it does not matter.

-- Hannes
