From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/11] t8001/t8002: blame: demonstrate -L bounds checking bug
Date: Mon, 05 Aug 2013 16:30:35 -0700
Message-ID: <7vk3jziulg.fsf@alter.siamese.dyndns.org>
References: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
	<1375258545-42240-3-git-send-email-sunshine@sunshineco.com>
	<7v4nb4j5qu.fsf@alter.siamese.dyndns.org>
	<CAPig+cTDrhruSHouGrKwFy3TqUe1_4YxJi-oWTUUe6KpZ7p4Qw@mail.gmail.com>
	<CAPig+cRYASsHyujx3uhHtRqSnfC8e1cAEMAa2thS3mgOyF2Ozw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 01:30:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6UEd-00032h-RY
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 01:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755649Ab3HEXaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 19:30:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41664 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755624Ab3HEXaj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 19:30:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3236F36B8C;
	Mon,  5 Aug 2013 23:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/rFfuRpJKA0fex0hrZp4rLSYNac=; b=wKxUFg
	m5CfmoNFrZI9ELp0tEYyO4C9JNSLei6BPVLBFcXt+At+O/5TXrOVVIoPUB7YRxC7
	pvObGRD52rxeT84o6vE2ynVL7NeSSlcHd6YWmKAvf9Ef5n4AJamlkuEa+5msm3Ja
	y27tHc9Z5iIRfIRdl/8FK61mW0sSkD4Zaf5wE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FgaFh2LZ/uzyKKKbbtqnGkYuqvLZwIE2
	O/UOKyO79WmbKIN7o10hcPJ7sdTRewvYr+w+SpPD7hXyNt8o6hPwwsBZWTon9MsO
	vHYOVDI8cr+W0oxNTdTiR6BcSda36trkhH0q8kryXycKWfClrsjNo/YLD2Jd6758
	+cAEYLxySq8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2503036B8B;
	Mon,  5 Aug 2013 23:30:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58CEA36B8A;
	Mon,  5 Aug 2013 23:30:37 +0000 (UTC)
In-Reply-To: <CAPig+cRYASsHyujx3uhHtRqSnfC8e1cAEMAa2thS3mgOyF2Ozw@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 5 Aug 2013 15:45:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 087744AA-FE27-11E2-83C0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231707>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> The problem exists with and without the incomplete line. The comment
>> mentioning "incomplete line" and "wc" was inserted to explain why it
>> was necessary to add one to the result of wc, which might not
>> otherwise be obvious.
>
> Would the comment be clearer if phrased like this?
>
>   # We want to test -LX where X is the last line of the file, so we need
>   # to compute the number of lines in the file, which normally would be
>   # done via 'wc -l'.  In this case, however, the last line of 'file' is
>   # incomplete, so 'wc' reports one fewer than the actual line count. To
>   # adjust for this anomaly, we must add one to the result of 'wc'.

If the patch picked a place where the test vector does not have to
involve a file that ends with an incomplete line, the test would not
have had to do anything tricky that required such a comment to
explain why it is doing something mysterious.

Such a change would be much cleaner and may be worth the effort, but
I do not think just rewording the comment is worth the bother.

I didn't see if there is such a place in the existing test sequence,
though.
