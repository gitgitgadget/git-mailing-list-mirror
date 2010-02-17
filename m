From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git status' on NFS performance regression in 1.7.0
Date: Wed, 17 Feb 2010 14:03:56 -0800
Message-ID: <7vbpfncyer.fsf@alter.siamese.dyndns.org>
References: <885649361002171208j41405b9exdfc34034c905e96c@mail.gmail.com>
 <7vy6irligs.fsf@alter.siamese.dyndns.org>
 <885649361002171335r74295d34l9a5ed9557059dbc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 23:04:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhs0E-0000k6-Jc
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 23:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260Ab0BQWEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 17:04:07 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48194 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194Ab0BQWEF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 17:04:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 490AF9AEAC;
	Wed, 17 Feb 2010 17:04:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jb0h+A03VtQ/E2L4MBzNxK1KCbU=; b=CBd/L/
	RSHPoKRQbVmEzp6Zzfx8K1mBalKtid+kokKXNlLU45+Us/n0nQ7TxCnhMQrXuckS
	wyfY53tvvJTw4O3VpDJ7skj5NQs2AkiFgY/m3io99D17J5S7KLrH3Y/esUTU9/Ux
	OuPdJocXEvxABI1uqkmUmdNPCbsz08B/T2tU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jTgorUSW3Me5i3SnPs5XzVzHXEO9JcqC
	qrsVgdCRg2+duPGUR8H0gj2d9FKj2tlmnnGJZf9BW1o7tncsXuZaFaTum/cQ8TiO
	SrRcoP4F/HYcDH8/4OUavTfgGU35/8QMf2XpsmzikTzmxyqHKqbf2CFpTFUiVGnN
	MAVIjZsS7A8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 267739AEAB;
	Wed, 17 Feb 2010 17:04:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 875DF9AEA3; Wed, 17 Feb
 2010 17:03:58 -0500 (EST)
In-Reply-To: <885649361002171335r74295d34l9a5ed9557059dbc6@mail.gmail.com>
 (James Pickens's message of "Wed\, 17 Feb 2010 14\:35\:06 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5AB4B876-1C10-11DF-9023-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140266>

James Pickens <jepicken@gmail.com> writes:

> I'm not sure how to interpret the "subtle breakage" comment with the
> winking smiley.  Do you mean that preload_index in 1.7.0 is not well tested
> and may be broken?  FWIW, I didn't notice any breakage, but I didn't do
> much testing.

The new "status" codepath is different from "commit --dry-run" codepath
that was used by "git status" in 1.6.6 series.  This old codepath has been
used extensibly with preloaded index and is continued to be used when you
run "git commit" with various options.  It is not preload-index that could
be subtly broken.

However, nobody used the new "status" codepath with preloaded index, and I
haven't thought things through if anything we are doing in that codepath
is incompatible with preloaded index in some way.

By the way, the argument to read_cache_preload() should be s.pathspec, not
NULL, I think.

Thanks.
