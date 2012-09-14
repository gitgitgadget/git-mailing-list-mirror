From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/6] t7810-grep: test multiple --author with
 --all-match
Date: Fri, 14 Sep 2012 08:55:35 -0700
Message-ID: <7vboh87g5k.fsf@alter.siamese.dyndns.org>
References: <7v7grzdue6.fsf@alter.siamese.dyndns.org>
 <cover.1347544259.git.git@drmicha.warpmail.net>
 <8fd93bb87098298677426735dd354fa4f64abc17.1347544259.git.git@drmicha.warpmail.net> <7vmx0t7iq0.fsf@alter.siamese.dyndns.org> <7vwqzx4i9i.fsf@alter.siamese.dyndns.org> <5052E756.2040605@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 14 17:55:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCYFC-0004cd-BM
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 17:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759220Ab2INPzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 11:55:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51263 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759186Ab2INPzj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 11:55:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35A016EFF;
	Fri, 14 Sep 2012 11:55:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b7Um+e7HfWzNHRrXYfVYV2slvCg=; b=cdCQZ6
	0IZdSXdb77JRQG/gB6YfOzCe5c3Jrw9DM1yWecZisjxaQSWX6hjb7mTXuoqBhfZ4
	+jrRTJ+jZETsQ3Bjhy+lf8ojfqeSDBwhNva1EqchNBZEwGtUpXViwDT7Rq9uZU0A
	OzLdsA/zBAkmfU8vwRDZJ1M6XwAyeDbXWZK9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uppVsWIfPsZTDBlAF9NeT6uhdv0o9a6k
	7ujz4eFyJmX2Cd3r4gmbTGGsqTjyuG7cWmPqARtItCBb5aW0VnuNH69xid13MYmo
	7IQIgT4UJbjpNHhCYnWSH/e7em/uWCeKu47QrNh7Wdh5ECcoNDqbOoHhYhvRME4B
	aeCTx3yftsg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 235796EFE;
	Fri, 14 Sep 2012 11:55:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 812276EFA; Fri, 14 Sep 2012
 11:55:37 -0400 (EDT)
In-Reply-To: <5052E756.2040605@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri, 14 Sep 2012 10:14:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A03DE8C8-FE84-11E1-855C-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205496>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 14.09.2012 01:26:
> ...
>> when "--all-match" was given from the command line, so that the
>> "committer", "author" and elements on the top-level backbone in
>> "pattern" form the top-level backbone of the resulting expression to
>> be inspected by the "all-match" logic.
>> 
>> Does this pass the expect-failure test in your [PATCH 5/6]?
>
> Just a quick heads up:
>
> I merged 38ed8ef (log --grep/--author: honor --all-match honored for
> multiple --grep patterns, 2012-09-13) from pu into my test branch,
> and this fixes what I had marked as known failure there. Thanks!

Thanks for testing.

>
> I still have to figure out the logic, but begin to understand that
> "(OR...) and "(AND...)" are linewise, and all-match is a bufferwise AND

Yes, all-match is about requiring all the top-level nodes to have
fired while inspecting the whole file.  So between these:

    $ git grep -e foo --and -e bar
    $ git grep --all-match -e foo -e bar

the former shows lines that has both foo and bar, while the latter
shows lines that has either foo or bar but only from files that has
both in them (on possibly separate lines).

> Now, what is "*or*" ...

That is for to show the token we received from the command line
parser; the more interesting part is the parsed expression tree,
that is mostly formed as a tree with each node labeled with what
kind of operation it represents.
