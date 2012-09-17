From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make test output coloring more intuitive
Date: Mon, 17 Sep 2012 13:50:39 -0700
Message-ID: <7vboh4tluo.fsf@alter.siamese.dyndns.org>
References: <1347882637-21766-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 22:50:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDiHL-0002fk-E0
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 22:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756225Ab2IQUum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 16:50:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62839 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753423Ab2IQUul (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 16:50:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A19E8602;
	Mon, 17 Sep 2012 16:50:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TgvA6nf68fKK1BPJnBmnyh9lZGs=; b=TMNWfI
	FC/uEcQs7h9PkGdt6ZIjVuHOKDxGvc/YTA5Whlb6nSHGD/b+te5QsakPm3F3V5T2
	t1pfl2WS3l69rovSfLL2Su+f+TTulWNmQRDkFfq1wonrF57cm1mLFnhgFcHNNhXz
	f34ZPluQnSvjPqkVi0OGIwRaOo+J5cKsbSaYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dfi8Cp8ZTmif2wuA8jENnBFd3bF2Toca
	s8djSfGgjDZV1qIjQ+npiQL5KRfVx/pssYezMz6Qd9RTHnbjOzptxdiR7IQ4d5c/
	KZ0e4oFUMY4H8/7+cVPZpvjsJpNbim2cuYeXFtL1gRfLhhCrfGxG7ojyPr/xtfwR
	98onaHvvffg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17B018601;
	Mon, 17 Sep 2012 16:50:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7571A8600; Mon, 17 Sep 2012
 16:50:40 -0400 (EDT)
In-Reply-To: <1347882637-21766-1-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Mon, 17 Sep 2012 12:50:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57431DDC-0109-11E2-85A8-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205745>

Adam Spiers <git@adamspiers.org> writes:

> 1. Change the color of individual known breakages from bold green to
>    bold yellow.  This seems more appropriate when considering the
>    universal traffic lights coloring scheme, where green conveys the
>    impression that everything's OK, and amber that something's not
>    quite right.
>
> 2. Likewise, change the color of the summarized total number of known
>    breakages from bold red to bold yellow to be less alarmist and more
>    consistent with the above.
>
> 3. Change color of unexpectedly fixed known breakages to bold red.  An
>    unexpectedly passing test indicates that the test is wrong or the
>    semantics of the code being tested have changed.  Either way this
>    is an error which is arguably as bad as a failing test, and as such
>    is now counted in the totals too.

I agree with Peff's comments.

The point #3 above wants to be a separate patch; we may even want to
consider a follow-up change to add an option to make a "test that is
expected to fail did not fail" case a failure.

>  test_known_broken_ok_ () {
>  	test_fixed=$(($test_fixed+1))
> -	say_color "" "ok $test_count - $@ # TODO known breakage"
> +	test_broken=$(($test_broken+1))
> +	say_color error "ok $test_count - $@ # TODO known breakage vanished"
>  }

Also I wonder if this is still a "TODO".  "# TODO fixed known breakage",
meaning that it is something that must be looked at by whoever happened
to have fixed the known breakage by accident, might be a better wording.
