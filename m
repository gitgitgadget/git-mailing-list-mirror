From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] request-pull: resurrect for-linus -> tags/for-linus DWIM
Date: Mon, 02 Jun 2014 11:05:17 -0700
Message-ID: <xmqqfvjn5grm.fsf@gitster.dls.corp.google.com>
References: <1400263070-15312-1-git-send-email-gitster@pobox.com>
	<538C2290.3060506@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 02 20:05:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrWbv-00083r-69
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 20:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbaFBSFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 14:05:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61847 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbaFBSFW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 14:05:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5EF231D72C;
	Mon,  2 Jun 2014 14:05:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rfzYLC5pMnZLt2MvgXkydjs8GoY=; b=uAE72/
	eo55grdP7UWu20ELHaf/J0vAm6MZ+hxivqTF3L596i4SkJaECv0QruwE5WgAG58S
	1EA6IphDXIg04PiCs586BZTH07Dn69I2cVt/Hnt2QEBI7EN6fUGf6biY47vjggeG
	uXDW0tva6wf+fYmuZdB5JkquvNO288/0lxySQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rvWYuqqgSYynXUwg6UEWL2XOza4FVn2C
	oQlDdJnW/q6RhyotxFI9wZDTpjKAopX39zKQrwvJilBI1LsVTCBx9atBubCUGs+m
	ZdCj+vGzpulXcKK3DfRl0FOFhdM8WVqz7frY8uDbMlZqWulyhyazj76EFPdhxWSx
	/c11l2GYbHk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 54C951D72B;
	Mon,  2 Jun 2014 14:05:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A55F01D724;
	Mon,  2 Jun 2014 14:05:18 -0400 (EDT)
In-Reply-To: <538C2290.3060506@viscovery.net> (Johannes Sixt's message of
	"Mon, 02 Jun 2014 09:06:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 74C3252A-EA80-11E3-A2E9-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250576>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 5/16/2014 19:57, schrieb Junio C Hamano:
>> --- a/t/t5150-request-pull.sh
>> +++ b/t/t5150-request-pull.sh
>> @@ -223,7 +223,13 @@ test_expect_success 'pull request format' '
>>  		git request-pull initial "$downstream_url" tags/full:refs/tags/full
>>  	) >request &&
>>  	sed -nf fuzz.sed <request >request.fuzzy &&
>> -	test_i18ncmp expect request.fuzzy
>> +	test_i18ncmp expect request.fuzzy &&
>> +
>> +	(
>> +		cd local &&
>> +		git request-pull initial "$downstream_url" full
>> +	) >request &&
>> +	grep ' tags/full$'
>>  '
>
> What's this crap? Here's a fix. Feel free to tame down the subject line
> if you think it's too strong ;)
>
> --- 8< ---
> From: Johannes Sixt <j6t@kdbg.org>
> Subject: [PATCH] fix brown paper bag breakage in t5150-request-pull.sh

Thanks for catching; I do not think the "brown paper bag" is too
strong ;-)

> The recent addition to the test case 'pull request format' interrupted
> the single-quoted text, effectively adding a third argument to the
> test_expect_success command. Since we do not have a prerequisite named
> "pull request format", the test is skipped, no matter what. Additionally,
> the file name argument to the grep command is missing. Fix both issues.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  t/t5150-request-pull.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
> index 93e2c65..82c33b8 100755
> --- a/t/t5150-request-pull.sh
> +++ b/t/t5150-request-pull.sh
> @@ -229,7 +229,7 @@ test_expect_success 'pull request format' '
>  		cd local &&
>  		git request-pull initial "$downstream_url" full
>  	) >request &&
> -	grep ' tags/full$'
> +	grep " tags/full\$" request
>  '
>
>  test_expect_success 'request-pull ignores OPTIONS_KEEPDASHDASH poison' '
