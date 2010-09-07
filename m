From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] t1303 (config): style tweaks
Date: Mon, 06 Sep 2010 21:52:01 -0700
Message-ID: <7vtym2p34e.fsf@alter.siamese.dyndns.org>
References: <4C85357A.8090000@web.de> <20100906190655.GG25426@burratino>
 <4C854B36.6010606@web.de> <20100907014135.GA1182@burratino>
 <20100907015317.GG1182@burratino>
 <20100907043050.GA13291@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 07 06:52:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsqAZ-0003xd-D9
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 06:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083Ab0IGEwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 00:52:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944Ab0IGEwN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 00:52:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 02491D3B58;
	Tue,  7 Sep 2010 00:52:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pmwKgRR4YEvlwitVlSugeEX+/qc=; b=Q5Ialm
	I7FqbHtVhRio85nyXhUsNiP7kuHgmH2WEhBxMOVE5YLfJuOaT5JcDcbyrbZzx4CI
	F6IefdHZiz/SaOtd4hILYspeCDtc0gymxXL7ySkjdBBdGfXYN9PlBNXvbHDk1GhP
	jwEDNXqljSKTugQZ58DG+yNs85CTJII0hu7bw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dasuymw3mb7mHcSNvyUPTrM+zbllsLfa
	nStTCSH+fYJDEq1k1VfYtaivv8w9oJuDog6petaUGoZijwxzoorNIBbbLriM0za/
	HJkVqrcBKfiJ+tQ60NlDB1U11KEJ7vuk8fVdOHHmWkrQteI5Mgy6SRM2yxFyg1H4
	pXDhlUSvlhk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B0183D3B57;
	Tue,  7 Sep 2010 00:52:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B74DDD3B55; Tue,  7 Sep
 2010 00:52:03 -0400 (EDT)
In-Reply-To: <20100907043050.GA13291@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 7 Sep 2010 00\:30\:50 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AB766402-BA3B-11DF-8BEA-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155673>

Jeff King <peff@peff.net> writes:

> ... But I really don't want to be too draconian
> about "everything must go into test_expect_success". Sure, if you are
> executing commands that might have output, or might be of interest to
> the user, put them there. But I find this a lot more readable:
>
> cat >expect <<'EOF'
> ... some expected output ...
> EOF
> test_expect_success 'frob it' '
>         git frob &&
>         test_cmp expect actual
> '
>
> than:
>
> test_expect_success 'frob it' '
>         cat >expect <<"EOF" &&
> ... some expected output ...
> EOF
>         git frob &&
>         test_cmp expect actual
> '

I agree.

My gut feeling has been that any set-up that uses "git" should never be
outside test_expect_success, but things like cat <<HERE / echo to prepare
test vector are not expected to fail (we are not in the business of
testing the build platform) and can be at the top of the script between
the inclusion of test-lib.sh and the first test_expect_success.

When you throw in tools that are platform dependent to the mix, however,
things get muddier.  Setup that use stuff like "ln -s this that" and
"setacl" is easier to handle inside test_expect_success guarded by an
appropriate prerequisite.  So even that "anything git should be inside,
everything else can go outside if it wants to" rule of thumb is not so
black and white.
