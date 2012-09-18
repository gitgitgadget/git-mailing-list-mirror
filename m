From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] string_list API: document what "sorted" means.
Date: Tue, 18 Sep 2012 10:21:46 -0700
Message-ID: <7va9wnnt5h.fsf@alter.siamese.dyndns.org>
References: <1347895267-5054-1-git-send-email-mhagger@alum.mit.edu>
 <7vy5k8s622.fsf@alter.siamese.dyndns.org> <505829AB.8000506@alum.mit.edu>
 <7vmx0noi8s.fsf@alter.siamese.dyndns.org> <5058371C.8060209@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 18 19:22:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE1VN-0007Dt-59
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 19:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717Ab2IRRWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 13:22:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43020 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752693Ab2IRRVt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 13:21:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14DBD9535;
	Tue, 18 Sep 2012 13:21:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B4UlKFqMRTrBWFJQWk8dDPYXnqQ=; b=qkvY1f
	sJ4IljLA5Wd1M8mXE+ZO5A2jD8OyfZJDIfB7X9msZrVx3482BMGXAATisvQV1GtS
	KqfnjeUCYhjuDG83alp7RnqxXMV8KCygl2KKuBu+hnJIWmvdmFDQPDPFFORAT4xv
	XRvLPK41EEcbLGNFqWYoquZAh9dJckw1dZKk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SCHByE4DAfF+Nsxt9U/1ScTp+1s0pN1J
	6ct0WKuZLjfsc+CnCyD0RArsNqRRGkM0cKmC5Kx/Vm9KqJLylxmjUXubzgELQKcj
	k4OAYfmV0WQ1kRtrSuBEIPjfIcvkBqTuOv1xhbqvX/HdqFpRs4E7HYLJXZR6LUbQ
	a+5haI/fC0E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02A9F9534;
	Tue, 18 Sep 2012 13:21:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5FE3D9533; Tue, 18 Sep 2012
 13:21:48 -0400 (EDT)
In-Reply-To: <5058371C.8060209@alum.mit.edu> (Michael Haggerty's message of
 "Tue, 18 Sep 2012 10:55:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 53F7E886-01B5-11E2-8404-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205840>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> If another sort order is needed, then we will either have to audit
> existing string_list users to make sure that they don't rely on strcmp()
> ordering, or we will have to implement strcmp() ordering *plus* the new
> ordering.

What I was envisioning was to pass in an optional custom comparison
when you instantiate a string_list object.  Existing callers that
rely on (or can live with, because they do not care about the exact
order) the default order will continue to use the byte-value ordering,
so there is no need for auditing.  Only the new callers that want
different ordering would set custom comparison routine.

But now I wrote it down, I realize that there is no _harm_ in
documenting "we sort in byte-value order, so expect iterations on
sorted string list to give them in that order to you" at all.

So let's go with your documentation patch as-is.

> It's not that I'm unwilling to implement 2; it's just that I still don't
> see any advantage to doing so before there is a demonstrated need for it.

As I said, I have this suspicion that the lack of demonstrated need
is largely because the existing code that do _not_ use string-list
don't do so because the interface is limited, so the argument is
sort of self-fulfilling.
