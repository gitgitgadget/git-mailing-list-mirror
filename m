From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/2] merge-one-file: fix broken merges with alternate
 work trees
Date: Fri, 29 Apr 2011 15:41:43 -0700
Message-ID: <7vtydgvfx4.fsf@alter.siamese.dyndns.org>
References: <20110429185228.GA27268@sigill.intra.peff.net>
 <20110429222432.GB3347@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Aman Gupta <themastermind1@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 30 00:42:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFwNz-0003qf-97
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 00:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558Ab1D2WmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 18:42:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160Ab1D2WmA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 18:42:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ADA1D5502;
	Fri, 29 Apr 2011 18:43:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qsiUvf6TMEhIXdBjEjsdvAS5reA=; b=uGf1nr
	Ho86CtYsJ9pFPF9Yc0pO0iCbbVVop1nzJThtUSo94h2hQ6r0SlT8FM5Rp2k+RmuY
	UV5dceKMZcPJ0arJEoW2aS/UsVjCtYuBarjtEXYt5st2bX5sxU5B9Al0UqbxIzBy
	EFfxpGaMLjTKeGKj9Lq0k/IkIgfUVbr7N09MY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GqF6eXRozwk/u6ednTJcXDK/cYlTr3AT
	MeADy+v4AUVh8sUGZ2zzgtleE+VLPVs3kgzFqDfJrfZdlK09cWzwlB787fG6QNmP
	+Ot8y830pNVXgTpzBLRScA4IyU+pPAi7K9czukfzRpKe0LFnvJITc53uhXfra52X
	B/ojizbZjYY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B6F55500;
	Fri, 29 Apr 2011 18:43:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CE6B954FF; Fri, 29 Apr 2011
 18:43:47 -0400 (EDT)
In-Reply-To: <20110429222432.GB3347@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 29 Apr 2011 18:24:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29286D12-72B2-11E0-BD2A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172503>

Jeff King <peff@peff.net> writes:

> This patch makes merge-one-file chdir to the toplevel of the working
> tree (and exit if we don't have one). This most closely matches the
> assumption made by the original script (before separate work trees were
> invented), and matches what happens when the script is called as part of
> a merge strategy.
>
> While we're at it, we'll also error-check the call to cat.
> Merging a file in a subdirectory could in fact fail, as the
> redirection relies on the "checkout-index" call just prior
> to create leading directories. But we never noticed, since
> we ignored the error return from running cat.

This part is probably incorrect as we have && before cat that checks
an error from checkout-index that fails to create such a subdirectory, no?

And then "exec git update-index -- $4" at the last step would have failed.

Other than that, the patch looks much nicer and more modern.

Will queue.
