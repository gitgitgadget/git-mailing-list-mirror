From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: display key_delim for config --bool --get-regexp
Date: Mon, 10 Oct 2011 13:59:16 -0700
Message-ID: <7vk48ck1gb.fsf@alter.siamese.dyndns.org>
References: <201110101220.21890.brian.foster@maxim-ic.com>
 <1318251291-30297-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Oct 10 22:59:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDMwW-0003Ue-RZ
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 22:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057Ab1JJU7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 16:59:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59944 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685Ab1JJU7S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 16:59:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FD484818;
	Mon, 10 Oct 2011 16:59:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=lAqEWUaMnlPYSqYz7xsqIVp7nn0=; b=PvkBgMAawNJLO+4UnE49
	d3BfAYb9AtOEOMWmBXBzCryHhZq8rQn3KX+p/ud3Yefpw5AGUaOpJyUD1NGktYeS
	3gy/n9humkb196Myi/zgSgeT18h31/bWlV4fD5Wh6523AhUG6fI3VxFmmGwsGUaD
	8QWJ6KBMrAKmZ0ht0h89p8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=cORGKG5KeRsGWdo/ialDNu1ITQ6jq/xc7LJSu5XJjq0fsG
	5A1wREZJH4+nDA8XSJgorz8jJqSF4FdoIjRzX3bPKSTstNRQSHzlOQ4wH/PMtNil
	ZgZtZSEv0iJO0Mu5O/RI2WXJV9a0KkuhVWYiqeCIL1iASIjleoibI1q4gm9dw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 560FC4817;
	Mon, 10 Oct 2011 16:59:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCB8A4816; Mon, 10 Oct 2011
 16:59:17 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7FBCBD2-F382-11E0-9C0F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183258>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The previous logic in show_config was to print the delimiter when the
> value was set, but Boolean variables have an implicit value "true" when
> they appear with no value in the config file. As a result, we got:
>
> git_Config        --get-regexp '.*\.Boolean'	#1. Ok: example.boolean
> git_Config --bool --get-regexp '.*\.Boolean'	#2. NO: example.booleantrue
>
> Fix this by defering the display of the separator until after the value
> to display has been computed.
>
> Reported-by: Brian Foster <brian.foster@maxim-ic.com>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---

Thanks. Will queue for maintenance track.

> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index 3e140c1..dffccf8 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -333,6 +333,12 @@ test_expect_success 'get-regexp variable with no value' \
>  	'git config --get-regexp novalue > output &&
>  	 cmp output expect'
>  
> +echo 'novalue.variable true' > expect
> +
> +test_expect_success 'get-regexp --bool variable with no value' \
> +	'git config --bool --get-regexp novalue > output &&
> +	 cmp output expect'
> +
>  echo 'emptyvalue.variable ' > expect
>  
>  test_expect_success 'get-regexp variable with empty value' \

This matches the style of the surrounding code, but we may want to update
this to a more modern style.
