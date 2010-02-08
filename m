From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] git-push: clean up some of the output from git
 push --porcelain
Date: Mon, 08 Feb 2010 12:51:52 -0800
Message-ID: <7vtytrih7b.fsf@alter.siamese.dyndns.org>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org> <a1b71c9f6566549e6117f5c98c2f1e60754a7334.1265661033.git.larry@elder-gods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Mon Feb 08 21:52:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeaaV-0007cC-Qt
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 21:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331Ab0BHUv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 15:51:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54222 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab0BHUv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 15:51:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 508E898A1B;
	Mon,  8 Feb 2010 15:51:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nf54DI0XcL7XTd1lJjKp2GQazd4=; b=Y+mBG6
	ybdwwfqFzQxXNxfi0TG8XuJzmZEE00wp33fAK0YMpfNssnUPop+PkuqloWTrZgqh
	sUFpD6XJVCE8uYuahJJ81bTp/4DV902yTtCOodjvruRZ1Ry5zuVsw7cF8Ea4zTI8
	/wJbhqMtmi4gopNkOfg0znKiLUyVqhYwrSWCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H7fESJUqYuDj5vfFU3V2Nrc8jvTm/iLi
	k7ZC4JIVLxmH2NlXfsD1//22n4UMb6i+1aupPgdsmK82E2Hl9uKR/oWmGXan79Sw
	72dtkKYQySzM4PQnaeJZXmErxlylJLOulOLIufQbYlpQSXjvwhGeUhnQtCtSN1oI
	PKlpgI+Tx8A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F6B298A1A;
	Mon,  8 Feb 2010 15:51:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A35098A19; Mon,  8 Feb
 2010 15:51:53 -0500 (EST)
In-Reply-To: <a1b71c9f6566549e6117f5c98c2f1e60754a7334.1265661033.git.larry@elder-gods.org> (Larry D'Anna's message of "Mon\,  8 Feb 2010 15\:31\:23 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CB1C7334-14F3-11DF-BB51-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139317>

Larry D'Anna <larry@elder-gods.org> writes:

> * don't emit long explanatory message about non-fast-forward updates.

This makes sense as a goal, but at the same time as an implementation it
would be cleaner to flip "advice" off under --porcelain, instead of doing
"s/if (advice_blah)/if (advice_blah && !porcelain)/;".

This is doubly important if you consider longer term maintainability.  I
do not want to see the next person who tries to add new advice messages to
copy and paste the long if() statement you added in this patch.

> * send "To dest" lines to standard out so whoever is reading standard
> out knows which ref updates went to which remotes.

Makes sense. s/standard out/the standard output/, and
s/reading .*knows/reading from the process knows/, perhaps.

> * only send the "Everything up-to-date" line if verbose.

Don't you want to send this also to stdout?
