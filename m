From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] merge-base: teach "--fork-point" mode
Date: Mon, 28 Oct 2013 12:13:22 -0700
Message-ID: <xmqq38nlfbu5.fsf@gitster.dls.corp.google.com>
References: <1382641884-14756-1-git-send-email-gitster@pobox.com>
	<1382641884-14756-3-git-send-email-gitster@pobox.com>
	<CAPig+cQrBMMqSmOk0GSZJ9PTHNt-t+vuOG2Aq=7VTR1EZSeLsw@mail.gmail.com>
	<xmqq61smmkc0.fsf@gitster.dls.corp.google.com>
	<CAPig+cQ2tWFXX-RYnUrHEZCaqaPV6ZwgoPfiNPv9P1jFNTGEYg@mail.gmail.com>
	<xmqqwql2l3ln.fsf@gitster.dls.corp.google.com>
	<xmqqsivql37i.fsf_-_@gitster.dls.corp.google.com>
	<526A19CA.9020609@viscovery.net>
	<xmqqmwlxjnq6.fsf@gitster.dls.corp.google.com>
	<xmqq61sljakf.fsf_-_@gitster.dls.corp.google.com>
	<20131026090034.GH10779@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Oct 28 20:13:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VasFm-0007Va-Jc
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 20:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876Ab3J1TN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 15:13:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53174 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755559Ab3J1TN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 15:13:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77B864ED4B;
	Mon, 28 Oct 2013 19:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=OdHKBBXTez2itdl5iFtRRaoh4I0=; b=nPmyvGTF80e946JUvshy
	+vNWlHMkGpXTWMQH/HtRGiar01xJt7faaQWCaFe8x9yiMQ1ZzIqrcWbrNbs6rWrQ
	nSpX1R2p4OV4VqaFdTXGVkWiroTgsUNqBrTLhfPfEoBklp+y1Sm+CppaND64/6Tk
	+TFH8FyJ4blgrejyWIzKpT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=a3Q/1G2BmEEFt1WIdewoaU+Far/aRXlqiRex+ZLnNPvVgm
	qhHy/xbVDuKeAzC/yWW39KDXuf1U/cAQabitftZNT9V053xYeydqp/ndCS5/Evj8
	mqfImM8WdsOSWL5rru+pFCVv4CBk7HrqNrbtRHcURNPrDB8OCRX0mhiS9cCW8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FEFD4ED4A;
	Mon, 28 Oct 2013 19:13:25 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B8C694ED48;
	Mon, 28 Oct 2013 19:13:24 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 049D1D8A-4005-11E3-B9BF-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236849>

John Keeping <john@keeping.me.uk> writes:

> The --reflog name has the advantage that it makes clear that this is
> looking at something more than the commit graph and I don't think
> --fork-point does imply that.

I think I understand what you are saying, but that "more than the
commit graph" part in your reasoning is exactly one of the two
reasons why I do not think that it is a good idea to call it with
"reflog" in its name.  The next round of update to the feature may
find a better way to find the fork point than looking at the reflog.
What the feature is meant to do, i.e. "find the fork point" can stay
the same (i.e. people can use it in their script), while the way how
the implementation achieves it (i.e. by looking at reflog) can
evolve over time, and by not hardcoding "how" in the name, the users
will benefit from the updated behaviour, without having to ask for a
better heuristics by using a different option by updating all of
their scripts.

The other reason (of my two reasons) is because I do not think
"finding the fork-point" will stay to be the _only_ feature that
uses reflog in merge-base. When a next cool feature to compute
something completely different from fork-point happens to be
implemented by taking advantage of reflog data, what would we call
it?
