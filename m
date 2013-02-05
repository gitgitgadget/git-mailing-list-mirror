From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/13] contrib/subtree: Make each test self-contained
Date: Mon, 04 Feb 2013 21:13:35 -0800
Message-ID: <7vwqunwdfk.fsf@alter.siamese.dyndns.org>
References: <1360037173-23291-1-git-send-email-greened@obbligato.org>
 <1360037173-23291-12-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Nylen <jnylen@gmail.com>, git@vger.kernel.org,
	Techlive Zheng <techlivezheng@gmail.com>,
	Wayne Walter <wayne@tickzoom.com>,
	"Avery Pennarun \"" <apenwarr@gmail.com>,
	Jakub Suder <jakub.suder@gmail.com>,
	John Yani <vanuan@gmail.com>,
	"David A. Greene <greened@obbligato.org>"@b-sasl-quonix.pobox.com
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 06:14:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2ar5-0000AH-0m
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 06:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774Ab3BEFNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 00:13:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35973 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719Ab3BEFNi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 00:13:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B297BE13;
	Tue,  5 Feb 2013 00:13:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wysyi6WrOn2Z5lOqExtBiIgzkw8=; b=wmNL8i
	os1umXj9FSoAcb8H2KD8ZjzG+DFqGwCLEtEW2Ijq0AaHc0WoOy818Czk51wW+rrI
	AoEIWirCduL43sqNjed6ftjqT8s0YK4FFH8sqXG91RnwQY3ByYmXVkSYPxAOoq1L
	DcwatNOu3Z78brDHhvT0dEEMo0NGNYbnxEpFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hxf/1euPoE5joKOiPHPy8QwPUpjivydT
	SaxCnigjxCLBWfDiRNIXDxZd604Bhmk6mOJFHzV/yTcxwx/vYe5RdFGOb2o9w6wO
	zjv9Urskx7moz5v3NxJSE1HGervO7mpQOlf32e64fP9kw7WIGWHoQLXsDgknTdQ8
	tnluWTxZGa0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DA3BBE12;
	Tue,  5 Feb 2013 00:13:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7BB9FBE11; Tue,  5 Feb 2013
 00:13:37 -0500 (EST)
In-Reply-To: <1360037173-23291-12-git-send-email-greened@obbligato.org>
 (David A. Greene's message of "Mon, 4 Feb 2013 22:06:11 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC053D6E-6F52-11E2-8D81-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215459>

"David A. Greene" <greened@obbligato.org> writes:

> +test_create_commit() (
> +	repo=$1
> +	commit=$2
> +	cd "$repo"
> +	mkdir -p "$(dirname "$commit")"
> +	echo "$commit" > "$commit"

Style.

> +	git add "$commit"
> +	git commit -m "$commit"
> +)

Very nice, but don't we want to check for possible errors in any of
the above commands?

>  last_commit_message()
>  {
>  	git log --pretty=format:%s -1
>  }
>  
> +#
> +# Tests for 'git subtree add'
> +#
>  
> -test_expect_success 'fetch subproj history' '
> -		git fetch ./subproj sub1 &&
> -		git branch sub1 FETCH_HEAD
> -'
>  
>  test_expect_success 'no pull from non-existant subtree' '
> -		test_must_fail git subtree pull --prefix=subdir ./subproj sub1
> +	test_create_repo "$test_count" &&
> +	test_create_repo "$test_count/subproj" &&
> +	test_create_commit "$test_count" main1 &&
> +	test_create_commit "$test_count/subproj" sub1 &&
> +	(
> +		cd "$test_count" &&
> +		git fetch ./subproj master &&
> +		test_must_fail git subtree pull --prefix=subdir ./subproj master
> +	)
>  '

The goal of making each tests indenendent is a very good one, but
we'd really prefer not to see $test_count which is an implementation
detail of the test framework to be used like this.  It will make it
unnecessarily harder to improve the test framework (e.g. it may want
to stop using the $test_count variable).

This is not limited to this variable, but all other $test_anything
variable.  Earlier I wanted to update the definition of test_tick
which happens to be decimal number of seconds since epoch, but some
tests were comparing it with the raw values read from cat-file output
for a commit object, and it was really painful.
