From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 w/prune index] remote.c: avoid O(m*n) behavior in match_push_refs
Date: Mon, 08 Jul 2013 09:12:37 -0700
Message-ID: <7vmwpx1156.fsf@alter.siamese.dyndns.org>
References: <20130708075007.GB25072@sigill.intra.peff.net>
	<1373273919-32005-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, git@vger.kernel.org, mfick@codeaurora.org,
	bcasey@nvidia.com
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 18:12:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwE3Q-0003wJ-U3
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 18:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab3GHQMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 12:12:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38646 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672Ab3GHQMk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 12:12:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E29AD2DD3E;
	Mon,  8 Jul 2013 16:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RQSBT8ki5r9xoH94y7AVucaa9hI=; b=m3KQlj
	3ZQttFXjxTxEX2VoWqLIQ6U5nJ2Yw0HsLBvQEi5sXbuCLhLbs0qq5a6bErTH3AOT
	e8W2lEPbulATQxQI/y5+apiGJ82ylo8nNB/61CGblCCT2UN4ZrzvzJbd/c4czxzv
	NV3t0XjNAJD/Gg0bRhnqDUhThto6PvKcX7Pq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d9cR5fOwRhVpwTdMIMZeaisdnmXt0Udt
	L4IeUvacMonwI4tAZaIMatv6EvjOIidsbYDWW7fDue3O30OIayBx7zP4Gnu08fJf
	Vt5DT4wv1CThmL6XF1B4sm20Q45qseiy/3Oxsw1/GTmbTzredh7SxuiMlX01rfS5
	EJjAVnHALn4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D27F52DD3D;
	Mon,  8 Jul 2013 16:12:39 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0526F2DD39;
	Mon,  8 Jul 2013 16:12:38 +0000 (UTC)
In-Reply-To: <1373273919-32005-1-git-send-email-drafnel@gmail.com> (Brandon
	Casey's message of "Mon, 8 Jul 2013 01:58:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 35C95B36-E7E9-11E2-AFFC-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229872>

Brandon Casey <drafnel@gmail.com> writes:

> ...
> Using an index takes 41 ms longer, or roughly 7.8% longer.
>
> Jeff King measured a no-op push of a single ref into a remote repo
> with 370,000 refs:
>
>         before    after
> real    0m1.087s  0m1.156s
> user    0m1.344s  0m1.412s
> sys     0m0.288s  0m0.284s
>
> Using an index takes 69 ms longer, or roughly 6.3% longer.
>
> None of the measurements above required transferring any objects to
> the remote repository.  If the push required transferring objects and
> updating the refs in the remote repository, the impact of preparing
> the search index would be even smaller.
>
> A similar operation is performed in the reverse direction when pruning
> using a matching or pattern refspec.  Let's avoid O(m*n) behavior in
> the same way by lazily preparing an index on the local refs.

Thanks.  Both the explanation and the code change makes sense to me.

Will queue.
