From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] Improved infrastructure for refname normalization
Date: Sun, 11 Sep 2011 21:28:07 -0700
Message-ID: <7vehzmbd0o.fsf@alter.siamese.dyndns.org>
References: <1315637443-14012-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 06:31:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2yBA-0002AF-0J
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 06:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846Ab1ILE2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 00:28:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64103 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797Ab1ILE2L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 00:28:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDE274556;
	Mon, 12 Sep 2011 00:28:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9zPS5/Q0ViQvlQwyxfr3tfkQjZU=; b=xVxlJd
	+KZp1gyYxeOY/smaBwzBZ3b3Z+JlQOxKiZWWVJWvEiMn21d0Vzhi7tiCvGkLClKq
	m8qewxlL4zi7NImJf1cmOH5Gq6DoKir9ZJR0AXN5SEludaqXR4Y/iMM63dJLA9oc
	ikP2iEG84G/Srhr4MzY10L3Or64h3+/eVVOzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ar6of666rGLUb/VKcZXjm/7OZvRob6/b
	RZ6G+D3iQ2ZcQbagDvqEHvtvv5q1huazNHmiWgi/hmSLQTdCxrlFf+jb07lGKiy1
	92QDmBWPJD8eGnwi1DX2guNiyCo//Jz6VRz+INZQdLAXV8XoMjei/G3s9CFdyoBy
	lzJD1Wi8aek=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4DDC4555;
	Mon, 12 Sep 2011 00:28:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 674374554; Mon, 12 Sep 2011
 00:28:09 -0400 (EDT)
In-Reply-To: <1315637443-14012-1-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Sat, 10 Sep 2011 08:50:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E70D4E2-DCF7-11E0-9EC0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181205>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Patch series re-roll:

Thanks for working on this. I very much like the general direction of the
series, the strategy to avoid wholesale audit of the callers and marking
the places that needs fixing with "_unsafe()".

There were a few minor things that looked worth mentioning while
reviewing, though.

 - (style) You seem to be fond of pre-increment a lot, but in general our
   codebase prefers post-increment especially when the end result does not
   make any difference, e.g.

	for (i = 1; ...; ++i) {
        	...

 - (series structure) It might make the series progress easier to follow
   if you introduced check_ref_format_unsafe() in the same commit where
   you change check_ref_format() to take flags parameter.
