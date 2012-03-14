From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward
 errors
Date: Wed, 14 Mar 2012 10:26:34 -0700
Message-ID: <7vty1rqek5.fsf@alter.siamese.dyndns.org>
References: <20120313232256.GA49626@democracyinaction.org>
 <vpqipi7zh3n.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net,
	Christopher Tiwald <christiwald@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Mar 14 18:26:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7ryF-0000Ca-Ci
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 18:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761110Ab2CNR0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 13:26:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33657 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760744Ab2CNR0h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 13:26:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09AF36875;
	Wed, 14 Mar 2012 13:26:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7uNvX1akuZPF05emhXMEbXS2Ivo=; b=yANONL
	3My0QNpg9Ewih1q5la8NHWoaYq2Rnjwq/DoG8jd3FtazfScCTzVpEWm1PWjRZUvB
	hdCSlOJuWtyZQLPNI9pNVUYj30/pLO4Lu09N2otHAvwSY1q7g68VlxYvYtZ+yeM5
	gH3vTeKdtqJcr4LSNJEd0M5haTh3ppMW/MAmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HeH7PONQoEcrTjt0etqxq/Wc7amo+dSc
	tzSrOxlGnQ22dff+CQXg7w6z8B4LxXhb7t4GK4IBOGW7pNhqiC7rfOoIJjsoGDsd
	vppw2B5wOvbKKlzQSTywTne/xNnlaWfp7MPiTSCeJm9N8pLgfNBi3yT7ByGkGiA2
	WiDBSLoyfSA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01D766874;
	Wed, 14 Mar 2012 13:26:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F8576872; Wed, 14 Mar 2012
 13:26:35 -0400 (EDT)
In-Reply-To: <vpqipi7zh3n.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed, 14 Mar 2012 10:06:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D97E1330-6DFA-11E1-A92F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193136>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I'm no expert in gettext, but I think the internationalization people
> will have a hard time dealing with a single message split accross an
> array.

My original patch on this topic predates the i18n adjustment we made to
advice infrastructure in 23cb5bf (i18n of multi-line advice messages,
2011-12-22), so that is an understandable oversight.

Thanks for catching this.

> Actually, I prefer the effect of a single advise() call (i.e. say
> "hint:" just once, not for each line), but this part is subjective.

The way advice.c::error_resolve_conflict() uses multi-line advice message
should be a good template.  The choice between "hint" for once or for
every line can later be adjusted in advice.c::advice() if we want to and
such a change will convert all the users of advice API consistently.
