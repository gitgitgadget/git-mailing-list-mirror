From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] shell portability: Use sed instead of non-portable variable
 expansion
Date: Mon, 05 Sep 2011 09:35:49 +0200
Message-ID: <4E647BD5.8060609@viscovery.net>
References: <8762l73758.fsf@elisp.net> <4E647442.9000005@viscovery.net> <7v7h5nxxwf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Naohiro Aota <naota@elisp.net>, git@vger.kernel.org,
	tarmigan+git@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 05 09:36:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0Tiq-0008L4-LZ
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 09:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151Ab1IEHf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 03:35:56 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:40785 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab1IEHfz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 03:35:55 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1R0Tif-00023K-Or; Mon, 05 Sep 2011 09:35:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7D5C41660F;
	Mon,  5 Sep 2011 09:35:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.21) Gecko/20110830 Thunderbird/3.1.13
In-Reply-To: <7v7h5nxxwf.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180722>

Am 9/5/2011 9:15, schrieb Junio C Hamano:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>>>  run_backend() {
>>>  	echo "$2" |
>>> -	QUERY_STRING="${1#*\?}" \
>>> -	PATH_TRANSLATED="$HTTPD_DOCUMENT_ROOT_PATH/${1%%\?*}" \
>>
>> What happens if you write these as
>>
>> 	QUERY_STRING=${1#*\?} \
>> 	PATH_TRANSLATED=$HTTPD_DOCUMENT_ROOT_PATH/${1%%\?*} \
>>
>> i.e., drop the double-quotes?
> 
> Interesting. Your conjecture is that the shell may be dropping the
> backslash inside dq context when it does not understand what follows the
> backslash, i.e. "\?"  -> "?", losing the quote. I find it very plausible.

Actually, it's the opposite: Within double-quotes, a backslash is only
removed when the next character has a special meaning (essentially $, `,
", \), otherwise, it remains and loses its quoting ability. This means,
that the backslash would remain as a literal character in our patterns on
the right of % or #, and they would not work anymore as intended.

Other shells seem to parse the pattern following % and # in a different
mode, which keeps the quoting ability of the backslash even inside
double-quotes... (And to me it looks like those shells are wrong.)

Without double-quotes, backslashes (that are not themselves quoted) are
always removed and give the subsequent character its literal meaning.
Hence, in my version, the question mark would unambiguously (I think) act
as a literal rather than a wildcard.

> If that is the case, either the above or my [?] would work it around, I
> would think.

[?] instead of \? is certainly also worth a try.

-- Hannes
