From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Fri, 10 Dec 2010 11:55:56 -0800
Message-ID: <7vk4jhcshf.fsf@alter.siamese.dyndns.org>
References: <7voc90wx36.fsf@alter.siamese.dyndns.org>
 <20101205073938.GB15233@sigill.intra.peff.net>
 <7v8w04vvvr.fsf@alter.siamese.dyndns.org>
 <20101209172708.GA1817@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Aleksi Aalto <aga@iki.fi>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 20:56:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR94i-0000p0-Bz
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 20:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756902Ab0LJT4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 14:56:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41116 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756818Ab0LJT4J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 14:56:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 34BC83F8B;
	Fri, 10 Dec 2010 14:56:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qj6hB/oZ8/Shpvqot4xiAbNfeO4=; b=JAqMu4
	8lDqrKBMfM+slWq4qnf2sPGs2QSHHM/EFAis7MCqJrnEknrUKfsV1SaFq64rau97
	uY5/8zYkou0/c+mbr9FAfp7AQWLU0KOtga3wwMbJpk4FPdy11UHDrnFDcgDeilZs
	AHEY5JKtcU6vhYXLoXxJaeiU/FmjwYlY7F/iM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HgoMMBlq9nTbILlXlbjVrNAWRc1NKAPy
	Vuu7ZYYZjxlkjeTQywQjmphhpp7xva0dnb+a9Z37xIQKyL22NCv2rHGvWR/a6q2Z
	/wX8WldLpLC0Xowj9OycHYVYRKm9sZcLISGRFJLZBL7ZNG9DZnMM/kUElEDalSQf
	BVJagpAazCM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EEBED3F8A;
	Fri, 10 Dec 2010 14:56:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8BE3C3F68; Fri, 10 Dec 2010
 14:56:24 -0500 (EST)
In-Reply-To: <20101209172708.GA1817@sigill.intra.peff.net> (Jeff King's
 message of "Thu\, 9 Dec 2010 12\:27\:08 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9483B154-0497-11E0-8724-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163437>

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] default color.status.branch to "same as header"
>
> This gives it the same behavior as we had prior to 1d28232
> (status: show branchname with a configurable color).
>
> To do this we need the concept of a "NIL" color, which is
> provided by color.[ch]. The implementation is very simple;
> in particular, there are no precautions taken against code
> accidentally printing the NIL. This should be fine in
> practice because:
>
>   1. You can't input a NIL color in the config, so it must
>      come from the in-code defaults. Which means it is up
>      the client code to handle the NILs it defines.
>
>   2. If we do ever print a NIL, it will be obvious what the
>      problem is, and the bug can be fixed.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I resisted the urge to make a generic "same as $X" token, which would
> allow users to do something like:
>
>   [color "status"]
>     branch = from:color.status.header
>
> if they really wanted. But that would be a lot more code, and I'm not
> sure it would be all that useful (it would be if people did stuff like
> theming git colors like they do window managers, but I don't think we
> are at quite that level).

Also if you go that route you would need to worry about dependencies,
which would not be worth it.

> This is simple, solves the current regression, and provides an easy
> blueprint for handling the case in the future.

As I said, I don't care deeply, but you obviously cared enough to produce
a patch that is pretty simple and straightforward.  Let's take it.

Thanks.
