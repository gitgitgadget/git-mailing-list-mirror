From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] mv: improve overwrite warning
Date: Mon, 12 Dec 2011 11:57:31 -0800
Message-ID: <7vobvd36ms.fsf@alter.siamese.dyndns.org>
References: <20111212074503.GB16511@sigill.intra.peff.net>
 <20111212075227.GD17532@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 20:57:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaC0J-0005dG-R9
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 20:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021Ab1LLT5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 14:57:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41656 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753924Ab1LLT5e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 14:57:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2F40611A;
	Mon, 12 Dec 2011 14:57:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wf1gYxoLow0k0iA54Fi09TP/1L4=; b=QJSX3t
	90CbRmYxBKg8DAPx6w8cnqvDF0kZiIMGc19y39Aq6M3COn3HljN3SOm29HAmBddQ
	x9i+Me5yFxi1kmr74IhJ+HZKDnXN2L4ofUazjruPnENPA4W15bvXkowdAP2pGics
	NeRkZkDPo0fsDlcsNBvtSlRZMZ3eFDESaXK90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tu1wGLchh5o+/JAJNnVbFYE0jvJGGSMd
	jCvRil9ijtEabuCaF51nK4gRkNUbeBYTD8w0u4y3jZgPVFKMu4Py0CvogQGMVFWL
	C1BrNO/yY3dZ0ZOB6spiEQA7Pe7YDk7nHmyCaMXo1/YvhnujyXXQBuFaY4hV+fLu
	ONG8racErTU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA4FD6119;
	Mon, 12 Dec 2011 14:57:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5ECD96118; Mon, 12 Dec 2011
 14:57:33 -0500 (EST)
In-Reply-To: <20111212075227.GD17532@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 12 Dec 2011 02:52:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 87F1DD82-24FB-11E1-8244-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186942>

Jeff King <peff@peff.net> writes:

> This message looks overly long to me, but I wanted to match the existing
> messages. Another option would be just:
>
>   warning: overwriting 'three/one'

Yes, I think it makes perfect sense to drop the ugly "source=one destination=two"
cruft, both for single-source and multiple-source cases.

>  builtin/mv.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index ae6c30c..c9ecb03 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -177,7 +177,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  				 * check both source and destination
>  				 */
>  				if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)) {
> -					warning(_("%s; will overwrite!"), bad);
> +					warning(_("%s (will overwrite), source=%s, destination=%s"),
> +						bad, src, dst);
>  					bad = NULL;
>  				} else
>  					bad = _("Cannot overwrite");
