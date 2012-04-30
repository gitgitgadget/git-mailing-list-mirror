From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git bug: moved file with local unstaged changes are lost during
 merge
Date: Sun, 29 Apr 2012 17:16:18 -0700
Message-ID: <7vr4v6hy5p.fsf@alter.siamese.dyndns.org>
References: <CAAZnV3Einocd4TJ0iqcxPJNsr44j3RwhczS9OhyURX0faGWgBQ@mail.gmail.com>
 <CAAZnV3EwZ6kminW7D3ssn_Rtj2SsMHd++VCx7w14K5rQKba4_g@mail.gmail.com>
 <20120413064941.GC27214@sigill.intra.peff.net> <20120414231515.GB18137@ecki>
 <20120429141758.GA6500@ecki.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Joe Angell <joe.d.angell@gmail.com>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Apr 30 02:16:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOeHz-00085u-9b
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 02:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741Ab2D3AQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Apr 2012 20:16:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43412 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754132Ab2D3AQU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2012 20:16:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 670777C27;
	Sun, 29 Apr 2012 20:16:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xLeycvsQ5av+Amz4mzL5LxnyM0U=; b=gms0jl
	KTt9TDbohY5x0E/C77bkeUswQAWjbdXjq4o3SNqrNoyHXD7T7oblAKRhEo/685Lq
	Xhnplkn82w4oFK2H4WLfBo/MjcAPRRZYr2KhGSmDerfMu4LXuiPb7z5KoiPmnfsK
	hLskdNqcMZdQuVXsRcyC6gZLW+3xuhe+DFPD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cgrX4Kl5IN+5cTiUUQPy3UXs2XXevJHK
	+vj3X79Z3sMYtEDwNXhMIpu9HZbdjESXpZnHlvpJScytvc7nlOf4zLwfONtBe8nR
	G3o5lEbS1UkxjaJrw9nlSOcB6eonNc0NpAI8s2jJdPGfMmJX5aWK0gp4ST4ARi85
	43/r7N0ZPws=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EA3A7C26;
	Sun, 29 Apr 2012 20:16:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E66D87C23; Sun, 29 Apr 2012
 20:16:19 -0400 (EDT)
In-Reply-To: <20120429141758.GA6500@ecki.lan> (Clemens Buchacher's message of
 "Sun, 29 Apr 2012 16:17:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5E9767A-9259-11E1-B42D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196523>

Clemens Buchacher <drizzd@aon.at> writes:

> 2. merge_trees -> process_entry
>
> Find possible rename pairs and try to merge renames. Due to the renames,
> entries that were classified as b) above can now become of type a).

Yes, unfortunately the rename-processing part of merge-recursive is known
to be broken wrt things like this.  If you want to punt,

> Maybe we should disable merging with a dirty work tree altogether, until
> we have a solution that is safe to use?

this is not the way to go, as "resolve" is perfectly safe.  It would make
more sense to disable the rename-processing part of recursive by default,
until it gets cleaned up further.
