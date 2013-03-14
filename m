From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow combined diff to ignore white-spaces
Date: Thu, 14 Mar 2013 08:31:22 -0700
Message-ID: <7v7glayp4l.fsf@alter.siamese.dyndns.org>
References: <7v38wdc4ei.fsf@alter.siamese.dyndns.org>
 <1363209683-10264-1-git-send-email-apelisse@gmail.com>
 <51417773.5000401@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 14 16:32:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGA8O-0007ab-OE
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 16:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758079Ab3CNPb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 11:31:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37084 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757582Ab3CNPbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 11:31:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FFF5A926;
	Thu, 14 Mar 2013 11:31:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dgaIA8JS9uFg+MBieSR2NG46Ppw=; b=ke+UnZ
	1woQ3VcbEGG/ttB6Vyb0rl6PtAraYpfrbIM969G/OM3PRG+02GsDkqcv1C9v6nHM
	Of9NP+nBU++URN8ZW8FPdUKdWWhWbjz3qBvh9fho6mbI90scAjBzMdjOyN0uVm4T
	oT2cIv+m4Tc0438g0DwRBzEaraIbeRBmQ3PVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z6/AASU/YP18eTn3RJy6yGFlE00SVt5R
	h89gIEeI5L8UyHGRgqC4uiy3V3/4G9M5JGt4k0DmKKzgBcDIk89feoWzdNKJUQ+T
	wPYQhsxuRhg1rJ5rTU8LdJscmyzDgweoZD1CZzejPYX5CLnGAh5FeMM5k9ZXzCHT
	pX5eZZfvOxA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82D80A925;
	Thu, 14 Mar 2013 11:31:24 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2198A924; Thu, 14 Mar 2013
 11:31:23 -0400 (EDT)
In-Reply-To: <51417773.5000401@viscovery.net> (Johannes Sixt's message of
 "Thu, 14 Mar 2013 08:08:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A9867E8-8CBC-11E2-8D47-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218146>

Johannes Sixt <j.sixt@viscovery.net> writes:

> This form of 'echo' is not sufficiently portable. How about:
>
> 	tr -d Q <<-\EOF >test &&
>
> 	always coalesce
> 	eol space coalesce Q
> ...
> 	EOF

Much better.

>> +test_expect_success 'check combined output (no ignore space)' '
>> +	git show | test_i18ngrep "^-\s*eol spaces" &&
>> ...
>> +	git show | test_i18ngrep "^--\s*always coalesce"
>
> This loses the exit code of git show. We usually write this as
>
> 	git show >actual &&
> 	grep "^- *eol spaces" &&
> 	grep "^- *eol space coalesce" &&
> 	...
>
> (Same for later tests.)
>
> There is nothing i18n-ish in the test patterns. Use regular grep.
>
> BTW, there is compare_diff_patch() in diff-lib.sh. You can use it to
> compare diff output to expected output. Then you do not need a grep
> invocation for each line of the test file.

All good suggestions.  Thanks.
