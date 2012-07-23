From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] Use variables for the lists of tools that support
 merging / diffing
Date: Mon, 23 Jul 2012 11:37:47 -0700
Message-ID: <7vzk6ql3wk.fsf@alter.siamese.dyndns.org>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com>
 <500CFAB4.4050905@gmail.com> <7vvchemnmn.fsf@alter.siamese.dyndns.org>
 <500D984D.4070909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 20:38:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StNW9-0000Pd-ME
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 20:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754648Ab2GWShv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 14:37:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53305 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754590Ab2GWShu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 14:37:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E29848514;
	Mon, 23 Jul 2012 14:37:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yfPbDR/uSaxOF8yAyXfMh9i/jQI=; b=RHgGq3
	V/IC3KUXCwV0oWLUF95LwrkHU5Dw2uI+tt/b+hYoTGWnZ2icDLWlcbtHLWEYBU4+
	c79a8s6VKmKfDd1GadUv+xLQt11+Vt8YJyA+9A1MX4opTGWPkkgDdZaNQjd7hke5
	+DEbsHw3B5k74jQ52CL5yXAkRwUu2FGDP0ExM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w7x9yMHADCkgSQt0t40tOA9xLkJZVZ8L
	EoMWANCOuRpBiY3tQ2yH7mFwz5p9KjKc+n5AUvjOpRqHqlsXiSQCBLndlEuDG/tV
	wzku2JmWpHoK0cQthwu/Cy8CFqpzqbGNQRmF4qCZqPDa3452gYFHA9ABpkQc581j
	zgY99dIzo0U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D062B8513;
	Mon, 23 Jul 2012 14:37:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 489E78512; Mon, 23 Jul 2012
 14:37:49 -0400 (EDT)
In-Reply-To: <500D984D.4070909@gmail.com> (Sebastian Schuberth's message of
 "Mon, 23 Jul 2012 20:30:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80EF1220-D4F5-11E1-8282-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201955>

Sebastian Schuberth <sschuberth@gmail.com> writes:

>> This patch makes sense to me, but at the same time makes [PATCH 1/5]
>> a "Meh", methinks.
>
> Yeah, I can see why. So I've renamed __git_mergetools_common to
> __git_diffmerge_tools and squashed with [PATCH 1/5] to make it
> less "Meh" as it does not stand on its own.

As you append kcompare or tortoise _after_ the common list, any code
that uses the variable cannot assume that the list is sorted, and
needs to sort the elements if it wants to give a sorted output, so
squashing does not make the Meh-ness go away.

By the way, would it make sense to remove these three variables from
the completion code, and instead ask "git mergetool --tool-help"
when it needs the list of supported tools for the first time?  It
would be trivial to introduce --tool-list that gives a one tool per
line output to both "git difftool" and "git mergetool" and we would
remove the risk of separately maintained list drifting away over
time.
