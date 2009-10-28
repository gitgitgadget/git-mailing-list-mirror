From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Use the --submodule option for diffs
Date: Wed, 28 Oct 2009 00:19:49 -0700
Message-ID: <7v7hugrnmy.fsf@alter.siamese.dyndns.org>
References: <4AE70AC9.6040302@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:20:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N32pD-0008Ut-Jz
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 08:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbZJ1HTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 03:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbZJ1HTy
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 03:19:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48315 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932559AbZJ1HTx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 03:19:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AD16769DFE;
	Wed, 28 Oct 2009 03:19:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=g7A5tNsc8utzsVrQlMfLnd8doDk=; b=RMU09Tfui7hOyXvuzJHEcNa
	aOJZzHBrlCqQ85f3DeaOjP+2qogfMk468exNMqwKH0HdAFlkXhznR76FT0IV65V7
	IobJnCo2WXm3FCXRy2Fec/ofDeg2mfvpWoZ6uRgW+ht1oUsh19Qer00NFGKHMm4B
	D7rCSvCmijeb+gD+b0vs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=KHryzXmnEhLk/g+8ldHlWWWuwfZVqFl6H/oG4YwYQqHkRWi5g
	ADCss/u/ZH0NFFrx2ZzCmdWTsKqnqpGqS9yuoP1dVMWt03SvVGAPezbmtxMXrG8M
	SvhjbzZL5QCUcrCg3C7zeru0ev27d39SQ1aYfvL5Xp7+cnVb8P4BbvDRaI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DFEC69DFD;
	Wed, 28 Oct 2009 03:19:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7A3169DFC; Wed, 28 Oct
 2009 03:19:50 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4AC6596E-C392-11DE-9A45-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131427>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Instead of just showing not-quite-helpful SHA-1 pairs display the first
> lines of the corresponding commit messages in the submodule (similar to
> the output of 'git submodule summary').
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>
> This patch applies to 'next' and uses the new --submodule option of git
> diff to achieve a more meaningful output of submodule differences in
> gitk.
>
> Any objections against making this the default?

It looks like you are not making this the default, but are making it
mandatory.  That's quite different.

As long as gitk ships with matching version of git, I do not think it is a
huge problem to force "diff" to always run with --submodule option, but if
that is what the patch does, I'd prefer to see the patch says so, instead
of giving a false impression that there may be a way to disable it if one
wants to.

Looking at the patched text, I had to wonder where these $flags come from.
The callers of "diffcmd" give it to you, and I am not sure if all of them
want -p format diffs.  Specifically, what does gettreediffs do?  Does it
make sense to give --submodule to that invocation?

Yes, I know --submodule happens to be a no-op in non-patch format diffs,
but I do not think that is by design.  It is something somebody may notice
and correct it later, at which time this patch will be broken.

I also suspect that this might break getpatchid, but as long as all the
patches consistently change/break ids it would be Ok.
