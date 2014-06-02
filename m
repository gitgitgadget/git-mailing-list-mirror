From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] request-pull: resurrect for-linus -> tags/for-linus DWIM
Date: Mon, 02 Jun 2014 09:06:56 +0200
Message-ID: <538C2290.3060506@viscovery.net>
References: <1400263070-15312-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 09:07:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrMKt-0003xq-DB
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 09:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbaFBHHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 03:07:04 -0400
Received: from so.liwest.at ([212.33.55.24]:40280 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbaFBHHD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 03:07:03 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WrMKf-0001Oa-3m; Mon, 02 Jun 2014 09:06:57 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D32C316613;
	Mon,  2 Jun 2014 09:06:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <1400263070-15312-1-git-send-email-gitster@pobox.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250558>

Am 5/16/2014 19:57, schrieb Junio C Hamano:
> --- a/t/t5150-request-pull.sh
> +++ b/t/t5150-request-pull.sh
> @@ -223,7 +223,13 @@ test_expect_success 'pull request format' '
>  		git request-pull initial "$downstream_url" tags/full:refs/tags/full
>  	) >request &&
>  	sed -nf fuzz.sed <request >request.fuzzy &&
> -	test_i18ncmp expect request.fuzzy
> +	test_i18ncmp expect request.fuzzy &&
> +
> +	(
> +		cd local &&
> +		git request-pull initial "$downstream_url" full
> +	) >request &&
> +	grep ' tags/full$'
>  '

What's this crap? Here's a fix. Feel free to tame down the subject line
if you think it's too strong ;)

--- 8< ---
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] fix brown paper bag breakage in t5150-request-pull.sh

The recent addition to the test case 'pull request format' interrupted
the single-quoted text, effectively adding a third argument to the
test_expect_success command. Since we do not have a prerequisite named
"pull request format", the test is skipped, no matter what. Additionally,
the file name argument to the grep command is missing. Fix both issues.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t5150-request-pull.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 93e2c65..82c33b8 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -229,7 +229,7 @@ test_expect_success 'pull request format' '
 		cd local &&
 		git request-pull initial "$downstream_url" full
 	) >request &&
-	grep ' tags/full$'
+	grep " tags/full\$" request
 '

 test_expect_success 'request-pull ignores OPTIONS_KEEPDASHDASH poison' '
-- 
2.0.0.1326.g81a507a
