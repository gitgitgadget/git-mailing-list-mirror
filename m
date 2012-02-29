From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] pickaxe: allow -i to search in patch
 case-insensitively
Date: Wed, 29 Feb 2012 00:55:35 -0800
Message-ID: <7vy5rmt3w8.fsf@alter.siamese.dyndns.org>
References: <1330474831-9030-1-git-send-email-gitster@pobox.com>
 <1330474831-9030-3-git-send-email-gitster@pobox.com>
 <20120229083534.GC14181@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 29 09:55:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2fK5-0006sz-9M
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 09:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018Ab2B2Izk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 03:55:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38261 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755840Ab2B2Izi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 03:55:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12D7C4BC3;
	Wed, 29 Feb 2012 03:55:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nKAt2d5kHA9/TDd5862nXaLXOg8=; b=iewExa
	ipSWvlid30w701e1IbuQAgsVQz0T4IOcumEiK/fIbp3h7MD2eAHN+TyR35QVrtcl
	WT3dOw8LF6Zdu8KlpidB0WE4qy/zkpwVrIn35jMAeY71bH38mbHGstqdQVeC12iF
	KDMg6sAIyHsLs4P1QdubicO2wSB+ddYNcmI1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IxBTSUfPcAQnA1ksPOC2fqziAxILt3Ba
	1HLg4HGL6CCee64cGn3D0IET/+muhsFAcXGLkUZ7nu/UhxPiB3JUzqQxEbvzJgM3
	TU+TARRY1IEV+VqZpZl9T9VekPQwp+e5VvWupZzVAMkztaoBtNuGXdPlcy+sBsgW
	EK9+F1GPrs8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09CB14BC2;
	Wed, 29 Feb 2012 03:55:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8B174BC1; Wed, 29 Feb 2012
 03:55:36 -0500 (EST)
In-Reply-To: <20120229083534.GC14181@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 29 Feb 2012 03:35:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 25950A2E-62B3-11E1-B49B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191824>

Jeff King <peff@peff.net> writes:

>> When given the "--regexp-ignore-case" (or "-i") option, which originally
>> was designed to affect case sensitivity of the search done in the commit
>> log part, e.g. "log --grep", the matches made with -S/-G pickaxe search is
>> done case insensitively now.
>
> I can't imagine anybody would want to have different case-sensitivity
> options for grepping the commit message versus pickaxe. But even if they
> do, and we later add options to control them individually, we would
> still want the short-and-sweet "-i" to cover the common case of setting
> both. So I think the approach is good.

What you didn't read in the above is that the devilq around "-i" is not in
the case insensitivity switch between log-part grep (--grep/--author) and
patch part grep (-S/-G), but how it interacts with generating the patch
part case insensitively (i.e. "log -p --ignore-case", which is also "-i").

You can see what I decided to do in an evil merge in 'pu'.

In short,

  * The short-and-sweet "-i" means both --regexp-ignore-case (grep) and
    --ignore-case (diff); and

  * The long-hand can be used to ask for case
    insensitive grep but case sensitive patch, or vice versa.
