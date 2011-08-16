From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] update-index: add --swap to swap index and worktree
 content
Date: Tue, 16 Aug 2011 16:01:57 -0700
Message-ID: <7vzkj9eza2.fsf@alter.siamese.dyndns.org>
References: <1313158058-7684-1-git-send-email-pclouds@gmail.com>
 <7vippxgm6y.fsf@alter.siamese.dyndns.org>
 <20110816210108.GA13710@sigill.intra.peff.net>
 <7vbovpggva.fsf@alter.siamese.dyndns.org>
 <20110816222212.GA19471@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 17 01:02:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtSeQ-0004y0-Jk
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 01:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862Ab1HPXCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 19:02:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39743 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888Ab1HPXCA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 19:02:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0E21589E;
	Tue, 16 Aug 2011 19:01:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cefhVlZXHi50UhY4dkEH+EceJ4w=; b=MzlLTq
	2Bv1HJmxEA7BbFmY5+ydWKMamief0bWcTKhleSvxdaNb68JDPP2Rm3ewKdkdqRtX
	B09vPNrPziAXWKx6D5r+yLIbthMhC774DM/gxjw9Sv4H63wqsRVRUKOqqKYcMR9l
	+plBZFQpCHxfJBWPFLEC8KcNYpK1Wpc0zU83M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cGW6U3lQtozZEhawZHpFg7t68HLtjJjf
	nfpw9xv4UyvMY65JN33tDztRYT9BCiAGbZT4ZwEFIE+Q4luRco6jCuvnIR/XsQAW
	dK3M1bufKYy3Pbm7kp2jH0nGb5RxxuvUayRmZp1jIvFZ7NwkorJvhyECmcDDQ+Tb
	RuU/iuEgi80=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7F18589D;
	Tue, 16 Aug 2011 19:01:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A96B589C; Tue, 16 Aug 2011
 19:01:59 -0400 (EDT)
In-Reply-To: <20110816222212.GA19471@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 16 Aug 2011 15:22:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BEF64B9E-C85B-11E0-8C0E-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179484>

Jeff King <peff@peff.net> writes:

>> > So the swap really functions as a toggle of "I would like to work on
>> > the index version for a minute", and then you toggle back when you're
>> > done.
>> 
>> And you have to redo what you did to the index version in the working tree
>> after the second "swap", no?
>
> No. The point is that I _already_ did it in the working tree version

But that does not change that you have to do that twice. You may already
have done so in the working tree, and then redo it in the old indexed
version again.

> while doing my s/hello/goodbye/ change (let's call this the "new
> change"). And ideally I would just use "git add -p" to stage only the
> s/word/world/ change (let's call this the "fixup"). But they're tangled
> in a single hunk, and I need some way of splitting them.

As a way to punt from making "add -e" usable, I'd think it would be a
workable q&d workaround, even though it feels wrong, and I would imagine
that normal people would probably prefer the "check out to a temporary
file to be edited" solution you wrote in your previous message.
