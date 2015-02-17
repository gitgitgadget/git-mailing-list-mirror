From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'make test' fails in pu
Date: Tue, 17 Feb 2015 11:44:35 -0800
Message-ID: <xmqq7fvg2uho.fsf@gitster.dls.corp.google.com>
References: <1424162357.30155.14.camel@kaarsemaker.net>
	<20150217085509.GC17174@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 20:44:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNo4Z-00014R-0r
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 20:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971AbbBQToi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 14:44:38 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65261 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752868AbbBQToi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 14:44:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A8EFC37B78;
	Tue, 17 Feb 2015 14:44:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rxh9SBnMNsJWrXA1X3r7ReF5hxM=; b=NHbPbN
	U6gHUJUwTnWmFUgv243QAY8Ew+hl/knCdS1BMBjiA7Lxa3nfnghB9KWxOwXGJhQ6
	yap4LIFbzOXtTcwhgiiG7dLXMzRQBIyonAAqWtGthwAE5lh6FGoISskjxOTN+sVj
	vs/Jd4HJhgaHgPEXobC9i/qlPDRInzVDXL4T4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IIVi+nji/Td2Cz921gk1dyNmn3CzkK8u
	yMtnZ1SXrnrFy3Cdkp9NAGZkkZG1snbzMybTFClZnnImkpSCdhvzLjkDyIAf/tIt
	XPcVksusKD1ExmcbZP6UbVg1C5/MmlvxYj2I3s0cwPzmBNa6agOFsGWFxL/o5ala
	6NaxszNeHlo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A037B37B77;
	Tue, 17 Feb 2015 14:44:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1202437B75;
	Tue, 17 Feb 2015 14:44:37 -0500 (EST)
In-Reply-To: <20150217085509.GC17174@peff.net> (Jeff King's message of "Tue,
	17 Feb 2015 03:55:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 67A4C180-B6DD-11E4-AE79-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263978>

Jeff King <peff@peff.net> writes:

> Sometimes a breakage in pu is surprising (e.g., it breaks only on a
> platform that the maintainer does not run "make test" on) and we would
> want to know about it. But sometimes it is merely that there is a
> work-in-progress. And it probably requires a human to tell the
> difference.
>
> So no, I do not think automatically mailing on test failures in pu is a
> good idea. Manually peeking at them and sending fixes before the series
> is merged to next _is_ very much encouraged, though. :)

Thanks, that is exactly what people saw.  From time to time, I queue
a topic that does not pass the tests on 'pu', hoping that somebody
sufficiently interested would step in to collaborate with the author
of the topic to move things forward when the breakage looks simple
enough, and sometimes that original author happens to be me.

This case, it turns out that the breakage is not so simple, though.
Inside the rename detection logic, I want to peek the rename source
array to decide which deletion filepair to keep, but rename source
array itself has pointers to the original filepairs the loop wants
to free, so the WIP code was peeking into a freed piece memory X-<.

> Unlike "pu", "next" and "master" should never fail tests (I think that
> Junio will not push them out if the tests have failed on his system). So
> failures there are much more likely to be interesting platform bugs (but
> of course, testing "pu" is still encouraged, as we may catch problems).

True.  I do not mind automated tests on 'next', and testing 'pu' and
helping the topic to move forward is very much encouraged, but
sending test results on 'pu' blindly is often more noise than it is
worth.
