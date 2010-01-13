From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] commit: show interesting ident information in
 summary
Date: Wed, 13 Jan 2010 11:48:53 -0800
Message-ID: <7vbpgxn5ui.fsf@alter.siamese.dyndns.org>
References: <20100112153656.GA24840@coredump.intra.peff.net>
 <20100112154631.GC24957@coredump.intra.peff.net>
 <7v3a2asda8.fsf@alter.siamese.dyndns.org>
 <20100113173050.GB21318@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 13 20:49:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV9DK-00030z-Ju
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 20:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664Ab0AMTtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 14:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754652Ab0AMTtF
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 14:49:05 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40838 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754639Ab0AMTtC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 14:49:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E9145909F7;
	Wed, 13 Jan 2010 14:49:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=yl53uoKvodQ8TaCUgLa69vIUE3Q=; b=DNC0p90620mcJHXcCcPG3RA
	rPLnBtmOi0D2j5e8TxDLDIoo/v7v3aPb3UzUcmHEp4PhIImFVGLT8REaEhocjACm
	koRWkB6bdJb3xvBeTuk771r6w0N99JtHxahPR+Sqx/lpgGAhKdhkoAgb5HdwrpLO
	4isuxbVNc7ujY5r2mt1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=oOZ3cPSo9fEk+Hw7nieqEYkPxbrvUpkQPTSkedp32sxpYE3JR
	JFk65F/hSicS1zKn2ZwkZQu/fAnwL0zzQ7Eqp33JUFmA8sVTS1Gd+jQKZh82kNs4
	0S3JFeER9mSmD1D/xD2KNqz+sG2MutfXMWBLygzbUr/9XVBYq8cI8CHPk8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B43D3909F5;
	Wed, 13 Jan 2010 14:48:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7DD9909F3; Wed, 13 Jan
 2010 14:48:54 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B0D500C6-007C-11DF-B980-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136866>

Jeff King <peff@peff.net> writes:

> Just adding the "Committer:" reminder is slightly annoying (though
> perhaps some people will even like it). Adding a big advice message on
> every commit is going to be annoying to everyone who sees it, and is
> really crossing the line of "we don't really support implicit identities
> anymore", since anyone seeing it is going to want to fix it.
>
> I know there has been some discussion of that area in the last few
> months, but I admit I didn't pay any attention. Is that the direction we
> want to move in? I don't have a particular problem with it, but I want
> to point out that if there _are_ people who really like the implicit
> ident feature, we are effectively killing it off for them.

Traditionally, we've only had a minimal sanity check (e.g. to barf when
the name is empty, or something silly like that) and tried to come up with
a reasonable name/email given the available system information.

In olden days, `whoami`@`hostname`, at least on systems that were
competently maintained, gave a reasonable mail address for most people,
but I think it stopped being adequate more than 10 years ago, and it is
not useful anymore to majority of people, especially the ones who work on
Open Source projects as individuals, whose desired public identities are
often tied to their email account at their ISPs or mailbox providers (like
gmail).  There is no way for us to guess, when `whoami`@`hostname -f` is
the only thing we can go by without explicit user configuration.

Inside corporate environments, `whoami`@`hostname -f` might still be a
reasonable and usable default, though.

So I think the safest thing to do would be to give a big advice but make
it squelch-able with advice.howToSetYourIdentity or something.
