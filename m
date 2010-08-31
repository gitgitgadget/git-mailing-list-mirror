From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] tests: make test_must_fail fail on missing commands
Date: Tue, 31 Aug 2010 09:58:09 -0700
Message-ID: <7v7hj6d8im.fsf@alter.siamese.dyndns.org>
References: <20100831155457.GB11014@sigill.intra.peff.net>
 <20100831155652.GB11530@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 31 18:58:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqUAD-0000Lg-TU
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 18:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107Ab0HaQ6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 12:58:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36344 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032Ab0HaQ6T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 12:58:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B2F7FD24C3;
	Tue, 31 Aug 2010 12:58:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cLHm3jPahPwaDP46jvyuUrOxV0M=; b=KpGo9b
	eKYtTYOaPmadaGyTNu8vZsHkU+t+K0aQl5XSGwgQPejxKh0O7HHTbbAtXcl3DEyf
	cxcU1CkVn35obKyGaVxO6pu+TjOO86xBgJVuWVGVbBJrbR6Yfl4jXDYV+HygEBJL
	E8cF5mLAvGbPmeQURw8pzCHfBOCtXxOZsJmpY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=edjS8yvx6e5vh5LiXQNiNjFP0YUBY4OA
	P+PSUGB/qLqqcqzIH28fIlUoz6wUa9KreSFDtYI6An1d1nA9bY9L4ZLNYig5a8HF
	5htof4dkRbGI1KOl1SddOJUzQOmTV+xsOIK2oXucXA/bFU4MNpx8S6e3TSo7ssTA
	t32ianUFYws=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D242D24C0;
	Tue, 31 Aug 2010 12:58:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 83E82D24B8; Tue, 31 Aug
 2010 12:58:11 -0400 (EDT)
In-Reply-To: <20100831155652.GB11530@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 31 Aug 2010 11\:56\:53 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F2677EE8-B520-11DF-8E0C-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154939>

Jeff King <peff@peff.net> writes:

> The point of it is to run a command that produces failure. A
> missing command is more likely an error in the test script
> (e.g., using 'test_must_fail "command with arguments"', or
> relying on a missing command).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/test-lib.sh |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 285bfd8..dbb13af 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -598,6 +598,9 @@ test_must_fail () {
>  	elif test $exit_code -gt 129 -a $exit_code -le 192; then
>  		echo >&2 "test_must_fail: died by signal: $*"
>  		return 1
> +	elif test $exit_code = 127; then
> +		echo >&2 "test_must_fail: command not found: $*"
> +		return 1
>  	fi

Hmm.  One worry is that if we ever exit(127) ourselves this would be
confused, but hopefully we are not that clueless.
