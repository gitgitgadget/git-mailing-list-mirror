From: Junio C Hamano <gitster@pobox.com>
Subject: Re: approxidate parsing for bad time units
Date: Thu, 06 Sep 2012 13:36:06 -0700
Message-ID: <7vehme3n49.fsf@alter.siamese.dyndns.org>
References: <CAFE6XRFgQa10vTWXfxRG53W6K4U=VGqpK5sQwH7xp9GfKd=2Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeffrey Middleton <jefromi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 22:36:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9ioF-0007Ib-Uy
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 22:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759894Ab2IFUgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 16:36:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48015 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759Ab2IFUgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 16:36:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A46B589E7;
	Thu,  6 Sep 2012 16:36:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7AWMFjLvamBXXPBeHP+YcjtY0m0=; b=rQRe3P
	DIUcvSXsR6i8GzO8YPwD+68NZWt5RTds75bFcLdPsfWEzTBzTrw3KTZSTqLpglMS
	aC+MhPFGjel9doNqvn2Q3Z3Bjt8IVqAWcVNyKmObH8UDcBrol665h4jYxUu1mG17
	Vd+53Nm+z4GrhrCBCpXR4YdOXd7u3BuW773hw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v+snc26/rYIGu7m4vsmRSA+WLPWWbokM
	Sv2eLqxoPfMY5KbwlM0FX65oP+bI0vrw3Y7wXOC/yMpZ2s/00cJ9stNu77xUYnRI
	gS2C8QFeMv7KRneC9DtU5rdwqkQjmAN7qY0EqZriq/Tr7HNwVQ3VJ9dqVTXtCzKJ
	Pw513ng+dpc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9040F89E6;
	Thu,  6 Sep 2012 16:36:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EADBF89E5; Thu,  6 Sep 2012
 16:36:07 -0400 (EDT)
In-Reply-To: <CAFE6XRFgQa10vTWXfxRG53W6K4U=VGqpK5sQwH7xp9GfKd=2Uw@mail.gmail.com> (Jeffrey
 Middleton's message of "Thu, 6 Sep 2012 09:24:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7CA800BA-F862-11E1-926C-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204920>

Jeffrey Middleton <jefromi@gmail.com> writes:

> In telling someone what date formats git accepts, and how to verify it
> understands, I noticed this weirdness:
>
> $ export TEST_DATE_NOW=`date -u +%s --date='September 10'`;
> ./test-date approxidate now; for i in `seq 1 10`; do ./test-date
> approxidate "$i frobbles ago"; done
> now -> 2012-09-10 00:00:00 +0000
> 1 frobbles ago -> 2012-09-02 00:00:00 +0000
> ...
> 10 frobbles ago -> 2012-09-11 00:00:00 +0000
>
> Which gets more concerning once you realize the same thing happens no
> matter what fake unit of time you use... including things like "yaers"
> and "moths". Perhaps approxidate could be a little stricter?

"Could be stricter", perhaps.

Do we care deeply?  I doubt it, and for a good reason.  The fuzzy
parsing is primarily [*1*] for humans getting interactive results
who are expected to be able to notice when the fuzziness went far
off.

As long as we have ways for scripts and humans to feed its input in
a more strict and unambiguous way [*2*], it does not hurt anybody if
the fuzzy parser ignored crufts that it does not understand.


[Footnotes]

*1* ... and of course some coding fun and easter egg values. Think
of it as our own Eliza or Zork parser ;-).

*2* And of course we do.
