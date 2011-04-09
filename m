From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] add -u: get rid of "treewideupdate" configuration
Date: Fri, 08 Apr 2011 21:56:49 -0700
Message-ID: <7v39ls10q6.fsf@alter.siamese.dyndns.org>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-3-git-send-email-gitster@pobox.com>
 <20110408175149.GA3917@sigill.intra.peff.net>
 <7vaag04k8m.fsf@alter.siamese.dyndns.org>
 <20110408202404.GA16540@sigill.intra.peff.net>
 <7vmxk01izn.fsf@alter.siamese.dyndns.org>
 <20110408223206.GA7343@sigill.intra.peff.net>
 <7vei5c1iat.fsf@alter.siamese.dyndns.org>
 <7vaag01gdl.fsf@alter.siamese.dyndns.org> <20110409043824.GA22543@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 06:57:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8QEe-0006jM-QK
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 06:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566Ab1DIE5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 00:57:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49107 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab1DIE5I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 00:57:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0D3CD5C87;
	Sat,  9 Apr 2011 00:59:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zimaU2CU5fZJzJYKysm+5EmKz3M=; b=spZ3ZA
	OqDub+cgcCRojzVH95vhKASo3lc9RyOy5hYDZWDw7ta4ZLpiJ2h5zzraVe2A6CSa
	+bhkfUCjjVeAjZBUC1tzcQ/7UNzNKrmjETvjH5C1OmF3gJN6xcfErzlfMPowJqlO
	4jsg6hCHcDB6K98LgObyj6kjjSpQEyqQD9QZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wTbdyMrUxkYpKza2ZLO88EhVF+b3b1XA
	zl0fIlOk08PfKPGDh8dFfIvwRvcezfxPwAWbJ7DW3PN2MBjArnNbDBbJmN2zvRC/
	m0aibHJOvx12bAbi2dhrMCalHqgyVd2xq/Dn21IdOXiKBnmAruQB2/mRRX6mmahb
	1IwKTTujGG4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BCBD35C86;
	Sat,  9 Apr 2011 00:58:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8A1E85C85; Sat,  9 Apr 2011
 00:58:47 -0400 (EDT)
In-Reply-To: <20110409043824.GA22543@do> (Nguyen Thai Ngoc Duy's message of
 "Sat, 9 Apr 2011 11:38:24 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1268770E-6266-11E0-A211-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171181>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Fri, Apr 08, 2011 at 04:18:46PM -0700, Junio C Hamano wrote:
>> It appears that we might want to further tweak the code that tries to
>> disambiguate between revs and paths (we error out when argv[i] does not
>> name a rev and lstat(argv[i]) fails)
>
> Something like below?

That's too loose for my taste.  At that point in the codepath, don't we
sometimes expect the argv[i] might name a blob in the index?

By "we might want to further...", I meant "when we properly redesign the
get_pathspec vs init_pathspec combination".


There are places in the current code that call verify_filename() to make
sure that argv[i] is a pathspec after making sure argv[i] cannot be an
object name.  Currently it just does lstat() on it to see if it names a
path.

Instead, when we refactor get/init-pathspec API, we could expose an
interface to turn one element from argv[] into a "struct pathspec_item".
Then we can try to feed argv[i] to that string-to-pathspec_item function,
and consider that argv[i] _is_ a proper pathspec only if it parses
correctly *and* if it matches either an item in the current working tree.

That would be a moral equivalent of the current verify_filename() check
but is far more precise one; e.g. the current code rejects

	git grep -e foo '*.c' ;# bad

because '*.c' is not an object name, but lstat("*.c") fails, and you need
to disambiguate with '--'.  If you rewrite the verify_filename() in the
way I outlined above, you wouldn't have to.
