From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Improve "git log --graph" output of merges
Date: Thu, 07 Feb 2013 12:53:31 -0800
Message-ID: <7v4nhn7sms.fsf@alter.siamese.dyndns.org>
References: <cover.1360267849.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Feb 07 21:54:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3YTm-0007mF-B9
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 21:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128Ab3BGUxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 15:53:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758877Ab3BGUxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 15:53:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD9E7CA72;
	Thu,  7 Feb 2013 15:53:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YAv6c2gvjUr8mg30j8Cts7htgP8=; b=cdqXVq
	NjqHvsG7jGQa3vRONQzVnbiQwIw65jHgYfDSE8Bz9jOsqtlDen8LnyrDnvdU27jd
	OopWW+EfGa22Cye5CRcs+bm46VqpRIrw6GEuOLs0frmaQcVfSVsuXLrcCD8LNyfp
	hd7QXKHbSnh55NIEvpyFrGZDZEraDRuZ46jtI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bLRBaFRYnBQH2zBR0koGAaN3i8xb4ke6
	V7Gt/YGq8es/dF3dvUTE39Mo/qi2ikq1bSe3ZCS0DKol2rsG9MgwwYC93H4+7qgX
	B1dLA2SNJCNZIq+4Nq+CeKqPbYZNV6RzM0C03zLOCgjow6M5UXKFHzeZdns/OVF5
	qCDaGslkQ7A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0B98CA71;
	Thu,  7 Feb 2013 15:53:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 39304CA6A; Thu,  7 Feb 2013
 15:53:33 -0500 (EST)
In-Reply-To: <cover.1360267849.git.john@keeping.me.uk> (John Keeping's
 message of "Thu, 7 Feb 2013 20:15:22 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F4D8438-7168-11E2-8EDD-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215729>

John Keeping <john@keeping.me.uk> writes:

> This series changes a couple of places that do not currently indent
> their output when being shown with a graph.
>
> The first patch was already posted [1] and addresses the output of "git
> log --graph -c -p".  Patch 2 is an independent fix I noticed while
> working on the later patches.
>
> Patches 3-5 introduce a helper function and change existing sites using
> diff_options->output_prefix to use it, resulting in a net reduction by
> about 60 lines.  There is no functional change here.
>
> The final patch uses the helper introduced in patch 4 to make combined
> diffs should the output prefix before each line.  This affects the
> output of "git log --graph --cc [-p|--raw]".
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/215630

Overall direction looks sensible.

It is a bit scary that we are doing the the fifth one now, as
opposed to catching this repetitiveness during the initial review of
patch series that added the graph code to the diff codepath.

Thanks.

> John Keeping (6):
>   graph: output padding for merge subsequent parents
>   diff: write prefix to the correct file
>   diff.c: make constant string arguments const
>   diff: add diff_line_prefix function
>   diff.c: use diff_line_prefix() where applicable
>   combine-diff.c: teach combined diffs about line prefix
>
>  combine-diff.c |  47 +++++++++++++--------
>  diff.c         | 131 +++++++++++++++------------------------------------------
>  diff.h         |   3 ++
>  graph.c        |  10 +++++
>  4 files changed, 77 insertions(+), 114 deletions(-)
