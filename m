From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] rev-list: add --authorship-order alternative ordering
Date: Thu, 06 Jun 2013 15:48:41 -0700
Message-ID: <7vvc5qx3cm.fsf@alter.siamese.dyndns.org>
References: <1370369299-20744-1-git-send-email-me@ell.io>
	<1370369299-20744-2-git-send-email-me@ell.io>
	<7vip1t7koi.fsf@alter.siamese.dyndns.org>
	<7vobbl60aj.fsf@alter.siamese.dyndns.org>
	<CAPZ477OFM6D4n_Wz-OozN=aYn5-LmNA2ggL+9GNrbGrRQh9pRQ@mail.gmail.com>
	<7vobbjxc21.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Elliott Cable <me@ell.io>
X-From: git-owner@vger.kernel.org Fri Jun 07 00:48:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkizF-0005zX-HH
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 00:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510Ab3FFWst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 18:48:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36747 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693Ab3FFWss (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 18:48:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CE4F25862;
	Thu,  6 Jun 2013 22:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qk/wM25yCcqpm0suGiCsm/Izzt4=; b=GJTuTt
	/fn4snA/jkPh73kYtwOKVo0Ig1tCfdPTK9SA+yORw1zhiC0nnxM47rOu79RZSbTS
	bytXI1WVBuTJ5Gyw5kdZWvdJpAGPb/0TPybbMFOVZ28RXD8IEjj90eoZtzQFWa0w
	ibOp+mT3nb2vL43ZAohxT0MV/pTH+KQuCO46o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vPZs6ytPjAPoZReoPsHcIAu4itbsqBVH
	WoUVFIWnr/TrZbSSdMWtqchSE0kY5IuY2qmCfj/tz7NlDZ/hrXparOiNur1nuph8
	iM0UsKk9h6lGAW0xpZq81anG6+1UqxBPGU6cSFf68jDjQheYS7feiADDrRzWeXhV
	SFJtdHCRlcA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63F7A25861;
	Thu,  6 Jun 2013 22:48:48 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED3DA2584F;
	Thu,  6 Jun 2013 22:48:42 +0000 (UTC)
In-Reply-To: <7vobbjxc21.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 06 Jun 2013 12:40:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3CFC57DE-CEFB-11E2-B4B3-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226570>

Junio C Hamano <gitster@pobox.com> writes:

> If you want to do this in a multi-step series (which may not be a
> bad idea), I would imagine that the enum starts as a choice between
> the two: traversal-order vs committer-date-order.  The first patch
> would change nothing else.
>
> And then you would add the third choice, author-date-order, and
> implement the logic to sort them using author instead of committer
> date in the same patch.
> ...
> You would parse all of them at the beginning of topo-sort function
> once and store these dates in the commit-info-slab (alongside with
> indegree).  Once you are done sorting, you can discard the slab.
>
> This could be done as a follow-up patch, but the tons of helper
> functions you added to compare by author date to revision.c will
> have to be removed in such a transition, because the whole point of
> using commit-info-slab is not to have commit->author_date field,
> which these new helpers work on.

As I needed to have an excuse to push jk/commit-info-slab topic
further (I have an unpublished show-branch rewrite on top of it),
I may take a look at doing this myself if/when I find some time.
