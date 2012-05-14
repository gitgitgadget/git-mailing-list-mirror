From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update "gc" behavior in commit, merge, am, rebase and
 index-pack
Date: Mon, 14 May 2012 16:35:35 -0700
Message-ID: <7vy5oufi9k.fsf@alter.siamese.dyndns.org>
References: <1336810134-3103-1-git-send-email-pclouds@gmail.com>
 <20120514205039.GB3740@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 15 01:35:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SU4no-0008J3-0K
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 01:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679Ab2ENXfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 19:35:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33361 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932402Ab2ENXfi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 19:35:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B99358F02;
	Mon, 14 May 2012 19:35:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vsr0n/1bFw2ryPVTa9JoPk690TY=; b=SbKMt1
	JXTRP7Qbdof6PC1u+rMJ92VakUUfDCJHEwr2ubvXJ2J4I+AWSCtWNeVzHjfv1yja
	X4YoNu6iUMJyFe2mV5zuabEc9876TXh6M6HjMyXEsb2hj2K3y2awRKPb2eafkpg3
	qBAurhUooDX48SPrqolxgtEp13Tlzp8ATe2kQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sT1fOz/77mGQbG78Rnc6CumPdTekhy+w
	LKKyTGAeKmA/7RZYNQst1xvUulwv3V90babR1MeoUTg4pKcKoLMXuSxsxi3+SDRP
	A7QeASCyLlP/TcWjcauyp98DCbIs7MpIDdvQo4tT4Elb5WeFwzx/ihcUFZ3vNIJE
	SsL7yQAonZ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B06448EFF;
	Mon, 14 May 2012 19:35:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3961E8EFE; Mon, 14 May 2012
 19:35:37 -0400 (EDT)
In-Reply-To: <20120514205039.GB3740@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 14 May 2012 16:50:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82244E8A-9E1D-11E1-A190-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197815>

Jeff King <peff@peff.net> writes:

> The pre-auto-gc hook runs only when we need to gc (i.e., when we would
> be doing something expensive, anyway). So it is still cheap to check
> whether we need to gc (although if you have an option like "--check"
> which does not _fix_ the situation after checking, then you may end up
> running the hook repeatedly).

Whether we need to gc might be cheap to check, but I think the worry about
the new hook added after commit lost auto-gc was the hook to see if the
user declines our offer to run "gc --auto" may be expensive with an extra
fork and exec.  But I am personally fine with "commit" running "gc --auto"
every time; pre-auto-gc hook is opt-in after all.

As you mentioned in your own follow-up message, however, it will make
things worse without any real benefit if it is merely "check and warn but
never gc".  Also when "gc --auto" does not make the repository better (I
vaguely recall some corner cases mentioned here in the past), repeated
invocation of it might make such a change annoying.
