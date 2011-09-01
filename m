From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib: save test counts across invocations
Date: Thu, 01 Sep 2011 09:14:26 -0700
Message-ID: <7v62lcxmsd.fsf@alter.siamese.dyndns.org>
References: <8fe5381a6b69079b8c20452fd4d99a128764dd52.1314882443.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Sep 01 18:14:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qz9uW-0001nA-85
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 18:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605Ab1IAQO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 12:14:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62039 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932570Ab1IAQO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 12:14:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AA414436;
	Thu,  1 Sep 2011 12:14:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xO24XxNg9kTU/9agf9KNQ+h9ChU=; b=VqotB9
	khXXjeOexXc5ds0hbM7SBLRyPgHWnx8w7E0MJPkiZ6fJ5MQHHL2d5Cw2GA8heSzL
	fbA6IHAwvsU9hCKU9Q/eYwfNSYpwUW+1qsLEmyD+cBmPXDz6XbaTGKpS95BVMZye
	YVU1UlCzphtYENDb4tWgGsTJ/41y1aSi99EkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h/sSQRlCVVPwzgwK/2SLranfroICBBCT
	GT5LL6KutIi/S9ORsAszigN+CXSVjIUimIqVVs1Ea1r4Kc1NfUhc5l7GP0TYnVsf
	rjn+ES/9Z0QF/E45gOtjSmUmFJPn32hNkEaNuoBLD2IVjvzWzAbmpB9iaFaxrQYU
	h2NIRPdffCA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40E2E4435;
	Thu,  1 Sep 2011 12:14:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB1024434; Thu,  1 Sep 2011
 12:14:27 -0400 (EDT)
In-Reply-To: <8fe5381a6b69079b8c20452fd4d99a128764dd52.1314882443.git.trast@student.ethz.ch> (Thomas Rast's message of "Thu, 1 Sep 2011 15:08:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 77657D98-D4B5-11E0-9A08-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180538>

Thomas Rast <trast@student.ethz.ch> writes:

> Save the number of tests run ($test_count) in a file under
> test-counts/.  Then when sourcing test-lib.sh the next time, compare
> the timestamps.

... which is this logic ...

> +test_count_file="$TEST_DIRECTORY"/test-counts/$(basename "$0" .sh)
> +test_count_saved=$(
> +	if [ -n "$test_disable_saved_count" ]; then
> +		:
> +	# the saved count is only valid if the file is newer than the test
> +	elif [ -f "$test_count_file" -a "$test_count_file" -nt "$0" ]; then
> +		cat "$test_count_file" 2>/dev/null
> +	fi
> +	# otherwise we leave the variable empty
> +)

I think the patch is cute, but I however do not think this is sufficient
to catch prerequisite changes, unfortunately. I'd rather leave the total
unknown than giving incorrect numbers.
