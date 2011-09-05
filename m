From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] shell portability: Use sed instead of non-portable variable
 expansion
Date: Mon, 05 Sep 2011 09:03:30 +0200
Message-ID: <4E647442.9000005@viscovery.net>
References: <8762l73758.fsf@elisp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, tarmigan+git@gmail.com
To: Naohiro Aota <naota@elisp.net>
X-From: git-owner@vger.kernel.org Mon Sep 05 09:07:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0THB-0007J9-IW
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 09:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887Ab1IEHDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 03:03:39 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:5835 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750744Ab1IEHDh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 03:03:37 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1R0TDO-00007m-EN; Mon, 05 Sep 2011 09:03:30 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 305511660F;
	Mon,  5 Sep 2011 09:03:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.21) Gecko/20110830 Thunderbird/3.1.13
In-Reply-To: <8762l73758.fsf@elisp.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180719>

Am 9/5/2011 7:11, schrieb Naohiro Aota:
> Variable expansions like "${foo#bar}" or "${foo%bar}" doesn't work on
> shells like FreeBSD sh and they made the test to fail. This patch
> replace such variable expansions with sed.
> 
> Signed-off-by: Naohiro Aota <naota@elisp.net>
> ---
> 
> Testing on FreeBSD failed because of this "bash-ism".

These are not bashism, but features require by POSIX.

I'd rather suspect that the failures are not because FreeBSD sh does not
have ${%} or ${#}, but rather that it interprets the meaning of the
backslash in this case in a way different from other shells.

>  run_backend() {
>  	echo "$2" |
> -	QUERY_STRING="${1#*\?}" \
> -	PATH_TRANSLATED="$HTTPD_DOCUMENT_ROOT_PATH/${1%%\?*}" \

What happens if you write these as

	QUERY_STRING=${1#*\?} \
	PATH_TRANSLATED=$HTTPD_DOCUMENT_ROOT_PATH/${1%%\?*} \

i.e., drop the double-quotes?

-- Hannes
