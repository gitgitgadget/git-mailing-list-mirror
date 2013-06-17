From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] show-ref.c: Add missing call to git_config()
Date: Sun, 16 Jun 2013 20:05:48 -0700
Message-ID: <7vppvlighf.fsf@alter.siamese.dyndns.org>
References: <51BCCE98.3070201@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Jun 17 05:05:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoPlU-0004Bz-L0
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 05:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755654Ab3FQDFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 23:05:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59194 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755634Ab3FQDFv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 23:05:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BE761E4C0;
	Mon, 17 Jun 2013 03:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S0ODAWqFGWCIfP34TGhJJxEuB3U=; b=sJ52jz
	nFtVndZdS0hkdTs96t16PvzT3mV7YI19UGuU67HOP2GRBtndw93PtS5d4o6eYcdV
	QLCprnosZJKr3qdP04qsGFip8IYupkWcELLog5v4R2J6Q5PEuH7SC4TbhpDBCiR2
	yucOlspY4Umpf48SjA5o3MCr5A7eJTzGRbJ74=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N3J+S3bXhSnr8Zph2025y8VuqaZgvMII
	TNBOhcfcGLe4vJVBBlf7/es2WVCZRPtYD6RAiYFwrrRajbz+E69zVBSKaFjoZ/dW
	AZc0qQSb9cUWwjj+l7PnD1gDGeTlrFeBPDVqBynMn2Xa9eL7KlRFmvzfXJGvZ4kn
	tW+A31Q4Qb4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 801781E4BF;
	Mon, 17 Jun 2013 03:05:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC6791E4BE;
	Mon, 17 Jun 2013 03:05:49 +0000 (UTC)
In-Reply-To: <51BCCE98.3070201@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Sat, 15 Jun 2013 21:29:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0525D60-D6FA-11E2-B010-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228036>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> At present, 'git show-ref' ignores any attempt to set config
> variables (e.g. core.checkstat) from the command line using
> the -c option to git.

I think what you really want to see is not giving "-c" and have it
honored.

	"git show-ref" does not honor configuration variables at
	all, but at least core configuration variables read by
	git_default_config (most importantly core.checkstat) should
	be read and honored, because ...

would be more appropriate.  What are the variables that matter to
show-ref, and what are the reasons why they should be honored?  I
thought show-ref was just a way to enumerate refs, and does not read
the index nor checks if there are modifications in the working tree,
so I do not see any reason offhand for it to honor core.checkstat
(and I think that is the reason why we don't have the call there in
the current code).

Exactly the same comment applies to 2/2.

Note that I am _not_ opposing these changes.  You brought them up
because you saw some reason why these should honor some core
variables.  I just want that reason to be explained in the log for
the future developers.
