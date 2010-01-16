From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep --no-index: allow use of "git grep" outside a git
 repository
Date: Fri, 15 Jan 2010 17:05:42 -0800
Message-ID: <7vwrzin9jt.fsf@alter.siamese.dyndns.org>
References: <201001131713.05505.agruen@suse.de>
 <7vfx69k0bu.fsf@alter.siamese.dyndns.org>
 <20100115223259.6117@nanako3.lavabit.com>
 <7vska71br0.fsf@alter.siamese.dyndns.org>
 <7vzl4fum3r.fsf_-_@alter.siamese.dyndns.org>
 <20100115210854.GA21540@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 16 02:06:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVx7K-0000C7-IB
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 02:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758547Ab0APBFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 20:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758386Ab0APBFw
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 20:05:52 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36245 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758376Ab0APBFv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 20:05:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CB6E91273;
	Fri, 15 Jan 2010 20:05:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=gL55tghsynCo5t09Wt0iD/9y9U4=; b=xEQGzO
	jJ85TzncZAF3lxUQ2VcUpEFQE8eHqTRZqKqKWA6MAk5a7Sod0pbzc+evo2TSNku1
	cpW45nict9Baq1b0n8Nm0zwJMcxwkFyR7xAZKv6ONf8OpYE7D84aPC9p1GpPtL+5
	VyQYCTpTOKtKD1myHS/r+liIzn9A7KLy3wO5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=byU0UruzbAanLnUAO/GCNaVY3E3Ndfkh
	2j2hJxQ3iXwAQjLiI02m6uAs0lU1zAqPABgvIOo8sPSffSN3rLJklSSPM8t/FdPW
	xpnPn7k6tTu98t1NZXSdBn9WXSoFdqNgmrjrurq2rocxgefexTG/+OJDGFdSxCwa
	MifuHV7yQWs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4925091270;
	Fri, 15 Jan 2010 20:05:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7797F9126E; Fri, 15 Jan
 2010 20:05:43 -0500 (EST)
In-Reply-To: <20100115210854.GA21540@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 15 Jan 2010 16\:08\:54 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 47A47116-023B-11DF-82AE-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137184>

Jeff King <peff@peff.net> writes:

> On Fri, Jan 15, 2010 at 12:52:40PM -0800, Junio C Hamano wrote:
>
>> Just like some people wanted diff features that are not found in
>> other people's diff implementations outside of a git repository
>> and added --no-index mode to the command, this adds --no-index mode
>> to the "git grep" command.
>
> Out of curiosity, what are the interesting features in git grep versus
> other greps?

Three examples:

    git grep -e Junio --and -e Dscho --and -e Peff

is different from

    grep "Junio.*Dscho.*Peff"

in that the latter wouldn't find a line that has these names in different
order.  You can of course give permutations explicitly, like

    grep -e "Junio.*Dscho.*Peff" \
         -e "Dscho.*Junio.*Peff" \
         ...
	 -e "Peff.*Dscho.*Junio"

I don't know how you would do these with "grep":

    git grep -e Junio --and -e Dscho --and --not -e Linus

    git grep --all-match -e Junio -e Dscho
