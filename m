From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t6030: use $SHELL_PATH to invoke user's preferred shell
 instead of bare sh
Date: Tue, 30 Aug 2011 15:55:06 -0500
Message-ID: <9Mf0-hbcq2yQhZea9SPcW_u7qYq8G669j-m6nWbGmCA50MnYbUc0VyfjRoRkKCY9LZKWWqwZZVQfQlC6f2mFgdGd1OG7z0-ILDeRZolzPpA@cipher.nrlssc.navy.mil>
References: <AX_v58JCVQaEpje66svorKmGJD7HpSiOHBJnOQNVrHDgfPmc0U18ieH5lid-K0qVdSih0VESG4m-wI7qRpPahQ@cipher.nrlssc.navy.mil> <7vfwki1wqo.fsf@alter.siamese.dyndns.org> <7vaaaq1w6x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 22:55:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyVL5-0007te-RV
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 22:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756704Ab1H3UzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 16:55:14 -0400
Received: from mail3.nrlssc.navy.mil ([128.160.11.249]:59179 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756690Ab1H3UzN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 16:55:13 -0400
Received: by mail3.nrlssc.navy.mil id p7UKt7g0027826; Tue, 30 Aug 2011 15:55:07 -0500
In-Reply-To: <7vaaaq1w6x.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 30 Aug 2011 20:55:06.0698 (UTC) FILETIME=[190CB2A0:01CC6757]
X-Virus-Scanned: clamav-milter 0.97.2 at mail3
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180443>

On 08/30/2011 03:27 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>>> +	git bisect run \"$SHELL_PATH\" -c '
>>>  		GOOD=\$(git for-each-ref \"--format=%(objectname)\" refs/bisect/good-*) &&
>>>  		git rev-list --objects BISECT_HEAD --not \$GOOD >tmp.\$\$ &&
>>>  		git pack-objects --stdout >/dev/null < tmp.\$\$
>>
>> Hmm, shouldn't we also be quoting '$' in front of SHELL_PATH to make the
>> test_expect_success interpolate the value of SHELL_PATH, instead of hoping
>> that SHELL_PATH does not have double-quote in it when the shell that forms
>> parameters given to test_expect_success interpolates it?

Yep, makes sense.  Good catch.  Thanks.

-Brandon


> By doing this silly thing:
> 
> 	$ mkdir '/var/tmp/a"b c/'
>         $ ln -s /bin/sh '/var/tmp/a"b c/shell'
> 
> and then adding
> 
> 	SHELL_PATH='/var/tmp/a"b c/shell'
> 
> after we source "test-lib.sh" in t6030, I see this breaks when the shell
> parses to figure out what parameters to call test_expect_success with.
> 
>  t/t6030-bisect-porcelain.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index 68c0e97..cd9de63 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -701,7 +701,7 @@ test_expect_success 'bisect: demonstrate identification of damage boundary' "
>  	git bisect reset &&
>  	git checkout broken &&
>  	git bisect start broken master --no-checkout &&
> -	git bisect run \"$SHELL_PATH\" -c '
> +	git bisect run \"\$SHELL_PATH\" -c '
>  		GOOD=\$(git for-each-ref \"--format=%(objectname)\" refs/bisect/good-*) &&
>  		git rev-list --objects BISECT_HEAD --not \$GOOD >tmp.\$\$ &&
>  		git pack-objects --stdout >/dev/null < tmp.\$\$
