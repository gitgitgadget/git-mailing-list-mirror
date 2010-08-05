From: Junio C Hamano <gitster@pobox.com>
Subject: Re: jk/tag-contains (Re: What's cooking in git.git (Jul 2010, #05;
 Wed, 28))
Date: Thu, 05 Aug 2010 11:22:37 -0700
Message-ID: <7vd3twex76.fsf@alter.siamese.dyndns.org>
References: <7vvd7zuecv.fsf@alter.siamese.dyndns.org>
 <20100730183709.GC18544@coredump.intra.peff.net>
 <20100731060703.GA21207@burratino>
 <20100731123328.GA5273@coredump.intra.peff.net>
 <7vocdlpsmw.fsf@alter.siamese.dyndns.org> <20100805175640.GB15760@sigill>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 05 20:22:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh55k-0001Bi-S1
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 20:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758575Ab0HESWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 14:22:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577Ab0HESWs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 14:22:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D549CB7A4;
	Thu,  5 Aug 2010 14:22:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dUsrXeMOnVZxXq0BMri+2OXX+dc=; b=oAdpl4
	eatPoVEHOZV7D9SeElrneQ380U2us3Ox7ceRZ6paFJyuBlYGX+Lu7VNmpfsKaXZm
	YnUV6f4DsMq0vWmJuW5pn9POTI6udt3VTntKmA/kXA1UyWMy5kefDFxmnBAMpysm
	vO0/B+mwXdBpShC02GyOJa58oWspIT/Zjs0lY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oelrcz0kFsHrgpYZDnriT9V1ZieikAYa
	tL8rhpWxeldMQX2sL8BMvdvDIvQGQ6uZeoaVQ1aLSh9lYhJ5mEieouVD+58AXetV
	QngiJKUdEmnNErPcZVlNjV4i6BNa+FnSZtd2szNVlnDDb36i6EkE0piqyh4Gp8GC
	ir1DUPdib0I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D9938CB79E;
	Thu,  5 Aug 2010 14:22:42 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25735CB798; Thu,  5 Aug
 2010 14:22:38 -0400 (EDT)
In-Reply-To: <20100805175640.GB15760@sigill> (Jeff King's message of "Thu\, 5
 Aug 2010 13\:56\:40 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 700E5F14-A0BE-11DF-9C00-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152698>

Jeff King <peff@peff.net> writes:

> That's basically a finer-grained version of what I implemented. Mine
> finds the _worst_ skew for the whole graph, and never lets you optimize
> a traversal cutoff more than that skew. So it is nicely bounded
> space-wise, as it is always a single integer, but you waste effort on
> the entire traversal because a couple of commits are skewed. Yours
> optimizes perfectly, but needs O(skewed commits) storage. Which is
> probably a better tradeoff when the number of skewed commits is tiny
> (which is what we expect).

One thing missing from the above equation is that O(skewed commits)
approach will need O(number of commits) look-ups in the skew database (be
it a notes tree or whatever), only to make sure that most of the look-ups
say "no timestamp tweak required".  So I think the global single integer
approach you took would probably be better in the overall picture.
